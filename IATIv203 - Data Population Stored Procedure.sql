USE [IATIv203]
GO

/****** Object:  StoredProcedure [PublicationControl].[p_Populate]    Script Date: 05/09/2018 10:37:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--DROP PROCEDURE [PublicationControl].[p_Populate]

CREATE PROCEDURE [PublicationControl].[p_Populate]
(
       @ExportedFlag                     Configuration.Flag         = 'N',
       @VersionId                        Configuration.Version      = NULL,
       @PivotDays                        INT                        = 5,
       @LatestTransactionDate            DATETIME                   = NULL
)
AS
--*/
       -- Uncomment these declarations if you want to run this routine as a script and not a procedure
       DECLARE @ExportedFlagInternal                    Configuration.Flag
       DECLARE @VersionIdInternal                       Configuration.Version
       DECLARE @PivotDaysInternal						INT
       DECLARE @LatestTransactionDateInternal			DATETIME
       
       SET @ExportedFlagInternal                = @ExportedFlag
       SET @VersionIdInternal                          = @VersionId
       SET @PivotDaysInternal                          = @PivotDays
       SET @LatestTransactionDateInternal = @LatestTransactionDate
       
       DECLARE       @ActivitiesId                            INT                               
       DECLARE       @DFIDProjectIdentifier                   NVARCHAR(4)   
       DECLARE       @DFIDOrganisationIdentifier       NVARCHAR(8)   
       DECLARE       @DFIDOrganisationName                    NVARCHAR(4)   
       DECLARE       @EarliestTransactionDate          DATETIME                   
       DECLARE       @MinimumTransactionAmount         INT                               
       DECLARE       @ComponentSource                         SYSNAME                           
       DECLARE       @DocumentSource                                 SYSNAME                           
       DECLARE		 @DocumentURIPrefix                      NVARCHAR(MAX)

       SET @ActivitiesId                                      = 101
       SET @DFIDProjectIdentifier                      = N'GB-1'
       SET @DFIDOrganisationIdentifier                 = N'GB-GOV-1'
       SET @DFIDOrganisationName                       = N'DFID'
       SET @EarliestTransactionDate                    = '20100512'
       SET @MinimumTransactionAmount                   = 500
       SET @ComponentSource                            = NULL
       SET @DocumentSource                                    = NULL
       SET @DocumentURIPrefix                                 = N'http://iati.dfid.gov.uk/iati_documents/'
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
              PopulationId  INT           NOT NULL
       )
       
       /* LastUpdatedDate changes for Project*/
       DECLARE @ProjectLastUpdatedDate TABLE
       (
              ProjectId            VARCHAR(25) NOT NULL,
              LastUpdatedDate      DATETIME      NOT NULL
       )
       
       /* LastUpdatedDate changes for Component*/
       DECLARE @ComponentLastUpdatedDate TABLE
       (
              ProjectId            VARCHAR(25) NOT NULL,
              ComponentId          VARCHAR(25) NOT NULL,
              LastUpdatedDate      DATETIME      NOT NULL
       )
       
       -- Used to hold project budget data per sector
       DECLARE @ProjectBudgetBySector TABLE
       (
              ProjectId                         VARCHAR(25) NOT NULL,
              SectorCode                        INT                        NOT NULL,
              SectorText                        NVARCHAR(MAX) NOT NULL,
              Budget                            FLOAT                NOT NULL
       )

       -- Used to hold the percentage of project budget allocated per geographic location
       DECLARE @ProjectBudgetByGeoLocation TABLE
       (
              ProjectId                                VARCHAR(25) NOT NULL,
              BenefittingCountryCode            VARCHAR(25) NULL,
              CountryCode                              NCHAR(2) NULL,
              RegionCode                               INT NULL,
              Percentage                               DECIMAL(36,4) NOT NULL
       )

          -- Used to the hold Staging condition data for All Projects
          DECLARE @StagedData TABLE
              (
                     [iati-activityID] VARCHAR(25) ,
                     [HasSpecificConditions] VARCHAR(1) ,
                     [HasBudgetSupport] VARCHAR(1)
              )

       DBCC CHECKIDENT ('[PublicationControl].Population', RESEED, 0)
       DBCC CHECKIDENT ('[PublicationControl].Population', RESEED)

      BEGIN TRANSACTION

       BEGIN TRY
				/* Clearing down IATISchema tables before re-populating them */
				DELETE FROM [IATISchema].[activity-date]
				DELETE FROM [IATISchema].[budget]
				DELETE FROM [IATISchema].[capital-spend]
				DELETE FROM [IATISchema].[collaboration-type]
				DELETE FROM [IATISchema].[conditions]
				DELETE FROM [IATISchema].[conditions/condition]
				DELETE FROM [IATISchema].[contact-info]
				DELETE FROM [IATISchema].[contact-info/details]
				DELETE FROM [IATISchema].[country-budget-items]
				DELETE FROM [IATISchema].[country-budget-items/budget-item]
				DELETE FROM [IATISchema].[crs-add]
				DELETE FROM [IATISchema].[crs-add/channel-code]
				DELETE FROM [IATISchema].[crs-add/loan-status]
				DELETE FROM [IATISchema].[crs-add/loan-status/interest-arrears]
				DELETE FROM [IATISchema].[crs-add/loan-status/interest-received]
				DELETE FROM [IATISchema].[crs-add/loan-status/principal-arrears]
				DELETE FROM [IATISchema].[crs-add/loan-status/principal-outstanding]
				DELETE FROM [IATISchema].[crs-add/loan-terms]
				DELETE FROM [IATISchema].[crs-add/loan-terms/commitment-date]
				DELETE FROM [IATISchema].[crs-add/loan-terms/repayment-final-date]
				DELETE FROM [IATISchema].[crs-add/loan-terms/repayment-first-date]
				DELETE FROM [IATISchema].[crs-add/loan-terms/repayment-plan]
				DELETE FROM [IATISchema].[crs-add/loan-terms/repayment-type]
				DELETE FROM [IATISchema].[crs-add/other-flags]
				DELETE FROM [IATISchema].[default-aid-type]
				DELETE FROM [IATISchema].[description]
				DELETE FROM [IATISchema].[document-link]
				DELETE FROM [IATISchema].[document-link/category]
				DELETE FROM [IATISchema].[document-link/description]
				DELETE FROM [IATISchema].[document-link/document-date]
				DELETE FROM [IATISchema].[document-link/language]
				DELETE FROM [IATISchema].[document-link/title]
				DELETE FROM [IATISchema].[humanitarian-scope]
				DELETE FROM [IATISchema].[iati-activities]
				DELETE FROM [IATISchema].[iati-activity]
				DELETE FROM [IATISchema].[legacy-data]
				DELETE FROM [IATISchema].[location]
				DELETE FROM [IATISchema].[other-identifier]
				DELETE FROM [IATISchema].[participating-org]
				DELETE FROM [IATISchema].[policy-marker]
				DELETE FROM [IATISchema].[recipient-country]
				DELETE FROM [IATISchema].[recipient-region]
				DELETE FROM [IATISchema].[related-activity]
				DELETE FROM [IATISchema].[result]
				DELETE FROM [IATISchema].[result/description]
				DELETE FROM [IATISchema].[result/document-link]
				DELETE FROM [IATISchema].[result/document-link/category]
				DELETE FROM [IATISchema].[result/document-link/description]
				DELETE FROM [IATISchema].[result/document-link/document-date]
				DELETE FROM [IATISchema].[result/document-link/language]
				DELETE FROM [IATISchema].[result/document-link/title]
				DELETE FROM [IATISchema].[result/indicator]
				DELETE FROM [IATISchema].[result/indicator/baseline]
				DELETE FROM [IATISchema].[result/indicator/baseline/comment]
				DELETE FROM [IATISchema].[result/indicator/baseline/dimension]
				DELETE FROM [IATISchema].[result/indicator/baseline/document-link]
				DELETE FROM [IATISchema].[result/indicator/baseline/document-link/category]
				DELETE FROM [IATISchema].[result/indicator/baseline/document-link/description]
				DELETE FROM [IATISchema].[result/indicator/baseline/document-link/document-date]
				DELETE FROM [IATISchema].[result/indicator/baseline/document-link/language]
				DELETE FROM [IATISchema].[result/indicator/baseline/document-link/title]
				DELETE FROM [IATISchema].[result/indicator/baseline/location]
				DELETE FROM [IATISchema].[result/indicator/document-link]
				DELETE FROM [IATISchema].[result/indicator/document-link/category]
				DELETE FROM [IATISchema].[result/indicator/document-link/description]
				DELETE FROM [IATISchema].[result/indicator/document-link/document-date]
				DELETE FROM [IATISchema].[result/indicator/document-link/language]
				DELETE FROM [IATISchema].[result/indicator/document-link/title]
				DELETE FROM [IATISchema].[result/indicator/period]
				DELETE FROM [IATISchema].[result/indicator/period/actual]
				DELETE FROM [IATISchema].[result/indicator/period/actual/comment]
				DELETE FROM [IATISchema].[result/indicator/period/actual/dimension]
				DELETE FROM [IATISchema].[result/indicator/period/actual/document-link]
				DELETE FROM [IATISchema].[result/indicator/period/actual/document-link/category]
				DELETE FROM [IATISchema].[result/indicator/period/actual/document-link/description]
				DELETE FROM [IATISchema].[result/indicator/period/actual/document-link/document-date]
				DELETE FROM [IATISchema].[result/indicator/period/actual/document-link/language]
				DELETE FROM [IATISchema].[result/indicator/period/actual/location]
				DELETE FROM [IATISchema].[result/indicator/period/period-end]
				DELETE FROM [IATISchema].[result/indicator/period/period-start]
				DELETE FROM [IATISchema].[result/indicator/period/target]
				DELETE FROM [IATISchema].[result/indicator/period/target/comment]
				DELETE FROM [IATISchema].[result/indicator/period/target/dimension]
				DELETE FROM [IATISchema].[result/indicator/period/target/document-link]
				DELETE FROM [IATISchema].[result/indicator/period/target/document-link/category]
				DELETE FROM [IATISchema].[result/indicator/period/target/document-link/description]
				DELETE FROM [IATISchema].[result/indicator/period/target/document-link/document-date]
				DELETE FROM [IATISchema].[result/indicator/period/target/document-link/language]
				DELETE FROM [IATISchema].[result/indicator/period/target/document-link/title]
				DELETE FROM [IATISchema].[result/indicator/period/target/location]
				DELETE FROM [IATISchema].[result/indicator/reference]
				DELETE FROM [IATISchema].[result/indicator/title]
				DELETE FROM [IATISchema].[result/reference]
				DELETE FROM [IATISchema].[result/title]
				DELETE FROM [IATISchema].[sector]
				DELETE FROM [IATISchema].[tag]
				DELETE FROM [IATISchema].[title]
				DELETE FROM [IATISchema].[transaction]
				DELETE FROM [IATISchema].[transaction/aid-type]

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
                           SELECT LEFT(ComponentLastUpdate.ComponentId,6) AS ProjectId, ComponentLastUpdate.ComponentId,  CONVERT(DATETIME,ComponentLastUpdate.UpdatedDate)
                           FROM 
                           (
                                         SELECT FullComponentList.ComponentId, MAX(LastUpdated) As UpdatedDate
                                         FROM
                                                (-- Return the last updated date of all components on days when there was not a system issue (i.e. a balance table problem) causing a huge number of updates
                                                SELECT ip.ComponentId, MAX(DATEADD(d,-1,CONVERT(DATE,v.StartDateTime))) AS LastUpdated
                                                FROM [ProjectDataMart].[AgressoTransformation].IATIKeyDataComponentTransformed ip
                                                LEFT JOIN [ProjectDataMart].[Configuration].[Version] v ON ip.[FromVersionId] = v.[VersionId]
                                                WHERE ip.FromVersionId NOT IN (SELECT VersionId FROM [ProjectDataMart].[Configuration].VersionedObjectRefreshHistory WHERE VersionedObjectId = 314 AND VersionedRows > 10000)
                                                Group By ip.ComponentID
                                                UNION ALL
                                                -- Get the first date that every component appears within the table, unioning this table will return all components that were first created on one of the excluded versions (see above)
                                                SELECT ip.ComponentId, MIN(DATEADD(d,-1,CONVERT(DATE,v.StartDateTime))) AS LastUpdated
                                                FROM [ProjectDataMart].[AgressoTransformation].IATIKeyDataComponentTransformed ip
                                                LEFT JOIN [ProjectDataMart].[Configuration].[Version] v ON ip.[FromVersionId] = v.[VersionId]
                                                Group BY ip.ComponentID
                                                UNION ALL
                                                --Get the last updated date from the published transactions
                                                SELECT ia.ComponentId, MAX(CONVERT(DATE,tr.[transaction-date/@iso-date])) LastUpdated
                                                FROM [IATISchema].[transaction] tr
                                                INNER JOIN
                                                [IATISchema].[iati-activity] ia
                                                ON 
                                                tr.[iati-activityID] = ia.[iati-activityID]
                                                WHERE tr.[transaction-date/@iso-date] < GETDATE()
                                                Group By ia.ProjectId, ia.ComponentId) FullComponentList 
                                          Group By FullComponentList.ComponentID 
                           ) ComponentLastUpdate
               
                                                  UPDATE 
                                                                                 clu
              SET 
                     clu.LastUpdatedDate = vc.OperationalEndDate
              From 
                     @ComponentLastUpdatedDate  clu
              INNER JOIN
                     [PublicationControl].[v_Component] vc
              ON 
                     clu.ComponentId = vc.ComponentId
              Where 
                     clu.LastUpdatedDate='2012-04-05 00:00:00.000'
                                                                                       
              /* Store Last Updated Date for Projects */
              EXECUTE [PublicationControl].p_PrintProgress N'Populating @ProjectLastUpdatedDate'

              INSERT INTO
                     @ProjectLastUpdatedDate
              SELECT  ProjectLastUpdate.ProjectId,  CONVERT(DATETIME,MAX(ProjectLastUpdate.LastUpdated)) AS LastUpdatedDate
                                  FROM
                                         (   SELECT ip.ProjectId, DATEADD(d,-1,CONVERT(DATE,v.StartDateTime)) AS LastUpdated
                                                FROM [ProjectDataMart].[AgressoTransformation].IATIKeyDataProjectTransformed ip
                                                LEFT JOIN [ProjectDataMart].[Configuration].[Version] v ON ip.[FromVersionId] = v.[VersionId]
                                                WHERE ip.ToVersionId IS NULL 
                                                UNION ALL
                                                       -- Get the Last updtaed dates for Published Documents
                                                       SELECT [ProjectID], MAX([ExtractionDate]) AS LastUpdated  
                                                       FROM [PublicationControl].[PublishedDocuments]  
                                                       -- Don't include the dates when all doc refferences were deleted from the table due to a system error
                                                       WHERE ExtractionDate NOT IN ('2014-04-06', '2014-04-24') 
                                                       GROUP BY ProjectID
                                                UNION ALL
                                                       -- Get the Last updtaed dates for Geo Locations
                                                       SELECT [ProjectID], MAX([LastUpdated])
                                                       --FROM (SELECT * FROM  amp.[location].geocodes) as ampLocationGeocodes
                                                       FROM (SELECT * FROM  [PublicationControl].[LocationData]) as ampLocationGeocodes
                                                       WHERE [Confirmed] = 1 AND Deleted = 0 
                                                       GROUP BY ProjectID 
                                                UNION ALL
                                                       -- Get the Last updated dates for Geo Locations
                                                       SELECT ProjectId, MAX(LastUpdatedDate) AS LastUpdated 
                                                       FROM @ComponentLastUpdatedDate 
                                                       GROUP BY ProjectId 
                                           ) ProjectLastUpdate
                           GROUP BY ProjectLastUpdate.ProjectId
              
                                                  UPDATE 
                                                                                 plu
              SET 
                     plu.LastUpdatedDate = vp.OperationalEndDate
              From 
                     @ProjectLastUpdatedDate  plu
              INNER JOIN
                     [PublicationControl].[v_Project] vp
              ON 
                     plu.ProjectId = vp.ProjectId
              Where 
                     plu.LastUpdatedDate='2012-04-05 00:00:00.000'

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
                           SET @DFIDOrganisationIdentifier = (SELECT ISNULL(Code, 'GB-GOV-1') FROM [Codelist].[OrganisationIdentifier] WHERE NAME='Department for International Development')
                     END

                     /* Store Meta-Data associated with p_populate run in [iati-activities] */

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activities'

                     INSERT INTO
                           [IATISchema].[iati-activities]
                     VALUES
                     (
                           @ActivitiesId                                                                      -- [iati-activitiesID]
                           ,'Real Data'                                                                       -- [Name]
                           ,NULL                                                                                     -- [Notes]
                           ,DEFAULT                                                                                  -- [@version]
                           ,@GeneratedDateTime                                                                -- [@generated-datetime]
                           ,DEFAULT                                                                                  -- [ir:registry-record/@xml:lang]                      
                           ,@DFIDOrganisationIdentifier                                                -- [ir:registry-record/@file-id]                       
                           ,'http://dfid.gov.uk/projects/iati/activities.xml'            -- [ir:registry-record/@source-url]                
                           ,@DFIDOrganisationIdentifier                                                -- [ir:registry-record/@publisher-id]                  
                           ,'Funding'                                                                                -- [ir:registry-record/@publisher-role]         
                           ,'devtracker-feedback@dfid.gov.uk'                                   -- [ir:registry-record/@contact-email]             
                           ,@DFIDOrganisationIdentifier                                                -- [ir:registry-record/@donor-id]                      
                           ,10                                                                                             -- [ir:registry-record/@donor-type]                    
                           ,NULL                                                                                     -- [ir:registry-record/@donor-country]          
                           ,'DFID Activity File'                                                              -- [ir:registry-record/@title]                         
                           ,'All Periods'                                                                            -- [ir:registry-record/@activity-period]        
                           ,@GeneratedDateTime                                                    -- [ir:registry-record/@last-updated-datetime]
                           ,@GeneratedDateTime                                                                -- [ir:registry-record/@generated-datetime]     
                           ,1                                                                                              -- [ir:registry-record/@verification-status]    
                           ,'application/xml'                                                                 -- [ir:registry-record/@format]                        
                           ,'IATI'                                                                                         -- [ir:registry-record/@license]  
                     )

                     /* Store projects' data (e.g. level 1 IATI activities) in the [iati-activity] table*/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activity with projects'
                     EXECUTE [PublicationControl].p_PrintProgress N'@VersionIdInternal'

                     DECLARE @ProjectActivityMapping TABLE
                     (
                           [ProjectId]                       VARCHAR(25)          NOT NULL PRIMARY KEY
                           ,[iati-activityID]         INT                        NOT NULL UNIQUE
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
                           ,v_ProjectTransformed.ProjectId AS [ProjectId]
                           ,1 AS [@hierarchy],
                           CASE
                                  WHEN v_ProjectTransformed.ProjectId LIKE '3%' THEN @DFIDOrganisationIdentifier + '-' + v_ProjectTransformed.ProjectId
                                  ELSE @DFIDProjectIdentifier + '-' + v_ProjectTransformed.ProjectId
                           END AS [iati-identifier/text()]
                           ,@DFIDOrganisationIdentifier             
                           ,@DFIDOrganisationName
                           ,v_ProjectTransformed.ProjectId AS [ProjectIDText]
                           ,plud.LastUpdatedDate
                     FROM
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     INNER JOIN
                           @ProjectLastUpdatedDate plud
                     ON plud.ProjectId = v_ProjectTransformed.ProjectId
                     WHERE
                           v_ProjectTransformed.ProjectId IN
                           (
                                  SELECT DISTINCT
                                         ProjectId
                                  FROM
                                         (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectComponentMappingTransformed WHERE VersionId=@VersionIdInternal) v_ProjectComponentMappingTransformed
                                  INNER JOIN
                                         [PublicationControl].PopulationComponent Component
                                  ON
                                         Component.PopulationId = @PopulationId
                                         AND v_ProjectComponentMappingTransformed.ComponentId = Component.ComponentId
                                  WHERE
                                         v_ProjectComponentMappingTransformed.ProjectFlag = 'Y'
                                         AND v_ProjectComponentMappingTransformed.ComponentFlag = 'Y'
                           )
                     
                     /* Store components' data (e.g. level 2 IATI activities) in the [iati-activity] table*/
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating iati-activity with components'

                     DECLARE @ComponentActivityMapping TABLE
                     (
                           [ComponentId]              VARCHAR(25)          NOT NULL PRIMARY KEY
                           ,[ProjectId]               VARCHAR(25)          NOT NULL 
                           ,[iati-activityID]         INT                        NOT NULL UNIQUE
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
                           ,v_ComponentTransformed.ProjectId AS [ProjectId]
                           ,v_ComponentTransformed.ComponentId AS [ComponentId]
                           ,NULLIF(v_ComponentTransformed.BenefittingCountryCode, '') AS [BenefittingCountryCode]
                           ,[MappingBenefittingCountry].IATICountryCode AS [CountryCode]
                           ,[MappingBenefittingCountry].IATIRegionCode AS [RegionCode]
                           ,2 AS [@hierarchy],
                           CASE
                                  WHEN v_ComponentTransformed.ProjectId  LIKE '3%' THEN @DFIDOrganisationIdentifier + '-' + v_ComponentTransformed.ComponentId
                                  ELSE @DFIDProjectIdentifier + '-' + v_ComponentTransformed.ComponentId
                           END AS [iati-identifier/text()]
                           ,@DFIDOrganisationIdentifier             
                           ,@DFIDOrganisationName
                           ,v_ComponentTransformed.ComponentId AS [ComponentIDText]
                           ,clud.LastUpdatedDate
                     FROM
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     INNER JOIN
                           [PublicationControl].PopulationComponent Component
                     ON
                           Component.PopulationId = @PopulationId
                           AND v_ComponentTransformed.ComponentId = Component.ComponentId
                     INNER JOIN
                           @ComponentLastUpdatedDate clud
                     ON clud.ComponentId = v_ComponentTransformed.ComponentId
                     LEFT OUTER JOIN
                           [PublicationControl].[MappingBenefittingCountry]
                     ON
                           v_ComponentTransformed.BenefittingCountryCode = MappingBenefittingCountry.BenefittingCountryCode

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
                            [IATISchema].[iati-activity] ia
                     INNER JOIN
                            [PublicationControl].[MappingDFIDRegionToDACRegion] mr
                     ON 
                            ia.BenefittingCountryCode = mr.BenefittingCountryCode
                     Where 
                             ia.ComponentId IS NOT NULL
                            AND ia.BenefittingCountryCode IS NOT NULL
                            AND ia.RegionCode IS NULL
                            AND ia.CountryCode IS NULL
   
                       /* Store participating-org with funding and extending roles along with [iati-activityID] in [IATISchema].[participating-org]*/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating participating-org with funding, accountable and extending roles'

					 /* Funding, including identifying cross-government funds 
					    Assumption: that funding is determined by component level relationships with budget centres.
						Approach:
							1. Identify component funding orgs using subheadcodes
							2. Identify project-level funding orgs using aggregate of components
							3. Insert a union of the 2 tables into the participating-org table
					 */
					 
					 /* Drop Temporary objects */
					 IF OBJECT_ID('tempdb..#tempParticipatingOrgComponent', 'U') IS NOT NULL
                           DROP TABLE #tempParticipatingOrgComponent
					 IF OBJECT_ID('tempdb..#tempParticipatingOrgProject', 'U') IS NOT NULL
                           DROP TABLE #tempParticipatingOrgProject
					 	
					/*	1. Identify component funding using subheadcodes and insert into temp table */
						SELECT
							a.[iati-activityID] AS [iati-activityID]
							,a.ProjectId
							,a.ComponentId
							,NULL AS [@xml:lang]
							,CASE
								WHEN c.subheadcode is not null THEN s.[iati-orgcode]
								ELSE 'GB-GOV-1' END AS [@ref]
							,'10' AS [@type] -- Government
							,'1' AS [@role] -- Funding
							,CASE
							    WHEN c.subheadcode is not null THEN s.title
								ELSE 'Department for International Development' END AS [text()]
						INTO #tempParticipatingOrgComponent
						FROM
							[IATISchema].[iati-activity] a
						LEFT JOIN
							PublicationControl.v_CrossGov_Funds c on a.ComponentId = c.ComponentId
						LEFT OUTER JOIN
							PublicationControl.CrossGovFundsSubheads s on c.subheadcode = s.subheadcode
						WHERE
							a.[iati-activitiesID] =  101
							and a.ComponentId is not NULL

					/* 2. Identify project-level funding orgs using aggregate of components and insert into temp table */

						SELECT DISTINCT
							a.[iati-activityID] AS [iati-activityID]
							,t.ProjectId
							,null AS ComponentId
							,NULL AS [@xml:lang]
							,t.[@ref]
							,t.[@type] 
							,t.[@role]
							,t.[text()]
						INTO #tempParticipatingOrgProject
						FROM #tempParticipatingOrgComponent t
						LEFT JOIN IATISchema.[iati-activity] a
						on a.ProjectId = t.ProjectId
						WHERE a.ComponentId is null
						order by t.ProjectId

					/* 3. Insert funding organisation results into participating-org table */

						INSERT INTO
							[IATISchema].[participating-org]
						(
							--[participating-orgID]
							[iati-activityID]
							,[@xml:lang]
							,[@ref]
							,[@type]
							,[@role]
							,[text()]
						)						
						SELECT 
							[iati-activityID]
							,[@xml:lang]
							,[@ref]
							,[@type]
							,[@role]
							,[text()] 
						FROM #tempParticipatingOrgProject
						UNION 
						SELECT 
							[iati-activityID]
							,[@xml:lang]
							,[@ref]
							,[@type]
							,[@role]
							,[text()] 
						FROM #tempParticipatingOrgComponent 

 
 					 /* Accountable organisations (in this case DFID only) */

                     INSERT INTO
                           [IATISchema].[participating-org]
                     (
                           --[participating-orgID]
                           [iati-activityID]
                           ,[@xml:lang]
                           ,[@ref]
                           ,[@type]
                           ,[@role]
                           ,[text()]
                     )
                     SELECT
                           [iati-activity].[iati-activityID] AS [iati-activityID]
                           ,NULL AS [@xml:lang]
                           ,'GB-GOV-1' AS [@ref]
                           ,'10' AS [@type] -- Government
                           ,'2' AS [@role] -- Accountable
						   ,'Department for International Development' AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     WHERE
                           [iati-activity].[iati-activitiesID] =  @ActivitiesId 

					 /* Extending */

                     INSERT INTO
                           [IATISchema].[participating-org]
                     (
                           --[participating-orgID]
                           [iati-activityID]
                           ,[@xml:lang]
                           ,[@ref]
                           ,[@type]
                           ,[@role]
                           ,[text()]
                     )
                     SELECT
                           [iati-activity].[iati-activityID] AS [iati-activityID]
                           ,NULL AS [@xml:lang]
                           ,'GB-GOV-1' AS [@ref]
                           ,'10' AS [@type] -- Government
                           ,'3' AS [@role] -- Extending
						   ,'Department for International Development' AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     WHERE
                           [iati-activity].[iati-activitiesID] =  @ActivitiesId
   
                    
                    /* Store recipient-country along with [iati-activityID] in [IATISchema].[other-identifier]*/

					EXECUTE [PublicationControl].p_PrintProgress N'Populating other-identifier with Type A1'

                    INSERT INTO 
                                [IATISchema].[other-identifier]
                    (
                                [iati-activityID]
                                ,[@ref]
                                ,[@type]
								,[owner-org/@ref]
								,[owner-org/text()]
                    )
                    SELECT
                           [iati-activity].[iati-activityID] AS [iati-activityID]
                           ,[other-identifier/text()] AS [@ref]                                
                           ,'A1' AS [@type]                     
						   ,[other-identifier/@owner-ref] AS [owner-org/@ref]
                           ,ISNULL([other-identifier/@owner-name], OtherIdentifierOwner.Name) AS [owner-org/text()]        
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                                                [Codelist].OrganisationIdentifier OtherIdentifierOwner
                                  ON
                                                [iati-activity].[other-identifier/@owner-ref] = OtherIdentifierOwner.Code
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId

                    EXECUTE [PublicationControl].p_PrintProgress N'Populating other-identifier with Type B1'

					INSERT INTO 
								[IATISchema].[other-identifier]
					(
								[iati-activityID]
								,[@ref]
                                ,[@type]
								,[owner-org/@ref]
								,[owner-org/text()]
					)
					SELECT
                           [iati-activity].[iati-activityID] AS [iati-activityID]
                           ,'GB-1' AS [@ref]                                
                           ,'B1' AS [@type]                     
						   ,[other-identifier/@owner-ref] AS [owner-org/@ref]
                           ,'DFID previous reporting-org identifier' AS [owner-org/text()]       
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                                                [Codelist].OrganisationIdentifier OtherIdentifierOwner
                                  ON
                                                [iati-activity].[other-identifier/@owner-ref] = OtherIdentifierOwner.Code
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                     
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
                           ,[MappingBenefittingCountry].[IATICountryName] AS [text()]         
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                            --(SELECT * FROM [ProjectDataMart].AgressoTransformation.v_BenefittingCountryTransformed WHERE VersionId=@VersionIdInternal) v_BenefittingCountryTransformed
                                                [PublicationControl].[MappingBenefittingCountry]
                     ON
                           [iati-activity].BenefittingCountryCode = [MappingBenefittingCountry].BenefittingCountryCode
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

					 /*** Set the Default Aid Type based on the: Views, DAC sectors and Markers***/

        			 INSERT INTO [IATISchema].[default-aid-type]
					 (     
						   [iati-activityID]
						  ,[@code]
						  ,[@vocabulary]
					 )
					 SELECT
						   [iati-activityID] AS [iati-activityID] 	
                           ,CASE
                                  WHEN v_ComponentTransformed.FundingTypeCode = 'GENBUDGETSUPPORT' THEN 'A01'
                                  WHEN v_ComponentTransformed.FundingTypeCode = 'SECTORBUDGETSUPPORT' THEN 'A02'
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 3 THEN 'B01'
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 2 THEN 'B02'
                                  WHEN v_ComponentTransformed.FundingTypeCode = 'OTHERBILATERALDONOR' THEN 'B04'
                                  WHEN v_ComponentTypeOfFinanceTransformed.TypeOfFinanceCode IN ('610', '611', '612', '613', '614', '615', '616', '617', '618') THEN 'F01'
                                  WHEN sector.DACSectorCode = '91010' THEN 'G01'
                                  WHEN sector.DACSectorCode = '99820' THEN 'H01'
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 THEN 'C01'
                            END AS [@code]
                           ,'1' AS [@vocabulary]
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentTransformed.ComponentId
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentBiMultiMarkerTransformed WHERE VersionId=@VersionIdInternal) v_ComponentBiMultiMarkerTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentBiMultiMarkerTransformed.ComponentId
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTypeOfFinanceTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTypeOfFinanceTransformed
                     ON
                           v_ComponentTypeOfFinanceTransformed.Rank = 1
                           AND [iati-activity].ComponentId = v_ComponentTypeOfFinanceTransformed.ComponentId
                     LEFT OUTER JOIN
                     (
                           SELECT
                                  v_ComponentInputSectorTransformed.ComponentId
                                  ,v_InputSectorTransformed.DACSectorCode
                                  ,ROW_NUMBER() OVER (PARTITION BY v_ComponentInputSectorTransformed.ComponentId ORDER BY SUM(Percentage) DESC) AS Rank
                           FROM
                                  (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                           INNER JOIN
                                  (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_InputSectorTransformed WHERE VersionId=@VersionIdInternal) v_InputSectorTransformed
                           ON
                                  v_ComponentInputSectorTransformed.InputSectorCode = v_InputSectorTransformed.InputSectorCode
                           GROUP BY
                                  v_ComponentInputSectorTransformed.ComponentId
                                  ,v_InputSectorTransformed.DACSectorCode
                     ) sector
                     ON
                           sector.Rank = 1
                           AND [iati-activity].ComponentId = sector.ComponentId
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                           AND [iati-activity].ComponentId IS NOT NULL


                     /*** collaboration-type ***/

                     UPDATE
                           [iati-activity]
                     SET
                           [collaboration-type/@xml:lang] = NULL
                           ,[collaboration-type/@code] = 
                                  CASE
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 AND LEFT(v_ComponentTransformed.ChannelCode, 1) = '2' THEN 3
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 3 AND LEFT(v_ComponentTransformed.ChannelCode, 1) = '2' THEN 3
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 AND LEFT(v_ComponentTransformed.ChannelCode, 1) = '3' THEN 3
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 1 THEN 1
                                  WHEN v_ComponentBiMultiMarkerTransformed.BiMultiMarkerCode = 2 THEN 2
                                  END
                           ,[collaboration-type/@type] = NULL
                           ,[collaboration-type/text()] = NULL
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentTransformed.ComponentId
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentBiMultiMarkerTransformed WHERE VersionId=@VersionIdInternal) v_ComponentBiMultiMarkerTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentBiMultiMarkerTransformed.ComponentId
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
                                  WHEN v_ComponentTransformed.ODAOOFMarkerCode = 'ODA' THEN '10'
                                  WHEN v_ComponentTransformed.ODAOOFMarkerCode = 'OOF' THEN '20'
                                  END
                           ,[default-flow-type/@type] = NULL
                           ,[default-flow-type/text()] = NULL
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentTransformed.ComponentId
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                           AND [iati-activity].ComponentId IS NOT NULL

                    /*** default-finance-type ***/

                     UPDATE
                           [iati-activity]
                     SET
                           [default-finance-type/@xml:lang] = NULL
                           ,[default-finance-type/@code] = v_ComponentTypeOfFinanceTransformed.TypeOfFinanceCode
                           ,[default-finance-type/@type] = NULL
                           ,[default-finance-type/text()] = NULL
                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentTransformed.ComponentId
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTypeOfFinanceTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTypeOfFinanceTransformed
                     ON
                           v_ComponentTypeOfFinanceTransformed.Rank = 1
                           AND [iati-activity].ComponentId = v_ComponentTypeOfFinanceTransformed.ComponentId
                     INNER JOIN
                           [Codelist].FinanceType
                     ON
                           v_ComponentTypeOfFinanceTransformed.TypeOfFinanceCode = FinanceType.Code
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                           AND [iati-activity].ComponentId IS NOT NULL

                     /* other-identifier */

                     -- No Action

                     /* Populate Project Title along with [iati-activityID] in [IATISchema].[title]*/
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating title for projects and components'

                     INSERT INTO
                           [IATISchema].[title]
                     (
                           [iati-activityID]    
                           ,[@xml:lang]               
                           ,[text()]                  
                     )
                     SELECT
                           ProjectActivityMapping.[iati-activityID] AS [iati-activityID] 
                           ,NULL
                           ,v_ProjectTransformed.ProjectTitle
                     FROM
                           @ProjectActivityMapping ProjectActivityMapping
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           ProjectActivityMapping.ProjectId = v_ProjectTransformed.ProjectId
                     UNION ALL
                     SELECT
                           ComponentActivityMapping.[iati-activityID] AS [iati-activityID]      
                           ,NULL
                           ,v_ComponentTransformed.ComponentTitle
                    FROM
                           @ComponentActivityMapping ComponentActivityMapping
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           ComponentActivityMapping.ComponentId = v_ComponentTransformed.ComponentId

                     /* Populate Project Description along with [iati-activityID] in [IATISchema].[description]*/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating description for projects and components'

                     INSERT INTO
                           [IATISchema].[description]
                     (
                           [iati-activityID]    
                           ,[@xml:lang]  
						   ,[@type]                 
                           ,[text()]                  
                     )
                     SELECT
                           ProjectActivityMapping.[iati-activityID] AS [iati-activityID] 
                           ,NULL
						   ,NULL
                           ,v_ProjectTransformed.MostRecentPurpose
                     FROM
                           @ProjectActivityMapping ProjectActivityMapping
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           ProjectActivityMapping.ProjectId = v_ProjectTransformed.ProjectId
                     WHERE
                           v_ProjectTransformed.MostRecentPurpose != ''

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
                           ,v_InputSectorTransformed.DACSectorCode AS [@code]
                           ,NULL AS [@type]
                           ,NULL AS [@other-code]
                           ,NULL AS [@vocabulary] -- 1 is the default for OECD DAC CRS
                           ,NULLIF(v_ComponentInputSectorTransformed.percentage, 100) AS [@percentage]
                           ,v_InputSectorTransformed.DACSectorName As [text()]
                     FROM
                           @ComponentActivityMapping ComponentActivityMapping
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           v_ComponentInputSectorTransformed.Percentage != 0
                           AND ComponentActivityMapping.ComponentId = v_ComponentInputSectorTransformed.ComponentId
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_InputSectorTransformed WHERE VersionId=@VersionIdInternal) v_InputSectorTransformed
                     ON
                           v_ComponentInputSectorTransformed.InputSectorCode = v_InputSectorTransformed.InputSectorCode
                     INNER JOIN
                           [Codelist].DAC5DigitSector
                     ON
                           v_InputSectorTransformed.DACSectorCode = DAC5DigitSector.Code

                     
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
                                  WHEN ActivityDateType.Code='1' THEN v_ProjectTransformed.OperationalStartDate
                                  WHEN ActivityDateType.Code='3' THEN v_ProjectTransformed.OperationalEndDate
                                  WHEN ActivityDateType.Code='2' THEN v_ProjectTransformed.ApprovalDate
                                  WHEN ActivityDateType.Code='4' AND v_ProjectTransformed.OperationalEndDate<GETDATE() THEN v_ProjectTransformed.OperationalEndDate  
                                  END AS [@iso-date]
                                  ,NULL AS [text()]    
                           FROM
                                  [IATISchema].[iati-activity]
                           INNER JOIN 
                                  (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                           ON
                                  [iati-activity].ProjectId = v_ProjectTransformed.ProjectId
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
                                  WHEN ActivityDateType.Code='1' THEN v_ComponentTransformed.OperationalStartDate
                                  WHEN ActivityDateType.Code='3' THEN v_ComponentTransformed.OperationalEndDate
                                  WHEN ActivityDateType.Code='2' THEN v_ComponentTransformed.OperationalStartDate
                                  WHEN ActivityDateType.Code='4' AND v_ComponentTransformed.OperationalEndDate<GETDATE() THEN v_ComponentTransformed.OperationalEndDate       
                                  END AS [@iso-date]
                                  ,NULL AS [text()]    
                           FROM
                                  [IATISchema].[iati-activity]
                           INNER JOIN 
                                  (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                           ON
                                  [iati-activity].ComponentId = v_ComponentTransformed.ComponentId
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
                           WHEN v_ProjectTransformed.StageCode IN ('0', '1', '2', '3', '4') THEN 1
                           WHEN v_ProjectTransformed.StageCode IN ('5') THEN 2
                           WHEN v_ProjectTransformed.StageCode IN ('6') THEN 3
                           WHEN v_ProjectTransformed.StageCode IN ('7','8') THEN 4
                           ELSE NULL
                           END
                           ,[activity-status/@type] = NULL
                           ,[activity-status/text()] = NULL -- text filled automatically by view if no explicit name specified
                     FROM
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                           AND [iati-activity].ProjectId = v_ProjectTransformed.ProjectId

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
                                            --,[website/text()]
                     )
                     SELECT
                           [contact-info].[contact-infoID] AS [contact-infoID]
                           ,'+44 (0) 1355 84 3132' AS [telephone/text()]
                          ,'enquiry@dfid.gov.uk' AS [email/text()]
                           ,'Public Enquiry Point, Abercrombie House, Eaglesham Road, East Kilbride, Glasgow G75 8EA' AS [mailing-address/text()]
                                            --,[PublicationControl].[ProjectWebsite].[website/text()] AS [website/text()]
                     FROM
                           [IATISchema].[contact-info]
                     INNER JOIN
                           [IATISchema].[iati-activity]
                     ON
                           [contact-info].[iati-activityID] = [iati-activity].[iati-activityID]
                                  -- INNER JOIN
                                  --          [PublicationControl].[ProjectWebsite]
                                  -- ON
                                  --           [iati-activity].[projectid] = [PublicationControl].[ProjectWebsite].projectid
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN v_ProjectTransformed.CCOGenderEqualityCode = 'PRINCIPAL' THEN 2
                           WHEN v_ProjectTransformed.CCOGenderEqualityCode = 'SIGNIFICANT' THEN 1
                           ELSE 0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           --f_ProjectTransformed.CCOGenderEqualityCode != ''
                           [iati-activity].ProjectId = v_ProjectTransformed.ProjectId
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN v_ProjectTransformed.DSOClimateChange = 'Principal' THEN 2
                           WHEN v_ProjectTransformed.DSOClimateChange = 'Significant' THEN 1
                           ELSE 0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           --f_ProjectTransformed.DSOClimateChange != ''
                           [iati-activity].ProjectId = v_ProjectTransformed.ProjectId
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN
                                  SUM(
                                         CASE
                                         WHEN
                                                v_ComponentInputSectorTransformed.LineNumber = 1 AND
                                                (
                                                       v_ComponentInputSectorTransformed.InputSectorCode IN ('15130', '15150', '15210', '15220', '15230', '15240', '15261')
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '1512%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '1514%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '1516%'
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
                                                v_ComponentInputSectorTransformed.InputSectorCode IN ('15130', '15150', '15210', '15220', '15230', '15240', '15261')
                                                OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '1512%'
                                                OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '1514%'
                                                OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '1516%'
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
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentInputSectorTransformed.ComponentId
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN
                                  SUM(
                                         CASE
                                         WHEN
                                                (
                                                       v_ComponentInputSectorTransformed.InputSectorCode IN ('33210', '25010')
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '240%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '311%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '312%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '313%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '321%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '322%'
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
                                                v_ComponentInputSectorTransformed.LineNumber = 1 AND
                                                (
                                                       v_ComponentInputSectorTransformed.InputSectorCode IN ('33210', '25010')
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '240%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '311%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '312%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '313%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '321%'
                                                       OR v_ComponentInputSectorTransformed.InputSectorCode LIKE '322%'
                                                )
                                         THEN
                                                1
                                         ELSE
                                                0                    
                                         END
                                  ) > 0
                                  AND SUM(CASE WHEN v_ComponentInputSectorTransformed.InputSectorCode IN ('33110', '33120', '33130', '33140', '33150', '33181') THEN 1 ELSE 0 END) > 0
                           THEN
                                  1
                           ELSE
                                  0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentInputSectorTransformed.ComponentId
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN SUM(CASE WHEN v_ComponentInputSectorTransformed.LineNumber = 1 AND v_ComponentInputSectorTransformed.InputSectorCode IN ('41031') THEN 1 ELSE 0 END) > 0 THEN 2
                           WHEN SUM(CASE WHEN v_ComponentInputSectorTransformed.InputSectorCode IN ('41031') THEN 1 ELSE 0 END) > 0 THEN 1
                           ELSE 0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentInputSectorTransformed.ComponentId
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN SUM(CASE WHEN v_ComponentInputSectorTransformed.InputSectorCode IN ('41033') THEN percentage ELSE 0 END) >= 50 THEN 2
                           WHEN SUM(CASE WHEN v_ComponentInputSectorTransformed.InputSectorCode IN ('41033') THEN percentage ELSE 0 END) > 0 THEN 1
                           ELSE 0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentInputSectorTransformed.ComponentId
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN SUM(CASE WHEN v_ComponentInputSectorTransformed.InputSectorCode IN ('23010', '23030', '80017', '80019', '80023', '41032') THEN 1 ELSE 0 END) > 0 THEN
                                  CASE v_ProjectTransformed.DSOClimateChange WHEN 'Principal' THEN 2 WHEN 'Significant' THEN 1 ELSE 0 END
                           ELSE 0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           [iati-activity].ProjectId = v_ProjectTransformed.ProjectId
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentInputSectorTransformed.ComponentId
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                           AND [iati-activity].ComponentId IS NOT NULL
                     GROUP BY
                           [iati-activity].[iati-activityID]
                           ,v_ProjectTransformed.DSOClimateChange
                     
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
                           ,'1' AS [@vocabulary]
                           ,CASE
                           WHEN SUM(CASE WHEN v_ComponentInputSectorTransformed.InputSectorCode IN ('12262', '14010', '14015', '14040', '31110', '31130', '41010', '41050', '74010', '80018', '80020') THEN 1 ELSE 0 END) > 0 THEN
                                  CASE v_ProjectTransformed.DSOClimateChange WHEN 'Principal' THEN 2 WHEN 'Significant' THEN 1 ELSE 0 END
                           ELSE 0
                           END AS [@significance]
                           ,NULL AS [text()]
                     FROM
                           [IATISchema].[iati-activity]
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           [iati-activity].ProjectId = v_ProjectTransformed.ProjectId
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           [iati-activity].ComponentId = v_ComponentInputSectorTransformed.ComponentId
                     WHERE
                           [iati-activity].[iati-activitiesID] = @ActivitiesId
                           AND [iati-activity].ComponentId IS NOT NULL
                     GROUP BY
                           [iati-activity].[iati-activityID]
                           ,v_ProjectTransformed.DSOClimateChange

                                  
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
									-- locationID automatic
									ia.[iati-activityID]
									,null as [@ref] --keep as null
									,CASE 
										WHEN country.[Name] is not null THEN 'A4'
										ELSE null
										END as [location-id/@vocabulary]
									,CASE 
										WHEN country.[Name] is not null THEN [administrative/@country]
										ELSE null
										END as [location-id/@code]
									,null as [name/narrative/@xml:lang]
									,ld.[name/text()]
									,null as [description/narrative/@xml:lang]
									,CASE 
										WHEN country.[Name] is not null THEN 'Representation of country-level for ' + convert(varchar(max),ld.[administrative/text()])
										ELSE convert(varchar(max),ld.[administrative/text()])
										END as [description/narrative]
									,null as [activity-description/narrative/@xml:lang]
									,null as [activity-description/narrative]
									,null as [adaministrative/@level] 
									,CASE 
										WHEN country.[Name] is not null THEN [administrative/@country]
										ELSE null
										END as [administrative/@code] 
									,CASE 
										WHEN country.[Name] is not null THEN 'A4'
										ELSE null
										END as [administrative/@vocabulary]
									,'http://www.opengis.net/def/crs/EPSG/0/4326' as [point/@srsName]
									,LTRIM(RTRIM(STR([coordinates/@latitude],20,20))) + ' ' + LTRIM(RTRIM(STR([coordinates/@longitude],20,20))) as [point/pos]
									,case 
											when ld.[coordinates/@precision] in (1,3,4,6) THEN 1
											else 2 
									end as [exactness/@code]
									,2 as [location-reach/@code] --activity =1 ; beneficiary location =2
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
									ld.projectID = ia.ProjectId and ia.ComponentId IS NULL
								left outer join
									(select [Name] from Codelist.Country 
										union select 'Congo (DRC)'
										union select 'Democratic Republic of Congo' 
										union select 'Republic of the Congo' 
										union select 'Ivory Coast'
										union select 'Tanzania'
										union select 'Fiji Islands'
										union select 'Syria'
										union select 'Libya'
										union select 'Bolivia'
										union select 'FYRO Macedonia'
										union select 'Macedonia'
										union select 'Iran'
										union select 'Laos'
										union select 'Myanmar(Burma)'
										union select 'Vietnam'
										union select 'Venezuela'
									) country	
								on
									upper(convert(varchar(max),[administrative/text()])) = country.[Name]

					EXECUTE [PublicationControl].p_PrintProgress N'Adding geolocation data at country level from benefitting country';

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
								-- locationID automatic
								p.[iati-activityID]
								,null as [@ref] --keep as null
								,'A4' as [location-id/@vocabulary]
								,c.[@code] as [location-id/@code]
								,null as [name/narrative/@xml:lang]	-- usually NULL
								,c.[text()] AS [name/narrative]
								,null as [description/narrative/@xml:lang]	-- usually NULL
								,'Representation of country-level for ' + convert(varchar(max),c.[text()]) AS [description/narrative]
								,null as [activity-description/narrative/@xml:lang]	-- usually NULL
								,null as [activity-description/narrative]				-- usually NULL
								,null as [administrative/@level]						-- usually NULL
								,c.[@code] as [administrative/@code]
								,'A4' as [administrative/@vocabulary]		--A4 represents ISO code vocabulary
								,'http://www.opengis.net/def/crs/EPSG/0/4326' as [point/@srsName]
								,LTRIM(RTRIM(STR(pc.[coordinates/@latitude],20,20))) + ' ' + LTRIM(RTRIM(STR(pc.[coordinates/@longitude],20,20))) as [point/pos]
								,2 as [exactness/@code]			-- approximate
								,2 as [location-reach/@code]	-- activity location
								,1 as [location-class/@code]	-- administrative region
								,'ADM1' as [feature-designation/@code]
							from IATISchema.[iati-activity] a
							inner join IATISchema.[recipient-country] c
							on a.[iati-activityID] = c.[iati-activityID]
							inner join
							(select * from IATISchema.[iati-activity] where ComponentId is null) p
							on p.ProjectId = a.ProjectId
							inner join PublicationControl.MappingRecipientCountryRegionToLocation pc
							on pc.[IATICountryCode] = c.[@code]
							where a.ProjectId not in
							(
								select distinct a.ProjectId from IATISchema.[iati-activity] a
								inner join IATIschema.[location] l
								on a.[iati-activityID] = l.[iati-activityID]
							)
							--and ComponentId is null

                     /*** budgets and transactions building segments are starting from here ***/
                     
                     
                     /* Storing Component wise budget related value in temporary Table*/
                     EXECUTE [PublicationControl].p_PrintProgress N'Building budget values';

                     IF OBJECT_ID('tempdb..#temp', 'U') IS NOT NULL
                           DROP TABLE #temp

                     
                     SELECT
                           ComponentActivityMapping.[iati-activityID]
                           ,ComponentActivityMapping.ComponentId AS [ComponentId]
                           ,v_BalanceTransformed.FiscalYear
                           ,v_BalanceTransformed.BudgetOriginal
                           ,v_BalanceTransformed.BudgetCurrent
                           ,v_BalanceTransformed.FiscalPeriod
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
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_BalanceTransformed WHERE VersionId=@VersionIdInternal) v_BalanceTransformed
                     ON
                           ComponentActivityMapping.ComponentId = v_BalanceTransformed.ComponentId
                     INNER JOIN 
                           (SELECT * FROM [ProjectDataMart].AgressoSourceData.v_aglrelvalue WHERE VersionID=@VersionIdInternal) v_aglrelvalue
                     ON 
                           v_BalanceTransformed.AccountCode = v_aglrelvalue.att_value and v_aglrelvalue.attribute_id = 'A0' and v_aglrelvalue.rel_attr_id = 'S14' and v_aglrelvalue.rel_value = 'yes'
                     
                     
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
                           ,CASE WHEN (SUM(FQRange.[budget-current]) = SUM(FQRange.[budget-original])) THEN '1' ELSE '2' END as [@type]
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
                           ,NULL AS [value/@currency] 
                           ,[IATISchema].[f_ActivityActualStartDate]([iati-activityID]) AS [value/@value-date]
                           ,NULL AS [value/@type]            
                           ,SUM(BudgetCurrent) AS [value/text()]           
                           ,NULL AS [transaction-type/@xml:lang]
                           ,'2' AS [transaction-type/@code]
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
                                  v_agltransact.account,
                                  v_agltransact.amount,
                                  v_agltransact.apar_id,
                                  v_agltransact.apar_type,
                                  v_agltransact.client,
                                  v_agltransact.cur_amount,
                                  v_agltransact.currency,
                                  v_agltransact.dc_flag,
                                  v_agltransact.description,
                                  v_agltransact.dim_1,
                                  v_agltransact.dim_4,
                                  v_agltransact.dim_7,
                                  v_agltransact.ext_inv_ref,
                                  v_agltransact.ext_ref,
                                  v_agltransact.fiscal_year,
                                  v_agltransact.last_update,
                                  v_agltransact.order_id,
                                  v_agltransact.period,
                                  v_agltransact.sequence_no,
                                  v_agltransact.status,
                                  v_agltransact.tax_code,
                                  v_agltransact.tax_system,
                                  v_agltransact.trans_date,
                                  v_agltransact.trans_id,
                                  v_agltransact.user_id,
                                  v_agltransact.voucher_date,
                                  v_agltransact.voucher_no,
                                  v_agltransact.voucher_type,
                                  v_agltransact.agrtid,
                                  CASE WHEN v_agltransact.account <= '4999' THEN 'Y' ELSE 'N' END AS IsExpenditureAccount,
                                  /* Handle promissory notes and provisions */
                                  CASE WHEN (v_agltransact.account <= '4999' AND v_agltransact.account NOT IN ('3204','3205','3501') ) OR (v_agltransact.account IN ('6002', '6008', '6013', '6020', '6022')) THEN 'Y' ELSE 'N' END AS IsIncludedAccount,
                                  CASE WHEN SUM(CASE WHEN v_agltransact.account IN ('6001', '6003', '6004', '6005', '6007', '6009', '6010', '6012', '6014', '6015', '6021', '6023', '6024') THEN 1 ELSE 0 END) OVER (PARTITION BY v_agltransact.client, v_agltransact.voucher_type, v_agltransact.voucher_no) > 0 THEN 'Y' ELSE 'N' END AS IsProvisionRelated,
                                  CASE WHEN PopulationComponent.StatusFinData = N'HideFinData' THEN 'Y' ELSE 'N' END AS IsProcurementExcluded,
                                  CASE WHEN ExclusionProject.ID IS NULL THEN 'N' ELSE 'Y' END AS IsProjectExcluded,
                                  CASE WHEN ExclusionComponent.ID IS NULL THEN 'N' ELSE 'Y' END AS IsComponentExcluded,
                                  CASE WHEN ExclusionAccount.AccountCode IS NULL OR ExclusionAccount.ReplacementAccountName IS NOT NULL THEN 'N' ELSE 'Y' END AS IsAccountExcluded,
                                  CASE 
                                         WHEN v_agltransact.voucher_type = 'RV' AND v_agltransact.voucher_date < '20150501' THEN 'Y'
                                         WHEN ExclusionVoucherType.VoucherTypeCode IS NULL OR ExclusionVoucherType.ReplacementSupplierName IS NOT NULL THEN 'N'                                  
                                  ELSE 'Y' END AS IsVoucherTypeExcluded,                               
                                  CASE WHEN ExclusionBudgetCentre.BudgetCentreCode IS NULL THEN 'N' ELSE 'Y' END AS IsBudgetCentreExcluded,
                                  /* Need to revise*/
                                  'N' AS IsBenefittingCountryExcluded,
                                  CASE WHEN v_agltransact.voucher_type = 'PR' AND v_agltransact.voucher_no = 400136721 THEN 'Y' ELSE 'N' END AS IsTransactionExcluded,
                                  /* Need to revise*/
                                  CASE
                                         WHEN ExclusionSupplier.ID IS NOT NULL THEN 'Y' 
                                         ELSE 'N' 
                                  END AS IsSupplierExcluded,
                                  CASE WHEN @EarliestTransactionDate <= v_agltransact.last_update AND v_agltransact.last_update < DATEADD(DAY, 1, @LatestTransactionDateInternal) THEN 'N' ELSE 'Y' END AS IsDateExcluded,
                                  CASE WHEN ABS(v_agltransact.amount) >= @MinimumTransactionAmount THEN 'N' ELSE 'Y' END AS IsTransactionLineAmountExcluded,
                                  SUM(amount) OVER (PARTITION BY v_agltransact.client, v_agltransact.voucher_type, v_agltransact.voucher_no) AS TransactionTotal,
                                  CASE WHEN SUM(amount) OVER (PARTITION BY v_agltransact.client, v_agltransact.voucher_type, v_agltransact.voucher_no) > 25000 THEN 'Y' ELSE 'N' END AS IsGreaterThan25K,
                                  v_asuheader.apar_name AS SupplierName,
                                  v_acuheader.apar_name AS CustomerName,
                                  amount AS IATIAmount,
                                  CASE WHEN ExclusionAccount.ReplacementAccountName IS NOT NULL THEN ExclusionAccount.ReplacementAccountName ELSE v_aglaccounts.description END AS IATIAccountName,
                                  
                                  CASE
                                  WHEN ExclusionVoucherType.ReplacementSupplierName IS NOT NULL THEN 'Excluded'
                                  WHEN v_agltransact.apar_id = '' THEN 'Not available'
                                  WHEN v_agltransact.apar_id LIKE 'S%' OR v_agltransact.apar_id LIKE 'C%' THEN 'Not available'
                                                         WHEN ExclusionSupplierAsStaff.ID IS NOT NULL THEN 'Not available'
                                  WHEN v_agltransact.apar_type = 'R' THEN 'Not available'
                                  WHEN ExclusionSupplier.ID IS NOT NULL THEN 'Excluded'
                                  WHEN ExclusionSupplierProject.ID IS NOT NULL THEN 'Excluded'
                                  WHEN ExclusionProjectAllSupplier.ID IS NOT NULL THEN 'Excluded'
                                  WHEN [iati-activity].BenefittingCountryCode = 'AF' THEN 'Excluded'
                                  ELSE v_aglrelvalue.rel_value
                                  END AS IATIChannelCode,           
                                                                     
                                  CASE
                                  WHEN v_agltransact.account IN ('6002', '6008', '6013', '6020', '6022') AND v_asuheader.apar_name = 'Department for International Development' THEN 'Not available'
                                  WHEN ExclusionVoucherType.ReplacementSupplierName IS NOT NULL THEN ExclusionVoucherType.ReplacementSupplierName
                                  WHEN v_agltransact.apar_id = '' THEN 'Correction'
                                  WHEN v_agltransact.apar_id LIKE 'S%' OR v_agltransact.apar_id LIKE 'C%' THEN 'Staff Member'
                                                         WHEN ExclusionSupplierAsStaff.ID IS NOT NULL THEN 'Staff Member' 
                                  WHEN v_agltransact.apar_type = 'R' THEN 'Customer'
                                  WHEN ExclusionSupplier.ID IS NOT NULL THEN 'Supplier Name Withheld'
                                  WHEN ExclusionSupplierProject.ID IS NOT NULL THEN 'Supplier Name Withheld' 
                                  WHEN ExclusionProjectAllSupplier.ID IS NOT NULL THEN 'Supplier Name Withheld'
                                  WHEN [iati-activity].BenefittingCountryCode = 'AF' THEN 'Supplier Name Withheld'
                                  ELSE v_asuheader.apar_name
                                  END AS IATICustomerSupplier
                           FROM
                                  [IATISchema].[iati-activity]
                           INNER JOIN
                                  [PublicationControl].PopulationComponent
                           ON
                                  PopulationComponent.PopulationId = @PopulationId
                                  AND [iati-activity].ComponentId = PopulationComponent.ComponentId
                           INNER JOIN
                                  (SELECT * FROM [ProjectDataMart].AgressoSourceData.v_agltransact WHERE VersionId=@VersionIdInternal) v_agltransact
                           ON
                                  v_agltransact.client = 'DF'
                                  AND [iati-activity].ComponentId = v_agltransact.dim_4
                           INNER JOIN
                                  (SELECT * FROM [ProjectDataMart].AgressoSourceData.v_aglaccounts WHERE VersionId=@VersionIdInternal) v_aglaccounts
                           ON
                                  v_aglaccounts.client = 'DF'
                                  AND v_agltransact.account = v_aglaccounts.account
                           LEFT OUTER JOIN
                                  (SELECT * FROM [ProjectDataMart].AgressoSourceData.v_asuheader WHERE VersionId=@VersionIdInternal) v_asuheader
                           ON
                                  v_agltransact.apar_type IN ('P', '')
                                  AND v_asuheader.client = 'DF'
                                  AND v_agltransact.apar_id = v_asuheader.apar_id 
                           LEFT OUTER JOIN
                                  (SELECT * FROM [ProjectDataMart].AgressoSourceData.v_aglrelvalue WHERE VersionID=@VersionIdInternal) v_aglrelvalue
                           ON
                                  v_agltransact.apar_type IN ('P', '')
                                  AND v_aglrelvalue.client = 'DF'
                                  AND v_aglrelvalue.attribute_id = 'A5'
                                  AND v_aglrelvalue.rel_attr_id = 'S1'
                                  AND v_agltransact.apar_id = v_aglrelvalue.att_value
                           LEFT OUTER JOIN
                                  (SELECT * FROM [ProjectDataMart].AgressoSourceData.v_acuheader WHERE VersionId=@VersionIdInternal) v_acuheader
                           ON
                                  v_agltransact.apar_type IN ('R', '')
                                  AND v_acuheader.client = 'DF'
                                  AND v_agltransact.apar_id = v_acuheader.apar_id 
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
                                  v_agltransact.account = ExclusionAccount.AccountCode
                           LEFT OUTER JOIN
                                  [PublicationControl].ExclusionVoucherType
                           ON
                                  v_agltransact.voucher_type = ExclusionVoucherType.VoucherTypeCode
                           LEFT OUTER JOIN
                                  [PublicationControl].ExclusionBudgetCentre
                           ON
                                  v_agltransact.dim_1 = ExclusionBudgetCentre.BudgetCentreCode
                           LEFT OUTER JOIN
                                  /* For Blanket Level Supplier Exclusion */
                                  (SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Supplier' AND ExclusionLevel='Blanket' AND Status='Open' AND ShowStatusToPRA=1) ExclusionSupplier
                           ON
                                  v_agltransact.apar_type IN ('', 'P')
                                  AND v_agltransact.apar_id = ExclusionSupplier.ID
                                                         --New on 21/09/2016
                                            LEFT OUTER JOIN
                                  /* For Staff as Supplier Exclusion */
                                  (SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Supplier' AND ExclusionLevel='Blanket' AND Status='Open' AND ShowStatusToPRA=0 AND ID NOT LIKE 'S%') ExclusionSupplierAsStaff
                           ON
                                  v_agltransact.apar_type IN ('', 'P')
                                  AND v_agltransact.apar_id = ExclusionSupplierAsStaff.ID 
                           LEFT OUTER JOIN
                                  /* For Project Level Supplier Exclusion */
                                  (SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Supplier' AND ExclusionLevel='Project' AND Status='Open' AND ShowStatusToPRA=1) ExclusionSupplierProject
                           ON
                                  [iati-activity].ProjectId = ExclusionSupplierProject.ParentProjectID
                                  AND v_agltransact.apar_id = ExclusionSupplierProject.ID
                           LEFT OUTER JOIN
                                  /*For all the supplier exclusion under a specific project*/
                                  (SELECT * FROM [PublicationControl].[ExclusionDetails] WHERE ExclusionType='Supplier' AND ExclusionLevel='project-blanket' AND Status='Open') ExclusionProjectAllSupplier
                           ON
                                  [iati-activity].ProjectId = ExclusionProjectAllSupplier.ParentProjectID
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
  
                                                                                /* Handling labelling of Promissory Notes */
                                                                                EXECUTE [PublicationControl].p_PrintProgress N'Updating labels for Promissory Notes';
                                                                  
                                                                                -- 1. Create Temp table to merge in unfiltered transactions plus supplier details from #CSM
                                                                                IF OBJECT_ID('tempdb..#unfiltered_supplier', 'U') IS NOT NULL
                                                                                                DROP TABLE #unfiltered_supplier
                                                                                               
                                                                                select * into #unfiltered_supplier from (
                                                                                select u.*,s.apar_name,p.* 
                                                                                from PublicationControl.UnfilteredTransactions u
                                                                                left outer join [PublicationControl].[NonPOSupplierMap] csm
                                                                                on csm.ComponentID = u.dim_4
                                                                                left outer join [ProjectDataMart].[AgressoSourceData].[v_asuheaderCurrent] s
                                                                                on s.apar_id = csm.SupplierId
                                                                                left outer join [PublicationControl].[MappingParticipatingOrg] p
                                                                                on p.DFIDSupplierId = s.apar_id
                                                                                where u.IATIAccountName = 'Promissory Note deposit'
                                                                                and IsIncluded = 'Y'
                                                                                ) unfiltered_supplier 

                                                                                -- 2. Update PublicationControl.UnfilteredTransactions with the new label
                                                                                update u
                                                                                set 
                                                                                                u.IATICustomerSupplier = us.apar_name, 
                                                                                                u.IATIChannelCode = us.IATIIdentifier
                                                                                from PublicationControl.UnfilteredTransactions u 
                                                                                join #unfiltered_supplier us on (us.agrtid = u.agrtid)
                                                                                where u.IATICustomerSupplier in ('Journal Transaction','Department for International Development')
                                                                                and u.IATIAccountName = 'Promissory Note deposit'

                                                                                -- 3. Remove specific transactions to make the dataset simpler
                                                                                -- Add the voucher_numbers to PublicationControl.ExclusionTransaction and they get marked as IsIncluded='N'?
                                                                                update u
                                                                                set 
                                                                                                u.IsIncluded = 'N' 
                                                                                from PublicationControl.UnfilteredTransactions u 
                                                                                join PublicationControl.ExclusionTransaction et on (et.VoucherNumber = u.voucher_no)
                                                                                where ExclusionTransactionId > 4 -- to avoid historic issues

                     EXECUTE [PublicationControl].p_PrintProgress N'Finished updating labels for Promissory Notes';
                     
                     /* Populate transaction with spend along with [iati-activityID] in [IATISchema].[transaction]*/
                                         
                     EXECUTE [PublicationControl].p_PrintProgress N'Finished populating transaction with spend';

                     INSERT INTO [IATISchema].[transaction]
                     (
                           [iati-activityID]
                           ,[IsExcluded]
                          ,[OriginalValue]
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
                           ,'GBP' AS [value/@currency]
                           ,UnfilteredTransactions.last_update AS [value/@value-date]
                           ,NULL AS [value/@type]
                           ,UnfilteredTransactions.[amount] AS [value/text()]
                           ,NULL AS [transaction-type/@xml:lang]
                           , CASE 
                                                                                                                   WHEN AccountGroup.account = 2402 THEN 8 -- Purchase Of Equity
                                                                                                                   WHEN AccountGroup.account = 3403 THEN 5 -- Interest Repayment
                                                                                                                   WHEN AccountGroup.account = 3402 THEN 6 -- Loan Repayment
                                                                                                                   WHEN AccountGroup.account = 2400 THEN 4 -- Expenditure
                                                                                                                   WHEN AccountGroup.account = 2370 THEN 4   -- Incoming Funds now Expenditure
                                                                                                                   WHEN AccountGroup.account_grp IN (300,340,370) THEN 4 -- Incoming Funds now Expenditure
                                                                                                                   WHEN AccountGroup.account_grp IN (230,232,234,236,238,240) THEN 3 -- Disbursement           
                                                                                                                   ELSE 4 -- Expenditure
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
                    INNER JOIN 
                                    (Select * From [Agresso].[dbo].aglaccounts WHERE client  = 'DF') AccountGroup
                    ON 
                                        UnfilteredTransactions.account = AccountGroup.account
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           UnfilteredTransactions.dim_4 = v_ComponentTransformed.ComponentId
                     WHERE
                          UnfilteredTransactions.IsIncluded = 'Y'

                     /* Populate aggregated transactions (Expenditure Items) Before 12th May 2010 along with [iati-activityID] in [IATISchema].[transaction]*/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating aggregated transactions (Expenditure Items) pre 12th May 2010'
                     
                     INSERT INTO [IATISchema].[transaction]
                     (      
                           [iati-activityID]
                           ,[IsExcluded]
                           ,[OriginalValue]
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
                           ,'4' AS [transaction-type/@code]
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
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           UnfilteredTransactions.dim_4 = v_ComponentTransformed.ComponentId
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
                           ,'GBP' AS [value/@currency]
                           ,CASE 
                                  WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 1 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),4, 1)
                                  WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 2 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),7, 1)
                                  WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 3 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),10, 1)
                                  ELSE Configuration.f_MakeDate(Max(LT500.fiscal_year)+1,1, 1)
                           END
                           AS [value/@value-date]
                           ,NULL AS [value/@type]
                           ,SUM(LT500.[amount]) AS [value/text()]
                           ,NULL AS [transaction-type/@xml:lang]
                           ,'4' AS [transaction-type/@code]
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
                                  WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 1 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),4, 1)
                                  WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 2 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),7, 1)
                                  WHEN PublicationControl.f_QuarterValue(LT500.voucher_date) = 3 THEN Configuration.f_MakeDate(Max(LT500.fiscal_year),10, 1)
                                  ELSE Configuration.f_MakeDate(Max(LT500.fiscal_year)+1,1, 1)
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
              
					 
					 /* Store participating-org & implementing role along with [iati-activityID] in [IATISchema].[participating-org] based on Disbursement and Purchase of Equity transactions*/
					 EXECUTE [PublicationControl].p_PrintProgress N'Populating participating-org with implmenting organisations'       

					 INSERT INTO [IATISchema].[participating-org]
                     (
                       --[participating-orgID] (autopopulated)
                       [iati-activityID]
                       ,[@xml:lang]
                       ,[@ref]
                       ,[@type]
                       ,[@role]
                       ,[text()]
                      )
					  SELECT    
							t.[iati-activityID] AS [iati-activityID]
								,NULL AS [@xml:lang]
								,CASE WHEN mpo.IATIIdentifier IS NOT NULL THEN mpo.IATIIdentifier ELSE NULL END AS [@ref]
								,NULL AS [@type]
							   ,'4' AS [@role]
							   , CASE WHEN (t.[receiver-org/text()] LIKE '%UNICEF%' OR t.[receiver-org/text()] = 'United Nation’s Children Fund' ) THEN 'United Nations Children’s Fund (UNICEF)' ELSE t.[receiver-org/text()] END AS [text()]         
					   FROM (SELECT [iati-activityID] ,[receiver-org/text()] FROM [IATISchema].[transaction] WHERE ([transaction-type/@code] = 3  OR [transaction-type/@code] = 8) GROUP BY [iati-activityID] ,[receiver-org/text()] ) t
					   LEFT JOIN 
							[PublicationControl].[ExclusionParticipatingOrg] epo
					    ON REPLACE(t.[receiver-org/text()],' ','') = REPLACE(epo.ParticipatingOrgName,' ','')
						LEFT OUTER JOIN
							[PublicationControl].[MappingParticipatingOrg] mpo
						ON 
							REPLACE(t.[receiver-org/text()],' ','') = REPLACE(mpo.SupplierHqDescription,' ','')
						WHERE epo.ParticipatingOrgName IS NULL AND t.[receiver-org/text()] IS NOT NULL
												          
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating conditions for all projects'
       
                     /* Delete All data from [IATISchema].[conditions] */ 
                     DELETE FROM [IATISchema].[conditions] 
              
                     /* Populate conditions info for all Projects along with [iati-activityID] in [IATISchema].conditions */
                     
                     --SELECT
                     --      [iati-activityID]
                     --      ,CASE
                     --             WHEN [PublicationControl].[f_HasSpecificConditions](ProjectId) = 1 THEN 1
                     --             WHEN [PublicationControl].[f_HasBudgetSupport](ProjectId) = 1 THEN 1             
                     --             ELSE 0
                     --      END AS [@attached]
                     --      ,CASE
                     --             WHEN [PublicationControl].[f_HasSpecificConditions](ProjectId) = 1 AND [PublicationControl].[f_HasBudgetSupport](ProjectId) = 1 THEN 'C'
                     --             WHEN [PublicationControl].[f_HasSpecificConditions](ProjectId) = 1 THEN 'S'
                     --             WHEN [PublicationControl].[f_HasBudgetSupport](ProjectId) = 1 THEN 'G'
                     --             ELSE NULL
                     --      END AS [condtionFlag]
                     --FROM
                     --      [IATISchema].[iati-activity] 
                     --WHERE [@hierarchy] = 1
                                  INSERT @StagedData
                                         SELECT
                                                [iati-activityID] ,
                                                CASE  
                                                WHEN ProjectId IN    (
                                                                                  SELECT ProjectId FROM [ProjectDataMart].[AgressoTransformation].ProjectTransformed 
                                                                                  WHERE SpecificConditions LIKE 'Yes%'
                                                                                  )
                                                THEN 1 ELSE 0 END AS [HasSpecificConditions] ,
                                                CASE
                                                WHEN ProjectId IN    (
                                                                                  SELECT ProjectId FROM [ProjectDataMart].[AgressoTransformation].ComponentTransformed
                                                                                  WHERE FundingTypeCode IN ('GENBUDGETSUPPORT', 'SECTORBUDGETSUPPORT', 'NONBUDGETSUPPFINAID')
                                                                                  )
                                                THEN 1 ELSE 0 END AS [HasBudgetSupport]
                                         FROM
                                                [IATISchema].[iati-activity] 
                                          WHERE 
                                                [@hierarchy] = 1

                                  INSERT INTO [IATISchema].conditions 
                     (
                           [iati-activityID]
                           ,[@attached]
                           ,[condtionFlag]
                     )
                                  SELECT 
                                         [sd].[iati-activityID] ,
                                         CASE
                                                WHEN sd.HasSpecificConditions = 1 THEN 1
                                                WHEN sd.HasBudgetSupport = 1 THEN 1             
                                                ELSE 0
                                         END AS [@attached] ,
                                         CASE
                                                WHEN sd.HasSpecificConditions = 1 AND sd.HasBudgetSupport = 1 THEN 'C'
                                                WHEN sd.HasSpecificConditions = 1 THEN 'S'
                                                WHEN sd.HasBudgetSupport = 1 THEN 'G'
                                                ELSE NULL
                                         END AS [condtionFlag]
                                  FROM @StagedData sd ORDER BY 1

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
                     where c.[@attached] = 1    AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'G'

                     UNION ALL

                     SELECT
                           [conditionsID]
                           ,1 as [@type]
                           ,'Yes - Specific Conditions - Details on specific conditions can be found in the Business Case for individual projects.' AS [text()]
                     FROM 
                           [IATISchema].conditions c
                     inner join [IATISchema].[iati-activity] a
                     on a.[iati-activityID] = c.[iati-activityID]
                     where c.[@attached] = 1    AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'S'

                     UNION ALL

                     SELECT
                           [conditionsID]
                           ,1 as [@type]
                           ,'Yes - General Conditions - For all financial aid that the UK provides direct to partner governments, the four Partnership Principles apply.' AS [text()]
                     FROM
                           [IATISchema].conditions c
                     inner join [IATISchema].[iati-activity] a
                     on a.[iati-activityID] = c.[iati-activityID]
                     where c.[@attached] = 1    AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'C'

                     UNION ALL

                     SELECT
                           [conditionsID]
                           ,1 as [@type]
                           ,'Yes - Specific Conditions - Details on specific conditions can be found in the Business Case for individual projects.' AS [text()]
                     FROM 
                           [IATISchema].conditions c
                     inner join [IATISchema].[iati-activity] a
                     on a.[iati-activityID] = c.[iati-activityID]
                     where c.[@attached] = 1    AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'C'
              
                     
                     
                     
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
                           ,NULL AS [@xml:lang],
                           CASE
                                  WHEN ComponentActivityMapping.ProjectId LIKE '3%' THEN @DFIDOrganisationIdentifier + '-' + ComponentActivityMapping.ProjectId
                                  ELSE @DFIDProjectIdentifier + '-' + ComponentActivityMapping.ProjectId
                           END AS [@ref]
                           ,1 AS [@type]
                            ,v_ProjectTransformed.ProjectTitle AS [text()]
                     FROM
                           @ComponentActivityMapping ComponentActivityMapping
                     LEFT OUTER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ProjectTransformed WHERE VersionId=@VersionIdInternal) v_ProjectTransformed
                     ON
                           ComponentActivityMapping.ProjectId = v_ProjectTransformed.ProjectId
                     
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
                           ,NULL AS [@xml:lang],
                           CASE
                                  WHEN ComponentActivityMapping.ProjectId LIKE '3%' THEN @DFIDOrganisationIdentifier + '-' + ComponentActivityMapping.ComponentId
                                  ELSE @DFIDProjectIdentifier + '-' + ComponentActivityMapping.ComponentId
                           END AS [@ref]
                           ,2 AS [@type]
                           ,v_ComponentTransformed.ComponentTitle AS [text()]
                     FROM
                           @ProjectActivityMapping ProjectActivityMapping
                     INNER JOIN
                           @ComponentActivityMapping ComponentActivityMapping
                     ON
                           ProjectActivityMapping.ProjectId = ComponentActivityMapping.ProjectId
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                           ComponentActivityMapping.ComponentId = v_ComponentTransformed.ComponentId
                     
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
                           ,NULL AS [@xml:lang],
                           CASE
                                  WHEN v_ComponentTransformed.ProjectId LIKE '3%' THEN @DFIDOrganisationIdentifier + '-' + v_ComponentTransformed.ComponentId
                                  ELSE @DFIDProjectIdentifier + '-' + v_ComponentTransformed.ComponentId
                           END AS [@ref]
                           ,3 AS [@type]
                           ,v_ComponentTransformed.ComponentTitle AS [text()]
                     FROM
                           @ComponentActivityMapping component
                     INNER JOIN
                           @ComponentActivityMapping sibling_component
                     ON
                           component.ProjectId = sibling_component.ProjectId
                           AND component.ComponentId != sibling_component.ComponentId
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentTransformed WHERE VersionId=@VersionIdInternal) v_ComponentTransformed
                     ON
                          sibling_component.ComponentId = v_ComponentTransformed.ComponentId

                     /* Populate document url for Publishable documents along with [iati-activityID] in [IATISchema].[document-link] */

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link'
       
                     INSERT INTO [IATISchema].[document-link]
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
                                         UPPER(publishedDocs.DocExtension) ='DOC'
                                  THEN  
                                    '.odt'
                                WHEN
                                         UPPER(publishedDocs.DocExtension) ='DOCX'    
                                   THEN
                                         '.odt'       
                                ELSE
                                   '.'+(publishedDocs.DocExtension) 
                                END
                        as [@url],
                        CASE
                                WHEN
                                         UPPER(publishedDocs.DocExtension) ='DOC'
                                  THEN  
                                    'application/vnd.oasis.opendocument.text'
                                WHEN
                                         UPPER(publishedDocs.DocExtension) ='DOCX'    
                                   THEN
                                         'application/vnd.oasis.opendocument.text'
                                WHEN
                                         UPPER(publishedDocs.DocExtension) ='XLS'    
                                   THEN
                                         'application/vnd.ms-excel'
                                WHEN
                                         UPPER(publishedDocs.DocExtension) ='XLSX'    
                                   THEN
                                         'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                                WHEN
                                         UPPER(publishedDocs.DocExtension) ='PDF'    
                                   THEN
                                         'application/pdf'                                                                                            
                                END
                        AS [@format],
                        CASE
                           WHEN ISNULL(questLanguage.IATILanguageCode, '') = '' THEN NULL
                           WHEN questLanguage.IATILanguageCode = 'en' THEN NULL                 
                           ELSE questLanguage.IATILanguageCode
                        END AS [@language],
                        DATENAME(MONTH, publishedDocs.LastUpdatedDate) + ', ' + DATENAME(YEAR, publishedDocs.LastUpdatedDate) AS [@LastUpdated-Month-Year]
                       FROM [PublicationControl].PublishedDocuments publishedDocs
                       LEFT OUTER JOIN
                       [PublicationControl].[MappingQuestLanguage] questLanguage
                       ON 
                       publishedDocs.[Language] = questLanguage.QuestLanguage
                       INNER JOIN
					   --LEFT OUTER JOIN
                       @ProjectActivityMapping ProjectActivityMapping
                      ON
                       publishedDocs.ProjectID = ProjectActivityMapping.ProjectId
                       WHERE publishedDocs.PublicationStatusID<>3
                     
                     /* Populate title for Publishable documents along with [document-linkID] in [IATISchema].[document-link/title] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title'
       
                     INSERT INTO [IATISchema].[document-link/title]
                     (
                           [document-linkID]
                           ,[@xml:lang]
                           ,[text()]
                     )
                     SELECT 
                              docLink.[document-linkID] AS [document-linkID],
                              docLink.[@language] AS [@language],
                              ISNULL(publishedDocs.DocType, '<Unknown Title>') 
                              + ' ' +
                              CASE
                              WHEN
                                         COUNT(*) OVER (PARTITION BY activity.ProjectID, publishedDocs.DocType) != 1
                              THEN
                                         '(' + CONVERT(VARCHAR(MAX), ROW_NUMBER() OVER (PARTITION BY activity.ProjectID, publishedDocs.DocType ORDER BY docLink.QuestID)) + ') '
                              ELSE
                                         ''
                              END
                              + replace(activity.ProjectID,' ','')
                              + CASE
                                WHEN
                                         docLink.[@LastUpdated-Month-Year] IS NOT NULL
                                  THEN  
                                    /*' (' + docLink.[@LastUpdated-Month-Year] + ')'*/
									' (Published - ' + docLink.[@LastUpdated-Month-Year] + ')'
                                ELSE
                                    ''
                                END
                              + (reverse(left(reverse(docLink.[@url]),charindex('.',reverse(docLink.[@url])))))
                              AS [text()]
                     FROM [IATISchema].[document-link] docLink
                           INNER JOIN
						  [IATISchema].[iati-activity] activity
						  ON
						   activity.[iati-activityID] = docLink.[iati-activityID]
					 INNER JOIN
                           [PublicationControl].PublishedDocuments publishedDocs
                           ON 
                            (docLink.QuestID = publishedDocs.QuestID AND activity.ProjectId=publishedDocs.ProjectID)

       
                     /* Populate Category for Publishable documents along with [document-linkID] in [IATISchema].[document-link/category] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category'
       
                     INSERT INTO [IATISchema].[document-link/category]
                     (
                           [document-linkID]
                           ,[@xml:lang]
                           ,[@code]
                           ,[@type]
                           ,[text()]
                     )
                     SELECT
                           docLink.[document-linkID] AS [document-linkID],
                           docLink.[@language] AS [@xml:lang],
                           questContentType.IATIContentTypeCode AS [@code],
                           NULL AS [@type]
                           ,docContentType.Name AS [text()]
                     FROM
                           [IATISchema].[document-link] docLink
                     INNER JOIN
						  [IATISchema].[iati-activity] activity
						  ON
						   activity.[iati-activityID] = docLink.[iati-activityID]
					 INNER JOIN
                           [PublicationControl].PublishedDocuments publishedDocs
                           ON 
                            (docLink.QuestID = publishedDocs.QuestID AND activity.ProjectId=publishedDocs.ProjectID)
                     INNER JOIN
                           [PublicationControl].MappingQuestContentType questContentType       
                            ON 
                            questContentType.QuestContentType = publishedDocs.DocType 
                     INNER JOIN [Codelist].[DocumentCategory] docContentType
                           ON
                           questContentType.IATIContentTypeCode = docContentType.Code          
       
       /* Populate document url for Legacy documents along with [iati-activityID] in [IATISchema].[document-link] */
       
       EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with legacy document data'
       
              INSERT INTO [IATISchema].[document-link]
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
                     @DocumentURIPrefix + replace(ld.QuestID,' ','') + replace(ld.DocumentExtension,' ','') as [@url],
                     ld.Format AS [@format],
                     NULL AS [@language]
              FROM 
                     [PublicationControl].LegacyDocuments ld
                     INNER JOIN
                     [IATISchema].[iati-activity] ia
                     ON
                     ld.ProjectNumber = ia.ProjectId
              Where ia.ComponentId IS NULL             
              
              /* Populate title for Legacy documents along with [document-linkID] in [IATISchema].[document-link/title] */
              
              EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with legacy documents'
              
              INSERT INTO [IATISchema].[document-link/title]
              (
                     [document-linkID]
                    ,[@xml:lang]
                     ,[text()]
              )
              SELECT
                     [document-link].[document-linkID] AS [document-linkID]
                     ,[document-link].[@language] AS [@language]
                     ,replace(ld.[Type],' ','')+' '+replace(ld.[ProjectNumber],' ','')+replace(ld.[DocumentExtension],' ','') AS [text()]
              FROM
                     [IATISchema].[document-link]
              INNER JOIN
                     [PublicationControl].[LegacyDocuments] ld
              ON
                     [document-link].QuestID = ld.QuestID

              
              /* Populate Category for Legacy documents along with [document-linkID] in [IATISchema].[document-link/category] */
              
              EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with legacy documents'

              INSERT INTO [IATISchema].[document-link/category]
              (
                     [document-linkID]
                     ,[@xml:lang]
                     ,[@code]
                     ,[@type]
                     ,[text()]
              )
              SELECT
                     [document-link].[document-linkID] AS [document-linkID]
                     ,[document-link].[@language] AS [@xml:lang]
                     ,ld.IatiCode AS [@code]
                     ,NULL AS [@type]
                     ,ld.IatiTextDesc AS [text()]
              FROM
                     [IATISchema].[document-link]
              INNER JOIN
                     [PublicationControl].[LegacyDocuments] ld
              ON
                     [document-link].QuestID = ld.QuestID     
                           

                    /***Populate document urls for the activity-websites along with [iati-activityID] in [IATISchema].[document-link] ***/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with activity website document data'
       
                      INSERT INTO [IATISchema].[document-link]
                      (
                             [iati-activityID]
                             ,[QuestID]
                             ,[@url]
                             ,[@format]
                             ,[@language]
                      )
                      SELECT
                             ia.[iati-activityID] AS [iati-activityID],
                             'AW' + CONVERT(varchar(10),pw.ProjectId) + CONVERT(varchar(10),pw.WebsiteId) AS QuestID,
                             pw.[website/text()] as [@url],
                             'text/html' AS [@format],
                             NULL AS [@language]
                      FROM 
                             [PublicationControl].[ProjectWebsite] pw
                             INNER JOIN
                             [IATISchema].[iati-activity] ia
                             ON
                             pw.ProjectId = ia.ProjectId
                      Where ia.ComponentId IS NULL
                      
                      /* Populate title for activity websites along with [document-linkID] in [IATISchema].[document-link/title] */
                      
                      EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with activity website data'
                      
                      INSERT INTO [IATISchema].[document-link/title]
                      (
                             [document-linkID]
                             ,[@xml:lang]
                             ,[text()]
                      )
                      SELECT
                             [document-link].[document-linkID] AS [document-linkID]
                             ,[document-link].[@language] AS [@language]
                             ,'Activity website' AS [text()]
                      FROM
                             [IATISchema].[document-link]
                      INNER JOIN
                             [PublicationControl].[ProjectWebsite] pw
                      ON
                             [document-link].QuestID = 'AW' + CONVERT(varchar(10),pw.ProjectId) + CONVERT(varchar(10),pw.WebsiteId)

                      
                      /* Populate Category for activity websites along with [document-linkID] in [IATISchema].[document-link/category] */
                      
                      EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with activity website data'

                      INSERT INTO [IATISchema].[document-link/category]
                      (
                             [document-linkID]
                             ,[@xml:lang]
                             ,[@code]
                             ,[@type]
                             ,[text()]
                      )
                      SELECT
                             [document-link].[document-linkID] AS [document-linkID]
                             ,[document-link].[@language] AS [@xml:lang]
                             ,'A12' AS [@code]
                             ,NULL AS [@type]
                             ,'Activity website' AS [text()]
                      FROM
                             [IATISchema].[document-link]
                      INNER JOIN
                             [PublicationControl].[ProjectWebsite] pw
                      ON
                             [document-link].QuestID = 'AW' + CONVERT(varchar(10),pw.ProjectId) + CONVERT(varchar(10),pw.WebsiteId)



       
       /* Populate document url for contracts and tenders documents from ContractsFinder along with [iati-activityID] in [IATISchema].[document-link] */
       
       EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with contracts and tenders from ContractsFinder'

                     INSERT INTO [IATISchema].[document-link]
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
                     INNER JOIN
                           IATISchema.[iati-activity]
                     ON
                           [PublicationControl].[ContractsFinderContracts].ProjectId = IATISchema.[iati-activity].ProjectId
                     WHERE
                          IATISchema.[iati-activity].[@hierarchy] = 1                      
       
                     
                     /* Populate title for contracts and tenders documents from ContractsFinder along with [document-linkID] in [IATISchema].[document-link/title] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with contracts and tenders from ContractsFinder'
       
                     INSERT INTO [IATISchema].[document-link/title]
                     (
                           [document-linkID]
                           ,[@xml:lang]
                           ,[text()]
                     )
                     SELECT
                           [document-link].[document-linkID] AS [document-linkID]
                           ,[document-link].[@language] AS [@language]
                           ,CASE
                                  WHEN [PublicationControl].ContractsFinderContracts.DocumentCategoryCode = 'A10' THEN 'Tender: ' + [PublicationControl].ContractsFinderContracts.ContractTitle 
                                  WHEN [PublicationControl].ContractsFinderContracts.DocumentCategoryCode = 'A11' THEN 'Contract: ' + [PublicationControl].ContractsFinderContracts.ContractTitle 
                                  ELSE [PublicationControl].ContractsFinderContracts.ContractTitle 
                           END AS [text()]
                     FROM
                            [IATISchema].[document-link]
                     INNER JOIN
                           [PublicationControl].ContractsFinderContracts
                     ON
                           [document-link].QuestID = 'CF' + CONVERT(varchar(10),[PublicationControl].ContractsFinderContracts.ContractId)
                     
                     /* Populate Category for contracts and tenders documents from ContractsFinder along with [document-linkID] in [IATISchema].[document-link/category] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with contracts and tenders from ContractsFinder'
       
                     INSERT INTO [IATISchema].[document-link/category]
                     (
                           [document-linkID]
                           ,[@xml:lang]
                           ,[@code]
                           ,[@type]
                           ,[text()]
                     )
                     SELECT
                           [document-link].[document-linkID] AS [document-linkID]
                           ,[document-link].[@language] AS [@xml:lang]
                           ,[PublicationControl].ContractsFinderContracts.DocumentCategoryCode AS [@code]
                           ,NULL AS [@type]
                            ,DocumentCategory.Name AS [text()]
                     FROM
                           [IATISchema].[document-link]
                     INNER JOIN
                           [PublicationControl].ContractsFinderContracts
                     ON
                           [document-link].QuestID = 'CF' + CONVERT(varchar(10),[PublicationControl].ContractsFinderContracts.ContractId)
                     INNER JOIN
                           [Codelist].[DocumentCategory]
                     ON
                           [PublicationControl].ContractsFinderContracts.DocumentCategoryCode = [Codelist].[DocumentCategory].Code
                     
                     /* Populate document url for general conditions documents along with [iati-activityID] in [IATISchema].[document-link] */

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link with general conditions'
                     
                     INSERT INTO [IATISchema].[document-link]
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
                     where c.[@attached] = 1    AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'G'

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
                     where c.[@attached] = 1    AND c.[condtionFlag] IS NOT NULL AND  c.[condtionFlag] = 'C'

                     /* Populate title for general conditions documents along with [document-linkID] in [IATISchema].[document-link/title] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/title with general conditions'
       
                     INSERT INTO [IATISchema].[document-link/title]
                     (
                           [document-linkID]
                           ,[@xml:lang]
                           ,[text()]
                     ) 
                     SELECT
                           dl.[document-linkID] AS [document-linkID]
                           ,dl.[@language] AS [@language]
                           ,'General Conditions - For all financial aid that the UK provides direct to partner governments, the four Partnership Principles apply.' AS [text()]
                     FROM
                           [IATISchema].[document-link] dl
                     WHERE dl.[document-linkID] IN 
                     (
                           SELECT [document-linkID] 
                           FROM [IATISchema].[document-link]
                           WHERE [@url] = 'https://www.gov.uk/government/publications/partnerships-for-poverty-reduction-rethinking-conditionality'
                           AND [@format] = 'text/html'

                     )

                     /* Populate Category for general conditions documents along with [document-linkID] in [IATISchema].[document-link/category] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/category with general condtions'

                     INSERT INTO [IATISchema].[document-link/category]
                     (
                           [document-linkID]
                           ,[@xml:lang]
                           ,[@code]
                           ,[@type]
                           ,[text()]
                     )
                     SELECT
                                  dl.[document-linkID] AS [document-linkID]
                                  ,dl.[@language] AS [@xml:lang]
                                  ,'A04' AS [@code]
                                  ,NULL AS [@type]
                                  ,DocumentCategory.Name AS [text()]
                     FROM
                           [IATISchema].[document-link] dl
                     INNER JOIN
                           [Codelist].[DocumentCategory]
                     ON
                           [Codelist].[DocumentCategory].Code = 'A04'
                     WHERE dl.[document-linkID] IN 
                     (
                           SELECT [document-linkID] 
                           FROM [IATISchema].[document-link]
                           WHERE [@url] = 'https://www.gov.uk/government/publications/partnerships-for-poverty-reduction-rethinking-conditionality'
                           AND [@format] = 'text/html'
                     )

                     /* Populate language element for all documents including contracts and tenders along with [document-linkID] in [document-link/language] */
                     
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating document-link/language for core documents and contracts/tenders'
              
                     INSERT INTO [IATISchema].[document-link/language]
                     (
                           [document-linkID]
                           ,[@code]
                           ,[@xml:lang]
                           ,[text()]
                     )
                     SELECT
                           [document-link].[document-linkID] AS [document-linkID]
                           ,
                           CASE
                           WHEN ISNULL([document-link].[@language], '') = '' THEN 'en'
                           ELSE [document-link].[@language]
                           END AS [@code]
                           ,null as [@xml:lang]
                           ,
                           CASE
                           WHEN ISNULL([document-link].[@language], '') = '' THEN 'English'
                           ELSE [Codelist].[Language].Name
                           END AS [text()]
                     FROM
                           [IATISchema].[document-link]
                     LEFT OUTER JOIN
                           [Codelist].[Language]
                     ON
                           [Codelist].[Language].Code = [document-link].[@language]
       
       

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
                           ,v_InputSectorTransformed.InputSectorName AS [@name]
                           ,v_InputSectorTransformed.InputSectorCode AS [@value]
                           ,'sector' AS [@iati-equivalent]
                           ,CONVERT(VARCHAR(MAX), NULLIF(v_ComponentInputSectorTransformed.percentage, 100)) + '%' AS [text()]
                     FROM
                           @ComponentActivityMapping ComponentActivityMapping
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_ComponentInputSectorTransformed WHERE VersionId=@VersionIdInternal) v_ComponentInputSectorTransformed
                     ON
                           v_ComponentInputSectorTransformed.Percentage != 0
                           AND ComponentActivityMapping.ComponentId = v_ComponentInputSectorTransformed.ComponentId
                     INNER JOIN
                            (SELECT * FROM [ProjectDataMart].AgressoTransformation.v_InputSectorTransformed WHERE VersionId=@VersionIdInternal) v_InputSectorTransformed
                     ON
                           v_ComponentInputSectorTransformed.InputSectorCode = v_InputSectorTransformed.InputSectorCode


                     /*** Add Sector Data for Projects along with the percentage contribution project's budget to that sector***/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating IATISchema.sector with DFID input sectors at the project level'

                     INSERT INTO @ProjectBudgetBySector
                     SELECT compBudSec.[ProjectId], compBudSec.[@code], compBudSec.[text()], SUM(compBudSec.[Sector_Component_Budget])
                     FROM 
                           (-- Using the percentage value allocated to each component, calculate the total value of component budget that has been allocated to each sector     
                            SELECT ia.[ProjectId], sector.[@code], sector.[text()], SUM([value/text()]) as Total_Component_Budget,   
                           (CONVERT(float,percentage) / 100) * SUM([value/text()]) as Sector_Component_Budget, sector.[percentage]
                           FROM [IATISchema].[budget] b
                           INNER JOIN
                                  [IATISchema].[iati-activity] ia
                           ON 
                           ia.[iati-activityID] = b.[iati-activityID]
                           INNER JOIN
                           (Select * FROM 
                           -- Group all of the sectors to show the total percentage contribution to a component 
                           (SELECT s.[iati-activityID], s.[@code], SUM(s.percentage) AS percentage, s.[text()] 
                                  FROM
                                  -- Remove all of the nulls and replace them with 100%
                                  (SELECT  [iati-activityID] 
                                         ,[@code]
                                         ,CASE 
                                                WHEN [@percentage] IS NULL THEN 100
                                                ELSE [@percentage]  
                                                END as percentage
                                         ,[text()]
                                         FROM [IATISchema].[sector]) AS s
                           GROUP BY s.[iati-activityID], s.[@code], s.[text()]) AS sp ) AS sector
                           ON 
                           ia.[iati-activityID] = sector.[iati-activityID]
                           GROUP BY ia.[ProjectId], ia.[ComponentId], sector.[@code], sector.[percentage], sector.[text()]) AS compBudSec
                     GROUP BY compBudSec.[ProjectId], compBudSec.[@code], compBudSec.[text()]

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
                           IATIActivityID.[iati-activityID] AS [iati-activityID]
                           ,NULL AS [@xml:lang]
                           ,pbs.[SectorCode] AS [@code]
                           ,NULL AS [@type]
                           ,NULL AS [@other-code]
                           ,NULL AS [@vocabulary] -- 1 is the default for OECD DAC CRS
                           ,CASE WHEN TotalProjectBudgetBySector.Total_Budget = 0 THEN 0
                                  ELSE CONVERT(DECIMAL(36,2),(pbs.Budget/TotalProjectBudgetBySector.Total_Budget) * 100)
                                  END AS [@percentage]
                           ,pbs.[SectorText] As [text()]
                     FROM @ProjectBudgetBySector pbs
                     INNER JOIN
                           (SELECT [ProjectId], SUM(Budget) as Total_Budget
                           FROM @ProjectBudgetBySector
                           GROUP BY [ProjectId]) TotalProjectBudgetBySector
                     ON
                     pbs.[ProjectId] = TotalProjectBudgetBySector.[ProjectId]
                     INNER JOIN
                           (SELECT ia.[iati-activityID], ia.[ProjectId]
                           FROM [IATISchema].[iati-activity] ia
                           WHERE ia.[ComponentId] IS NULL) as IATIActivityID
                     ON IATIActivityID.[ProjectId] = pbs.[ProjectId]
                     WHERE TotalProjectBudgetBySector.Total_Budget != 0

                     /*** Add Geographic Area Data for Projects along with the percentage contribution of the project's budget to that area ***/

                     EXECUTE [PublicationControl].p_PrintProgress N'Populating IATISchema.sector with Geographic Areas at the project level'

                     INSERT INTO @ProjectBudgetByGeoLocation
                      SELECT ProjGeoBudget.[ProjectId],ProjGeoBudget.[BenefittingCountryCode], ProjGeoBudget.[CountryCode], ProjGeoBudget.[RegionCode],
                      --Ceiling(ROUND((CONVERT(FLOAT,ProjGeoBudget.TotalComponentBudget)/ProjGeoBudget.ProjectBudget) * 100,3)*100)/100.0 as Percentage
                      Round(ROUND((CONVERT(FLOAT,ProjGeoBudget.TotalComponentBudget)/ProjGeoBudget.ProjectBudget) * 100,4)*100/100.0,4) as Percentage
                      --(CONVERT(FLOAT,ProjGeoBudget.TotalComponentBudget)/ProjGeoBudget.ProjectBudget)*100 as Percentage
                      FROM
                          (select componentWiseBudget.[ProjectId],[BenefittingCountryCode],[CountryCode],[RegionCode],TotalComponentBudget,[totalProjectBudget].[ProjectBudget]
                          from 
                          ( 
                            SELECT compBud.[ProjectId], compBud.[BenefittingCountryCode],  compBud.[CountryCode],  compBud.[RegionCode], SUM(compBud.ComponentBudget) AS TotalComponentBudget
                            FROM   -- Return all of the budgets at component level
                                      (SELECT ia.ProjectId, ia.ComponentId, SUM(b.[value/Text()]) as ComponentBudget
                                  ,ia.BenefittingCountryCode
                                  ,ia.CountryCode
                                  ,ia.RegionCode  
                                      FROM [IATISchema].[iati-activity] ia
                                      INNER JOIN
                                      [IATISchema].[budget] b
                                      ON 
                                      ia.[iati-activityID] = b.[iati-activityID]
                                      Group By ia.ProjectId, ia.ComponentId, ia.BenefittingCountryCode, ia.CountryCode, ia.RegionCode ) AS compBud
                                WHERE compBud.[ComponentBudget] != 0
                                      GROUP BY compBud.[ProjectId], compBud.[BenefittingCountryCode], compBud.[CountryCode], compBud.[RegionCode]
                              ) AS componentWiseBudget
                                      left join
                                      (SELECT ia.ProjectId, SUM(b.[value/Text()]) as ProjectBudget
                                                      FROM [IATISchema].[iati-activity] ia
                                                      INNER JOIN
                                                      [IATISchema].[budget] b
                                                      ON 
                                                      ia.[iati-activityID] = b.[iati-activityID]
                                                      Group By ia.ProjectId) AS totalProjectBudget
                                                      on componentWiseBudget.projectid = totalProjectBudget.projectid
                                      ) AS ProjGeoBudget
                      WHERE (ProjGeoBudget.[BenefittingCountryCode] IS NOT NULL AND (ProjGeoBudget.[CountryCode] IS NOT NULL OR ProjGeoBudget.[RegionCode] IS NOT NULL)) AND ProjGeoBudget.TotalComponentBudget != 0


                     -- Insert Statement for Project Budget Percentage by IATI Country
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
                           IATIActivityID.[iati-activityID] AS [iati-activityID]
                           ,pbg.CountryCode AS [@code]
                           ,NULL AS [@type]                                
                           ,NULL AS [@xml:lang]                     
                           ,pbg.Percentage AS [@percentage]
                           ,CountryText.[text()] AS [text()]
                     FROM @ProjectBudgetByGeoLocation pbg
                     INNER JOIN
                           (SELECT ia.[iati-activityID], ia.[ProjectId]
                           FROM [IATISchema].[iati-activity] ia
                           WHERE ia.[ComponentId] IS NULL) as IATIActivityID
                     ON IATIActivityID.[ProjectId] = pbg.[ProjectId]
                     INNER JOIN
                           (SELECT [@Code], [text()]   
                           FROM [IATISchema].[recipient-country]
                           WHERE [text()] IS NOT NULL
                           GROUP BY [@Code], [text()]) CountryText
                     ON CountryText.[@Code] = pbg.CountryCode                      
                     WHERE pbg.CountryCode IS NOT NULL 
                     GROUP BY IATIActivityID.[iati-activityID], pbg.Percentage, pbg.CountryCode, CountryText.[text()]  
                     

                     -- Insert Statement for Project Budget Percentage by IATI Region
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
                           IATIActivityID.[iati-activityID] AS [iati-activityID]
                           ,pbg.RegionCode AS [@code]
                           ,NULL AS [@type]                                
                           ,NULL AS [@xml:lang]                     
                           ,pbg.Percentage AS [@percentage]
                           ,NULL AS [text()]
                     FROM @ProjectBudgetByGeoLocation pbg
                     INNER JOIN
                           (SELECT ia.[iati-activityID], ia.[ProjectId]
                           FROM [IATISchema].[iati-activity] ia
                           WHERE ia.[ComponentId] IS NULL) as IATIActivityID
                     ON IATIActivityID.[ProjectId] = pbg.[ProjectId]
                     WHERE pbg.RegionCode IS NOT NULL 
                     GROUP BY IATIActivityID.[iati-activityID], pbg.Percentage, pbg.RegionCode 

                     /*** Add Implementing Organisation information to Projects ***/
                     EXECUTE [PublicationControl].p_PrintProgress N'Populating [IATISchema].[participating-org] with participating organisations at the project level'
                                  
                     INSERT INTO
                           [IATISchema].[participating-org]
                     (
                           --[participating-orgID]
                           [iati-activityID]
                           ,[@xml:lang]
                           ,[@ref]
                           ,[@type]
                           ,[@role]
                                                                                                   ,[text()]
                     )
                     SELECT 
							projList.[iati-activityID],
							projList.[@xml:lang],
							CASE 
							WHEN [@ref] = 'GB' THEN [@ref]
							WHEN [@ref] = 'GB-GOV-1' THEN [@ref]
							WHEN ia.benefittingcountrycode = 'AF' THEN NULL
										ELSE [@ref] END AS [@ref],
							CASE
							WHEN [@ref] = 'GB' THEN [@type]
							WHEN [@ref] = 'GB-GOV-1' THEN [@type] 
							WHEN ia.benefittingcountrycode = 'AF' THEN NULL
											ELSE [@type] END AS [@type],
							CASE 
							WHEN [@ref] = 'GB' THEN [@role]
							WHEN [@ref] = 'GB-GOV-1' THEN [@role]
							WHEN ia.benefittingcountrycode = 'AF' THEN '4'
							else [@role] end as [@role],
							CASE 
							WHEN [@ref] = 'GB' THEN [text()]
							WHEN [@ref] = 'GB-GOV-1' THEN [text()]
							WHEN ia.benefittingcountrycode = 'AF' THEN 'Name Withheld'
											ELSE [text()] END AS [text()]
										from (SELECT 
													iaProj.[iati-activityID] AS [iati-activityID]
													,NULL AS [@xml:lang]
													,po.[@ref] AS [@ref]
													,po.[@type] AS [@type]
													,po.[@role] AS [@role]
													,po.[text()] AS [text()]
										FROM [IATISchema].[participating-org] po
										INNER JOIN       
															[IATISchema].[iati-activity] ia
										ON     
															ia.[iati-activityID] = po.[iati-activityID]
										INNER JOIN       
															(SELECT * 
															FROM [IATISchema].[iati-activity]
															WHERE ComponentId IS NULL) AS iaProj
										ON     
															ia.[ProjectId] = iaProj.[ProjectId]
										WHERE po.[@type] IS NULL and po.[@role] = '4'
										GROUP BY iaProj.[iati-activityID], iaProj.[ProjectId], po.[@ref], po.[@type], po.[@role],[text()]) projList
							left outer join [IATISchema].[iati-activity] ia
										on projList.[iati-activityID] = ia.[iati-activityID]

                     

