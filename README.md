# SQL-to-IATI-Database

## Contents

1. [Introduction](#intro)
2. [Database Table Schemas](#dts)
3. [Important Functions and Stored Procedures](#functions)
4. [Database Installation Guide](#installation)
5. [Additional Scripts](#scripts)
6. [Glossary](#glossary)

## <a name="intro"></a> Introduction

The IATIv201 database has been created using SQL server and is used by DFID to generate IATI 2.01 standard data in the XML file format. This document will briefly outline some of the Database’s main features and contains an installation guide to get you started.

## <a name="dts"></a> Database Table Schemas

The Database contains four schemas and the tables within each schema perform a particular purpose:

- __Codelist__ - 	The tables in this schema are used to hold the data from the IATI 2.01 codelist within the database structure.
- __IATISchema__ - 	The tables in this schema are used to hold IATI activity data.
- __Configuration__ -	The tables in this schema hold information relating to the generation of the IATI data (e.g. Configuration.Error logs any issues that arise when generating IATI data).
- __PublicationControl__ -	The tables in this schema are used to control the IATI data generation process and control what information is saved into the ‘IATISchema’ tables (e.g. PublicationControl.ExclusionDetails holds all of the IATI-activities that are excluded from publication).	

## <a name="functions"></a>Important Functions and Stored Procedures

- __[IATISchema].[p_Populate]__ - This stored procedure is the main driver of the data generation process within the database. It extracts DFID’s financial information from a DataMart that is linked to the organisation’s Enterprise Resource Planning system and transforms it, using the data in the Codelist and PublicationControl tables, before saving DFID’s IATI data into the IATISchema tables.

- __[IATISchema].[f_activitiesXMLFile_201]__ -  This function is used to return valid IATI 2.01 XML data from the IATI Schema database tables. The function takes in a number of different parameters to control what is contained in the returned XML; this is explained further in the documentation associated with the stored procedure. To view this information, right click on the function and select: Script function as -> Create to -> New Query Editor Window

## <a name="installation"></a>Database Installation Guide 

This database script has been tested with both SQL Server 2014 Express Edition and SQL Server 2012 Developer Edition. You will need administrator access to both SQL Server and the database server in order to install the database successfully. 

- Log on to the database server and create a folder called ‘IATIv201’ on the C: drive (e.g. C:\ IATIv201). 

- Open SQL Server Management Studio and run the script ‘IATIv201 – Create Database Script.sql’ to create the database and an associated login.

### <a name="scripts"></a>Additional Scripts
- The script **IATIv201 – Main Data Population Function.sql** is used to create the p_populate function, which is described earlier in this document. As this stored procedure is tightly coupled to DFID’s DataMart, it has been removed from the ‘IATIv201 – Create Database Script.sql’ script. However, as its functionality has been broken down into discrete SQL blocks, which have all been commented, it is a useful guide to show how DFID approaches the extraction and transformation of data from our DataMart. 

- **IATIv201 – Views on the DFID Database.sql** – these views are tightly bound to DFID’s Datamart and so cannot be created, but they may prove informative as they show what data is being extracted.

## <a name="glossary"></a>Glossary

There are some table/column names in the Database’s “PublicationControl” schema which relate to DFID specific terminology; these will be outlined below to avoid confusion:

- __Quest__ - This is the name of DFID’s document repository. A document’s Quest Number is its unique reference within this system.
- __Project__ - This is the name that is used within DFID to describe hierarchy one iati-activities.
- __Component__ - This is the name that is used within DFID to describe hierarchy two iati-activities. 
- __ARIES__ - This is the name of DFID’s Enterprise Resource Planner system, 
a project’s ARIES ID is effectively a hierarchy one iati-activity ID.

