# SQL-to-IATI-Database

## Contents

1. [Introduction](#intro)
2. [Database Table Schemas](#dts)
3. [Important Functions and Stored Procedures](#functions)
4. [Database Installation Guide](#installation)
5. [Additional Scripts](#scripts)
6. [Glossary](#glossary)
7. [Legacy IATI 2.01 Database](#legacy)

## <a name="intro"></a> Introduction

The IATIv203 database has been created using SQL server and is used by DFID to generate IATI 2.03 standard data in the XML file format. This document will briefly outline some of the Database’s main features and contains an installation guide to get you started.

## <a name="dts"></a> Database Table Schemas

The Database contains four schemas and the tables within each schema perform a particular purpose:

- __Codelist__ - 	The tables in this schema are used to hold the data from the IATI 2.03 codelist within the database structure.
- __IATISchema__ - 	The tables in this schema are used to hold IATI activity data.
- __Configuration__ -	The tables in this schema hold information relating to the generation of the IATI data (e.g. Configuration.Error logs any issues that arise when generating IATI data).
- __PublicationControl__ -	The tables in this schema are used to control the IATI data generation process and control what information is saved into the ‘IATISchema’ tables (e.g. PublicationControl.ExclusionDetails holds all of the IATI-activities that are excluded from publication).

## <a name="functions"></a>Important Functions and Stored Procedures

- __[IATISchema].[p_Populate]__ - This stored procedure is the main driver of the data generation process within the database. It extracts DFID’s financial information from a DataMart that is linked to the organisation’s Enterprise Resource Planning system and transforms it, using the data in the Codelist and PublicationControl tables, before saving DFID’s IATI data into the IATISchema tables. Please note: some passages of p_populate that are very specific to the source finance system have been removed from the publicly accessible code.

- __[IATISchema].[f_activitiesXMLFile_203]__ -  This function is used to return valid IATI 2.03 XML data from the IATI Schema database tables. The function takes in a number of different parameters to control what is contained in the returned XML; this is explained further in the documentation associated with the stored procedure. To view this information, right click on the function and select: Script function as -> Create to -> New Query Editor Window

## <a name="installation"></a>Database Installation Guide 

This database script has been tested with SQL Server 2016 Express Edition. You will need administrator access to both SQL Server and the Database Server to install the database successfully. 

- Log on to the database server and create a folder on the C: drive to host the database called IATI, then create a folder within that folder called IATI Database (e.g. C:\IATI\IATI Database) 

- Open SQL Server Management Studio and run the IATIv203 - Create Database Script to create the database.

- The DBA will then need to create user logins so that users/systems can use the new database.

- It is recommended that the DBA checks the database file sizes and auto-growth values to ensure there is sufficient disk space available for their organisation’s data.

### <a name="scripts"></a>Additional Scripts
- **IATIv203 - Populate IATI Codelist Data Script.sql** - This script is used to populate the IATI Codelist schema, described earlier, with all of the required data. 

- **IATIv203 - Data Population Stored Procedure.sql** – This is an optional script that has been created as to demonstrate how the the p_populate function, which is described earlier in this document, operates.  p_Populate is tightly coupled to DFID’s DataMart, it has been removed from the ‘IATIv203 – Create Database Script.sql’ script. However, as its functionality has been broken down into discrete SQL blocks, which have all been commented, it is a useful guide to show how DFID approaches the extraction and transformation of data from our DataMart.

## <a name="glossary"></a>Glossary

There are some table/column names in the Database’s “PublicationControl” schema which relate to DFID specific terminology; these will be outlined below to avoid confusion:

- __Vault__ - This is the name of DFID’s document repository. A document’s Vault Number is its unique reference within this system.
- __Quest__ - This is the name of DFID’s legacy document repository. A document’s Quest Number is its unique reference within this system.
- __Project__ - This is the name that is used within DFID to describe hierarchy one iati-activities.
- __Component__ - This is the name that is used within DFID to describe hierarchy two iati-activities. 
- __ARIES__ - This is the name of DFID’s Enterprise Resource Planner system, a project’s ARIES ID is effectively a hierarchy one iati-activity ID.