/* ======================================================================================================================
   POPULATE COMPONENT DESCRIPTION FIELD WITH TEXT FROM THE COMPONENT METADATA
   ====================================================================================================================== */
                    EXECUTE [PublicationControl].p_PrintProgress N'Populating component description field with text from component metadata'

                    INSERT INTO
                           [IATISchema].[description]
                     (
                           [iati-activityID]    
                           ,[@xml:lang]
						   ,[@type]               
                           ,[text()]                  
                     )
 					SELECT
						a.[iati-activityID]
						,null
						,null
						,'This activity (' + rtrim(t.[text()]) + ') is a component of ' + rtrim(r.[text()]) + ' reported by DFID'
						+ ', with a funding type of ' + '''' + LTRIM(SUBSTRING(d.[description], 6, 99))  + '''' + ' '
						+ 'and a budget of £' + LEFT(convert(varchar(50), cast(b.componentbudget as money), -1),LEN(convert(varchar(50), cast(b.componentbudget as money), -1))-3) + '. '
						+ CASE 
							WHEN rc.[text()] is not null THEN 'This component benefits ' + rc.[text()] + ', ' 
							WHEN rr.[@code] is not null THEN 'This component benefits ' + clr.[Name] + ', ' 
							ELSE '' 
						END 
						+ 'and works in the following sector(s): ' + s.sector
						+ CASE
							WHEN Implementers.imp is not null THEN
								', with the following implementing partners: ' + Implementers.imp + '. '
							ELSE ''
						END
						+ CASE
							WHEN PlannedStart.[@iso-date] is not null and PlannedEnd.[@iso-date] is not null THEN 
							'The start date is ' + convert(varchar,PlannedStart.[@iso-date],105) + ' and the end date is ' + convert(varchar,PlannedEnd.[@iso-date],105) + '.'
							ELSE ''
						END
						AS ComponentDescription
					from IATISchema.[iati-activity] a
					-- related activity
					inner join (select * from IATISchema.[related-activity] where [@type] = 1) r
					on a.[iati-activityID] = r.[iati-activityID] 
					-- component details
					inner join ProjectDataMart.AgressoTransformation.v_ComponentTransformedCurrent c
					on c.ComponentID = a.ComponentId
					-- component titles
					inner join IATISchema.[title] t
					on t.[iati-activityID] = a.[iati-activityID]
					-- funding type lookup
					inner join (select * from ProjectDataMart.AgressoSourceData.v_AgldimvalueCurrent where client = 'DF' AND attribute_id = '73') d
					on d.dim_value = c.FundingTypeCode
					-- aggregated budget
					inner join (select [iati-activityID], sum(convert(float,[value/text()])) as componentbudget from IATISchema.budget group by [iati-activityID]) b
					on b.[iati-activityID] = a.[iati-activityID]
					-- sector comma-separated list
					inner join
					(SELECT [iati-activityID],sector = 
						STUFF((SELECT ', ' + [text()]
							   FROM IATISchema.sector b 
							   WHERE b.[iati-activityID] = a.[iati-activityID] 
							  FOR XML PATH('')), 1, 2, '')
					FROM IATISchema.sector a
					GROUP BY [iati-activityID]) s
					on s.[iati-activityID] = a.[iati-activityID]
					-- policy marker comma-separated list

					-- recipient country
					left outer join IATISchema.[recipient-country] rc
					on rc.[iati-activityID] = a.[iati-activityID]
					-- recipient region
					left outer join IATISchema.[recipient-region] rr
					on rr.[iati-activityID] = a.[iati-activityID]
					left outer join Codelist.Region clr
					on clr.Code = rr.[@code]

					-- dates
					left outer join (select * from IATISchema.[activity-date] where [@type] = 1) PlannedStart 
					on PlannedStart.[iati-activityID] = a.[iati-activityID]
					--left outer join (select * from IATISchema.[activity-date] where [@type] = 2) ActualStart 
					--on ActualStart.[iati-activityID] = a.[iati-activityID]
					left outer join (select * from IATISchema.[activity-date] where [@type] = 3) PlannedEnd
					on PlannedEnd.[iati-activityID] = a.[iati-activityID]
					--left outer join (select * from IATISchema.[activity-date] where [@type] = 4) ActualEnd
					--on ActualEnd.[iati-activityID] = a.[iati-activityID]

					-- participating org
					left outer join
					(SELECT [iati-activityID],imp = 
						STUFF((SELECT ', ' + [text()]
							   FROM IATISchema.[participating-org] b
							   WHERE b.[iati-activityID] = a.[iati-activityID] 
							   AND b.[@role] = 4
							   AND b.[text()] is not null
							  FOR XML PATH('')), 1, 2, '')
					FROM IATISchema.[participating-org] a
					where a.[@role] = 4 and a.[text()] is not null
					GROUP BY [iati-activityID]) Implementers
					on Implementers.[iati-activityID] = a.[iati-activityID]

					where --a.ProjectId like '30%' and -- long query: 1:37 for full dataset
					a.ComponentId is not null
	
	          /* Populate empty Project and Component Descriptions*/
                     
				INSERT INTO IATISchema.[description] 
				SELECT 
					[title].[iati-activityID]
					,[title].[@xml:lang]
					,NULL
					,'Title: ' + [title].[text()]
				FROM IATISchema.[title]
				LEFT OUTER JOIN IATISchema.[description]
					ON [description].[iati-activityID] = [title].[iati-activityID]
				WHERE [description].[text()] is null				


/* ======================================================================================================================
   FINAL COMMIT. END
   ====================================================================================================================== */
 

                     COMMIT TRANSACTION
              END TRY
              BEGIN CATCH
                     IF @@TRANCOUNT > 0
                           ROLLBACK TRANSACTION

                     EXEC Configuration.p_ErrorHandler
              END CATCH--
              
              /* Update Population with End date of the procedure */
              UPDATE [PublicationControl].Population SET EndDateTime = GETDATE() WHERE PopulationId = @PopulationId

              COMMIT

       END TRY
       BEGIN CATCH
              IF @@TRANCOUNT > 0
                     ROLLBACK TRANSACTION

              EXEC Configuration.p_ErrorHandler
       END CATCH










GO