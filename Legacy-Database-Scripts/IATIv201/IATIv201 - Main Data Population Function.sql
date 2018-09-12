USE [IATI]
GO

/****** Object:  StoredProcedure [PublicationControl].[p_Populate]    Script Date: 07/08/2015 15:11:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









--DROP PROCEDURE [IATI].[p_Populate]


CREATE PROCEDURE [PublicationControl].[p_Populate]
(
	@ExportedFlag				Configuration.Flag		= 'N',
	@VersionId					Configuration.Version	= NULL,
	@PivotDays					INT						= 5,
	@LatestTransactionDate		DATETIME				= NULL
)
AS
--*/
	-- Uncomment these declarations if you want to run this routine as a script and not a procedure
	DECLARE @ExportedFlagInternal			Configuration.Flag
	DECLARE @VersionIdInternal				Configuration.Version
	DECLARE @PivotDaysInternal				INT
	DECLARE	@LatestTransactionDateInternal	DATETIME
	
	SET @ExportedFlagInternal			= @ExportedFlag
	SET @VersionIdInternal				= @VersionId
	SET @PivotDaysInternal				= @PivotDays
	SET @LatestTransactionDateInternal	= @LatestTransactionDate
	
	DECLARE	@ActivitiesId					INT					
	DECLARE	@DFIDOrganisationIdentifier		NVARCHAR(255)	
	DECLARE	@DFIDOrganisationName			NVARCHAR(4)	
	DECLARE	@EarliestTransactionDate		DATETIME			
	DECLARE	@MinimumTransactionAmount		INT					
	DECLARE	@ComponentSource				SYSNAME				
	DECLARE	@DocumentSource					SYSNAME				
	DECLARE @DocumentURIPrefix				NVARCHAR(MAX)

	SET @ActivitiesId						= 101
	SET @DFIDOrganisationIdentifier			= N'GB-1'
	SET @DFIDOrganisationName				= N'DFID'
	SET @EarliestTransactionDate			= '20100512'
	SET @MinimumTransactionAmount			= 500
	SET @ComponentSource					= NULL
	SET @DocumentSource						= NULL
	SET @DocumentURIPrefix					= N'http://iati.dfid.gov.uk/iati_documents/'
	SET @ExportedFlagInternal = ISNULL(@ExportedFlagInternal, 'N')
	/* this allows the script to run without being part of the stored procedure if necessary, 
	* also the routine will not work if a NULL value is passed in the @PivotDaysInternal parameter*/
	SET @PivotDaysInternal = ISNULL(@PivotDaysInternal, 5) 

	/* If no explicit latest transaction date is specified then we use the end of the previous month, provided we 
	 * are at least @PivotDaysInternal + 1 days into the current month, otherwise we use the end of the month before that.
	 * With the default value of 5 days for @PivotDaysInternal then if it is on or after the 6th of the month we will use 
	 * the end of the previous month, otherwise we will use the end of the month two months prior to the current month.*/
	IF @LatestTransactionDateInternal IS NULL
	BEGIN
		DECLARE @PivotDateTime DATETIME
		SET @PivotDateTime = DATEADD(DAY, -@PivotDaysInternal, GETDATE())

		SET @LatestTransactionDateInternal = Configuration.f_MakeDate(DATEPART(YEAR, @PivotDateTime), DATEPART(MONTH, @PivotDateTime), 1) - 1
	END

	SET NOCOUNT ON
    
    /* Storing Current Version from the DataWareHouse*/
	IF @VersionIdInternal IS NULL
		SET @VersionIdInternal = Configuration.f_CurrentVersion()
	
	/* Storing the Population ID associated with current run of p_populate*/
	DECLARE @Population TABLE
	(
		PopulationId	INT		NOT NULL
	)
	
	/* LastUpdatedDate changes for Project*/
	DECLARE @ProjectLastUpdatedDate TABLE
	(
		ProjectId		VARCHAR(25) NOT NULL,
		LastUpdatedDate	DATETIME	NOT NULL
	)
	
	/* LastUpdatedDate changes for Component*/
	DECLARE @ComponentLastUpdatedDate TABLE
	(
		ProjectId		VARCHAR(25) NOT NULL,
		ComponentId		VARCHAR(25) NOT NULL,
		LastUpdatedDate	DATETIME	NOT NULL
	)
	
	DBCC CHECKIDENT ('[PublicationControl].Population', RESEED, 0)
	DBCC CHECKIDENT ('[PublicationControl].Population', RESEED)

	BEGIN TRANSACTION

	BEGIN TRY
	
		/* Storing Information for this run of p_populate */
		INSERT INTO
			[PublicationControl].Population
		OUTPUT
			INSERTED.PopulationId
		INTO
			@Population (PopulationId)
		VALUES
		(
			@ExportedFlagInternal,
			GETDATE(),
			NULL,
			@VersionIdInternal,
			@ActivitiesId,
			@DFIDOrganisationIdentifier,	
			@EarliestTransactionDate,	
			@LatestTransactionDateInternal,	
			@MinimumTransactionAmount,
			@ComponentSource,
			@DocumentSource
		)

		DECLARE @PopulationId INT
		SET @PopulationId = (SELECT PopulationId FROM @Population)

		/* Clear down the database table [PublicationControl].PopulationComponent */
		DELETE FROM [PublicationControl].PopulationComponent 
		
		/* Store All Publishable Components to [PublicationControl].PopulationComponent */
		IF @ComponentSource IS NULL
			INSERT INTO [PublicationControl].PopulationComponent SELECT @PopulationId, ComponentCode, StatusFinData FROM [PublicationControl].[stageComponent]
		ELSE
			INSERT INTO [PublicationControl].PopulationComponent EXECUTE('SELECT ' + @PopulationId + ', * FROM (' + @ComponentSource + ') q')
	
		/* Emergency response data should be added to [PublicationControl].PopulationComponent */
		INSERT INTO [PublicationControl].PopulationComponent (PopulationId, ComponentId, StatusFinData)
		SELECT @PopulationId, Eac.ComponentId, 'Release' 
		FROM [PublicationControl].EmergencyAidComponents Eac 
		WHERE (Select COUNT(*) From [PublicationControl].PopulationComponent Pc Where Eac.ComponentId = Pc.ComponentId AND @populationId = Pc.PopulationId ) < 1
			
		/* Store Last Updated Date for Components */
		EXECUTE [PublicationControl].p_PrintProgress N'Populating @ComponentLastUpdatedDate'

		INSERT INTO
			@ComponentLastUpdatedDate
		Select ProjectId, ComponentId, Max(MaxDate) as LastUpdatedDate
		From
			(Select Components.ComponentId as ComponentId, Components.ProjectId as ProjectID, 
			(Select MAX(v)FROM (VALUES (Components.ComponentUpdated), (UnfilteredTransactions.TransactionUpdated), (Budgets.BudgetUpdated), (Sectors.SectorUpdated)) AS value(v)) 
			AS [MaxDate]      
			From 
				(Select [ProjectId], [ComponentId], Version_Number.EndDateTime As ComponentUpdated
				From [ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 0) as Latest_Components,
                [ProjectDataMart].Configuration.Version As Version_Number 
				Where Latest_Components.FromVersionId = Version_Number.VersionId) As Components
				LEFT OUTER JOIN
				(Select [dim_4] as ComponentID, MAX([last_update]) as TransactionUpdated
				From [PublicationControl].UnfilteredTransactions
				Group By [dim_4]) As UnfilteredTransactions
				ON   
				Components.ComponentId = UnfilteredTransactions.ComponentID
				LEFT OUTER JOIN
				(Select [ComponentId], MAX(Version_Number.EndDateTime) as BudgetUpdated 
				From [ProjectDataMart].AgressoTransformation.f_BalanceTransformed(@VersionIdInternal, 0) Latest_Component_Balance,
				[ProjectDataMart].Configuration.Version As Version_Number 
				Where Latest_Component_Balance.FromVersionId = Version_Number.VersionId
				AND ProjectId != ''
				Group By [ComponentId]) As Budgets
				ON
				Components.ComponentId = Budgets.ComponentID
				LEFT OUTER JOIN
				(Select ComponentId, MAX(Version_Number.EndDateTime) as SectorUpdated
				From [ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 0) Latest_Component_Sector,
				[ProjectDataMart].Configuration.Version As Version_Number 
				Where Latest_Component_Sector.FromVersionId = Version_Number.VersionId
				Group By [ComponentId]) As Sectors
				ON
				Components.ComponentId = Sectors.ComponentID) As Component_Update	
			Group BY ComponentId, ProjectId
			
		/* Store Last Updated Date for Projects */
		EXECUTE [PublicationControl].p_PrintProgress N'Populating @ProjectLastUpdatedDate'

		INSERT INTO
			@ProjectLastUpdatedDate
		Select ProjectUpdate.ProjectId, (Select MAX(v)FROM (VALUES (ProjectUpdate.LastUpdatedDate), (DocumentUpdate.LastModified), (ComponentUpdate.LastUpdated)) AS value(v)) AS [LastUpdatedDate]
			From 
				(Select Version_Number.EndDateTime as LastUpdatedDate, Latest_Projects.ProjectId as ProjectId 
				From [ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 0) as Latest_Projects, 
				[ProjectDataMart].Configuration.Version As Version_Number 
			Where Latest_Projects.FromVersionId = Version_Number.VersionId) As ProjectUpdate 
			LEFT OUTER JOIN 
			(Select ProjectID, Max(ExtractionDate) as LastModified from [PublicationControl].PublishedDocuments Group by ProjectID) As DocumentUpdate
			ON 
			ProjectUpdate.ProjectId = DocumentUpdate.ProjectID
			LEFT OUTER JOIN
			(SELECT ProjectId, MAX(LastUpdatedDate) as LastUpdated FROM @ComponentLastUpdatedDate Group by ProjectId) as ComponentUpdate
			ON 
			ProjectUpdate.ProjectId = ComponentUpdate.ProjectId
		

		/*Data Generation for [IATISchema] Tables starts here*/
		BEGIN TRANSACTION

		BEGIN TRY
			SET NOCOUNT ON
			
			/* Setting Variables for Data Generation*/
			IF @VersionIdInternal IS NULL
				SET @VersionIdInternal = Configuration.f_CurrentVersion()

			DELETE FROM [IATISchema].[iati-activities] WHERE [iati-activitiesID] = @ActivitiesId
			
			DELETE FROM [IATISchema].[iati-activity] WHERE [iati-activitiesID] = @ActivitiesId

			DECLARE @GeneratedDateTime [IATISchema].[xsd:datetime]
			SET @GeneratedDateTime = GETDATE()

			IF @DFIDOrganisationIdentifier IS NULL
			BEGIN
				EXECUTE [PublicationControl].p_PrintProgress N'Extracting the DFID Organisation Identifier'
				SET @DFIDOrganisationIdentifier = (SELECT ISNULL(Code, 'GB-1') FROM [Codelist].[OrganisationIdentifier] WHERE NAME='Department for International Development')
			END

			/* Store Meta-Data associated with p_populate run in [iati-activities] */

			EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activities'

			INSERT INTO
				[IATISchema].[iati-activities]
			VALUES
			(
				@ActivitiesId											-- [iati-activitiesID]
				,'Real Data'											-- [Name]
				,NULL													-- [Notes]
				,DEFAULT												-- [@version]
				,@GeneratedDateTime										-- [@generated-datetime]
				,DEFAULT												-- [ir:registry-record/@xml:lang]				
				,@DFIDOrganisationIdentifier							-- [ir:registry-record/@file-id]				
				,'http://dfid.gov.uk/projects/iati/activities.xml'		-- [ir:registry-record/@source-url]			
				,@DFIDOrganisationIdentifier							-- [ir:registry-record/@publisher-id]			
				,'Funding'												-- [ir:registry-record/@publisher-role]		
				,'aipbeta@dfid.gov.uk'									-- [ir:registry-record/@contact-email]		
				,@DFIDOrganisationIdentifier							-- [ir:registry-record/@donor-id]				
				,10														-- [ir:registry-record/@donor-type]			
				,NULL													-- [ir:registry-record/@donor-country]		
				,'DFID Activity File'									-- [ir:registry-record/@title]				
				,'All Periods'											-- [ir:registry-record/@activity-period]		
				,@GeneratedDateTime						                -- [ir:registry-record/@last-updated-datetime]
				,@GeneratedDateTime										-- [ir:registry-record/@generated-datetime]	
				,1														-- [ir:registry-record/@verification-status]	
				,'application/xml'										-- [ir:registry-record/@format]				
				,'IATI'													-- [ir:registry-record/@license]	
			)

			/* Store projects' data (e.g. level 1 IATI activities) in the [iati-activity] table*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activity with projects'
			EXECUTE [PublicationControl].p_PrintProgress N'@VersionIdInternal'

			DECLARE @ProjectActivityMapping TABLE
			(
				[ProjectId]				VARCHAR(25)		NOT NULL PRIMARY KEY
				,[iati-activityID]		INT				NOT NULL UNIQUE
			)

			INSERT INTO
				[IATISchema].[iati-activity]
			(
				[iati-activitiesID]
				,[ProjectId]
				,[@hierarchy]
				,[iati-identifier/text()]
				,[other-identifier/@owner-ref]
				,[other-identifier/@owner-name]
				,[other-identifier/text()]
				,[@last-updated-datetime] 
			)
			OUTPUT
				INSERTED.[ProjectId]
				,INSERTED.[iati-activityID]
			INTO
				@ProjectActivityMapping
			SELECT
				@ActivitiesID AS [iati-activitiesID]
				,f_ProjectTransformed.ProjectId AS [ProjectId]
				,1 AS [@hierarchy]
				,@DFIDOrganisationIdentifier + '-' + f_ProjectTransformed.ProjectId AS [iati-identifier/text()]
				,@DFIDOrganisationIdentifier		
				,@DFIDOrganisationName
				,f_ProjectTransformed.ProjectId AS [ProjectIDText]
				,plud.LastUpdatedDate
			FROM
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N') 
			INNER JOIN
				@ProjectLastUpdatedDate plud
			ON plud.ProjectId = f_ProjectTransformed.ProjectId
			WHERE
				f_ProjectTransformed.ProjectId IN
				(
					SELECT DISTINCT
						ProjectId
					FROM
						[ProjectDataMart].AgressoTransformation.f_ProjectComponentMappingTransformed(@VersionIdInternal, 'N')
					INNER JOIN
						[PublicationControl].PopulationComponent Component
					ON
						Component.PopulationId = @PopulationId
						AND f_ProjectComponentMappingTransformed.ComponentId = Component.ComponentId
					WHERE
						f_ProjectComponentMappingTransformed.ProjectFlag = 'Y'
						AND f_ProjectComponentMappingTransformed.ComponentFlag = 'Y'
				)
			
			/* Store components' data (e.g. level 2 IATI activities) in the [iati-activity] table*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activity with components'

			DECLARE @ComponentActivityMapping TABLE
			(
				[ComponentId]			VARCHAR(25)		NOT NULL PRIMARY KEY
				,[ProjectId]			VARCHAR(25)		NOT NULL 
				,[iati-activityID]		INT				NOT NULL UNIQUE
			)

			INSERT INTO
				[IATISchema].[iati-activity]
			(
				[iati-activitiesID]
				,[ProjectId]
				,[ComponentId]
				,[BenefittingCountryCode]
				,[CountryCode]
				,[RegionCode]
				,[@hierarchy]
				,[iati-identifier/text()]
				,[other-identifier/@owner-ref]
				,[other-identifier/@owner-name]
				,[other-identifier/text()]
				,[@last-updated-datetime] 
			)
			OUTPUT
				INSERTED.[ComponentId]
				,INSERTED.[ProjectId]
				,INSERTED.[iati-activityID]
			INTO
				@ComponentActivityMapping
			SELECT
				@ActivitiesID AS [iati-activitiesID]
				,f_ComponentTransformed.ProjectId AS [ProjectId]
				,f_ComponentTransformed.ComponentId AS [ComponentId]
				,NULLIF(f_ComponentTransformed.BenefittingCountryCode, '') AS [BenefittingCountryCode]
				,[MappingBenefittingCountry].IATICountryCode AS [CountryCode]
				,[MappingBenefittingCountry].IATIRegionCode AS [RegionCode]
				,2 AS [@hierarchy]
				,@DFIDOrganisationIdentifier + '-' + f_ComponentTransformed.ComponentId AS [iati-identifier/text()]
				,@DFIDOrganisationIdentifier		
				,@DFIDOrganisationName
				,f_ComponentTransformed.ComponentId AS [ComponentIDText]
				,clud.LastUpdatedDate
			FROM
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			INNER JOIN
				[PublicationControl].PopulationComponent Component
			ON
				Component.PopulationId = @PopulationId
				AND f_ComponentTransformed.ComponentId = Component.ComponentId
			INNER JOIN
				@ComponentLastUpdatedDate clud
			ON clud.ComponentId = f_ComponentTransformed.ComponentId
			LEFT OUTER JOIN
				[PublicationControl].[MappingBenefittingCountry]
			ON
				f_ComponentTransformed.BenefittingCountryCode = MappingBenefittingCountry.BenefittingCountryCode

			/*** activity-website ***/

			-- No Action

			/* Update every entry in the [iati-activity] table with reporting-org value */

			EXECUTE [PublicationControl].p_PrintProgress N'Populating reporting-org'

			UPDATE
				[IATISchema].[iati-activity]
			SET
				[reporting-org/@xml:lang] = NULL
				,[reporting-org/@ref] = @DFIDOrganisationIdentifier
				,[reporting-org/@type] = 10 -- i.e. "Government" entry in OrganisationType code list
				,[reporting-org/text()] = NULL -- text filled automatically by view if no explicit name specified
			WHERE
				[iati-activitiesID] = @ActivitiesId

			
			/* Insert a valid OECD DAC region into the iati-activity table for activities that have a DFID specific Benefitting Country (i.e. a custom region) 
			 * so that the activity meets the IATI 2.01 standard. 	
			 */

			 EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activity components with OECD DAC regions where they have been allocated a DFID specific region'

			 UPDATE 
				ia
			 SET 
			 	ia.RegionCode = mr.DACRegionCode
			 From 
			 	[IATI].[IATISchema].[iati-activity] ia
			 INNER JOIN
			 	[IATI].[PublicationControl].[MappingDFIDRegionToDACRegion] mr
			 ON 
			 	ia.BenefittingCountryCode = mr.BenefittingCountryCode
			 Where 
			 	 ia.ComponentId IS NOT NULL
			 	 AND ia.BenefittingCountryCode IS NOT NULL
			 	 AND ia.RegionCode IS NULL
			 	 AND ia.CountryCode IS NULL
						
			/* Store participating-org with funding and extending roles along with [iati-activityID] in [IATISchema].[participating-org]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating participating-org with funding and extending roles'

			INSERT INTO
				[IATISchema].[participating-org]
			(
				--[participating-orgID]
				[iati-activityID]
				,[@xml:lang]
				,[@ref]
				,[@type]
				,[@role]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,data.[@ref] AS [@ref]
				,data.[@type] AS [@type]
				,data.[@role] AS [@role]
			FROM
				[IATISchema].[iati-activity]
			CROSS JOIN
			(
				SELECT 'GB', 10 /* i.e. "Government" entry in OrganisationType code list */, 'Funding'
				UNION ALL
				SELECT @DFIDOrganisationIdentifier, 10 /* i.e. "Government" entry in OrganisationType code list */, 'Extending'
			) data ([@ref], [@type], [@role])
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
			
			/* Store participating-org with implementing role along with [iati-activityID] in [IATISchema].[participating-org]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating participating-org with implementing role'

			INSERT INTO
				[IATISchema].[participating-org]
			(
				--[participating-orgID]
				[iati-activityID]
				,[@xml:lang]
				,[@ref]
				,[@type]
				,[@role]
			)
			SELECT
				ComponentActivityMapping.[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,f_ComponentTransformed.ChannelCode AS [@ref]
				,NULL AS [@type]
				,'Implementing' AS [@role]
			FROM
				@ComponentActivityMapping ComponentActivityMapping
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				ComponentActivityMapping.ComponentId = f_ComponentTransformed.ComponentId
				AND ISNULL(f_ComponentTransformed.ChannelCode, '') != ''

			/* Store recipient-country along with [iati-activityID] in [IATISchema].[recipient-country]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating recipient-country'

			INSERT INTO
				[IATISchema].[recipient-country]
			(
				[iati-activityID]		
				,[@code]					
				,[@type]					
				,[@xml:lang]				
				,[@percentage]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,[iati-activity].[CountryCode] AS [@code]
				,NULL AS [@type]					
				,NULL AS [@xml:lang]				
				,NULL AS [@percentage]
				,f_BenefittingCountryTransformed.BenefittingCountryName AS [text()]		
			FROM
				[IATISchema].[iati-activity]
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_BenefittingCountryTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].BenefittingCountryCode = f_BenefittingCountryTransformed.BenefittingCountryCode
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
				AND [iati-activity].CountryCode IS NOT NULL


			/* Store IATI regions along with [iati-activityID] in [IATISchema].[recipient-region]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating recipient-region with IATI regions'

			INSERT INTO
				[IATISchema].[recipient-region]
			(
				[iati-activityID]		
				,[@code]					
				,[@type]					
				,[@xml:lang]				
				,[@percentage]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,[iati-activity].[RegionCode] AS [@code]
				,NULL AS [@type]					
				,NULL AS [@xml:lang]				
				,NULL AS [@percentage]
				,NULL AS [text()]		
			FROM
				[IATISchema].[iati-activity]
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
				AND [iati-activity].RegionCode IS NOT NULL

			/*** collaboration-type ***/

			UPDATE
				[iati-activity]
			SET
				[collaboration-type/@xml:lang] = NULL
				,[collaboration-type/@code] = 
					CASE
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 AND LEFT(f_ComponentTransformed.ChannelCode, 1) = '2' THEN 3
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 3 AND LEFT(f_ComponentTransformed.ChannelCode, 1) = '2' THEN 3
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 AND LEFT(f_ComponentTransformed.ChannelCode, 1) = '3' THEN 3
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 THEN 1
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 2 THEN 2
					END
				,[collaboration-type/@type] = NULL
				,[collaboration-type/text()] = NULL
			FROM
				[IATISchema].[iati-activity]
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentTransformed.ComponentId
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentBiMultiMarkerTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentBiMultiMarkerTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL

			/*** default-flow-type ***/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating default-flow-type'

			UPDATE
				[iati-activity]
			SET
				[default-flow-type/@xml:lang] = NULL
				,[default-flow-type/@code] = 
					CASE
					WHEN f_ComponentTransformed.ODAOOFMarkerCode = 'ODA' THEN '10'
					WHEN f_ComponentTransformed.ODAOOFMarkerCode = 'OOF' THEN '20'
					END
				,[default-flow-type/@type] = NULL
				,[default-flow-type/text()] = NULL
			FROM
				[IATISchema].[iati-activity]
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL

			/*** default-aid-type ***/

			UPDATE
				[iati-activity]
			SET
				[default-aid-type/@xml:lang] = NULL
				,[default-aid-type/@code] = 
					CASE
					WHEN f_ComponentTransformed.FundingTypeCode = 'GENBUDGETSUPPORT' THEN 'A01'
					WHEN f_ComponentTransformed.FundingTypeCode = 'SECTORBUDGETSUPPORT' THEN 'A02'
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 3 THEN 'B01'
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 2 THEN 'B02'
					WHEN f_ComponentTransformed.FundingTypeCode = 'OTHERBILATERALDONOR' THEN 'B04'
					WHEN f_ComponentTypeOfFinanceTransformed.TypeOfFinanceCode IN ('610', '611', '612', '613', '614', '615', '616', '617', '618') THEN 'F01'
					WHEN sector.DACSectorCode = '91010' THEN 'G01'
					WHEN sector.DACSectorCode = '99820' THEN 'H01'
					WHEN f_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 THEN 'C01'
					END
				,[default-aid-type/@type] = NULL
				,[default-aid-type/text()] = NULL
			FROM
				[IATISchema].[iati-activity]
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentTransformed.ComponentId
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentBiMultiMarkerTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentBiMultiMarkerTransformed.ComponentId
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTypeOfFinanceTransformed(@VersionIdInternal, 'N')
			ON
				f_ComponentTypeOfFinanceTransformed.Rank = 1
				AND [iati-activity].ComponentId = f_ComponentTypeOfFinanceTransformed.ComponentId
			LEFT OUTER JOIN
			(
				SELECT
					f_ComponentInputSectorTransformed.ComponentId
					,f_InputSectorTransformed.DACSectorCode
					,ROW_NUMBER() OVER (PARTITION BY f_ComponentInputSectorTransformed.ComponentId ORDER BY SUM(Percentage) DESC) AS Rank
				FROM
					[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
				INNER JOIN
					[ProjectDataMart].AgressoTransformation.f_InputSectorTransformed(@VersionIdInternal, 'N')
				ON
					f_ComponentInputSectorTransformed.InputSectorCode = f_InputSectorTransformed.InputSectorCode
				GROUP BY
					f_ComponentInputSectorTransformed.ComponentId
					,f_InputSectorTransformed.DACSectorCode
			) sector
			ON
				sector.Rank = 1
				AND [iati-activity].ComponentId = sector.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL

			/*** default-finance-type ***/

			UPDATE
				[iati-activity]
			SET
				[default-finance-type/@xml:lang] = NULL
				,[default-finance-type/@code] = f_ComponentTypeOfFinanceTransformed.TypeOfFinanceCode
				,[default-finance-type/@type] = NULL
				,[default-finance-type/text()] = NULL
			FROM
				[IATISchema].[iati-activity]
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentTransformed.ComponentId
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTypeOfFinanceTransformed(@VersionIdInternal, 'N')
			ON
				f_ComponentTypeOfFinanceTransformed.Rank = 1
				AND [iati-activity].ComponentId = f_ComponentTypeOfFinanceTransformed.ComponentId
			INNER JOIN
				[Codelist].FinanceType
			ON
				f_ComponentTypeOfFinanceTransformed.TypeOfFinanceCode = FinanceType.Code
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL

			/* other-identifier */

			-- No Action

			/* Populate Project Title along with [iati-activityID] in [IATISchema].[activity/title]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating activity/title for projects and components'

			INSERT INTO
				[IATISchema].[activity/title]
			(
				[iati-activityID]	
				,[@xml:lang]			
				,[text()]			
			)
			SELECT
				ProjectActivityMapping.[iati-activityID] AS [iati-activityID]	
				,NULL
				,f_ProjectTransformed.ProjectTitle
			FROM
				@ProjectActivityMapping ProjectActivityMapping
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				ProjectActivityMapping.ProjectId = f_ProjectTransformed.ProjectId
			UNION ALL
			SELECT
				ComponentActivityMapping.[iati-activityID] AS [iati-activityID]	
				,NULL
				,f_ComponentTransformed.ComponentTitle
			FROM
				@ComponentActivityMapping ComponentActivityMapping
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				ComponentActivityMapping.ComponentId = f_ComponentTransformed.ComponentId

			/* Populate Project Description along with [iati-activityID] in [IATISchema].[activity/description]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating activity/description for projects and components'

			INSERT INTO
				[IATISchema].[activity/description]
			(
				[iati-activityID]	
				,[@xml:lang]			
				,[text()]			
			)
			SELECT
				ProjectActivityMapping.[iati-activityID] AS [iati-activityID]	
				,NULL
				,f_ProjectTransformed.MostRecentPurpose
			FROM
				@ProjectActivityMapping ProjectActivityMapping
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				ProjectActivityMapping.ProjectId = f_ProjectTransformed.ProjectId
			WHERE
				f_ProjectTransformed.MostRecentPurpose != ''

			/* Populate Component (Title/Description) along with [iati-activityID] in [IATISchema].[activity/description]*/
			
			INSERT INTO 
				IATISchema.[activity/description] 
			SELECT 
				[activity/title].[iati-activityID]
				,[activity/title].[@xml:lang]
				,NULL
				,'Title: ' + [activity/title].[text()]
			from 
				IATISchema.[activity/title]
			LEFT OUTER JOIN 
				IATISchema.[activity/description]
				on [activity/description].[iati-activityID] = [activity/title].[iati-activityID]
			WHERE 
				[activity/description].[text()] is null

			/* Populate Sector along with [iati-activityID] in [IATISchema].[sector]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating sector'

			INSERT INTO [IATISchema].[sector]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@other-code]
				,[@vocabulary]
				,[@percentage]
				,[text()]
			)
			SELECT
				ComponentActivityMapping.[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,f_InputSectorTransformed.DACSectorCode AS [@code]
				,NULL AS [@type]
				,NULL AS [@other-code]
				,NULL AS [@vocabulary] -- 'DAC' is the default
				,NULLIF(f_ComponentInputSectorTransformed.percentage, 100) AS [@percentage]
				,f_InputSectorTransformed.DACSectorName As [text()]
			FROM
				@ComponentActivityMapping ComponentActivityMapping
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				f_ComponentInputSectorTransformed.Percentage != 0
				AND ComponentActivityMapping.ComponentId = f_ComponentInputSectorTransformed.ComponentId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_InputSectorTransformed(@VersionIdInternal, 'N')
			ON
				f_ComponentInputSectorTransformed.InputSectorCode = f_InputSectorTransformed.InputSectorCode
			INNER JOIN
				[Codelist].DAC5DigitSector
			ON
				f_InputSectorTransformed.DACSectorCode = DAC5DigitSector.Code

			
			/* Populate activity-date for projects along with [iati-activityID] in [IATISchema].[activity-date]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating activity-date for projects'

			INSERT INTO
				[IATISchema].[activity-date]
			(
				[iati-activityID]
				,[@type]
				,[@xml:lang]
				,[@iso-date]
				,[text()]
			)
			SELECT * FROM
				(
					SELECT
					[iati-activity].[iati-activityID] AS [iati-activityID]
					,ActivityDateType.Code AS [@type]
					,NULL AS [@xml:lang]
					,CASE 
					WHEN ActivityDateType.Code='1' THEN f_ProjectTransformed.OperationalStartDate
					WHEN ActivityDateType.Code='3' THEN f_ProjectTransformed.OperationalEndDate
					WHEN ActivityDateType.Code='2' THEN f_ProjectTransformed.ApprovalDate
					WHEN ActivityDateType.Code='4' AND f_ProjectTransformed.OperationalEndDate<GETDATE() THEN f_ProjectTransformed.OperationalEndDate	
					END AS [@iso-date]
					,NULL AS [text()]	
				FROM
					[IATISchema].[iati-activity]
				INNER JOIN 
					[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
				ON
					[iati-activity].ProjectId = f_ProjectTransformed.ProjectId
				CROSS JOIN
					[Codelist].ActivityDateType
				WHERE
					[iati-activity].[iati-activitiesID] = @ActivitiesId
					AND [iati-activity].ComponentId IS NULL
				) A
			WHERE 
				[@iso-date] IS NOT NULL	 
				
			/* Populate activity-date for components along with [iati-activityID] in [IATISchema].[activity-date]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating activity-date for components'

			INSERT INTO
				[IATISchema].[activity-date]
			(
				[iati-activityID]
				,[@type]
				,[@xml:lang]
				,[@iso-date]
				,[text()]
			)
			SELECT * FROM
				(
					SELECT
					[iati-activity].[iati-activityID] AS [iati-activityID]
					,ActivityDateType.Code AS [@type]
					,NULL AS [@xml:lang]
					,CASE 
					WHEN ActivityDateType.Code='1' THEN f_ComponentTransformed.OperationalStartDate
					WHEN ActivityDateType.Code='3' THEN f_ComponentTransformed.OperationalEndDate
					WHEN ActivityDateType.Code='2' THEN f_ComponentTransformed.OperationalStartDate
					WHEN ActivityDateType.Code='4' AND f_ComponentTransformed.OperationalEndDate<GETDATE() THEN f_ComponentTransformed.OperationalEndDate	
					END AS [@iso-date]
					,NULL AS [text()]	
				FROM
					[IATISchema].[iati-activity]
				INNER JOIN 
					[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
				ON
					[iati-activity].ComponentId = f_ComponentTransformed.ComponentId
				----CROSS JOIN (SELECT * FROM $(CodeListSchema).ActivityDateType WHERE Code LIKE '%planned') ActivityDateType
				CROSS JOIN
					[Codelist].ActivityDateType
				WHERE
					[iati-activity].[iati-activitiesID] = @ActivitiesId
					AND [iati-activity].ComponentId IS NOT NULL -- i.e. the activity is a component
				) A
			WHERE 
				[@iso-date] IS NOT NULL

			/* Remove end-date from 1st jan, 2099 */
			DELETE FROM [IATISchema].[activity-date] WHERE [@type] in ('3','4') and [@iso-date] >= '20990101'

			/* Update activity-status for this p_populate activity  in [IATISchema].[iati-activity]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating activity-status'

			UPDATE
				[IATISchema].[iati-activity]
			SET
				[activity-status/@xml:lang] = NULL
				,[activity-status/@code] = CASE 
				WHEN f_ProjectTransformed.StageCode IN ('0', '1', '2', '3', '4') THEN 1
				WHEN f_ProjectTransformed.StageCode IN ('5') THEN 2
				WHEN f_ProjectTransformed.StageCode IN ('6') THEN 3
				WHEN f_ProjectTransformed.StageCode IN ('7') THEN 4
				ELSE NULL
				END
				,[activity-status/@type] = NULL
				,[activity-status/text()] = NULL -- text filled automatically by view if no explicit name specified
			FROM
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ProjectId = f_ProjectTransformed.ProjectId

			/* Populate contact-info along with [iati-activityID] in [IATISchema].[contact-info]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating contact-info'

			INSERT INTO
				[IATISchema].[contact-info]
			(
				[iati-activityID]
				,[organisation/text()]
				,[person-name/@xml:lang]
				,[person-name/text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,(SELECT Name FROM [Codelist].OrganisationIdentifier WHERE Code = @DFIDOrganisationIdentifier) AS [organisation/text()]
				,NULL AS [person-name/@xml:lang]
				,NULL AS [person-name/text()]
			FROM
				[IATISchema].[iati-activity]
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId

			/* Populate Details of contact-info along with [iati-activityID] in [IATISchema].[contact-info/details]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating contact-info/details'

			INSERT INTO
				 [IATISchema].[contact-info/details]
			(
				[contact-infoID]
				,[telephone/text()]
				,[email/text()]
				,[mailing-address/text()]
			)
			SELECT
				 [contact-info].[contact-infoID] AS [contact-infoID]
				,'+44 (0) 1355 84 3132' AS [telephone/text()]
				,'enquiry@dfid.gov.uk' AS [email/text()]
				,'Public Enquiry Point, Abercrombie House, Eaglesham Road, East Kilbride, Glasgow G75 8EA' AS [mailing-address/text()]
			FROM
				[IATISchema].[contact-info]
			INNER JOIN
				[IATISchema].[iati-activity]
			ON
				[contact-info].[iati-activityID] = [iati-activity].[iati-activityID]
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId

			/* Update default-tied-status for this p_populate activity  in [IATISchema].[iati-activity]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating default-tied-status'

			UPDATE
				[IATISchema].[iati-activity]
			SET
				[default-tied-status/@xml:lang] = NULL
				,[default-tied-status/@code] = 5 -- i.e. "Untied" entry in TiedStatus code list
				,[default-tied-status/@type] = NULL 
				,[default-tied-status/text()] = NULL -- text filled automatically by view if no explicit name specified
			WHERE
				[iati-activitiesID] = @ActivitiesId

			/*** policy-marker ***/
			/* Populate policy-marker info along with [iati-activityID] in [IATISchema].[policy-marker]*/
			
			/* Step 1 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,1 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN f_ProjectTransformed.CCOGenderEqualityCode = 'PRINCIPAL' THEN 2
				WHEN f_ProjectTransformed.CCOGenderEqualityCode = 'SIGNIFICANT' THEN 1
				ELSE 0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				--f_ProjectTransformed.CCOGenderEqualityCode != ''
				[iati-activity].ProjectId = f_ProjectTransformed.ProjectId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			
			/* Step 2 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,2 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN f_ProjectTransformed.DSOClimateChange = 'Principal' THEN 2
				WHEN f_ProjectTransformed.DSOClimateChange = 'Significant' THEN 1
				ELSE 0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				--f_ProjectTransformed.DSOClimateChange != ''
				[iati-activity].ProjectId = f_ProjectTransformed.ProjectId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			
			/* Step 3 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,3 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN
					SUM(
						CASE
						WHEN
							f_ComponentInputSectorTransformed.LineNumber = 1 AND
							(
								f_ComponentInputSectorTransformed.InputSectorCode IN ('15130', '15150', '15210', '15220', '15230', '15240', '15261')
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '1512%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '1514%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '1516%'
							)
						THEN
							1
						ELSE
							0			
						END
					) > 0
				THEN
					2
				WHEN
					SUM(
						CASE
						WHEN
							f_ComponentInputSectorTransformed.InputSectorCode IN ('15130', '15150', '15210', '15220', '15230', '15240', '15261')
							OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '1512%'
							OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '1514%'
							OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '1516%'
						THEN
							1
						ELSE
							0			
						END
					) > 0
				THEN
					1
				ELSE
					0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentInputSectorTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			GROUP BY
				[iati-activity].[iati-activityID]
			
			/* Step 4 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,4 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN
					SUM(
						CASE
						WHEN
							(
								f_ComponentInputSectorTransformed.InputSectorCode IN ('33210', '25010')
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '240%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '311%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '312%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '313%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '321%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '322%'
							)
						THEN
							percentage
						ELSE
							0			
						END
					) > 50
				THEN
					2
				WHEN
					SUM(
						CASE
						WHEN
							f_ComponentInputSectorTransformed.LineNumber = 1 AND
							(
								f_ComponentInputSectorTransformed.InputSectorCode IN ('33210', '25010')
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '240%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '311%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '312%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '313%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '321%'
								OR f_ComponentInputSectorTransformed.InputSectorCode LIKE '322%'
							)
						THEN
							1
						ELSE
							0			
						END
					) > 0
					AND SUM(CASE WHEN f_ComponentInputSectorTransformed.InputSectorCode IN ('33110', '33120', '33130', '33140', '33150', '33181') THEN 1 ELSE 0 END) > 0
				THEN
					1
				ELSE
					0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentInputSectorTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			GROUP BY
				[iati-activity].[iati-activityID]
			
			/* Step 5 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,5 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN SUM(CASE WHEN f_ComponentInputSectorTransformed.LineNumber = 1 AND f_ComponentInputSectorTransformed.InputSectorCode IN ('41031') THEN 1 ELSE 0 END) > 0 THEN 2
				WHEN SUM(CASE WHEN f_ComponentInputSectorTransformed.InputSectorCode IN ('41031') THEN 1 ELSE 0 END) > 0 THEN 1
				ELSE 0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentInputSectorTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			GROUP BY
				[iati-activity].[iati-activityID]
			
			/* Step 6 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,6 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN SUM(CASE WHEN f_ComponentInputSectorTransformed.InputSectorCode IN ('41033') THEN percentage ELSE 0 END) >= 50 THEN 2
				WHEN SUM(CASE WHEN f_ComponentInputSectorTransformed.InputSectorCode IN ('41033') THEN percentage ELSE 0 END) > 0 THEN 1
				ELSE 0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentInputSectorTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			GROUP BY
				[iati-activity].[iati-activityID]
			
			/* Step 7 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,7 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN SUM(CASE WHEN f_ComponentInputSectorTransformed.InputSectorCode IN ('23010', '23030', '80017', '80019', '80023', '41032') THEN 1 ELSE 0 END) > 0 THEN
					CASE f_ProjectTransformed.DSOClimateChange WHEN 'Principal' THEN 2 WHEN 'Significant' THEN 1 ELSE 0 END
				ELSE 0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ProjectId = f_ProjectTransformed.ProjectId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentInputSectorTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			GROUP BY
				[iati-activity].[iati-activityID]
				,f_ProjectTransformed.DSOClimateChange
			
			/* Step 8 */
			INSERT INTO
				[IATISchema].[policy-marker]
			(
				[iati-activityID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[@vocabulary]
				,[@significance]
				,[text()]
			)
			SELECT
				[iati-activity].[iati-activityID] AS [iati-activityID]
				,NULL AS [@xml:lang]
				,8 AS [@code]
				,NULL AS [@type]
				,'DAC' AS [@vocabulary]
				,CASE
				WHEN SUM(CASE WHEN f_ComponentInputSectorTransformed.InputSectorCode IN ('12262', '14010', '14015', '14040', '31110', '31130', '41010', '41050', '74010', '80018', '80020') THEN 1 ELSE 0 END) > 0 THEN
					CASE f_ProjectTransformed.DSOClimateChange WHEN 'Principal' THEN 2 WHEN 'Significant' THEN 1 ELSE 0 END
				ELSE 0
				END AS [@significance]
				,NULL AS [text()]
			FROM
				[IATISchema].[iati-activity]
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ProjectId = f_ProjectTransformed.ProjectId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				[iati-activity].ComponentId = f_ComponentInputSectorTransformed.ComponentId
			WHERE
				[iati-activity].[iati-activitiesID] = @ActivitiesId
				AND [iati-activity].ComponentId IS NOT NULL
			GROUP BY
				[iati-activity].[iati-activityID]
				,f_ProjectTransformed.DSOClimateChange

					
			/* Populate geolocation data along with [iati-activityID] in [IATISchema].[location]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Adding geolocation data';
				  
			INSERT INTO [IATISchema].[location]
					   ([iati-activityID]
					   ,[@ref]
					   ,[location-id/@vocabulary]
					   ,[location-id/@code]
					   ,[name/narrative/@xml:lang]
					   ,[name/narrative]
					   ,[description/narrative/@xml:lang]
					   ,[description/narrative]
					   ,[activity-description/narrative/@xml:lang]
					   ,[activity-description/narrative]
					   ,[administrative/@level]
					   ,[administrative/@code]
					   ,[administrative/@vocabulary]
					   ,[point/@srsName]
					   ,[point/pos]
					   ,[exactness/@code]
					   ,[location-reach/@code]
					   ,[location-class/@code]
					   ,[feature-designation/@code])
				select 
					ia.[iati-activityID]
					,null as [@ref]
					,null as [location-id/@vocabulary]
					,null as [location-id/@code]
					,null as [name/narrative/@xml:lang]
					,ld.[name/text()]
					,null as [description/narrative/@xml:lang]
					,ld.[administrative/text()] as [description/narrative]
					,null as [activity-description/narrative/@xml:lang]
					,null as [activity-description/narrative]
					,null as [adaministrative/@level] -- deprecated
					,null as [adaministrative/@code] -- deprecated
					,null as [adaministrative/@vocabulary] -- deprecated
					,'http://www.opengis.net/def/crs/EPSG/0/4326' as [point/@srsName]
					,STR([coordinates/@latitude],20,20) + ' ' + STR([coordinates/@longitude],20,20) as [point/pos]
					,case 
						when ld.[coordinates/@precision] in (1,3,4,6) THEN 1
						else 2 
					end as [exactness/@code]
					,1 as [location-reach/@code] --activity =1 ; beneficiary location =2
					,case 
						when ld.[location-type/@code] like 'PPL%' THEN 2
						else 1   -- ADM%, PCL%
					end AS [location-class/@code]
					,ld.[location-type/@code] as [feature-designation/@code]
				FROM
					[PublicationControl].[LocationData] ld
				Inner Join
					[IATISchema].[iati-activity] ia
				ON
					ld.projectID = ia.ProjectId	and ia.ComponentId IS NULL


			/*** budgets and transactions building segments are starting from here ***/
			
			
			/* Storing Component wise budget related value in temporary Table*/
			EXECUTE [PublicationControl].p_PrintProgress N'Building budget values';

			IF OBJECT_ID('tempdb..#temp', 'U') IS NOT NULL
				DROP TABLE #temp

			
			SELECT
				ComponentActivityMapping.[iati-activityID]
				,ComponentActivityMapping.ComponentId AS [ComponentId]
				,f_BalanceTransformed.FiscalYear
				,f_BalanceTransformed.BudgetOriginal
				,f_BalanceTransformed.BudgetCurrent
				,f_BalanceTransformed.FiscalPeriod
			INTO
				#temp
			FROM
				@ComponentActivityMapping ComponentActivityMapping
			INNER JOIN
				[PublicationControl].PopulationComponent
			ON
				PopulationComponent.PopulationId = @PopulationId
				AND CASE WHEN PopulationComponent.StatusFinData IN (N'HideFinData', N'HideBudgetOnly') THEN 'N' ELSE 'Y' END = 'Y'
				AND ComponentActivityMapping.ComponentId = PopulationComponent.ComponentId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_BalanceTransformed(@VersionIdInternal, 'N')
			ON
				ComponentActivityMapping.ComponentId = f_BalanceTransformed.ComponentId
			INNER JOIN 
				[ProjectDataMart].AgressoSourceData.f_aglrelvalue(@VersionIdInternal,'N')
			ON 
				f_BalanceTransformed.AccountCode = f_aglrelvalue.att_value and f_aglrelvalue.attribute_id = 'A0' and f_aglrelvalue.rel_attr_id = 'S14' and f_aglrelvalue.rel_value = 'yes'
			
			
			/* Populate annual activity budgets along with [iati-activityID] in [IATISchema].[budget]*/
			EXECUTE [PublicationControl].p_PrintProgress N'Inserting annual activity budgets into budget table';

			INSERT INTO
				[IATISchema].[budget]
				(
					[iati-activityID]
					,[@type]
					,[period-start/@iso-date]
					,[period-start/text()]
					,[period-end/@iso-date]
					,[period-end/text()]
					,[value/@currency]
					,[value/@value-date]
					,[value/text()]
				)
			SELECT	
				FQRange.[iati-activityID]
				,CASE WHEN (SUM(FQRange.[budget-current]) = SUM(FQRange.[budget-original])) THEN 'Original' ELSE 'Revised' END as [@type]
				,CASE
					WHEN (FYQuarter = 1) THEN Configuration.f_MakeDate(FiscalYear, 4, 1)
					WHEN (FYQuarter = 2) THEN Configuration.f_MakeDate(FiscalYear, 7, 1) 
					WHEN (FYQuarter = 3) THEN Configuration.f_MakeDate(FiscalYear, 10, 1) 
					WHEN (FYQuarter = 4) THEN Configuration.f_MakeDate(FiscalYear + 1, 1, 1)
				END AS [period-start/@iso-date]
				,NULL
				,CASE 
					WHEN (FYQuarter = 1) THEN Configuration.f_MakeDate(FiscalYear, 6, 30) 
					WHEN (FYQuarter = 2) THEN Configuration.f_MakeDate(FiscalYear, 9, 30) 
					WHEN (FYQuarter = 3) THEN Configuration.f_MakeDate(FiscalYear, 12, 31)
					WHEN (FYQuarter = 4) THEN Configuration.f_MakeDate(FiscalYear + 1, 3, 31) 
				END AS [period-end/@iso-date]
				,NULL
				,'GBP' AS [value/@currency]
				,[IATISchema].[f_ActivityActualStartDate]([iati-activityID]) AS [value/@value-date]
				,SUM(FQRange.[budget-current]) AS [value/text()]				
			FROM
				(
					SELECT [iati-activityID]
							,FiscalYear						   
							,CASE
								WHEN (FiscalPeriod < 4) THEN 1
								WHEN (FiscalPeriod < 7) THEN 2
								WHEN (FiscalPeriod < 10) THEN 3 
								ELSE 4
							END AS FYQuarter
							,SUM(BudgetCurrent) AS [budget-current]
							,SUM(BudgetOriginal) AS [budget-original]
						FROM #temp
						group by
							[iati-activityID]
							,FiscalYear
							,FiscalPeriod					
				)FQRange
			GROUP BY
				FQRange.[iati-activityID]
				,FQRange.FiscalYear
				,FQRange.FYQuarter
			HAVING
				SUM(FQRange.[budget-current]) != 0
			
			/* Populate aggregated budgets (commitments) along with [iati-activityID] in [IATISchema].[transaction]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Inserting aggregated budgets (commitments) into transaction table';

			INSERT INTO
				[IATISchema].[transaction]
			(
				[iati-activityID]
				,[IsExcluded]
				,[OriginalValue]
				,[@flow]
				,[value/@currency]	
				,[value/@value-date]	
				,[value/@type]		
				,[value/text()]	
				,[transaction-type/@xml:lang]
				,[transaction-type/@code]
				,[transaction-type/@type]
				,[transaction-type/text()]
				,[transaction-date/@iso-date]
				,[transaction-date/text()]	
			)
			SELECT
				[iati-activityID]
				ComponentId
				,0 AS IsExcluded
				,SUM(BudgetCurrent) AS OriginalValue
				,NULL AS [@flow]
				,NULL AS [value/@currency]	
				,[IATISchema].[f_ActivityActualStartDate]([iati-activityID]) AS [value/@value-date]
				,NULL AS [value/@type]		
				,SUM(BudgetCurrent) AS [value/text()]		
				,NULL AS [transaction-type/@xml:lang]
				,'C' AS [transaction-type/@code]
				,NULL AS [transaction-type/@type]
				,NULL AS [transaction-type/text()]
				,[IATISchema].[f_ActivityActualStartDate]([iati-activityID]) AS [transaction-date/@iso-date]
				,'Total Commitment to ' + Convert(nvarchar,([IATISchema].[f_ActivityActualEndDate]([iati-activityID])),106) AS [transaction-date/text()]	
			FROM
				#temp
			GROUP BY
				[iati-activityID]
			HAVING
				SUM(BudgetCurrent) != 0
			
			/* Dropping [PublicationControl].UnfilteredTransactions Table*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Dropping transaction table';

			IF OBJECT_ID('[PublicationControl].UnfilteredTransactions', 'U') IS NOT NULL
				DROP TABLE [PublicationControl].UnfilteredTransactions;

			EXECUTE [PublicationControl].p_PrintProgress N'Populating transaction with spend';

			WITH
				Main AS
			(
				SELECT
					[iati-activity].[iati-activityID],
					f_agltransact.account,
					f_agltransact.amount,
					f_agltransact.apar_id,
					f_agltransact.apar_type,
					f_agltransact.client,
					f_agltransact.cur_amount,
					f_agltransact.currency,
					f_agltransact.dc_flag,
					f_agltransact.description,
					f_agltransact.dim_1,
					f_agltransact.dim_4,
					f_agltransact.dim_7,
					f_agltransact.ext_inv_ref,
					f_agltransact.ext_ref,
					f_agltransact.fiscal_year,
					f_agltransact.last_update,
					f_agltransact.order_id,
					f_agltransact.period,
					f_agltransact.sequence_no,
					f_agltransact.status,
					f_agltransact.tax_code,
					f_agltransact.tax_system,
					f_agltransact.trans_date,
					f_agltransact.trans_id,
					f_agltransact.user_id,
					f_agltransact.voucher_date,
					f_agltransact.voucher_no,
					f_agltransact.voucher_type,
					f_agltransact.agrtid,
					CASE WHEN f_agltransact.account <= '4999' THEN 'Y' ELSE 'N' END AS IsExpenditureAccount,
					/* Handle promissory notes and provisions */
					CASE WHEN (f_agltransact.account <= '4999' AND f_agltransact.account != '2323') OR (f_agltransact.account IN ('5821', '6002', '6008', '6013', '6020', '6022')) THEN 'Y' ELSE 'N' END AS IsIncludedAccount,
					CASE WHEN SUM(CASE WHEN f_agltransact.account IN ('6001', '6003', '6004', '6005', '6007', '6009', '6010', '6012', '6014', '6015', '6021', '6023', '6024') THEN 1 ELSE 0 END) OVER (PARTITION BY f_agltransact.client, f_agltransact.voucher_type, f_agltransact.voucher_no) > 0 THEN 'Y' ELSE 'N' END AS IsProvisionRelated,
					CASE WHEN PopulationComponent.StatusFinData = N'HideFinData' THEN 'Y' ELSE 'N' END AS IsProcurementExcluded,
					CASE WHEN ExclusionProject.ID IS NULL THEN 'N' ELSE 'Y' END AS IsProjectExcluded,
					CASE WHEN ExclusionComponent.ID IS NULL THEN 'N' ELSE 'Y' END AS IsComponentExcluded,
					CASE WHEN ExclusionAccount.AccountCode IS NULL OR ExclusionAccount.ReplacementAccountName IS NOT NULL THEN 'N' ELSE 'Y' END AS IsAccountExcluded,
					CASE WHEN ExclusionVoucherType.VoucherTypeCode IS NULL OR ExclusionVoucherType.ReplacementSupplierName IS NOT NULL THEN 'N' ELSE 'Y' END AS IsVoucherTypeExcluded,
					CASE WHEN ExclusionBudgetCentre.BudgetCentreCode IS NULL THEN 'N' ELSE 'Y' END AS IsBudgetCentreExcluded,
					/* Need to revise*/
					'N' AS IsBenefittingCountryExcluded,
					CASE WHEN f_agltransact.voucher_type = 'PR' AND f_agltransact.voucher_no = 400136721 THEN 'Y' ELSE 'N' END AS IsTransactionExcluded,
					/* Need to revise*/
					CASE
						WHEN ExclusionSupplier.ID IS NOT NULL THEN 'Y' 
						WHEN SupplierInclusionList.SupplierId IS NOT NULL THEN 'N' 
						ELSE 'Y' 
					END AS IsSupplierExcluded,
					CASE WHEN @EarliestTransactionDate <= f_agltransact.last_update AND f_agltransact.last_update < DATEADD(DAY, 1, @LatestTransactionDateInternal) THEN 'N' ELSE 'Y' END AS IsDateExcluded,
					CASE WHEN ABS(f_agltransact.amount) >= @MinimumTransactionAmount THEN 'N' ELSE 'Y' END AS IsTransactionLineAmountExcluded,
					SUM(amount) OVER (PARTITION BY f_agltransact.client, f_agltransact.voucher_type, f_agltransact.voucher_no) AS TransactionTotal,
					CASE WHEN SUM(amount) OVER (PARTITION BY f_agltransact.client, f_agltransact.voucher_type, f_agltransact.voucher_no) > 25000 THEN 'Y' ELSE 'N' END AS IsGreaterThan25K,
					f_asuheader.apar_name AS SupplierName,
					f_acuheader.apar_name AS CustomerName,
					amount AS IATIAmount,
					CASE WHEN ExclusionAccount.ReplacementAccountName IS NOT NULL THEN ExclusionAccount.ReplacementAccountName ELSE f_aglaccounts.description END AS IATIAccountName,
					
					CASE
					WHEN ExclusionVoucherType.ReplacementSupplierName IS NOT NULL THEN 'Excluded'
					WHEN f_agltransact.apar_id = '' THEN 'Not available'
					WHEN f_agltransact.apar_id LIKE 'S%' OR f_agltransact.apar_id LIKE 'C%' THEN 'Not available'
					WHEN f_agltransact.apar_type = 'R' THEN 'Not available'
					WHEN ExclusionSupplier.ID IS NOT NULL THEN 'Excluded'
					WHEN SupplierInclusionList.SupplierId IS NULL THEN 'Excluded'
					WHEN ExclusionSupplierProject.ID IS NOT NULL THEN 'Excluded'
					WHEN [iati-activity].BenefittingCountryCode = 'AF' THEN 'Excluded'
					ELSE f_aglrelvalue.rel_value
					END AS IATIChannelCode,		
										
					CASE
					WHEN f_agltransact.account IN ('5821', '6002', '6008', '6013', '6020', '6022') AND f_asuheader.apar_name = 'Department for International Development' THEN 'Not available'
					WHEN ExclusionVoucherType.ReplacementSupplierName IS NOT NULL THEN ExclusionVoucherType.ReplacementSupplierName
					WHEN f_agltransact.apar_id = '' THEN 'Correction'
					WHEN f_agltransact.apar_id LIKE 'S%' OR f_agltransact.apar_id LIKE 'C%' THEN 'Staff Member'
					WHEN f_agltransact.apar_type = 'R' THEN 'Customer'
					WHEN ExclusionSupplier.ID IS NOT NULL THEN 'Supplier Name Withheld' 
					WHEN SupplierInclusionList.SupplierId IS NULL THEN 'Supplier Name Withheld'
					WHEN ExclusionSupplierProject.ID IS NOT NULL THEN 'Supplier Name Withheld' 
					WHEN [iati-activity].BenefittingCountryCode = 'AF' THEN 'Supplier Name Withheld'
					ELSE f_asuheader.apar_name
					END AS IATICustomerSupplier
				FROM
					[IATISchema].[iati-activity]
				INNER JOIN
					[PublicationControl].PopulationComponent
				ON
					PopulationComponent.PopulationId = @PopulationId
					AND [iati-activity].ComponentId = PopulationComponent.ComponentId
				INNER JOIN
					[ProjectDataMart].AgressoSourceData.f_agltransact(@VersionIdInternal, 'N')
				ON
					f_agltransact.client = 'DF'
					AND [iati-activity].ComponentId = f_agltransact.dim_4
				INNER JOIN
					[ProjectDataMart].AgressoSourceData.f_aglaccounts(@VersionIdInternal, 'N')
				ON
					f_aglaccounts.client = 'DF'
					AND f_agltransact.account = f_aglaccounts.account
				LEFT OUTER JOIN
					[ProjectDataMart].AgressoSourceData.f_asuheader(@VersionIdInternal, 'N')
				ON
					f_agltransact.apar_type IN ('P', '')
					AND f_asuheader.client = 'DF'
					AND f_agltransact.apar_id = f_asuheader.apar_id	
				LEFT OUTER JOIN
					[ProjectDataMart].AgressoSourceData.f_aglrelvalue(@VersionIdInternal, 'N')
				ON
					f_agltransact.apar_type IN ('P', '')
					AND f_aglrelvalue.client = 'DF'
					AND f_aglrelvalue.attribute_id = 'A5'
					AND f_aglrelvalue.rel_attr_id = 'S1'
					AND f_agltransact.apar_id = f_aglrelvalue.att_value
				LEFT OUTER JOIN
					[ProjectDataMart].AgressoSourceData.f_acuheader(@VersionIdInternal, 'N')
				ON
					f_agltransact.apar_type IN ('R', '')
					AND f_acuheader.client = 'DF'
					AND f_agltransact.apar_id = f_acuheader.apar_id	
				LEFT OUTER JOIN
					(SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Project' AND Status='Open') ExclusionProject
				ON
					[iati-activity].ProjectId = ExclusionProject.ID
				LEFT OUTER JOIN
					(SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Component' AND Status='Open') ExclusionComponent
				ON
					[iati-activity].ComponentId = ExclusionComponent.ID
				LEFT OUTER JOIN
					[PublicationControl].ExclusionAccount
				ON
					f_agltransact.account = ExclusionAccount.AccountCode
				LEFT OUTER JOIN
					[PublicationControl].ExclusionVoucherType
				ON
					f_agltransact.voucher_type = ExclusionVoucherType.VoucherTypeCode
				LEFT OUTER JOIN
					[PublicationControl].ExclusionBudgetCentre
				ON
					f_agltransact.dim_1 = ExclusionBudgetCentre.BudgetCentreCode
				LEFT OUTER JOIN
					/* For Blanket Level Supplier Exclusion */
					(SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Supplier' AND ExclusionLevel='Blanket' AND Status='Open') ExclusionSupplier
				ON
					f_agltransact.apar_type IN ('', 'P')
					AND f_agltransact.apar_id = ExclusionSupplier.ID
				LEFT OUTER JOIN
					[PublicationControl].SupplierInclusionList
				ON
					f_agltransact.apar_id = SupplierInclusionList.SupplierId
				LEFT OUTER JOIN
					/* For Project Level Supplier Exclusion */
					(SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Supplier' AND ExclusionLevel='Project' AND Status='Open') ExclusionSupplierProject
				ON
					[iati-activity].ProjectId = ExclusionSupplierProject.ParentProjectID
					AND f_agltransact.apar_id = ExclusionSupplierProject.ID
				WHERE
					[iati-activity].[iati-activitiesId] = 101
					AND [iati-activity].ComponentId IS NOT NULL
			)
			SELECT
				*,
				CASE WHEN
					IsIncludedAccount = 'Y'
					AND IsProvisionRelated = 'N'
					AND IsProcurementExcluded = 'N'
					AND IsProjectExcluded = 'N'
					AND IsComponentExcluded = 'N'
					AND IsAccountExcluded = 'N'
					AND IsVoucherTypeExcluded = 'N'
					AND IsBudgetCentreExcluded = 'N'
					AND IsBenefittingCountryExcluded = 'N'
					AND IsTransactionExcluded = 'N'
					AND IsDateExcluded = 'N'
					AND IsTransactionLineAmountExcluded = 'N'
				THEN
					'Y'
				ELSE
					'N'
				END AS IsIncluded
			INTO
				[PublicationControl].UnfilteredTransactions
			FROM
				Main
			OPTION
				(RECOMPILE)
			
			/* Publish transactions related to emergency humanitarian aid in [PublicationControl].UnfilteredTransactions*/
			 
			UPDATE [PublicationControl].UnfilteredTransactions
			SET IsIncluded = 'Y'
			WHERE dim_4 IN (SELECT ComponentId 
							FROM [PublicationControl].UnfilteredTransactions Tr
							INNER JOIN
							[PublicationControl].EmergencyAidComponents Eac
							ON 
							Tr.dim_4 = Eac.ComponentId
							Group By ComponentId)	
			
			/* Populate transaction with spend along with [iati-activityID] in [IATISchema].[transaction]*/
						
			EXECUTE [PublicationControl].p_PrintProgress N'Finished populating transaction with spend';

			INSERT INTO [IATISchema].[transaction]
			(
				[iati-activityID]
				,[IsExcluded]
				,[OriginalValue]
				,[@flow]
				,[value/@currency]
				,[value/@value-date]
				,[value/@type]
				,[value/text()]
				,[transaction-type/@xml:lang]
				,[transaction-type/@code]
				,[transaction-type/@type]
				,[transaction-type/text()]
				,[provider-org/@xml:lang]
				,[provider-org/@ref]
				,[provider-org/@type]
				,[provider-org/@provider-activity-id]
				,[provider-org/text()]
				,[receiver-org/@xml:lang]
				,[receiver-org/@ref]
				,[receiver-org/@type]
				,[receiver-org/@receiver-activity-id]
				,[receiver-org/text()]
				,[description/@xml:lang]
				,[description/text()]
				,[transaction-date/@iso-date]
				,[tied-status/@xml:lang]
				,[tied-status/@code]
				,[tied-status/@type]
				,[tied-status/text()]
			)
			SELECT
				UnfilteredTransactions.[iati-activityID] AS [iati-activityID]
				,0 AS [IsExcluded]
				,UnfilteredTransactions.[amount] AS [OriginalValue]
				,NULL AS [@flow]
				,'GBP' AS [value/@currency]
				,UnfilteredTransactions.last_update AS [value/@value-date]
				,NULL AS [value/@type]
				,UnfilteredTransactions.[amount] AS [value/text()]
				,NULL AS [transaction-type/@xml:lang]
				,CASE
				WHEN UnfilteredTransactions.account = '3402' THEN 'LR'
				WHEN UnfilteredTransactions.account = '3403' THEN 'IR'
				WHEN f_ComponentTransformed.FundingTypeCode IN ('PROCUREMENTOFGOODS', 'PROCOFSERVICES') THEN 'E' -- i.e. "Expenditure" entry in TransactionType code list
				ELSE 'D' /* i.e. "Disbursement" entry in TransactionType code list */
				END AS [transaction-type/@code]
				,NULL AS [transaction-type/@type]
				,NULL AS [transaction-type/text()]
				,NULL AS [provider-org/@xml:lang]
				,@DFIDOrganisationIdentifier AS [provider-org/@ref]
				,NULL AS [provider-org/@type]
				,NULL AS [provider-org/@provider-activity-id]
				,NULL AS [provider-org/text()]
				,NULL AS [receiver-org/@xml:lang]
				,UnfilteredTransactions.IATIChannelCode AS [receiver-org/@ref]
				,NULL AS [receiver-org/@type]
				,NULL AS [receiver-org/@receiver-activity-id]
				,UnfilteredTransactions.IATICustomerSupplier AS [receiver-org/text()]
				,NULL AS [description/@xml:lang]
				,IATIAccountName AS [description/text()]
				,UnfilteredTransactions.last_update AS [transaction-date/@iso-date]
				/* all DFID aid is untied, which we pick up from the activity */
				,NULL AS [tied-status/@xml:lang]
				,NULL AS [tied-status/@code]
				,NULL AS [tied-status/@type]
				,NULL AS [tied-status/text()]
			FROM
				[PublicationControl].UnfilteredTransactions
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				UnfilteredTransactions.dim_4 = f_ComponentTransformed.ComponentId
			WHERE
				UnfilteredTransactions.IsIncluded = 'Y'

			/* Populate aggregated transactions (Expenditure Items) Before 12th May 2010 along with [iati-activityID] in [IATISchema].[transaction]*/

			EXECUTE [PublicationControl].p_PrintProgress N'Populating aggregated transactions (Expenditure Items) pre 12th May 2010'
			
			INSERT INTO [IATISchema].[transaction]
			(	
				[iati-activityID]
				,[IsExcluded]
				,[OriginalValue]
				,[@flow]
				,[value/@currency]
				,[value/@value-date]
				,[value/@type]
				,[value/text()]
				,[transaction-type/@xml:lang]
				,[transaction-type/@code]
				,[transaction-type/@type]
				,[transaction-type/text()]
				,[provider-org/@xml:lang]
				,[provider-org/@ref]
				,[provider-org/@type]
				,[provider-org/@provider-activity-id]
				,[provider-org/text()]
				,[receiver-org/@xml:lang]
				,[receiver-org/@ref]
				,[receiver-org/@type]
				,[receiver-org/@receiver-activity-id]
				,[receiver-org/text()]
				,[description/@xml:lang]
				,[description/text()]
				,[transaction-date/@iso-date]
				,[tied-status/@xml:lang]
				,[tied-status/@code]
				,[tied-status/@type]
				,[tied-status/text()]
			)
			SELECT
				UnfilteredTransactions.[iati-activityID] AS [iati-activityID]
				,0 AS [IsExcluded]
				,SUM(UnfilteredTransactions.[amount]) AS [OriginalValue]
				,NULL AS [@flow]
				,'GBP' AS [value/@currency]
				,CASE 
					WHEN UnfilteredTransactions.fiscal_year = '2010' THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year), 5, 11)
					WHEN PublicationControl.f_QuarterValue(voucher_date) = 1 THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year),6, 30)
					WHEN PublicationControl.f_QuarterValue(voucher_date) = 2 THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year),9, 30)
					WHEN PublicationControl.f_QuarterValue(voucher_date) = 3 THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year),12, 31)
					ELSE Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year)+1,3, 31)
				 END
				 AS [value/@value-date]
				,NULL AS [value/@type]
				,SUM(UnfilteredTransactions.[amount]) AS [value/text()]
				,NULL AS [transaction-type/@xml:lang]
				,'E' as [transaction-type/@code]
				,NULL AS [transaction-type/@type]
				,NULL AS [transaction-type/text()]
				,NULL AS [provider-org/@xml:lang]
				,@DFIDOrganisationIdentifier AS [provider-org/@ref] 
				,NULL AS [provider-org/@type]
				,NULL AS [provider-org/@provider-activity-id]
				,NULL AS [provider-org/text()]
				,NULL AS [receiver-org/@xml:lang]
				,NULL AS [receiver-org/@ref]
				,NULL AS [receiver-org/@type]
				,NULL AS [receiver-org/@receiver-activity-id]
				,NULL [receiver-org/text()]
				,NULL AS [description/@xml:lang]
				,CASE 
					WHEN UnfilteredTransactions.fiscal_year = '2010' THEN 'Aggregated spend data - Financial Year 2010 Quarter 1 (prior to 12th May 2010)'
					ELSE 'Aggregated spend data - Financial Year ' + CONVERT(nvarchar,(Max(UnfilteredTransactions.fiscal_year))) + ' Quarter ' + CONVERT(nvarchar,(Max(PublicationControl.f_QuarterValue(voucher_date))))
				 END
				AS [description/text()]
				,CASE 
					WHEN UnfilteredTransactions.fiscal_year = '2010' THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year), 5, 11)
					WHEN PublicationControl.f_QuarterValue(voucher_date) = 1 THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year),6, 30)
					WHEN PublicationControl.f_QuarterValue(voucher_date) = 2 THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year),9, 30)
					WHEN PublicationControl.f_QuarterValue(voucher_date) = 3 THEN Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year),12, 31)
					ELSE Configuration.f_MakeDate(Max(UnfilteredTransactions.fiscal_year)+1,3, 31)
				 END
				 AS [transaction-date/@iso-date]
				,NULL AS [tied-status/@xml:lang]
				,NULL AS [tied-status/@code]
				,NULL AS [tied-status/@type]
				,NULL AS [tied-status/text()]		
			FROM
				[PublicationControl].UnfilteredTransactions
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				UnfilteredTransactions.dim_4 = f_ComponentTransformed.ComponentId
			WHERE
				UnfilteredTransactions.last_update < '2010-05-12 00:00:00'
				and UnfilteredTransactions.IsIncludedAccount = 'Y'
				and UnfilteredTransactions.IsProvisionRelated = 'N'
				and UnfilteredTransactions.IsProcurementExcluded = 'N'
				and UnfilteredTransactions.IsProjectExcluded = 'N'
				and UnfilteredTransactions.IsComponentExcluded = 'N'
				and UnfilteredTransactions.IsAccountExcluded = 'N'
				and UnfilteredTransactions.IsVoucherTypeExcluded = 'N' 
				and UnfilteredTransactions.IsBudgetCentreExcluded = 'N'
				and UnfilteredTransactions.IsBenefittingCountryExcluded = 'N'
				and UnfilteredTransactions.IsTransactionExcluded = 'N'
			Group By
				UnfilteredTransactions.[iati-activityID], UnfilteredTransactions.fiscal_year, PublicationControl.f_QuarterValue(voucher_date)
		
			
			/* Populate aggregated transactions with a value less than £500 along with [iati-activityID] in [IATISchema].[transaction]*/
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating quarterly aggregated transactions (Expenditure Items) for values less than £500'
			
			INSERT INTO [IATISchema].[transaction]
			(	
				[iati-activityID]
				,[IsExcluded]
				,[OriginalValue]
				,[@flow]
				,[value/@currency]
				,[value/@value-date]
				,[value/@type]
				,[value/text()]
				,[transaction-type/@xml:lang]
				,[transaction-type/@code]
				,[transaction-type/@type]
				,[transaction-type/text()]
				,[provider-org/@xml:lang]
				,[provider-org/@ref]
				,[provider-org/@type]
				,[provider-org/@provider-activity-id]
				,[provider-org/text()]
				,[receiver-org/@xml:lang]
				,[receiver-org/@ref]
				,[receiver-org/@type]
				,[receiver-org/@receiver-activity-id]
				,[receiver-org/text()]
				,[description/@xml:lang]
				,[description/text()]
				,[transaction-date/@iso-date]
				,[tied-status/@xml:lang]
				,[tied-status/@code]
				,[tied-status/@type]
				,[tied-status/text()]
			)
			SELECT
				LT500.[iati-activityID] AS [iati-activityID]
				,0 AS [IsExcluded]
				,SUM(LT500.[amount]) AS [OriginalValue] --Sum this
				,NULL AS [@flow]
				,'GBP' AS [value/@currency]
				,CASE 
					WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 1 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),6, 30)
					WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 2 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),9, 30)
					WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 3 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),12, 31)
					ELSE Configuration.f_MakeDate(Max(LT500.fiscal_year)+1,3, 31)
				 END
				 AS [value/@value-date]
				,NULL AS [value/@type]
				,SUM(LT500.[amount]) AS [value/text()]
				,NULL AS [transaction-type/@xml:lang]
				,'E' as [transaction-type/@code]
				,NULL AS [transaction-type/@type]
				,NULL AS [transaction-type/text()]
				,NULL AS [provider-org/@xml:lang]
				,@DFIDOrganisationIdentifier AS [provider-org/@ref]
				,NULL AS [provider-org/@type] 
				,NULL AS [provider-org/@provider-activity-id]
				,NULL AS [provider-org/text()]
				,NULL AS [receiver-org/@xml:lang]
				,NULL AS [receiver-org/@ref]
				,NULL AS [receiver-org/@type]
				,NULL AS [receiver-org/@receiver-activity-id]
				,NULL [receiver-org/text()]
				,NULL AS [description/@xml:lang]
				,'Aggregated spend of less than £500 - Financial Year ' + CONVERT(nvarchar,(Max(LT500.fiscal_year))) + ' Quarter ' + CONVERT(nvarchar,(Max(PublicationControl.f_QuarterValue(voucher_date))))
				  AS [description/text()]
				,CASE 
					WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 1 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),6, 30)
					WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 2 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),9, 30)
					WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 3 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),12, 31)
					ELSE Configuration.f_MakeDate(Max(LT500.fiscal_year)+1,3, 31)
				 END
				 AS [transaction-date/@iso-date]
				,NULL AS [tied-status/@xml:lang]
				,NULL AS [tied-status/@code]
				,NULL AS [tied-status/@type]
				,NULL AS [tied-status/text()]
			FROM
			(Select *  
			 From [PublicationControl].UnfilteredTransactions
			 Where IsIncludedAccount = 'Y'
				  AND IsProvisionRelated = 'N'
				  AND IsProcurementExcluded = 'N'
				  AND IsProjectExcluded = 'N'
				  AND IsComponentExcluded = 'N'
				  AND IsAccountExcluded = 'N'
				  AND IsVoucherTypeExcluded = 'N'
				  AND IsBudgetCentreExcluded = 'N'
				  AND IsBenefittingCountryExcluded = 'N'
				  AND IsTransactionExcluded = 'N'
				  AND IsDateExcluded = 'N'
				  AND IsTransactionLineAmountExcluded = 'Y'
				  AND IsIncluded = 'N') As LT500
			GROUP BY LT500.[iati-activityID], LT500.fiscal_year, PublicationControl.f_QuarterValue(LT500.voucher_date)
		
	
	
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating conditions for all projects'
	
			/* Delete All data from [IATISchema].[conditions] */ 
			DELETE FROM [IATISchema].[conditions] 
		
			/* Populate conditions info for all Projects along with [iati-activityID] in [IATISchema].conditions */
			INSERT INTO [IATISchema].conditions 
			(
				[iati-activityID]
				,[@attached]
				,[condtionFlag]
			)
			SELECT
				[iati-activityID]
				,CASE
					WHEN [PublicationControl].[f_HasSpecificConditions](ProjectId) = 1 THEN 1
					WHEN [PublicationControl].[f_HasBudgetSupport](ProjectId) = 1 THEN 1		
					ELSE 0
				END AS [@attached]
				,CASE
					WHEN [PublicationControl].[f_HasSpecificConditions](ProjectId) = 1 AND [PublicationControl].[f_HasBudgetSupport](ProjectId) = 1 THEN 'C'
					WHEN [PublicationControl].[f_HasSpecificConditions](ProjectId) = 1 THEN 'S'
					WHEN [PublicationControl].[f_HasBudgetSupport](ProjectId) = 1 THEN 'G'
					ELSE NULL
				END AS [condtionFlag]
			FROM
				[IATISchema].[iati-activity] 
			WHERE [@hierarchy] = 1

			/* Populate condition detials info for all Projects along with [iati-activityID] in [IATISchema].[conditions/condition] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating conditions/condition for all projects with conditions'

			INSERT INTO [IATISchema].[conditions/condition] 
			(
				[conditionsID] 
				,[@type] 
				,[text()] 
			)
			SELECT
				[conditionsID]
				,1 as [@type]
				,'Yes - General Conditions - For all financial aid that the UK provides direct to partner governments, the four Partnership Principles apply.' AS [text()]
			FROM
				[IATISchema].conditions c
			inner join [IATISchema].[iati-activity] a
			on a.[iati-activityID] = c.[iati-activityID]
			where c.[@attached] = 1	AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'G'

			UNION ALL

			SELECT
				[conditionsID]
				,1 as [@type]
				,'Yes - Specific Conditions - Details on specific conditions can be found in the Business Case for individual projects.' AS [text()]
			FROM 
				[IATISchema].conditions c
			inner join [IATISchema].[iati-activity] a
			on a.[iati-activityID] = c.[iati-activityID]
			where c.[@attached] = 1	AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'S'

			UNION ALL

			SELECT
				[conditionsID]
				,1 as [@type]
				,'Yes - General Conditions - For all financial aid that the UK provides direct to partner governments, the four Partnership Principles apply.' AS [text()]
			FROM
				[IATISchema].conditions c
			inner join [IATISchema].[iati-activity] a
			on a.[iati-activityID] = c.[iati-activityID]
			where c.[@attached] = 1	AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'C'

			UNION ALL

			SELECT
				[conditionsID]
				,1 as [@type]
				,'Yes - Specific Conditions - Details on specific conditions can be found in the Business Case for individual projects.' AS [text()]
			FROM 
				[IATISchema].conditions c
			inner join [IATISchema].[iati-activity] a
			on a.[iati-activityID] = c.[iati-activityID]
			where c.[@attached] = 1	AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'C'
		
			
			
			
			/* Populate capital spend all Components along with [iati-activityID] in [IATISchema].[capital-spend]  */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating capital spend for all components'
			
			INSERT INTO [IATISchema].[capital-spend] 
			(
				[iati-activityID] 
				,[@percentage] 
			)
			SELECT
				[iati-activityID]
				,CASE
					WHEN b.SpendTypeCode in ('C', 'PC', 'CAME') THEN 100
					ELSE 0
				END AS [@percentage]
			FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformedCurrent c
			inner join [ProjectDataMart].AgressoTransformation.v_BudgetCentreTransformedCurrent b
			on c.BudgetCentreCode = b.BudgetCentreCode
			inner join [IATISchema].[iati-activity] a
			on a.[ComponentId] = c.[ComponentId]
			
			
			
			/* Populate budget-item along with [iati-activityID] in [IATISchema].[country-budget-items/budget-item] */
			INSERT INTO [IATISchema].[country-budget-items/budget-item] 
			(
				[iati-activityID]
				,[@code] 
				,[@percentage]
				,[text()]
			)
			SELECT  IATISchema.[iati-activity].[iati-activityID]
					,Mapping.[Code]
					,CASE 
						WHEN IATISchema.sector.[@percentage] IS NULL THEN 100
						ELSE IATISchema.sector.[@percentage]
					END AS [@percentage]
					,Mapping.BudgetSector + ' - ' + Mapping.Category + ' - ' + Mapping.[Function] as [text()]
			FROM    IATISchema.sector
			CROSS APPLY
					(
					SELECT  TOP 1 
						PublicationControl.MappingRecipientCountryBudgetIdentifier.[Code],
						PublicationControl.MappingRecipientCountryBudgetIdentifier.[Sector],
						Codelist.[v_RecipientCountryBudgetIdentifier].[Function],
						Codelist.[v_RecipientCountryBudgetIdentifier].BudgetSector,
						Codelist.[v_RecipientCountryBudgetIdentifier].Category
					FROM  PublicationControl.MappingRecipientCountryBudgetIdentifier
					LEFT OUTER JOIN
					[Codelist].[v_RecipientCountryBudgetIdentifier]
					on Codelist.[v_RecipientCountryBudgetIdentifier].[Code] = PublicationControl.MappingRecipientCountryBudgetIdentifier.[Code]
					WHERE   PublicationControl.MappingRecipientCountryBudgetIdentifier.[Sector] = [IATISchema].Sector.[@code]
					) Mapping
			INNER JOIN
				IATISchema.[iati-activity]
				on IATISchema.[iati-activity].[iati-activityID] = IATISchema.sector.[iati-activityID]	


			/* Populate Country budget items along with [iati-activityID] in [IATISchema].[country-budget-items]  */
			/** only insert the wrapper where there are child budget items to wrap **/
			
			INSERT INTO [IATISchema].[country-budget-items] 
			(
				[iati-activityID]
				,[@vocabulary] 
			)
			SELECT DISTINCT
				[IATISchema].[country-budget-items/budget-item].[iati-activityID]
				,'1' --IATI vocabulary
			FROM [IATISchema].[country-budget-items/budget-item]

	
			/* Populate related-activity with parent projects for all components along with [iati-activityID] in [IATISchema].[related-activity] */

			EXECUTE [PublicationControl].p_PrintProgress N'Populating related-activity with parent projects for all components'

			INSERT INTO
				[IATISchema].[related-activity]
			(
				[iati-activityID]	
				,[@xml:lang]			
				,[@ref]				
				,[@type]
				,[text()]				
			)
			SELECT
				ComponentActivityMapping.[iati-activityID] AS [iati-activityID]	
				,NULL AS [@xml:lang]			
				,@DFIDOrganisationIdentifier + '-' + ComponentActivityMapping.ProjectId AS [@ref]				
				,1 AS [@type]
				,f_ProjectTransformed.ProjectTitle AS [text()]
			FROM
				@ComponentActivityMapping ComponentActivityMapping
			LEFT OUTER JOIN
				[ProjectDataMart].AgressoTransformation.f_ProjectTransformed(@VersionIdInternal, 'N')
			ON
				ComponentActivityMapping.ProjectId = f_ProjectTransformed.ProjectId
			
			/* Populate related-activity with child components for all projects along with [iati-activityID] in [IATISchema].[related-activity] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating related-activity with child components for all projects'

			INSERT INTO
				[IATISchema].[related-activity]
			(
				[iati-activityID]	
				,[@xml:lang]			
				,[@ref]				
				,[@type]
				,[text()]				
			)
			SELECT
				ProjectActivityMapping.[iati-activityID] AS [iati-activityID]	
				,NULL AS [@xml:lang]			
				,@DFIDOrganisationIdentifier + '-' + ComponentActivityMapping.ComponentId AS [@ref]				
				,2 AS [@type]
				,f_ComponentTransformed.ComponentTitle AS [text()]
			FROM
				@ProjectActivityMapping ProjectActivityMapping
			INNER JOIN
				@ComponentActivityMapping ComponentActivityMapping
			ON
				ProjectActivityMapping.ProjectId = ComponentActivityMapping.ProjectId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				ComponentActivityMapping.ComponentId = f_ComponentTransformed.ComponentId
			
			/* Populate related-activity with sibling components for all components along with [iati-activityID] in [IATISchema].[related-activity] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating related-activity with sibling components for all components'

			INSERT INTO
				[IATISchema].[related-activity]
			(
				[iati-activityID]	
				,[@xml:lang]			
				,[@ref]				
				,[@type]
				,[text()]				
			)
			SELECT
				component.[iati-activityID] AS [iati-activityID]	
				,NULL AS [@xml:lang]			
				,@DFIDOrganisationIdentifier + '-' + f_ComponentTransformed.ComponentId AS [@ref]				
				,3 AS [@type]
				,f_ComponentTransformed.ComponentTitle AS [text()]
			FROM
				@ComponentActivityMapping component
			INNER JOIN
				@ComponentActivityMapping sibling_component
			ON
				component.ProjectId = sibling_component.ProjectId
				AND component.ComponentId != sibling_component.ComponentId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentTransformed(@VersionIdInternal, 'N')
			ON
				sibling_component.ComponentId = f_ComponentTransformed.ComponentId

			/* Populate document url for Publishable documents along with [iati-activityID] in [IATISchema].[iati-activity/document-link] */

			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link'
	
			INSERT INTO [IATISchema].[iati-activity/document-link]
			(
				[iati-activityID]
				,[QuestID]
				,[@url]
				,[@format]
				,[@language]
				,[@LastUpdated-Month-Year]
			)
			SELECT 
			   ProjectActivityMapping.[iati-activityID] AS [iati-activityID],
			   publishedDocs.QuestID AS [QuestID], 
			   @DocumentURIPrefix 
			   + replace(publishedDocs.QuestID,' ','') 
			   + CASE
				     WHEN
						 UPPER(reverse(left(reverse(docProjPage.OriginalFileName),charindex('.',reverse(docProjPage.OriginalFileName))))) ='.DOC'
					 THEN	
				         '.odt'
				     WHEN
						UPPER(reverse(left(reverse(docProjPage.OriginalFileName),charindex('.',reverse(docProjPage.OriginalFileName))))) ='.DOCX'    
					 THEN
						 '.odt'	
				     ELSE
				        (reverse(left(reverse(docProjPage.OriginalFileName),charindex('.',reverse(docProjPage.OriginalFileName))))) 
				     END
			   as [@url],
			   CASE
				     WHEN
						 UPPER(reverse(left(reverse(docProjPage.OriginalFileName),charindex('.',reverse(docProjPage.OriginalFileName))))) ='.DOC'
					 THEN	
				         'application/vnd.oasis.opendocument.text'
				     WHEN
						UPPER(reverse(left(reverse(docProjPage.OriginalFileName),charindex('.',reverse(docProjPage.OriginalFileName))))) ='.DOCX'    
					 THEN
						 'application/vnd.oasis.opendocument.text'	
				     ELSE
				        docProjPage.MimeType
				     END
			   AS [@format],
			   CASE
				WHEN ISNULL(questLanguage.IATILanguageCode, '') = '' THEN NULL
				WHEN questLanguage.IATILanguageCode = 'en' THEN NULL			
				ELSE questLanguage.IATILanguageCode
			   END AS [@language],
			   DATENAME(MONTH, pdc.LastUpdatedDate) + ', ' + DATENAME(YEAR, pdc.LastUpdatedDate) AS [@LastUpdated-Month-Year]
			  FROM [PublicationControl].PublishedDocuments publishedDocs
			  INNER JOIN
			  (Select pdpc.ProjectID, DocumentID 
				From [ProjectDatamart].[EDRMSourceData].v_ProjectDocumentProjectCurrent pdpc
				Group By pdpc.ProjectID, DocumentID) docProjLink 
		      ON
			  (publishedDocs.QuestID = docProjLink.DocumentID AND publishedDocs.ProjectID=docProjLink.ProjectID)
			  INNER JOIN
			  [ProjectDatamart].[EDRMSourceData].v_ProjectDocumentPageCurrent docProjPage
			  ON 
			  publishedDocs.QuestID = docProjPage.DocumentID
			  INNER JOIN
			  [ProjectDatamart].[EDRMSourceData].v_ProjectDocumentTypeCurrent docProjType
			  ON 
			  publishedDocs.QuestID = docProjType.DocumentID
			  INNER JOIN
			  [ProjectDatamart].[EDRMSourceData].v_ProjectDocumentCurrent pdc
			  ON 
			  publishedDocs.QuestID = pdc.DocumentID
			  LEFT OUTER JOIN
			  [PublicationControl].[MappingQuestLanguage] questLanguage
			  ON 
			  docProjType.[Language] = questLanguage.QuestLanguage
			  INNER JOIN
			  @ProjectActivityMapping ProjectActivityMapping
			  ON
			  docProjLink.ProjectID = ProjectActivityMapping.ProjectId
			  WHERE publishedDocs.PublicationStatusID<>6				
			
			/* Populate title for Publishable documents along with [document-linkID] in [IATISchema].[iati-activity/document-link/title] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title'
	
			INSERT INTO [IATISchema].[iati-activity/document-link/title]
			(
				[document-linkID]
				,[@xml:lang]
				,[text()]
			)
			SELECT 
				   docLink.[iati-activity/document-linkID] AS [document-linkID],
				   docLink.[@language] AS [@language],
				   ISNULL(projDocType.Content_Type, '<Unknown Title>') 
				   + ' ' +
				   CASE
				   WHEN
						COUNT(*) OVER (PARTITION BY activity.ProjectID, projDocType.Content_Type) != 1
				   THEN
						'(' + CONVERT(VARCHAR(MAX), ROW_NUMBER() OVER (PARTITION BY activity.ProjectID, projDocType.Content_Type ORDER BY docLink.QuestID)) + ') '
				   ELSE
						''
				   END
				   + replace(activity.ProjectID,' ','')
				   + CASE
				     WHEN
						 docLink.[@LastUpdated-Month-Year] IS NOT NULL
					 THEN	
				         ' (' + docLink.[@LastUpdated-Month-Year] + ')'
				     ELSE
				         ''
				     END
				   + (reverse(left(reverse(docLink.[@url]),charindex('.',reverse(docLink.[@url])))))
				   AS [text()]
			FROM [IATISchema].[iati-activity/document-link] docLink
				 INNER JOIN
				 [ProjectDatamart].[EDRMSourceData].[v_ProjectDocumentTypeCurrent] projDocType
				 ON 
				 docLink.QuestID = projDocType.DocumentID
				 INNER JOIN
				 [IATISchema].[iati-activity] activity
				 ON
				 activity.[iati-activityID] = docLink.[iati-activityID]

	
			/* Populate Category for Publishable documents along with [document-linkID] in [IATISchema].[iati-activity/document-link/category] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category'
	
			INSERT INTO [IATISchema].[iati-activity/document-link/category]
			(
				[document-linkID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[text()]
			)
			SELECT
				docLink.[iati-activity/document-linkID] AS [document-linkID],
				docLink.[@language] AS [@xml:lang],
				questContentType.IATIContentTypeCode AS [@code],
				NULL AS [@type]
				,docContentType.Name AS [text()]
			FROM
				[IATISchema].[iati-activity/document-link] docLink
			INNER JOIN
				 [ProjectDatamart].[EDRMSourceData].[v_ProjectDocumentTypeCurrent] projDocType
				 ON 
				 docLink.QuestID = projDocType.DocumentID
			INNER JOIN
				 [PublicationControl].MappingQuestContentType questContentType	 
				 ON 
				 questContentType.QuestContentType = projDocType.Content_Type	
			INNER JOIN [Codelist].[DocumentCategory] docContentType
				 ON
				 questContentType.IATIContentTypeCode = docContentType.Code		
	
	/* Populate document url for Legacy documents along with [iati-activityID] in [IATISchema].[iati-activity/document-link] */
	
	EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with legacy document data'
	
		INSERT INTO [IATISchema].[iati-activity/document-link]
		(
			[iati-activityID]
			,[QuestID]
			,[@url]
			,[@format]
			,[@language]
		)
		SELECT
			ia.[iati-activityID] AS [iati-activityID],
			ld.QuestID AS [QuestID],
			@DocumentURIPrefix + '/' + replace(ld.QuestID,' ','') + replace(ld.DocumentExtension,' ','') as [@url],
			ld.Format AS [@format],
			NULL AS [@language]
		FROM 
			[PublicationControl].LegacyDocuments ld
			INNER JOIN
			[IATISchema].[iati-activity] ia
			ON
			ld.ProjectNumber = ia.ProjectId
		Where ia.ComponentId IS NULL 		
		
		/* Populate title for Legacy documents along with [document-linkID] in [IATISchema].[iati-activity/document-link/title] */
		
		EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with legacy documents'
		
		INSERT INTO [IATISchema].[iati-activity/document-link/title]
		(
			[document-linkID]
			,[@xml:lang]
			,[text()]
		)
		SELECT
			[iati-activity/document-link].[iati-activity/document-linkID] AS [document-linkID]
			,[iati-activity/document-link].[@language] AS [@language]
			,replace(ld.[Type],' ','')+' '+replace(ld.[ProjectNumber],' ','')+replace(ld.[DocumentExtension],' ','') AS [text()]
		FROM
			[IATISchema].[iati-activity/document-link]
		INNER JOIN
			[PublicationControl].[LegacyDocuments] ld
		ON
			[iati-activity/document-link].QuestID = ld.QuestID

		
		/* Populate Category for Legacy documents along with [document-linkID] in [IATISchema].[iati-activity/document-link/category] */
		
		EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with legacy documents'

		INSERT INTO [IATISchema].[iati-activity/document-link/category]
		(
			[document-linkID]
			,[@xml:lang]
			,[@code]
			,[@type]
			,[text()]
		)
		SELECT
			[iati-activity/document-link].[iati-activity/document-linkID] AS [document-linkID]
			,[iati-activity/document-link].[@language] AS [@xml:lang]
			,ld.IatiCode AS [@code]
			,NULL AS [@type]
			,ld.IatiTextDesc AS [text()]
		FROM
			[IATISchema].[iati-activity/document-link]
		INNER JOIN
			[PublicationControl].[LegacyDocuments] ld
		ON
			[iati-activity/document-link].QuestID = ld.QuestID	
				 

	
	/* Populate document url for contracts and tenders documents from ContractsFinder along with [iati-activityID] in [IATISchema].[iati-activity/document-link] */
	
	EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with contracts and tenders from ContractsFinder'

			INSERT INTO [IATISchema].[iati-activity/document-link]
			(
				[iati-activityID]
				,[QuestID]
				,[@url]
				,[@format]
				,[@language]
			)
			SELECT
				IATISchema.[iati-activity].[iati-activityID] AS [iati-activityID]
				,'CF' + CONVERT(varchar(10),[PublicationControl].ContractsFinderContracts.ContractId) AS QuestID
				,[PublicationControl].ContractsFinderContracts.ContractUrl 
				,'text/html' AS [@format]
				,NULL AS [@language]
			FROM
				[PublicationControl].ContractsFinderContracts
			INNER JOIN [ProjectDataMart].AgressoSourceData.apoheader
				on [ProjectDataMart].AgressoSourceData.apoheader.order_id = [PublicationControl].ContractsFinderContracts.PurchaseOrder
			INNER JOIN
				IATISchema.[iati-activity]
			ON
				substring([ProjectDataMart].AgressoSourceData.apoheader.dim_value_4,0,7) = IATISchema.[iati-activity].ProjectId
			WHERE
				[ProjectDataMart].AgressoSourceData.apoheader.ToVersionId is NULL
				and IATISchema.[iati-activity].[@hierarchy] = 1				
	
			
			/* Populate title for contracts and tenders documents from ContractsFinder along with [document-linkID] in [IATISchema].[iati-activity/document-link/title] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with contracts and tenders from ContractsFinder'
	
			INSERT INTO [IATISchema].[iati-activity/document-link/title]
			(
				[document-linkID]
				,[@xml:lang]
				,[text()]
			)
			SELECT
				[iati-activity/document-link].[iati-activity/document-linkID] AS [document-linkID]
				,[iati-activity/document-link].[@language] AS [@language]
				,CASE
					WHEN [PublicationControl].ContractsFinderContracts.DocumentCategoryCode = 'A10' THEN 'Tender: ' + [PublicationControl].ContractsFinderContracts.ContractTitle 
					WHEN [PublicationControl].ContractsFinderContracts.DocumentCategoryCode = 'A11' THEN 'Contract: ' + [PublicationControl].ContractsFinderContracts.ContractTitle 
					ELSE [PublicationControl].ContractsFinderContracts.ContractTitle 
				END AS [text()]
			FROM
				[IATISchema].[iati-activity/document-link]
			INNER JOIN
				[PublicationControl].ContractsFinderContracts
			ON
				[iati-activity/document-link].QuestID = 'CF' + CONVERT(varchar(10),[PublicationControl].ContractsFinderContracts.ContractId)
			
			/* Populate Category for contracts and tenders documents from ContractsFinder along with [document-linkID] in [IATISchema].[iati-activity/document-link/category] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with contracts and tenders from ContractsFinder'
	
			INSERT INTO [IATISchema].[iati-activity/document-link/category]
			(
				[document-linkID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[text()]
			)
			SELECT
				[iati-activity/document-link].[iati-activity/document-linkID] AS [document-linkID]
				,[iati-activity/document-link].[@language] AS [@xml:lang]
				,[PublicationControl].ContractsFinderContracts.DocumentCategoryCode AS [@code]
				,NULL AS [@type]
				,DocumentCategory.Name AS [text()]
			FROM
				[IATISchema].[iati-activity/document-link]
			INNER JOIN
				[PublicationControl].ContractsFinderContracts
			ON
				[iati-activity/document-link].QuestID = 'CF' + CONVERT(varchar(10),[PublicationControl].ContractsFinderContracts.ContractId)
			INNER JOIN
				[Codelist].[DocumentCategory]
			ON
				[PublicationControl].ContractsFinderContracts.DocumentCategoryCode = [Codelist].[DocumentCategory].Code
			
			/* Populate document url for general conditions documents along with [iati-activityID] in [IATISchema].[iati-activity/document-link] */

			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with general conditions'
			
			INSERT INTO [IATISchema].[iati-activity/document-link]
			(
				[iati-activityID]
				,[QuestID]
				,[@url]
				,[@format]
				,[@language]
			)
			SELECT
				c.[iati-activityID] AS [iati-activityID]
				,NULL AS QuestID
				,'https://www.gov.uk/government/publications/partnerships-for-poverty-reduction-rethinking-conditionality' AS [@url]
				,'text/html' AS [@format]
				,NULL AS [@language]
			FROM
				[IATISchema].conditions c		
			INNER JOIN
				IATISchema.[iati-activity] a
			on a.[iati-activityID] = c.[iati-activityID]
			where c.[@attached] = 1	AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'G'

			UNION ALL

			SELECT
				c.[iati-activityID] AS [iati-activityID]
				,NULL AS QuestID
				,'https://www.gov.uk/government/publications/partnerships-for-poverty-reduction-rethinking-conditionality' AS [@url]
				,'text/html' AS [@format]
				,NULL AS [@language]
			FROM
				[IATISchema].conditions c		
			INNER JOIN
				IATISchema.[iati-activity] a
			on a.[iati-activityID] = c.[iati-activityID]
			where c.[@attached] = 1	AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'C'

			/* Populate title for general conditions documents along with [document-linkID] in [IATISchema].[iati-activity/document-link/title] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with general conditions'
	
			INSERT INTO [IATISchema].[iati-activity/document-link/title]
			(
				[document-linkID]
				,[@xml:lang]
				,[text()]
			) 
			SELECT
				dl.[iati-activity/document-linkID] AS [document-linkID]
				,dl.[@language] AS [@language]
				,'General Conditions - For all financial aid that the UK provides direct to partner governments, the four Partnership Principles apply.' AS [text()]
			FROM
				[IATISchema].[iati-activity/document-link] dl
			WHERE dl.[iati-activity/document-linkID] IN 
			(
				SELECT [iati-activity/document-linkID] 
				FROM [IATISchema].[iati-activity/document-link]
				WHERE [@url] = 'https://www.gov.uk/government/publications/partnerships-for-poverty-reduction-rethinking-conditionality'
				AND [@format] = 'text/html'

			)

			/* Populate Category for general conditions documents along with [document-linkID] in [IATISchema].[iati-activity/document-link/category] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with general condtions'

			INSERT INTO [IATISchema].[iati-activity/document-link/category]
			(
				[document-linkID]
				,[@xml:lang]
				,[@code]
				,[@type]
				,[text()]
			)
			SELECT
					dl.[iati-activity/document-linkID] AS [document-linkID]
					,dl.[@language] AS [@xml:lang]
					,'A04' AS [@code]
					,NULL AS [@type]
					,DocumentCategory.Name AS [text()]
			FROM
				[IATISchema].[iati-activity/document-link] dl
			INNER JOIN
				[Codelist].[DocumentCategory]
			ON
				[Codelist].[DocumentCategory].Code = 'A04'
			WHERE dl.[iati-activity/document-linkID] IN 
			(
				SELECT [iati-activity/document-linkID] 
				FROM [IATISchema].[iati-activity/document-link]
				WHERE [@url] = 'https://www.gov.uk/government/publications/partnerships-for-poverty-reduction-rethinking-conditionality'
				AND [@format] = 'text/html'
			)

			/* Populate language element for all documents including contracts and tenders along with [document-linkID] in [iati-activity/document-link/language] */
			
			EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/language for core documents and contracts/tenders'
		
			INSERT INTO [IATISchema].[iati-activity/document-link/language]
			(
				[document-linkID]
				,[@code]
				,[@xml:lang]
				,[text()]
			)
			SELECT
				[iati-activity/document-link].[iati-activity/document-linkID] AS [document-linkID]
				,
				CASE
				WHEN ISNULL([iati-activity/document-link].[@language], '') = '' THEN 'en'
				ELSE [iati-activity/document-link].[@language]
				END AS [@code]
				,null as [@xml:lang]
				,
				CASE
				WHEN ISNULL([iati-activity/document-link].[@language], '') = '' THEN 'English'
				ELSE [Codelist].[Language].Name
				END AS [text()]
			FROM
				[IATISchema].[iati-activity/document-link]
			LEFT OUTER JOIN
				[Codelist].[Language]
			ON
				[Codelist].[Language].Code = [iati-activity/document-link].[@language]
	
	

			/* Populate legacy-data with DFID input sectors along with [iati-activityID] in [legacy-data] */

			EXECUTE [PublicationControl].p_PrintProgress N'Populating legacy-data with DFID input sectors'

			INSERT INTO [IATISchema].[legacy-data]
			(
				[iati-activityID]
				,[@name]
				,[@value]
				,[@iati-equivalent]
				,[text()]
			)
			SELECT
				ComponentActivityMapping.[iati-activityID] AS [iati-activityID]
				,f_InputSectorTransformed.InputSectorName AS [@name]
				,f_InputSectorTransformed.InputSectorCode AS [@value]
				,'sector' AS [@iati-equivalent]
				,CONVERT(VARCHAR(MAX), NULLIF(f_ComponentInputSectorTransformed.percentage, 100)) + '%' AS [text()]
			FROM
				@ComponentActivityMapping ComponentActivityMapping
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_ComponentInputSectorTransformed(@VersionIdInternal, 'N')
			ON
				f_ComponentInputSectorTransformed.Percentage != 0
				AND ComponentActivityMapping.ComponentId = f_ComponentInputSectorTransformed.ComponentId
			INNER JOIN
				[ProjectDataMart].AgressoTransformation.f_InputSectorTransformed(@VersionIdInternal, 'N')
			ON
				f_ComponentInputSectorTransformed.InputSectorCode = f_InputSectorTransformed.InputSectorCode

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION

			EXEC Configuration.p_ErrorHandler
		END CATCH--
		
		/* Update [IATI].Population with End date of the procedure */
		UPDATE [PublicationControl].Population SET EndDateTime = GETDATE() WHERE PopulationId = @PopulationId

		COMMIT

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION

		EXEC Configuration.p_ErrorHandler
	END CATCH
















GO


