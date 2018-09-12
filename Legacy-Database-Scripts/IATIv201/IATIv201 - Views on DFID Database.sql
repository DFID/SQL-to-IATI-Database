/****** Object:  View [PublicationControl].[v_Component]    Script Date: 15/07/2015 15:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create view [PublicationControl].[v_Component] as

select
c.ProjectId,
c.ComponentId,
c.ComponentTitle,
c.OperationalStartDate,
c.OperationalEndDate,
c.FundingTypeCode,
c.QualityAssurerName,
c.InputterName,
isnull(ap.in_proc,'N') as InActiveProcurement,
d.ComponentBudgetOriginal
from
[ProjectDataMart].[AgressoTransformation].v_ComponentTransformedCurrent c

left join [ProjectDataMart].[AgressoTransformation].v_ComponentBalanceTransformedCurrent d
	on c.ComponentId = d.ComponentId

left join [SERVER_NAME].[Agresso].[dbo].[uvi_active_procurement] ap
	on c.ComponentId = ap.Component




GO
/****** Object:  View [PublicationControl].[v_Financial]    Script Date: 15/07/2015 15:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [PublicationControl].[v_Financial] as

with 

	QuarterlySpend as
	(
	select
	bt.ComponentId,
	bt.FiscalYear,
	fp.FiscalQuarter,
	SUM(bt.amount) as Spend,
	SUM(CASE WHEN bt.AccountCode IN ('2302','2303') THEN bt.BudgetCurrent ELSE 0 END) AS BudIndicative,
	SUM(CASE WHEN bt.AccountCode NOT IN ('2302','2303') THEN bt.BudgetCurrent ELSE 0 END) AS BudNonIndicative

	from [ProjectDataMart].AgressoTransformation.v_BalanceTransformedCurrent bt

	left join [IATI].[Configuration].FiscalPeriod fp on bt.FiscalYear = fp.FiscalYear 
		and case when bt.FiscalPeriod = 0 then 1 else bt.FiscalPeriod end = fp.FiscalPeriod
	
	where bt.ComponentId != ''
	group by bt.ComponentId, bt.FiscalYear, fp.FiscalQuarter
	)
	
	select
	qs.ComponentId,
	qs.FiscalYear,
	sum(qs.BudIndicative) as BudIndicative,
	sum(qs.BudNonIndicative) as BudNonIndicative,
	sum(case when qs.FiscalQuarter = 1 then qs.Spend else 0 end) as SpendQ1,
	sum(case when qs.FiscalQuarter = 2 then qs.Spend else 0 end) as SpendQ2,
	sum(case when qs.FiscalQuarter = 3 then qs.Spend else 0 end) as SpendQ3,
	sum(case when qs.FiscalQuarter = 4 then qs.Spend else 0 end) as SpendQ4,
	sum(qs.spend) as SpendFY
	from QuarterlySpend qs
	group by qs.ComponentId, qs.FiscalYear 


GO
/****** Object:  View [PublicationControl].[v_MappingBenefittingCountry]    Script Date: 15/07/2015 15:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [PublicationControl].[v_MappingBenefittingCountry]
AS
WITH
	ARIES AS (SELECT dim_value AS Code, description AS Name, status AS Status FROM [ProjectDataMart].[AgressoSourceData].[v_agldimvalueCurrent] WHERE client = 'DF' AND attribute_id = '55')
SELECT
	ARIES.Code AS BenefittingCountryCode
	,ARIES.Name AS BenefittingCountryName
	,ARIES.Status AS BenefittingCountryStatus
	,ISNULL(MappingBenefittingCountry.BenefittingCountryTypeCode, CASE WHEN Country.Code IS NOT NULL THEN 1 WHEN Region.Code IS NOT NULL THEN 3 END) AS BenefittingCountryTypeCode
	,MappingBenefittingCountryType.Name AS BenefittingCountryTypeName
	,MappingBenefittingCountry.IATICountryCode AS IATICountryCode
	,Country.Name AS IATICountryName
	,MappingBenefittingCountry.IATIRegionCode AS IATIRegionCode
	,Region.Name AS IATIRegionName
	,CASE WHEN ARIES.Name = ISNULL(Country.Name, Region.Name) THEN 'Y' ELSE 'N' END AS IsNameMatch
FROM
	ARIES
FULL OUTER JOIN
	[PublicationControl].MappingBenefittingCountry
ON
	ARIES.Code = MappingBenefittingCountry.BenefittingCountryCode
FULL OUTER JOIN
	[Codelist].Country
ON
	MappingBenefittingCountry.IATICountryCode = Country.Code
FULL OUTER JOIN
	[Codelist].Region
ON
	MappingBenefittingCountry.IATIRegionCode = Region.Code
LEFT OUTER JOIN
	[PublicationControl].MappingBenefittingCountryType
ON
	ISNULL(MappingBenefittingCountry.BenefittingCountryTypeCode, CASE WHEN Country.Code IS NOT NULL THEN 1 WHEN Region.Code IS NOT NULL THEN 3 END) = MappingBenefittingCountryType.Code




GO
/****** Object:  View [PublicationControl].[v_Project]    Script Date: 15/07/2015 15:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [PublicationControl].[v_Project] as

select
ProjectId,
ProjectTitle,
MostRecentPurpose as ProjectPurpose,
OperationalStartDate,
OperationalEndDate,
StageCode,
RiskAtApproval
from
[ProjectDataMart].AgressoTransformation.v_ProjectTransformedCurrent
GO
