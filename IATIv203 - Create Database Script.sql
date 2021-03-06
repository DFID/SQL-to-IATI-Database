USE [master]
GO
/****** Object:  Database [IATIv203]    Script Date: 05/09/2018 10:37:11 ******/
CREATE DATABASE [IATIv203]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IATI', FILENAME = N'C:\IATI\IATI203 Database\IATIv203.mdf' , SIZE = 524288KB , MAXSIZE = 819200KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IATI_log', FILENAME = N'C:\IATI\IATI203 Database\IATIv203.ldf' , SIZE = 130952KB , MAXSIZE = 204800KB , FILEGROWTH = 32768KB )
GO
ALTER DATABASE [IATIv203] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IATIv203].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IATIv203] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IATIv203] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IATIv203] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IATIv203] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IATIv203] SET ARITHABORT OFF 
GO
ALTER DATABASE [IATIv203] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IATIv203] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IATIv203] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IATIv203] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IATIv203] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IATIv203] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IATIv203] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IATIv203] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IATIv203] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IATIv203] SET DISABLE_BROKER 
GO
ALTER DATABASE [IATIv203] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IATIv203] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IATIv203] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IATIv203] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IATIv203] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IATIv203] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IATIv203] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IATIv203] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [IATIv203] SET MULTI_USER 
GO
ALTER DATABASE [IATIv203] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IATIv203] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IATIv203] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IATIv203] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [IATIv203] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'IATIv203', N'ON'
GO
ALTER DATABASE [IATIv203] SET QUERY_STORE = OFF
GO

USE [IATIv203]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

USE [IATIv203]
GO
/****** Object:  Schema [Codelist]    Script Date: 05/09/2018 10:37:12 ******/
CREATE SCHEMA [Codelist]
GO
/****** Object:  Schema [Configuration]    Script Date: 05/09/2018 10:37:12 ******/
CREATE SCHEMA [Configuration]
GO
/****** Object:  Schema [IATI]    Script Date: 05/09/2018 10:37:12 ******/
CREATE SCHEMA [IATI]
GO
/****** Object:  Schema [IATISchema]    Script Date: 05/09/2018 10:37:12 ******/
CREATE SCHEMA [IATISchema]
GO
/****** Object:  Schema [PublicationControl]    Script Date: 05/09/2018 10:37:12 ******/
CREATE SCHEMA [PublicationControl]
GO
/****** Object:  UserDefinedDataType [Configuration].[Flag]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [Configuration].[Flag] FROM [char](1) NOT NULL
GO
/****** Object:  UserDefinedDataType [Configuration].[Version]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [Configuration].[Version] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xml:lang]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xml:lang] FROM [nchar](2) NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:anyURI]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:anyURI] FROM [nvarchar](max) NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:date]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:date] FROM [datetime] NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:datetime]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:datetime] FROM [datetime] NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:decimal]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:decimal] FROM [decimal](36, 18) NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:integer]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:integer] FROM [bigint] NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:language]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:language] FROM [nchar](2) NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:NMTOKEN]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:NMTOKEN] FROM [nvarchar](max) NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:positiveInteger]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:positiveInteger] FROM [bigint] NULL
GO
/****** Object:  UserDefinedDataType [IATISchema].[xsd:string]    Script Date: 05/09/2018 10:37:12 ******/
CREATE TYPE [IATISchema].[xsd:string] FROM [nvarchar](max) NULL
GO
/****** Object:  XmlSchemaCollection [IATISchema].[SchemaCollection_2.03]    Script Date: 05/09/2018 10:37:12 ******/
CREATE XML SCHEMA COLLECTION [IATISchema].[SchemaCollection_2.03] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"><xsd:import namespace="http://www.w3.org/XML/1998/namespace" /><xsd:attribute name="currency" type="xsd:string" /><xsd:attribute name="value-date" type="xsd:date" /><xsd:complexType name="currencyType"><xsd:simpleContent><xsd:extension base="xsd:decimal"><xsd:attribute ref="currency" /><xsd:attribute ref="value-date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType><xsd:element name="activity-date"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" use="required" /><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="activity-scope"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="activity-status"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="period-start"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="period-end"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" /><xsd:attribute name="status" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="capital-spend"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="percentage" type="xsd:decimal" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="collaboration-type"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="comment" type="textRequiredType" /><xsd:element name="conditions"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="condition" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" use="required" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="attached" type="xsd:boolean" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="contact-info"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="organisation" type="textRequiredType" minOccurs="0" /><xsd:element name="department" type="textRequiredType" minOccurs="0" /><xsd:element name="person-name" type="textRequiredType" minOccurs="0" /><xsd:element name="job-title" type="textRequiredType" minOccurs="0" /><xsd:element name="telephone" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:string"><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="email" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:string"><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="website" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:anyURI"><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="mailing-address" type="textRequiredType" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="country-budget-items"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="budget-item" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="description" type="textRequiredType" minOccurs="0" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="percentage" type="xsd:decimal" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="crs-add"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="other-flags" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="significance" type="xsd:boolean" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="loan-terms" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="repayment-type" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="repayment-plan" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="commitment-date" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="repayment-first-date" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="repayment-final-date" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="rate-1" type="xsd:decimal" /><xsd:attribute name="rate-2" type="xsd:decimal" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="loan-status" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="interest-received" type="xsd:decimal" minOccurs="0" /><xsd:element name="principal-outstanding" type="xsd:decimal" minOccurs="0" /><xsd:element name="principal-arrears" type="xsd:decimal" minOccurs="0" /><xsd:element name="interest-arrears" type="xsd:decimal" minOccurs="0" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="year" type="xsd:decimal" use="required" /><xsd:attribute ref="currency" /><xsd:attribute ref="value-date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="channel-code" type="xsd:string" minOccurs="0" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="default-aid-type" type="aidTypeBase" /><xsd:element name="default-finance-type"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="default-flow-type"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="default-tied-status"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="description" type="descriptionBase" /><xsd:element name="dimension"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="name" type="xsd:string" /><xsd:attribute name="value" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="fss"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="forecast" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:decimal"><xsd:attribute name="year" type="xsd:decimal" use="required" /><xsd:attribute ref="currency" /><xsd:attribute ref="value-date" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="extraction-date" type="xsd:date" use="required" /><xsd:attribute name="priority" type="xsd:boolean" /><xsd:attribute name="phaseout-year" type="xsd:decimal" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="humanitarian-scope"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-activities"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="iati-activity" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="version" type="xsd:string" use="required" /><xsd:attribute name="generated-datetime" type="xsd:dateTime" /><xsd:attribute name="linked-data-default" type="xsd:anyURI" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-activity"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="iati-identifier" /><xsd:element ref="reporting-org" /><xsd:element name="title" type="textRequiredType" /><xsd:element name="description" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element ref="participating-org" maxOccurs="unbounded" /><xsd:element ref="other-identifier" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="activity-status" /><xsd:element ref="activity-date" maxOccurs="unbounded" /><xsd:element ref="contact-info" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="activity-scope" minOccurs="0" /><xsd:element ref="recipient-country" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="recipient-region" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="location" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="sector" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="tag" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="country-budget-items" minOccurs="0" /><xsd:element ref="humanitarian-scope" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="policy-marker" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="collaboration-type" minOccurs="0" /><xsd:element ref="default-flow-type" minOccurs="0" /><xsd:element ref="default-finance-type" minOccurs="0" /><xsd:element ref="default-aid-type" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="default-tied-status" minOccurs="0" /><xsd:element ref="budget" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="planned-disbursement" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="capital-spend" minOccurs="0" /><xsd:element ref="transaction" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="document-link" type="documentLinkBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="related-activity" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="legacy-data" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="conditions" minOccurs="0" /><xsd:element ref="result" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="crs-add" minOccurs="0" /><xsd:element ref="fss" minOccurs="0" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" /><xsd:attribute ref="xml:lang" /><xsd:attribute name="default-currency" type="xsd:string" /><xsd:attribute name="humanitarian" type="xsd:boolean" /><xsd:attribute name="hierarchy" type="xsd:int" /><xsd:attribute name="linked-data-uri" type="xsd:anyURI" /><xsd:attribute name="budget-not-provided" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-identifier"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:string"><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="legacy-data"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="name" type="xsd:string" use="required" /><xsd:attribute name="value" type="xsd:string" use="required" /><xsd:attribute name="iati-equivalent" type="xsd:NMTOKEN" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="location"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="location-reach" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="location-id" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="name" type="textRequiredType" minOccurs="0" /><xsd:element name="description" type="textRequiredType" minOccurs="0" /><xsd:element name="activity-description" type="textRequiredType" minOccurs="0" /><xsd:element name="administrative" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:attribute name="level" type="xsd:nonNegativeInteger" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="point" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="pos" type="xsd:string" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="srsName" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="exactness" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="location-class" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="feature-designation" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="narrative"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:string"><xsd:attribute ref="xml:lang" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="other-identifier"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="owner-org" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" use="required" /><xsd:attribute name="type" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="participating-org"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:attribute name="role" type="xsd:string" use="required" /><xsd:attribute name="activity-id" type="xsd:string" /><xsd:attribute name="crs-channel-code" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="planned-disbursement"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="period-start"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="period-end" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="value" type="currencyType" /><xsd:element name="provider-org" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="provider-activity-id" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="receiver-org" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="receiver-activity-id" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="policy-marker"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="significance" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-country"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="percentage" type="xsd:decimal" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-region"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:attribute name="percentage" type="xsd:decimal" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="related-activity"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" use="required" /><xsd:attribute name="type" type="xsd:string" use="required" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="reporting-org"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" use="required" /><xsd:attribute name="type" type="xsd:string" use="required" /><xsd:attribute name="secondary-reporter" type="xsd:boolean" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="result"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="title" /><xsd:element ref="description" minOccurs="0" /><xsd:element name="document-link" type="documentLinkResultBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="reference" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="indicator" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="title" /><xsd:element ref="description" minOccurs="0" /><xsd:element name="document-link" type="documentLinkResultBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="reference" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="indicator-uri" type="xsd:anyURI" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="baseline" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="location" type="resultLocationBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="dimension" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="document-link" type="documentLinkResultBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="comment" minOccurs="0" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" /><xsd:attribute name="year" type="xsd:positiveInteger" use="required" /><xsd:attribute name="value" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="period" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="period-start"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="period-end"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="target" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="location" type="resultLocationBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="dimension" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="comment" minOccurs="0" /><xsd:element name="document-link" type="documentLinkResultBase" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="value" type="xsd:string" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="actual" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="location" type="resultLocationBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="dimension" minOccurs="0" maxOccurs="unbounded" /><xsd:element ref="comment" minOccurs="0" /><xsd:element name="document-link" type="documentLinkResultBase" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="value" type="xsd:string" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="measure" type="xsd:string" use="required" /><xsd:attribute name="ascending" type="xsd:boolean" /><xsd:attribute name="aggregation-status" type="xsd:boolean" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="type" type="xsd:string" use="required" /><xsd:attribute name="aggregation-status" type="xsd:boolean" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="sector"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="percentage" type="xsd:decimal" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="tag"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" use="required" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="title" type="textRequiredType" /><xsd:element name="transaction"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="transaction-type"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="transaction-date"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="value" type="currencyType" /><xsd:element name="description" type="textRequiredType" minOccurs="0" /><xsd:element name="provider-org" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="provider-activity-id" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="receiver-org" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="receiver-activity-id" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="disbursement-channel" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="sector" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-country" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-region" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="vocabulary-uri" type="xsd:anyURI" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="flow-type" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="finance-type" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="aid-type" type="aidTypeBase" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="tied-status" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="humanitarian" type="xsd:boolean" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:complexType name="aidTypeBase"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="descriptionBase"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="documentLinkBase"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="title" /><xsd:element name="description" type="descriptionBase" minOccurs="0" /><xsd:element name="category" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="language" minOccurs="0" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="code" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="document-date" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="url" type="xsd:anyURI" use="required" /><xsd:attribute name="format" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="documentLinkResultBase"><xsd:complexContent><xsd:extension base="documentLinkBase" /></xsd:complexContent></xsd:complexType><xsd:complexType name="resultLocationBase"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ref" type="xsd:string" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="textRequiredType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="textType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="narrative" minOccurs="0" maxOccurs="unbounded" /><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema>'
GO
/****** Object:  XmlSchemaCollection [IATISchema].[SchemaCollectionConditions]    Script Date: 05/09/2018 10:37:12 ******/
CREATE XML SCHEMA COLLECTION [IATISchema].[SchemaCollectionConditions] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"><xsd:import namespace="http://www.w3.org/XML/1998/namespace" /><xsd:attribute name="code" type="xsd:string" /><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:complexType name="currencyType"><xsd:simpleContent><xsd:extension base="xsd:integer"><xsd:attribute name="currency" type="xsd:string" /><xsd:attribute name="value-date" type="xsd:date" use="required" /><xsd:attribute ref="type" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType><xsd:element name="activity-date"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:string"><xsd:attributeGroup ref="textAtts" /><xsd:attribute ref="type" use="required" /><xsd:attribute name="iso-date" type="xsd:date" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="activity-status" type="codeReqType" /><xsd:element name="activity-website"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:anyURI"><xsd:attribute ref="xml:lang" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="period-start"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="period-end"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute ref="type" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="budget-planned"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element name="receiver-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="receiver-activity-id" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="description" type="textType" minOccurs="0" /><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute ref="type" /><xsd:attribute name="period" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="collaboration-type" type="codeReqType" /><xsd:element name="conditions"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="condition"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute ref="type" use="required" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" processContents="lax" /></xsd:choice><xsd:attribute name="attached" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" processContents="lax" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="contact-info"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="organisation" type="xsd:anyType" /><xsd:element name="person-name" type="textType" /><xsd:element name="telephone"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="email" type="plainType" /><xsd:element name="mailing-address"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" /></xsd:choice><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="default-aid-type" type="codeReqType" /><xsd:element name="default-finance-type" type="codeReqType" /><xsd:element name="default-flow-type" type="codeReqType" /><xsd:element name="default-tied-status" type="codeReqType" /><xsd:element name="description"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attribute ref="type" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="document-link"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element name="title" type="textType" /><xsd:element name="category" type="codeReqType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="url" type="xsd:anyURI" use="required" /><xsd:attribute name="format" type="xsd:string" /><xsd:attribute name="language" type="xsd:language" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-activities"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element ref="iati-activity" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="version" type="xsd:decimal" /><xsd:attribute name="generated-datetime" type="xsd:dateTime" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-activity"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element ref="activity-website" /><xsd:element ref="reporting-org" /><xsd:element ref="participating-org" /><xsd:element ref="recipient-country" /><xsd:element ref="recipient-region" /><xsd:element ref="collaboration-type" /><xsd:element ref="default-flow-type" /><xsd:element ref="default-aid-type" /><xsd:element ref="default-finance-type" /><xsd:element ref="iati-identifier" /><xsd:element ref="other-identifier" /><xsd:element ref="title" /><xsd:element ref="description" /><xsd:element ref="sector" /><xsd:element ref="activity-date" /><xsd:element ref="activity-status" /><xsd:element ref="contact-info" /><xsd:element ref="default-tied-status" /><xsd:element ref="policy-marker" /><xsd:element ref="location" /><xsd:element ref="total-cost" /><xsd:element ref="budget-planned" /><xsd:element ref="transaction" /><xsd:element ref="budget" /><xsd:element ref="related-initiative" /><xsd:element ref="related-activity" /><xsd:element ref="document-link" /><xsd:element ref="conditions" /><xsd:element ref="legacy-data" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="version" type="xsd:decimal" /><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" /><xsd:attribute ref="xml:lang" /><xsd:attribute name="default-currency" type="xsd:string" /><xsd:attribute name="hierarchy" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-identifier"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-organisation"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element ref="organisation-website" /><xsd:element ref="iati-identifier" /><xsd:element ref="name" /><xsd:element ref="total-budget" /><xsd:element ref="recipient-org-budget" /><xsd:element ref="recipient-country-budget" /><xsd:element ref="document-link" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="version" type="xsd:decimal" /><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" /><xsd:attribute ref="xml:lang" /><xsd:attribute name="default-currency" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="legacy-data"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="name" type="xsd:string" use="required" /><xsd:attribute name="value" type="xsd:string" use="required" /><xsd:attribute name="iati-equivalent" type="xsd:NMTOKEN" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="location"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="location-type" type="codeReqType" /><xsd:element name="name" type="textType" /><xsd:element name="description" type="textType" /><xsd:element name="administrative"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="country" type="xsd:string" /><xsd:attribute name="adm1" type="xsd:string" /><xsd:attribute name="adm2" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="coordinates"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="latitude" type="xsd:decimal" use="required" /><xsd:attribute name="longitude" type="xsd:decimal" use="required" /><xsd:attribute name="precision" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="gazetteer-entry"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="gazetteer-ref" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="name"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:attributeGroup ref="textAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="organisation-website"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:anyURI"><xsd:attribute ref="xml:lang" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="other-identifier"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:attribute name="owner-ref" type="xsd:string" /><xsd:attribute name="owner-name" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="participating-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="role" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="policy-marker"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeReqAtts" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="significance" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-country"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="codeAtts" /><xsd:attributeGroup ref="textAtts" /><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-country-budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="recipient-country" type="refType" /><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-org-budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="recipient-org" type="refType" /><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-region"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="codeAtts" /><xsd:attributeGroup ref="textAtts" /><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="related-activity"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attribute ref="ref" use="required" /><xsd:attribute ref="type" use="required" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="related-initiative" type="refType" /><xsd:element name="reporting-org" type="refType" /><xsd:element name="sector"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeAtts" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="title" type="textType" /><xsd:element name="total-budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="total-cost" type="currencyType" /><xsd:element name="transaction"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element name="value" type="currencyType" /><xsd:element name="transaction-type" type="codeType" /><xsd:element name="status" type="codeType" /><xsd:element name="provider-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="provider-activity-id" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="receiver-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="receiver-activity-id" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="provider-activity" type="refType" /><xsd:element name="receiver-activity" type="refType" /><xsd:element name="description" type="textType" minOccurs="0" /><xsd:element name="transaction-date"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="flow-type" type="codeReqType" /><xsd:element name="aid-type" type="codeReqType" /><xsd:element name="finance-type" type="codeReqType" /><xsd:element name="tied-status" type="codeReqType" /><xsd:element name="disbursement-channel" type="codeReqType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attributeGroup ref="refAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:attributeGroup name="codeAtts"><xsd:attribute ref="code" /><xsd:attribute ref="type" /></xsd:attributeGroup><xsd:attributeGroup name="codeReqAtts"><xsd:attribute ref="code" use="required" /><xsd:attribute ref="type" /></xsd:attributeGroup><xsd:attributeGroup name="refAtts"><xsd:attribute ref="ref" /><xsd:attribute ref="type" /></xsd:attributeGroup><xsd:attributeGroup name="textAtts"><xsd:attribute ref="xml:lang" /></xsd:attributeGroup><xsd:complexType name="codeReqType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeReqAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="codeType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="dateType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="plainType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="refType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="textType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema><xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://iatiregistry.org/ns/record#" targetNamespace="http://iatiregistry.org/ns/record#"><xsd:import namespace="http://www.w3.org/XML/1998/namespace" /><xsd:element name="registry-record"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute ref="xml:lang" /><xsd:attribute name="file-id" type="xsd:string" use="required" /><xsd:attribute name="source-url" type="xsd:anyURI" use="required" /><xsd:attribute name="publisher-id" type="xsd:string" use="required" /><xsd:attribute name="publisher-role" type="xsd:string" use="required" /><xsd:attribute name="contact-email" type="xsd:string" /><xsd:attribute name="donor-id" type="xsd:string" /><xsd:attribute name="donor-type" type="xsd:string" /><xsd:attribute name="donor-country" type="xsd:string" /><xsd:attribute name="title" type="xsd:string" use="required" /><xsd:attribute name="activity-period" type="xsd:string" /><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" use="required" /><xsd:attribute name="generated-datetime" type="xsd:dateTime" use="required" /><xsd:attribute name="verification-status" type="xsd:string" use="required" /><xsd:attribute name="format" type="xsd:string" use="required" /><xsd:attribute name="license" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:schema>'
GO
/****** Object:  XmlSchemaCollection [IATISchema].[SchemaCollectionPreConditions]    Script Date: 05/09/2018 10:37:12 ******/
CREATE XML SCHEMA COLLECTION [IATISchema].[SchemaCollectionPreConditions] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"><xsd:import namespace="http://www.w3.org/XML/1998/namespace" /><xsd:attribute name="code" type="xsd:string" /><xsd:attribute name="ref" type="xsd:string" /><xsd:attribute name="type" type="xsd:string" /><xsd:complexType name="currencyType"><xsd:simpleContent><xsd:extension base="xsd:integer"><xsd:attribute name="currency" type="xsd:string" /><xsd:attribute name="value-date" type="xsd:date" use="required" /><xsd:attribute ref="type" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType><xsd:element name="activity-date"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:string"><xsd:attributeGroup ref="textAtts" /><xsd:attribute ref="type" use="required" /><xsd:attribute name="iso-date" type="xsd:date" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="activity-status" type="codeReqType" /><xsd:element name="activity-website"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:anyURI"><xsd:attribute ref="xml:lang" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="period-start"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="period-end"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute ref="type" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="budget-planned"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element name="receiver-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="receiver-activity-id" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="description" type="textType" minOccurs="0" /><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute ref="type" /><xsd:attribute name="period" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="collaboration-type" type="codeReqType" /><xsd:element name="contact-info"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="organisation" type="xsd:anyType" /><xsd:element name="person-name" type="textType" /><xsd:element name="telephone"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="email" type="plainType" /><xsd:element name="mailing-address"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" /></xsd:choice><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="default-aid-type" type="codeReqType" /><xsd:element name="default-finance-type" type="codeReqType" /><xsd:element name="default-flow-type" type="codeReqType" /><xsd:element name="default-tied-status" type="codeReqType" /><xsd:element name="description"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attribute ref="type" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="document-link"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element name="title" type="textType" /><xsd:element name="category" type="codeReqType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="url" type="xsd:anyURI" use="required" /><xsd:attribute name="format" type="xsd:string" /><xsd:attribute name="language" type="xsd:language" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-activities"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element ref="iati-activity" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="version" type="xsd:decimal" /><xsd:attribute name="generated-datetime" type="xsd:dateTime" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-activity"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element ref="activity-website" /><xsd:element ref="reporting-org" /><xsd:element ref="participating-org" /><xsd:element ref="recipient-country" /><xsd:element ref="recipient-region" /><xsd:element ref="collaboration-type" /><xsd:element ref="default-flow-type" /><xsd:element ref="default-aid-type" /><xsd:element ref="default-finance-type" /><xsd:element ref="iati-identifier" /><xsd:element ref="other-identifier" /><xsd:element ref="title" /><xsd:element ref="description" /><xsd:element ref="sector" /><xsd:element ref="activity-date" /><xsd:element ref="activity-status" /><xsd:element ref="contact-info" /><xsd:element ref="default-tied-status" /><xsd:element ref="policy-marker" /><xsd:element ref="location" /><xsd:element ref="total-cost" /><xsd:element ref="budget-planned" /><xsd:element ref="transaction" /><xsd:element ref="budget" /><xsd:element ref="related-initiative" /><xsd:element ref="related-activity" /><xsd:element ref="document-link" /><xsd:element ref="legacy-data" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="version" type="xsd:decimal" /><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" /><xsd:attribute ref="xml:lang" /><xsd:attribute name="default-currency" type="xsd:string" /><xsd:attribute name="hierarchy" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-identifier"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="iati-organisation"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element ref="organisation-website" /><xsd:element ref="iati-identifier" /><xsd:element ref="name" /><xsd:element ref="total-budget" /><xsd:element ref="recipient-org-budget" /><xsd:element ref="recipient-country-budget" /><xsd:element ref="document-link" /><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="version" type="xsd:decimal" /><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" /><xsd:attribute ref="xml:lang" /><xsd:attribute name="default-currency" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="legacy-data"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="name" type="xsd:string" use="required" /><xsd:attribute name="value" type="xsd:string" use="required" /><xsd:attribute name="iati-equivalent" type="xsd:NMTOKEN" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="location"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="location-type" type="codeReqType" /><xsd:element name="name" type="textType" /><xsd:element name="description" type="textType" /><xsd:element name="administrative"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="country" type="xsd:string" /><xsd:attribute name="adm1" type="xsd:string" /><xsd:attribute name="adm2" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="coordinates"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="latitude" type="xsd:decimal" use="required" /><xsd:attribute name="longitude" type="xsd:decimal" use="required" /><xsd:attribute name="precision" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="gazetteer-entry"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="gazetteer-ref" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:any namespace="##other" /></xsd:choice><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="name"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:attributeGroup ref="textAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="organisation-website"><xsd:complexType><xsd:simpleContent><xsd:extension base="xsd:anyURI"><xsd:attribute ref="xml:lang" /><xsd:anyAttribute namespace="##other" /></xsd:extension></xsd:simpleContent></xsd:complexType></xsd:element><xsd:element name="other-identifier"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:attribute name="owner-ref" type="xsd:string" /><xsd:attribute name="owner-name" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="participating-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="role" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="policy-marker"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeReqAtts" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="significance" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-country"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="codeAtts" /><xsd:attributeGroup ref="textAtts" /><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-country-budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="recipient-country" type="refType" /><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-org-budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="recipient-org" type="refType" /><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="recipient-region"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="codeAtts" /><xsd:attributeGroup ref="textAtts" /><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="related-activity"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attribute ref="ref" use="required" /><xsd:attribute ref="type" use="required" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="related-initiative" type="refType" /><xsd:element name="reporting-org" type="refType" /><xsd:element name="sector"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeAtts" /><xsd:attribute name="vocabulary" type="xsd:string" /><xsd:attribute name="percentage" type="xsd:positiveInteger" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="title" type="textType" /><xsd:element name="total-budget"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="period-start" type="dateType" /><xsd:element name="period-end" type="dateType" /><xsd:element name="value" type="currencyType" /><xsd:any namespace="##other" /></xsd:choice><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="total-cost" type="currencyType" /><xsd:element name="transaction"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice maxOccurs="unbounded"><xsd:element name="value" type="currencyType" /><xsd:element name="transaction-type" type="codeType" /><xsd:element name="status" type="codeType" /><xsd:element name="provider-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="provider-activity-id" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="receiver-org"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:attribute name="receiver-activity-id" type="xsd:string" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="provider-activity" type="refType" /><xsd:element name="receiver-activity" type="refType" /><xsd:element name="description" type="textType" minOccurs="0" /><xsd:element name="transaction-date"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="flow-type" type="codeReqType" /><xsd:element name="aid-type" type="codeReqType" /><xsd:element name="finance-type" type="codeReqType" /><xsd:element name="tied-status" type="codeReqType" /><xsd:element name="disbursement-channel" type="codeReqType" /><xsd:any namespace="##other" /></xsd:choice><xsd:attributeGroup ref="refAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:attributeGroup name="codeAtts"><xsd:attribute ref="code" /><xsd:attribute ref="type" /></xsd:attributeGroup><xsd:attributeGroup name="codeReqAtts"><xsd:attribute ref="code" use="required" /><xsd:attribute ref="type" /></xsd:attributeGroup><xsd:attributeGroup name="refAtts"><xsd:attribute ref="ref" /><xsd:attribute ref="type" /></xsd:attributeGroup><xsd:attributeGroup name="textAtts"><xsd:attribute ref="xml:lang" /></xsd:attributeGroup><xsd:complexType name="codeReqType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeReqAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="codeType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="codeAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="dateType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="iso-date" type="xsd:date" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="plainType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="refType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:attributeGroup ref="refAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="textType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attributeGroup ref="textAtts" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema><xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://iatiregistry.org/ns/record#" targetNamespace="http://iatiregistry.org/ns/record#"><xsd:import namespace="http://www.w3.org/XML/1998/namespace" /><xsd:element name="registry-record"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="##other" /></xsd:choice><xsd:attribute ref="xml:lang" /><xsd:attribute name="file-id" type="xsd:string" use="required" /><xsd:attribute name="source-url" type="xsd:anyURI" use="required" /><xsd:attribute name="publisher-id" type="xsd:string" use="required" /><xsd:attribute name="publisher-role" type="xsd:string" use="required" /><xsd:attribute name="contact-email" type="xsd:string" /><xsd:attribute name="donor-id" type="xsd:string" /><xsd:attribute name="donor-type" type="xsd:string" /><xsd:attribute name="donor-country" type="xsd:string" /><xsd:attribute name="title" type="xsd:string" use="required" /><xsd:attribute name="activity-period" type="xsd:string" /><xsd:attribute name="last-updated-datetime" type="xsd:dateTime" use="required" /><xsd:attribute name="generated-datetime" type="xsd:dateTime" use="required" /><xsd:attribute name="verification-status" type="xsd:string" use="required" /><xsd:attribute name="format" type="xsd:string" use="required" /><xsd:attribute name="license" type="xsd:string" use="required" /><xsd:anyAttribute namespace="##other" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:schema>'
GO
/****** Object:  UserDefinedFunction [Configuration].[f_MakeDate]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE FUNCTION [Configuration].[f_MakeDate]
(
	@Year INT,
	@Month INT,
	@Day INT
)
RETURNS DATETIME
BEGIN
	DECLARE @DateAsString VARCHAR(MAX)
	
	SET @DateAsString =
		REPLACE(STR(@Year, 4), ' ', '0') +
		REPLACE(STR(@Month, 2), ' ', '0') +
		REPLACE(STR(@Day, 2), ' ', '0')
	
	RETURN CASE WHEN ISDATE(@DateAsString) = 1 THEN @DateAsString END
END
GO
/****** Object:  UserDefinedFunction [IATISchema].[f_ActivitiesRegistryRecord]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [IATISchema].[f_ActivitiesRegistryRecord]
(
	@ActivitiesID	INT
	,@URI			IATISchema.[xsd:anyURI]
)
RETURNS
	XML
BEGIN
	DECLARE @XML XML;

	WITH
		XMLNAMESPACES ('http://iatiregistry.org/ns/record#' AS ir),
		--XMLNAMESPACES (DEFAULT 'http://iatiregistry.org/ns/record#'),
		XML (XML) AS
	(
		SELECT
			[ir:registry-record/@xml:lang]
			,[ir:registry-record/@file-id]
			,@URI AS [ir:registry-record/@source-url]
			,[ir:registry-record/@publisher-id]
			,[ir:registry-record/@publisher-role]
			,[ir:registry-record/@contact-email]
			,[ir:registry-record/@donor-id]
			,[ir:registry-record/@donor-type]
			,[ir:registry-record/@donor-country]
			,[ir:registry-record/@title]
			,[ir:registry-record/@activity-period]
			,IATISchema.FormatXSDDateTime([ir:registry-record/@last-updated-datetime]) AS [ir:registry-record/@last-updated-datetime]
			,IATISchema.FormatXSDDateTime(ISNULL([ir:registry-record/@generated-datetime], GETDATE())) AS [ir:registry-record/@generated-datetime]
			,[ir:registry-record/@verification-status]
			,[ir:registry-record/@format]
			,[ir:registry-record/@license]

--			[ir:registry-record/@xml:lang] AS [@xml:lang]
--			,[ir:registry-record/@file-id] AS [@file-id]
--			,[ir:registry-record/@source-url] AS [@source-url]
--			,[ir:registry-record/@publisher-id] AS [@publisher-id]
--			,[ir:registry-record/@publisher-role] AS [@publisher-role]
--			,[ir:registry-record/@contact-email] AS [@contact-email]
--			,[ir:registry-record/@donor-id] AS [@donor-id]
--			,[ir:registry-record/@donor-type] AS [@donor-type]
--			,[ir:registry-record/@donor-country] AS [@donor-country]
--			,[ir:registry-record/@title] AS [@title]
--			,[ir:registry-record/@activity-period] AS [@activity-period]
--			,IATISchema.FormatXSDDateTime([ir:registry-record/@last-updated-datetime]) AS [@last-updated-datetime]
--			,IATISchema.FormatXSDDateTime([ir:registry-record/@generated-datetime]) AS [@generated-datetime]
--			,[ir:registry-record/@verification-status] AS [@verification-status]
--			,[ir:registry-record/@format] AS [@format]
--			,[ir:registry-record/@license] AS [@license]
		FROM
			IATISchema.[iati-activities]
		FOR XML PATH (''), TYPE
	)
	SELECT @XML = XML FROM XML

	RETURN @XML
END

--SELECT IATISchema.f_ActivitiesRegistryRecord(101, 'http://projects.dfid.gov.uk/test.xml')
--
--SELECT * FROM IATISchema.[iati-activities]--

GO
/****** Object:  UserDefinedFunction [IATISchema].[f_ActivitiesXMLFile_203_998]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
 * This function has been created to generate "Developing countries, unspecified" data in four parts as the data set is now too large
 * to be returned in one query.
 *
 * @ActivitiesId: Set to 101 as a default value 					
 * @URI:  The path to the hosted files, the number should match the file number (e.g. http://iati.dfid.gov.uk/iati_files/Non_Iati_Region/DFID-Developing-countries-unspecified-998-1.xml for year range 1)
 *
 * yearClause: Set the value in the where clause to limit the number of values returned by the Non Specific Country query for the SelectedComponents table in each function
 *		AND YEAR(CONVERT(datetime,[@iso-date],103)) <= 2008
 *		AND YEAR(CONVERT(datetime,[@iso-date],103)) IN (2009, 2010)
 *		AND YEAR(CONVERT(datetime,[@iso-date],103)) IN (2011, 2012)
 *		AND YEAR(CONVERT(datetime,[@iso-date],103)) >= 2013
 *
 * The calls for each function are as follows
 * Select TypedXML AS 'DFID-Developing-countries-unspecified-998-1' From IATISchema.f_ActivitiesXMLFile_203_998(101,'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-1.xml') 
 * Select TypedXML AS 'DFID-Developing-countries-unspecified-998-2' From IATISchema.f_ActivitiesXMLFile_203_998(101,'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-2.xml') 
 * Select TypedXML AS 'DFID-Developing-countries-unspecified-998-3' From IATISchema.f_ActivitiesXMLFile_203_998(101,'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-3.xml') 
 * Select TypedXML AS 'DFID-Developing-countries-unspecified-998-4' From IATISchema.f_ActivitiesXMLFile_203_998(101,'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-4.xml') 
 *
 */


--DROP FUNCTION [IATISchema].[f_ActivitiesXMLFile_203_998]

CREATE FUNCTION [IATISchema].[f_ActivitiesXMLFile_203_998]
(
	@ActivitiesId					INT
	,@URI							[IATISchema].[xsd:anyURI]
)
RETURNS @rtnTable TABLE
(
	[iati-activitiesID] INT NOT NULL,
	[Name] NVARCHAR(255) NULL,
	[Notes] NVARCHAR(MAX) NULL,
	UntypedXML XML NOT NULL,
	TypedXML XML NOT NULL	
)
AS
BEGIN
	DECLARE @allData TABLE
	(
	[iati-activityID] INT ,
	[iati-activitiesID] INT ,
	[ProjectId] varchar(25) ,
	[ComponentId] varchar(25) ,
	[BenefittingCountryCode] varchar(25) ,
	[CountryCode] nchar(4) ,
	[RegionCode] INT ,
	[@iso-date] DATETIME ,
	[UntypedXML] XML
	)
	
	DECLARE @selectedComponents TABLE
	(
	[iati-activityID] INT ,
	[iati-activitiesID] INT ,
	[ProjectId] varchar(25) ,
	[ComponentId] varchar(25) ,
	[BenefittingCountryCode] varchar(25) ,
	[CountryCode] nchar(4) ,
	[RegionCode] INT ,
	[@iso-date] DATETIME ,
	[UntypedXML] XML
	)

	DECLARE @relatedProjects TABLE
	(
	[iati-activityID] INT ,
	[iati-activitiesID] INT ,
	[ProjectId] varchar(25) ,
	[ComponentId] varchar(25) ,
	[BenefittingCountryCode] varchar(25) ,
	[CountryCode] nchar(4) ,
	[RegionCode] INT ,
	[@iso-date] DATETIME ,
	[UntypedXML] XML
	)

	DECLARE @relatedComponents TABLE
	(
	[iati-activityID] INT ,
	[iati-activitiesID] INT ,
	[ProjectId] varchar(25) ,
	[ComponentId] varchar(25) ,
	[BenefittingCountryCode] varchar(25) ,
	[CountryCode] nchar(4) ,
	[RegionCode] INT ,
	[@iso-date] DATETIME ,
	[UntypedXML] XML
	)

	DECLARE @main TABLE
	(
	[iati-activitiesID] INT NOT NULL,
	[Name] NVARCHAR(255) NULL,
	[Notes] NVARCHAR(MAX) NULL,
	[UntypedXML] XML NOT NULL	
	)

	INSERT @allData
		SELECT * FROM [IATISchema].[v_Activity_203_Planned_Start_Date] 	

	INSERT @selectedComponents
		SELECT * FROM @allData WHERE ComponentId IS NOT NULL AND RegionCode = 998

	IF @URI = 'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-1.xml' 		
		INSERT @relatedProjects 
			SELECT * FROM @allData WHERE (ProjectId IN (SELECT ProjectId FROM @selectedComponents)) AND ComponentId IS NULL AND YEAR(CONVERT(datetime,[@iso-date],103)) <= 2008
	ELSE IF @URI = 'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-2.xml'
		INSERT @relatedProjects 
			SELECT * FROM @allData WHERE (ProjectId IN (SELECT ProjectId FROM @selectedComponents)) AND ComponentId IS NULL AND YEAR(CONVERT(datetime,[@iso-date],103)) IN (2009, 2010)
	ELSE IF @URI = 'http://iati.dfid.gov.uk/iati_files/Region/DFID-Developing-countries-unspecified-998-3.xml'
		INSERT @relatedProjects 
			SELECT * FROM @allData WHERE (ProjectId IN (SELECT ProjectId FROM @selectedComponents)) AND ComponentId IS NULL AND YEAR(CONVERT(datetime,[@iso-date],103)) IN (2011, 2012)
	ELSE
		INSERT @relatedProjects 
			SELECT * FROM @allData WHERE (ProjectId IN (SELECT ProjectId FROM @selectedComponents)) AND ComponentId IS NULL AND YEAR(CONVERT(datetime,[@iso-date],103)) >= 2013

	INSERT @relatedComponents
		SELECT * FROM @selectedComponents WHERE (ProjectId IN (SELECT ProjectId FROM @relatedProjects))
	
	INSERT @main
		 SELECT
			[iati-activitiesID]
			,[Name]
			,[Notes]
			,(
				SELECT
					'2.03' as [@version]
					,[IATISchema].FormatXSDDateTime([@generated-datetime]) AS [@generated-datetime]
					,(
						SELECT
							UntypedXML AS [*]
						FROM
						(
							SELECT
								ProjectId, ComponentId, UntypedXML
							FROM
								@relatedComponents
							UNION ALL
							SELECT
								ProjectId, ComponentId, UntypedXML
							FROM
								@relatedProjects
						) q
						ORDER BY
							ProjectId, ComponentId
						FOR XML PATH (''), TYPE
					)
				FROM
					[IATISchema].[iati-activities]
				WHERE
					[iati-activities].[iati-activitiesID] = o.[iati-activitiesID]
				FOR XML PATH ('iati-activities'), TYPE
			) 
		FROM
			[IATISchema].[iati-activities] o
		WHERE
			[iati-activitiesID] = @ActivitiesId		

	--This select returns data
	insert into @rtnTable
		SELECT
			[iati-activitiesID]
			,[Name]
			,[Notes]
			,[UntypedXML] AS UntypedXML
			,CONVERT(XML,CONVERT(XML ([IATISchema].[SchemaCollection_2.03]), [UntypedXML])) AS TypedXML
		FROM  @main
	return

END


GO
/****** Object:  UserDefinedFunction [IATISchema].[f_ActivityActualEndDate]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [IATISchema].[f_ActivityActualEndDate]
(
	@IATIActivityId int
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @Return as DATETIME
	
	Select  @Return = [@iso-date] From [IATISchema].[activity-date] Where [iati-activityID] = @IATIActivityId AND [@type] = '4'

	RETURN @Return
END

GO
/****** Object:  UserDefinedFunction [IATISchema].[f_ActivityActualStartDate]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [IATISchema].[f_ActivityActualStartDate]
(
	@IATIActivityId int
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @Return as DATETIME
	
	Select  @Return = [@iso-date] From [IATISchema].[activity-date] Where [iati-activityID] = @IATIActivityId AND [@type] = '2'

	RETURN @Return
END

GO
/****** Object:  UserDefinedFunction [IATISchema].[f_OrganisationRegistryRecord]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [IATISchema].[f_OrganisationRegistryRecord]
(
	@OrganisationID	INT
	,@URI			IATISchema.[xsd:anyURI]
)
RETURNS
	XML
BEGIN
	DECLARE @XML XML;

	WITH
		XMLNAMESPACES ('http://iatiregistry.org/ns/record#' AS ir),
		--XMLNAMESPACES (DEFAULT 'http://iatiregistry.org/ns/record#'),
		XML (XML) AS
	(
		SELECT
			[ir:registry-record/@xml:lang]
			,[ir:registry-record/@file-id]
			,ISNULL(@URI, [ir:registry-record/@source-url]) AS [ir:registry-record/@source-url]
			,[ir:registry-record/@publisher-id]
			,[ir:registry-record/@publisher-role]
			,[ir:registry-record/@contact-email]
			,[ir:registry-record/@donor-id]
			,[ir:registry-record/@donor-type]
			,[ir:registry-record/@donor-country]
			,[ir:registry-record/@title]
			,[ir:registry-record/@activity-period]
			,IATISchema.FormatXSDDateTime([ir:registry-record/@last-updated-datetime]) AS [ir:registry-record/@last-updated-datetime]
			,IATISchema.FormatXSDDateTime(ISNULL([ir:registry-record/@generated-datetime], GETDATE())) AS [ir:registry-record/@generated-datetime]
			,[ir:registry-record/@verification-status]
			,[ir:registry-record/@format]
			,[ir:registry-record/@license]

--			[ir:registry-record/@xml:lang] AS [@xml:lang]
--			,[ir:registry-record/@file-id] AS [@file-id]
--			,[ir:registry-record/@source-url] AS [@source-url]
--			,[ir:registry-record/@publisher-id] AS [@publisher-id]
--			,[ir:registry-record/@publisher-role] AS [@publisher-role]
--			,[ir:registry-record/@contact-email] AS [@contact-email]
--			,[ir:registry-record/@donor-id] AS [@donor-id]
--			,[ir:registry-record/@donor-type] AS [@donor-type]
--			,[ir:registry-record/@donor-country] AS [@donor-country]
--			,[ir:registry-record/@title] AS [@title]
--			,[ir:registry-record/@activity-period] AS [@activity-period]
--			,IATISchema.FormatXSDDateTime([ir:registry-record/@last-updated-datetime]) AS [@last-updated-datetime]
--			,IATISchema.FormatXSDDateTime([ir:registry-record/@generated-datetime]) AS [@generated-datetime]
--			,[ir:registry-record/@verification-status] AS [@verification-status]
--			,[ir:registry-record/@format] AS [@format]
--			,[ir:registry-record/@license] AS [@license]
		FROM
			IATISchema.[iati-organisation]
		WHERE
			[iati-organisationID] = @OrganisationID
		FOR XML PATH (''), TYPE
	)
	SELECT @XML = XML FROM XML

	RETURN @XML
END--

GO
/****** Object:  UserDefinedFunction [IATISchema].[FormatXSDDate]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [IATISchema].[FormatXSDDate]
(
      @Date [xsd:date]
)
RETURNS
	CHAR(10)
BEGIN
	RETURN CONVERT(CHAR(10), @Date, 126)
END




GO
/****** Object:  UserDefinedFunction [IATISchema].[FormatXSDDateTime]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--DROP FUNCTION [IATISchema].[FormatXSDDateTime]


CREATE FUNCTION [IATISchema].[FormatXSDDateTime]
(
	@Date [xsd:dateTime]
)
RETURNS
	CHAR(25)
BEGIN
	RETURN CONVERT(CHAR(19), @Date, 127) --+ '+00:00'
END


GO
/****** Object:  UserDefinedFunction [PublicationControl].[f_Quarter]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [PublicationControl].[f_Quarter]
(
	@DateTime DATETIME
)
RETURNS
	CHAR(6)
AS
BEGIN
	RETURN
		STR(((DATEPART(QUARTER, @DateTime) + 2) % 4) + 1, 1) + ' ' +
		STR(YEAR(@DateTime) + CASE ((DATEPART(QUARTER, @DateTime) + 2) % 4) + 1 WHEN 4 THEN -1 ELSE 0 END, 4)
END

--SELECT IATI.f_Quarter(Configuration.f_MakeDate(2011, 3, 31))--


GO
/****** Object:  UserDefinedFunction [PublicationControl].[f_QuarterValue]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE FUNCTION [PublicationControl].[f_QuarterValue]
(
	@DateTime DATETIME
)
RETURNS
	INT
AS
BEGIN
	RETURN
		((DATEPART(QUARTER, @DateTime) + 2) % 4) + 1 
END




GO
/****** Object:  Table [IATISchema].[other-identifier]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[other-identifier](
	[other-identifierID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@ref] [IATISchema].[xsd:string] NOT NULL,
	[@type] [nvarchar](255) NOT NULL,
	[owner-org/@ref] [IATISchema].[xsd:string] NULL,
	[owner-org/text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [other-identifierID$pk] PRIMARY KEY CLUSTERED 
(
	[other-identifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[description]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[description](
	[descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@type] [nvarchar](255) NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [description$pk] PRIMARY KEY CLUSTERED 
(
	[descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[country-budget-items/budget-item]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[country-budget-items/budget-item](
	[country-budget-items/budget-itemID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@code] [nvarchar](10) NOT NULL,
	[@percentage] [IATISchema].[xsd:positiveInteger] NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [country-budget-items/budget-item$pk] PRIMARY KEY CLUSTERED 
(
	[country-budget-items/budget-itemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[title]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[title](
	[titleID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [title$pk] PRIMARY KEY CLUSTERED 
(
	[titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[Region]    Script Date: 05/09/2018 10:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[Region](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [Region$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Region$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[CollaborationType]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[CollaborationType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [CollaborationType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[location]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[location](
	[locationID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@ref] [nvarchar](255) NULL,
	[location-id/@vocabulary] [IATISchema].[xsd:string] NULL,
	[location-id/@code] [IATISchema].[xsd:string] NULL,
	[name/narrative/@xml:lang] [IATISchema].[xml:lang] NULL,
	[name/narrative] [IATISchema].[xsd:string] NULL,
	[description/narrative/@xml:lang] [IATISchema].[xml:lang] NULL,
	[description/narrative] [IATISchema].[xsd:string] NULL,
	[activity-description/narrative/@xml:lang] [IATISchema].[xml:lang] NULL,
	[activity-description/narrative] [IATISchema].[xsd:string] NULL,
	[administrative/@level] [IATISchema].[xsd:string] NULL,
	[administrative/@code] [IATISchema].[xsd:string] NULL,
	[administrative/@vocabulary] [IATISchema].[xsd:string] NULL,
	[point/@srsName] [IATISchema].[xsd:string] NULL,
	[point/pos] [IATISchema].[xsd:string] NULL,
	[exactness/@code] [nvarchar](255) NULL,
	[location-reach/@code] [nvarchar](255) NULL,
	[location-class/@code] [nvarchar](255) NULL,
	[feature-designation/@code] [nvarchar](255) NULL,
 CONSTRAINT [location104$pk] PRIMARY KEY CLUSTERED 
(
	[locationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[conditions]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[conditions](
	[conditionsID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@attached] [int] NOT NULL,
	[condtionFlag] [nvarchar](1) NULL,
 CONSTRAINT [conditions$pk] PRIMARY KEY CLUSTERED 
(
	[conditionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[conditions/condition]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[conditions/condition](
	[conditions/conditionID] [int] IDENTITY(1,1) NOT NULL,
	[conditionsID] [int] NOT NULL,
	[@type] [int] NOT NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [conditions/condition$pk] PRIMARY KEY CLUSTERED 
(
	[conditions/conditionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[Country]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[Country](
	[Code] [nchar](2) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [Country$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Country$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[recipient-country]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[recipient-country](
	[recipient-countryID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@code] [nchar](2) NOT NULL,
	[@type] [IATISchema].[xsd:string] NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@percentage] [IATISchema].[xsd:decimal] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [recipient-country$pk] PRIMARY KEY CLUSTERED 
(
	[recipient-countryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[DisbursementChannel]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[DisbursementChannel](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [DisbursementChannel$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [DisbursementChannel$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[OrganisationIdentifier]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[OrganisationIdentifier](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [OrganisationIdentifier$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[iati-activity]    Script Date: 05/09/2018 10:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[iati-activity](
	[iati-activityID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activitiesID] [int] NOT NULL,
	[ProjectId] [varchar](25) NOT NULL,
	[ComponentId] [varchar](25) NULL,
	[BenefittingCountryCode] [varchar](25) NULL,
	[CountryCode] [nchar](2) NULL,
	[RegionCode] [int] NULL,
	[@last-updated-datetime] [IATISchema].[xsd:datetime] NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@default-currency] [nchar](3) NULL,
	[@hierarchy] [IATISchema].[xsd:string] NULL,
	[reporting-org/@xml:lang] [IATISchema].[xml:lang] NULL,
	[reporting-org/@ref] [nvarchar](255) NULL,
	[reporting-org/@type] [int] NULL,
	[reporting-org/text()] [IATISchema].[xsd:string] NULL,
	[collaboration-type/@xml:lang] [IATISchema].[xml:lang] NULL,
	[collaboration-type/@code] [int] NULL,
	[collaboration-type/@type] [IATISchema].[xsd:string] NULL,
	[collaboration-type/text()] [IATISchema].[xsd:string] NULL,
	[default-flow-type/@xml:lang] [IATISchema].[xml:lang] NULL,
	[default-flow-type/@code] [int] NULL,
	[default-flow-type/@type] [IATISchema].[xsd:string] NULL,
	[default-flow-type/text()] [IATISchema].[xsd:string] NULL,
	[default-finance-type/@xml:lang] [IATISchema].[xml:lang] NULL,
	[default-finance-type/@code] [int] NULL,
	[default-finance-type/@type] [IATISchema].[xsd:string] NULL,
	[default-finance-type/text()] [IATISchema].[xsd:string] NULL,
	[iati-identifier/text()] [nvarchar](255) NULL,
	[other-identifier/@owner-ref] [nvarchar](255) NULL,
	[other-identifier/@owner-name] [IATISchema].[xsd:string] NULL,
	[other-identifier/text()] [IATISchema].[xsd:string] NULL,
	[activity-status/@xml:lang] [IATISchema].[xml:lang] NULL,
	[activity-status/@code] [int] NULL,
	[activity-status/@type] [IATISchema].[xsd:string] NULL,
	[activity-status/text()] [IATISchema].[xsd:string] NULL,
	[default-tied-status/@xml:lang] [IATISchema].[xml:lang] NULL,
	[default-tied-status/@code] [int] NULL,
	[default-tied-status/@type] [IATISchema].[xsd:string] NULL,
	[default-tied-status/text()] [IATISchema].[xsd:string] NULL,
	[@humanitarian] [bit] NULL,
	[@linked-data-uri] [IATISchema].[xsd:anyURI] NULL,
	[@budget-not-provided] [IATISchema].[xsd:string] NULL,
	[reporting-org/@secondary-reporter] [bit] NULL,
 CONSTRAINT [iati-activity$pk] PRIMARY KEY CLUSTERED 
(
	[iati-activityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [iati-activity$uq$iati-activitiesID$iati-identifier/text()] UNIQUE NONCLUSTERED 
(
	[iati-activitiesID] ASC,
	[iati-identifier/text()] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[participating-org]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[participating-org](
	[participating-orgID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@ref] [nvarchar](255) NULL,
	[@type] [int] NULL,
	[@role] [nvarchar](255) NOT NULL,
	[text()] [IATISchema].[xsd:string] NULL,
	[@activity-id] [nvarchar](255) NULL,
	[@crs-channel-code] [int] NULL,
 CONSTRAINT [participating-org$pk] PRIMARY KEY CLUSTERED 
(
	[participating-orgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[PolicyMarker]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[PolicyMarker](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PolicyMarker$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PolicyMarker$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[recipient-region]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[recipient-region](
	[recipient-regionID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@code] [int] NULL,
	[@type] [IATISchema].[xsd:string] NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@percentage] [IATISchema].[xsd:decimal] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
	[@vocabulary-uri] [IATISchema].[xsd:anyURI] NULL,
 CONSTRAINT [recipient-region$pk] PRIMARY KEY CLUSTERED 
(
	[recipient-regionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[DocumentCategory]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[DocumentCategory](
	[Code] [nchar](3) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CategoryCode] [nchar](1) NOT NULL,
 CONSTRAINT [DocumentContentType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [DocumentContentType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[policy-marker]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[policy-marker](
	[policy-markerID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@code] [int] NOT NULL,
	[@type] [IATISchema].[xsd:string] NULL,
	[@vocabulary] [nvarchar](255) NULL,
	[@significance] [int] NOT NULL,
	[text()] [IATISchema].[xsd:string] NULL,
	[@vocabulary-uri] [IATISchema].[xsd:anyURI] NULL,
 CONSTRAINT [policy-marker$pk] PRIMARY KEY CLUSTERED 
(
	[policy-markerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[sector]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[sector](
	[sectorID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@code] [int] NULL,
	[@type] [IATISchema].[xsd:string] NULL,
	[@other-code] [IATISchema].[xsd:string] NULL,
	[@vocabulary] [nvarchar](255) NULL,
	[@percentage] [IATISchema].[xsd:decimal] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
	[@vocabulary-uri] [IATISchema].[xsd:anyURI] NULL,
 CONSTRAINT [sector$pk] PRIMARY KEY CLUSTERED 
(
	[sectorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[default-aid-type]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[default-aid-type](
	[default-aid-typeID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
	[@vocabulary] [nchar](1) NULL,
 CONSTRAINT [default-aid-type$pk] PRIMARY KEY CLUSTERED 
(
	[default-aid-typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[document-link]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[document-link](
	[document-linkID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[QuestID] [varchar](15) NULL,
	[@url] [IATISchema].[xsd:anyURI] NOT NULL,
	[@format] [nvarchar](255) NULL,
	[@language] [IATISchema].[xsd:language] NULL,
	[@LastUpdated-Month-Year] [varchar](25) NULL,
 CONSTRAINT [document-link$pk] PRIMARY KEY CLUSTERED 
(
	[document-linkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[budget]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[budget](
	[budgetID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@type] [int] NULL,
	[@status] [int] NULL,
	[period-start/@iso-date] [IATISchema].[xsd:date] NOT NULL,
	[period-start/text()] [IATISchema].[xsd:string] NULL,
	[period-end/@iso-date] [IATISchema].[xsd:date] NOT NULL,
	[period-end/text()] [IATISchema].[xsd:string] NULL,
	[value/@currency] [nchar](3) NULL,
	[value/@value-date] [IATISchema].[xsd:date] NOT NULL,
	[value/text()] [IATISchema].[xsd:integer] NOT NULL,
 CONSTRAINT [budget$pk] PRIMARY KEY CLUSTERED 
(
	[budgetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[document-link/category]    Script Date: 05/09/2018 10:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[document-link/category](
	[document-link/categoryID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@code] [nchar](3) NOT NULL,
	[@type] [IATISchema].[xsd:string] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [document-link/category$pk] PRIMARY KEY CLUSTERED 
(
	[document-link/categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[activity-date]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[activity-date](
	[activity-dateID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@type] [nvarchar](255) NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@iso-date] [IATISchema].[xsd:date] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [activity-date$pk] PRIMARY KEY CLUSTERED 
(
	[activity-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[document-link/language]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[document-link/language](
	[document-link/languageID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](2) NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [document-link/language$pk] PRIMARY KEY CLUSTERED 
(
	[document-link/languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[transaction]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[transaction](
	[transactionID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[IsExcluded] [bit] NOT NULL,
	[OriginalValue] [decimal](28, 3) NOT NULL,
	[@ref] [IATISchema].[xsd:string] NULL,
	[@humanitarian] [bit] NULL,
	[value/@currency] [nchar](3) NULL,
	[value/@value-date] [IATISchema].[xsd:date] NULL,
	[value/@type] [IATISchema].[xsd:string] NULL,
	[value/text()] [IATISchema].[xsd:integer] NULL,
	[transaction-type/@xml:lang] [IATISchema].[xml:lang] NULL,
	[transaction-type/@code] [nvarchar](255) NULL,
	[transaction-type/@type] [IATISchema].[xsd:string] NULL,
	[transaction-type/text()] [IATISchema].[xsd:string] NULL,
	[provider-org/@xml:lang] [IATISchema].[xml:lang] NULL,
	[provider-org/@ref] [nvarchar](255) NULL,
	[provider-org/@type] [IATISchema].[xsd:string] NULL,
	[provider-org/@provider-activity-id] [IATISchema].[xsd:string] NULL,
	[provider-org/text()] [IATISchema].[xsd:string] NULL,
	[receiver-org/@xml:lang] [IATISchema].[xml:lang] NULL,
	[receiver-org/@ref] [nvarchar](255) NULL,
	[receiver-org/@type] [IATISchema].[xsd:string] NULL,
	[receiver-org/@receiver-activity-id] [IATISchema].[xsd:string] NULL,
	[receiver-org/text()] [IATISchema].[xsd:string] NULL,
	[description/@xml:lang] [IATISchema].[xml:lang] NULL,
	[description/text()] [IATISchema].[xsd:string] NULL,
	[transaction-date/@iso-date] [IATISchema].[xsd:date] NULL,
	[transaction-date/text()] [IATISchema].[xsd:string] NULL,
	[flow-type/@xml:lang] [IATISchema].[xml:lang] NULL,
	[flow-type/@code] [int] NULL,
	[flow-type/@type] [IATISchema].[xsd:string] NULL,
	[flow-type/text()] [IATISchema].[xsd:string] NULL,
	[finance-type/@xml:lang] [IATISchema].[xml:lang] NULL,
	[finance-type/@code] [int] NULL,
	[finance-type/@type] [IATISchema].[xsd:string] NULL,
	[finance-type/text()] [IATISchema].[xsd:string] NULL,
	[tied-status/@xml:lang] [IATISchema].[xml:lang] NULL,
	[tied-status/@code] [int] NULL,
	[tied-status/@type] [IATISchema].[xsd:string] NULL,
	[tied-status/text()] [IATISchema].[xsd:string] NULL,
	[disbursement-channel/@xml:lang] [IATISchema].[xml:lang] NULL,
	[disbursement-channel/@code] [nvarchar](255) NULL,
	[disbursement-channel/@type] [IATISchema].[xsd:string] NULL,
	[disbursement-channel/text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [transaction$pk] PRIMARY KEY CLUSTERED 
(
	[transactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[related-activity]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[related-activity](
	[related-activityID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@ref] [IATISchema].[xsd:string] NOT NULL,
	[@type] [int] NOT NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [related-activity$pk] PRIMARY KEY CLUSTERED 
(
	[related-activityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[document-link/title]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[document-link/title](
	[document-link/titleID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [document-link/title$pk] PRIMARY KEY CLUSTERED 
(
	[document-link/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[FinanceType]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[FinanceType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Category] [int] NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [FinanceType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [FinanceType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[capital-spend]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[capital-spend](
	[capital-spendID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@percentage] [IATISchema].[xsd:positiveInteger] NULL,
 CONSTRAINT [capital-spend$pk] PRIMARY KEY CLUSTERED 
(
	[capital-spendID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[DAC5DigitSector]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[DAC5DigitSector](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CategoryCode] [int] NOT NULL,
 CONSTRAINT [Sector$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[FlowType]    Script Date: 05/09/2018 10:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[FlowType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [FlowType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [FlowType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[TiedStatus]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[TiedStatus](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [TiedStatus$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [TiedStatus$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[TransactionType]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[TransactionType](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [TransactionType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [TransactionType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ActivityStatus]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ActivityStatus](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [ActivityStatus$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ActivityStatus$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[contact-info]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[contact-info](
	[contact-infoID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[organisation/text()] [IATISchema].[xsd:string] NULL,
	[person-name/@xml:lang] [IATISchema].[xml:lang] NULL,
	[person-name/text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [contact-info$pk] PRIMARY KEY CLUSTERED 
(
	[contact-infoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[contact-info/details]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[contact-info/details](
	[contact-info/detailsID] [int] IDENTITY(1,1) NOT NULL,
	[contact-infoID] [int] NOT NULL,
	[telephone/text()] [IATISchema].[xsd:string] NULL,
	[email/text()] [IATISchema].[xsd:string] NULL,
	[mailing-address/text()] [IATISchema].[xsd:string] NULL,
	[website/text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [contact-info/details$pk] PRIMARY KEY CLUSTERED 
(
	[contact-info/detailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[country-budget-items]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[country-budget-items](
	[country-budget-itemsID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@vocabulary] [nvarchar](255) NOT NULL,
 CONSTRAINT [country-budget-items$pk] PRIMARY KEY CLUSTERED 
(
	[country-budget-itemsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [IATISchema].[v_Activity_203]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







--DROP VIEW [IATISchema].[v_Activity_203]




CREATE VIEW [IATISchema].[v_Activity_203] AS
WITH
       Main AS
(
       SELECT
              [iati-activityID]
              ,[iati-activitiesID]
              ,[ProjectId]
              ,[ComponentId]
              ,[BenefittingCountryCode]
              ,[CountryCode]
              ,[RegionCode]
              ,(
                     SELECT
                           -- iati-activity
                            [IATISchema].FormatXSDDateTime([iati-activity].[@last-updated-datetime]) AS [@last-updated-datetime]
                           ,[iati-activity].[@xml:lang]                           
                           ,[iati-activity].[@default-currency]             
                           ,[iati-activity].[@hierarchy]                   
                           
                           -- 1 iati-identifier
                           ,[iati-identifier/text()]
                           
                           -- 2 reporting-org
                           ,[iati-activity].[reporting-org/@xml:lang]
                           ,[iati-activity].[reporting-org/@ref]
                           ,[iati-activity].[reporting-org/@type]
                           ,ReportingOrganisation.Name AS [reporting-org/narrative]
                           
                           -- 3 title
                           ,(
                                  SELECT
                                         [title].[@xml:lang]
                                         ,[title].[text()] as [narrative]            
                                  FROM
                                         [IATISchema].[title]
                                  WHERE
                                         [title].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('title'), TYPE
                           )
                           
                           -- 4 description
                           ,(
                                  SELECT
                                         [description].[@xml:lang]
                                         ,[description].[@type]
                                         ,[description].[text()] as [narrative]            
                                  FROM
                                         [IATISchema].[description]
                                  WHERE
                                         [description].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('description'), TYPE
                           )
                           
                           -- 5 participating-org
                           ,(
                                  SELECT tpd.[@xml:lang],tpd.[@ref],tpd.[@type],tpd.[@role],tpd.[narrative] 
								  FROM	(SELECT distinct
                                                [participating-org].[@xml:lang]  
                                                ,[participating-org].[@ref]             
                                                ,[participating-org].[@type]            
                                                ,[participating-org].[@role]
                                                ,[participating-org].[text()] AS [narrative]
                                         FROM
                                                [IATISchema].[participating-org]
                                         WHERE
                                                [participating-org].[iati-activityId] = [iati-activity].[iati-activityId]) as tpd
                                  FOR XML PATH ('participating-org'), TYPE
                           )
                          
						  
				 
                           -- 5.5 other-identifier
                           ,(
                                  SELECT
                                         [other-identifier].[@ref]
                                         ,[other-identifier].[@type]
                                         ,[other-identifier].[owner-org/@ref] AS [owner-org/@ref]
                                         ,[other-identifier].[owner-org/text()] AS [owner-org/narrative]             
	                              FROM
                                         [IATISchema].[other-identifier]
                                  WHERE
                                         [other-identifier].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('other-identifier'), TYPE
                           )


                           -- 6 activity-status
                           ,[iati-activity].[activity-status/@xml:lang] 
                           ,[iati-activity].[activity-status/@code]          
                           ,[iati-activity].[activity-status/@type]                                      
                           
                           -- 7 activity-date
                           ,(
                                  SELECT [activity-date].[@type] as [@type]
                                            ,[IATISchema].FormatXSDDate([activity-date].[@iso-date]) AS [@iso-date]                                      
                                  FROM
                                         [IATISchema].[activity-date]
                                  WHERE
                                         [activity-date].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('activity-date'), TYPE
                           )
                           
                           -- 8 contact-info
                           ,(
                                  SELECT
                                         '1' as [@type]
                                         ,[contact-info].[organisation/text()] AS [organisation/narrative]
                                         ,[contact-info].[person-name/text()] AS [person-name/narrative]
                                         ,(
                                                SELECT
                                                       [contact-info/details].[telephone/text()] AS [telephone]           
                                                       ,[contact-info/details].[email/text()] AS [email]         
                                                       --,[contact-info/details].[website/text()] AS [website]       
                                                       ,[contact-info/details].[mailing-address/text()] AS [mailing-address/narrative]
                                                FROM
                                                       [IATISchema].[contact-info/details]
                                                WHERE
                                                       [contact-info/details].[contact-infoID] = [contact-info].[contact-infoID]
                                                FOR XML PATH (''), TYPE
                                         )
                                  FROM
                                         [IATISchema].[contact-info]
                                  WHERE
                                         [contact-info].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('contact-info'), TYPE
                           )
                           
                           -- 10 activity-scope 
                           
                           -- 11 recipient-country
                           ,(
                                  SELECT
                                         [recipient-country].[@code]
                                         --,[recipient-country].[@type]
                                         --,[recipient-country].[@xml:lang]
                                         ,[recipient-country].[@percentage]
                                         --,ISNULL([recipient-country].[text()], Country.Name) AS [text()]         
                                  FROM
                                         [IATISchema].[recipient-country]
                                  LEFT OUTER JOIN
                                         [Codelist].Country
                                  ON
                                         [recipient-country].[@code] = Country.Code
                                  WHERE
                                         [recipient-country].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('recipient-country'), TYPE
                           )
                           
                           -- 12 recipient-region
                           ,(
                                  SELECT
                                         [recipient-region].[@code]
                                         --,[recipient-region].[@type]
                                         --,[recipient-region].[@xml:lang]
                                         ,[recipient-region].[@percentage]
                                         --,ISNULL([recipient-region].[text()], Region.Name) AS [text()]
                                  FROM
                                         [IATISchema].[recipient-region]
                                  LEFT OUTER JOIN
                                         [Codelist].Region
                                  ON
                                         [recipient-region].[@code] = Region.Code
                                  WHERE
                                         [recipient-region].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('recipient-region'), TYPE
                           )
                           
                           -- 13 location
                           ,(
                                  SELECT
                                         [location].[@ref]                                  
                                         ,[location].[location-reach/@code]
                                         --,[location104].[name/narrative/@xml:lang]                        
                                         ,[location].[name/narrative]                                
                                         --,[location104].[description/narrative/@xml:lang]                    
                                         ,[location].[description/narrative]              
                                         --,[location104].[activity-description/narrative/@xml:lang]                    
                                         ,[location].[activity-description/narrative]              
                                         ,[location].[administrative/@vocabulary] 
                                         ,[location].[administrative/@level]             
                                         ,[location].[administrative/@code]                   
                                         ,[location].[point/@srsName]
                                         ,[location].[point/pos]         
                                         ,[location].[exactness/@code]         
                                         ,[location].[location-class/@code]            
                                         ,[location].[feature-designation/@code]        
                                  FROM
                                         [IATISchema].[location]
                                  WHERE
                                         [location].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('location'), TYPE
                           )                           
                           
                           -- 14 sector
                           ,(
                                  SELECT
                                         SchemaSector.[@xml:lang]
                                         ,SchemaSector.[@vocabulary]
                                         ,ISNULL(CONVERT(NVARCHAR(MAX), SchemaSector.[@code]), SchemaSector.[@other-code]) AS [@code]
                                         --,SchemaSector.[@type]
                                         ,SchemaSector.[@percentage]
                                         ,ISNULL(SchemaSector.[text()], CodeListSector.Name) AS [narrative]              
                                  FROM
                                         [IATISchema].[sector] SchemaSector
                                  LEFT OUTER JOIN
                                         [Codelist].DAC5DigitSector CodeListSector
                                  ON
                                         SchemaSector.[@code] = CodeListSector.Code
                                  WHERE
                                         SchemaSector.[iati-activityId] = [iati-activity].[iati-activityId]
                                  ORDER BY
                                         SchemaSector.[@vocabulary]
                                         ,SchemaSector.[@percentage] DESC
                                         ,ISNULL(CONVERT(NVARCHAR(MAX), SchemaSector.[@code]), SchemaSector.[@other-code])
                                  FOR XML PATH ('sector'), TYPE
                           )
                           
                           -- 15 country-budget-items
                           ,(
                                  SELECT
                                         [country-budget-items].[@vocabulary]
                                         ,(
                                                SELECT
                                                       [@code]
                                                       ,[@percentage]
                                                       ,[text()] AS [description/narrative]
                                                FROM
                                                       [IATISchema].[country-budget-items/budget-item]
                                                WHERE
                                                       [country-budget-items/budget-item].[iati-activityID] = [iati-activity].[iati-activityID]
                                                FOR XML PATH ('budget-item'), TYPE
                                         )
                                  FROM
                                         [IATISchema].[country-budget-items]
                                  WHERE
                                         [country-budget-items].[iati-activityID] = [iati-activity].[iati-activityID]
                                  FOR XML PATH ('country-budget-items'), TYPE
                           )                           
                           
                           -- 16 policy-marker
                           ,(
                                  SELECT
                                         [policy-marker].[@xml:lang]           
                                         ,[policy-marker].[@vocabulary] 
                                         ,[policy-marker].[@code]                    
                                         --,[policy-marker].[@type]                   
                                         ,[policy-marker].[@significance] 
                                         ,ISNULL([policy-marker].[text()], PolicyMarker.Name) AS [narrative]
                                  FROM
                                         [IATISchema].[policy-marker]
                                  LEFT OUTER JOIN
                                         [Codelist].PolicyMarker
                                  ON
                                         [policy-marker].[@code] = PolicyMarker.Code
                                  WHERE
                                         [policy-marker].[iati-activityId] = [iati-activity].[iati-activityId]
                                  ORDER BY
                                         [policy-marker].[@code]
                                  FOR XML PATH ('policy-marker'), TYPE
                           )
                           
                           -- 17 collaboration-type
                           --,[iati-activity].[collaboration-type/@xml:lang]
                           ,[iati-activity].[collaboration-type/@code]
                           --,[iati-activity].[collaboration-type/@type]
                           --,ISNULL([iati-activity].[collaboration-type/text()], CollaborationType.Name) AS [collaboration-type/text()]
--                          ,(
--                                 SELECT
--                                        [collaboration-type].[@xml:lang]
--                                        ,[collaboration-type].[@code]
--                                        ,[collaboration-type].[@type]
--                                        ,CollaborationType.Name AS [text()]          
--                                 FROM
--                                        $(ActivitiesSchema).[collaboration-type]
--                                 LEFT OUTER JOIN
--                                        $(CodeListSchema).CollaborationType
--                                 ON
--                                        [collaboration-type].[@code] = CollaborationType.Code
--                                 WHERE
--                                        [collaboration-type].[iati-activityId] = [iati-activity].[iati-activityId]
--                                 FOR XML PATH ('collaboration-type'), TYPE
--                          )
                           
                           -- 18 default-flow-type
                           --,[default-flow-type/@xml:lang]	 
                           ,[default-flow-type/@code]			    
                           --,[default-flow-type/@type]          
                           --,ISNULL([iati-activity].[default-flow-type/text()], FlowType.Name) AS [default-flow-type/text()]           
                           
                           -- 19 default-finance-type
                           --,[default-finance-type/@xml:lang]
                           ,[default-finance-type/@code]  
                           --,[default-finance-type/@type]
                           --,ISNULL([iati-activity].[default-finance-type/text()], FinanceType.Name) AS [default-finance-type/text()]           
                           

                           -- 20 default-aid-type
						    ,(
                                SELECT  [@code]
								FROM	[IATISchema].[default-aid-type]
								WHERE
								        [IATISchema].[default-aid-type].[iati-activityID] = [IATISchema].[iati-activity].[iati-activityId]
								FOR XML PATH ('default-aid-type'), TYPE
                           )
						             
                           -- 21 default-tied-status
                           --,[default-tied-status/@xml:lang]      
                           ,[default-tied-status/@code]          
                           --,[default-tied-status/@type]         
                           --,ISNULL([default-tied-status/text()], TiedStatus.Name) AS [default-tied-status/text()]
                           
                           -- 22 budget
                           ,(
                                  SELECT
                                         [budget].[@type]
                                         ,[IATISchema].[FormatXSDDate]([budget].[period-start/@iso-date]) as [period-start/@iso-date]
                                         ,[budget].[period-start/text()]
                                         ,[IATISchema].[FormatXSDDate]([budget].[period-end/@iso-date]) as [period-end/@iso-date] 
                                         ,[budget].[period-end/text()]
                                         ,[IATISchema].[FormatXSDDate]([budget].[value/@value-date]) as [value/@value-date]
                                         ,[budget].[value/@currency]
                                         ,[budget].[value/text()]                                    
                                  FROM
                                         [IATISchema].[budget]
                                  WHERE
                                         [budget].[iati-activityID] = [iati-activity].[iati-activityId]
                                  ORDER BY
                                         [budget].[period-start/@iso-date]
                                  FOR XML PATH ('budget'),TYPE
                           )
                           
                           -- 23 planned-disbursement
                           
                           -- 24 capital-spend
                        ,(
                                  SELECT
                                         [capital-spend].[@percentage]
                                  FROM
                                         [IATISchema].[capital-spend]
                                  WHERE
                                         [capital-spend].[iati-activityId] = [iati-activity].[iati-activityId]
                                  FOR XML PATH ('capital-spend'), TYPE
                           )                           
                           
                           -- 25 transaction
                           ,(
                                  SELECT
                                         NULL AS [@ref]                                                     
                                         --,[transaction].[@type]                                                 
                                         --,[transaction].[transaction-type/@xml:lang]                  
                                           ,[transaction].[transaction-type/@code]                     										 
                                         --,[transaction].[transaction-type/@type]                     
                                         --,ISNULL([transaction].[transaction-type/text()], TransactionType.Name) AS [transaction-type/text()]
--                                                     ,[transaction].[status/@xml:lang]                            
--                                                     ,[transaction].[status/@code]                                     
--                                                     ,[transaction].[status/@type]                                      
--                                                     ,[transaction].[status/text()]                                        
                                         ,[IATISchema].FormatXSDDate([transaction].[transaction-date/@iso-date]) AS [transaction-date/@iso-date]
                                         --,[transaction].[transaction-date/text()]               
                                         ,[transaction].[value/@currency]                            
                                         ,[IATISchema].FormatXSDDate([transaction].[value/@value-date]) AS [value/@value-date]
                                         --,[transaction].[value/@type]                                     
                                         ,[transaction].[value/text()]                                        
                                         ,[transaction].[description/@xml:lang]                       
                                         ,[transaction].[description/text()] AS [description/narrative]
                                         --,[transaction].[provider-org/@xml:lang]                            
                                         ,[transaction].[provider-org/@provider-activity-id]      
                                         ,[transaction].[provider-org/@ref]                                 
                                         --,[transaction].[provider-org/@type]                               
                                         ,ISNULL([transaction].[provider-org/text()], provider.Name) AS [provider-org/narrative]
                                         --,[transaction].[receiver-org/@xml:lang]                     
                                         ,[transaction].[receiver-org/@receiver-activity-id]       
                                         ,[transaction].[receiver-org/@ref]                                  
                                         --,[transaction].[receiver-org/@type]                               
                                         ,ISNULL([transaction].[receiver-org/text()], receiver.Name) AS [receiver-org/narrative]
                                         --,[transaction].[disbursement-channel/@xml:lang]             
                                         ,[transaction].[disbursement-channel/@code]                 
                                         --,[transaction].[disbursement-channel/@type]                
                                         --,ISNULL([transaction].[disbursement-channel/text()], DisbursementChannel.Name) AS [disbursement-channel/text()]
                                         -- TODO: Sector
                                         -- TODO: Recipient Country
                                         -- TODO: Recipient Region
                                         --,[transaction].[@flow]                                                  
                                         --,[transaction].[flow-type/@xml:lang]                       
                                         ,[transaction].[flow-type/@code]                                  
                                         --,[transaction].[flow-type/@type]                                  
                                         --,ISNULL([transaction].[flow-type/text()], FlowType.Name) AS [flow-type/text()]
                                         --,[transaction].[finance-type/@xml:lang]                     
                                         ,[transaction].[finance-type/@code]                                
                                         --,[transaction].[finance-type/@type]                               
                                         --,ISNULL([transaction].[finance-type/text()], FinanceType.Name) AS [finance-type/text()]
                                         --,[transaction].[aid-type/@xml:lang]                               
                                         --,[transaction].[aid-type/@code]                                   
                                         --,[transaction].[aid-type/@type]                                         
                                         --,ISNULL([transaction].[aid-type/text()], AidType.Name) AS [aid-type/text()]
                                         --,[transaction].[tied-status/@xml:lang]                      
                                         ,[transaction].[tied-status/@code]                                 
                                         --,[transaction].[tied-status/@type]                                 
                                         --,ISNULL([transaction].[tied-status/text()], TiedStatus.Name) AS [tied-status/text()]
                                  FROM
                                         [IATISchema].[transaction]
                                  LEFT OUTER JOIN
                                         [Codelist].TransactionType
                                  ON
                                         [transaction].[transaction-type/@code] = TransactionType.Code
                                  LEFT OUTER JOIN
                                         [Codelist].OrganisationIdentifier provider
                                  ON
                                         [transaction].[provider-org/@ref] = provider.Code
                                  LEFT OUTER JOIN
                                         [Codelist].OrganisationIdentifier receiver
                                  ON
                                         [transaction].[receiver-org/@ref] = receiver.Code
                                  LEFT OUTER JOIN
                                         [Codelist].FlowType
                                  ON
                                         [transaction].[flow-type/@code] = FlowType.Code
                                  --LEFT OUTER JOIN
                                  --       [Codelist].AidType
                                  --ON
                                  --       [transaction].[aid-type/@code] = AidType.Code
                                  LEFT OUTER JOIN
                                         [Codelist].FinanceType
                                  ON
                                         [transaction].[finance-type/@code] = FinanceType.Code
                                  LEFT OUTER JOIN
                                         [Codelist].TiedStatus
                                  ON
                                         [transaction].[tied-status/@code] = TiedStatus.Code
                                  LEFT OUTER JOIN
                                         [Codelist].DisbursementChannel
                                  ON
                                         [transaction].[disbursement-channel/@code] = DisbursementChannel.Code
                                  WHERE
                                         [transaction].[iati-activityId] = [iati-activity].[iati-activityId]
                                  ORDER BY
                                         [transaction].[transaction-type/@code]
                                         ,[transaction].[transaction-date/@iso-date]
                                  FOR XML PATH ('transaction'), TYPE
                           )
                           
                           -- 26 document-link
                           ,(
                                  SELECT
                                         [document-link].[@format]
                                         ,[document-link].[@url]
                                         --,[document-link].[@language]
                                         ,(
                                                SELECT
                                                       [@xml:lang]
                                                       ,[text()] AS [narrative]
                                                FROM
                                                       [IATISchema].[document-link/title]
                                                WHERE
                                                       [document-linkID] = [document-link].[document-linkID]
                                                ORDER BY
                                                       CASE WHEN [@xml:lang] = 'en' THEN 1 ELSE 2 END
                                                       ,[@xml:lang]
                                                       ,[text()]
                                                FOR XML PATH ('title'), TYPE
                                         )
                                         ,( -- category
                                                SELECT
                                                       --[document-link/category].[@xml:lang]
                                                       [document-link/category].[@code]
                                                       --,[document-link/category].[@type]
                                                       --,DocumentContentType.Name AS [text()]
                                                FROM
                                                       [IATISchema].[document-link/category]
                                                LEFT OUTER JOIN
                                                       [Codelist].[DocumentCategory] 
                                                ON
                                                       [document-link/category].[@code] = [DocumentCategory].Code
                                                WHERE
                                                       [document-link/category].[document-linkID] = [document-link].[document-linkID]
                                                ORDER BY
                                                       CASE WHEN [document-link/category].[@xml:lang] = 'en' THEN 1 ELSE 2 END
                                                       ,[document-link/category].[@xml:lang]
                                                       ,[DocumentCategory].Name
                                                FOR XML PATH ('category'), TYPE
                                         )
                                         ,( -- language
                                                SELECT
                                                       [@code]
                                                       --,[@xml:lang]
                                                       --,[text()]
                                                FROM
                                                       [IATISchema].[document-link/language]
                                                WHERE
                                                       [document-linkID] = [document-link].[document-linkID]
                                                ORDER BY
                                                       CASE WHEN [@xml:lang] = 'en' THEN 1 ELSE 2 END
                                                       ,[@xml:lang]
                                                       ,[text()]
                                                FOR XML PATH ('language'), TYPE
                                         )
                                  FROM
                                         [IATISchema].[document-link]
                                  WHERE
                                         [document-link].[iati-activityID] = [iati-activity].[iati-activityID]
                                  ORDER BY
                                         [document-link].QuestID
                                  FOR XML PATH ('document-link'), TYPE
                           )
                           
                           -- 27 activity-website
                           
                           -- 28 related-activity
                           ,(
                                  SELECT
                                         [related-activity].[@xml:lang]                 
                                         ,[related-activity].[@ref]                     
                                         ,[related-activity].[@type]
                                         --,[related-activity].[text()]                    
                                  FROM
                                         [IATISchema].[related-activity]
--                                 LEFT OUTER JOIN
--                                        $(CodeListSchema).RelatedActivityType
--                                 ON
--                                        [related-activity].[@type] = RelatedActivityType.Code
                                  WHERE
                                         [related-activity].[iati-activityId] = [iati-activity].[iati-activityId]
                                  -- order by type (parent, child, sibling), reference (Component ID)
                                  ORDER BY
                                         [related-activity].[@type]       -- parent, child then sibling
                                         ,[related-activity].[@ref]
                                  FOR XML PATH ('related-activity'), TYPE
                           )

                           -- 31 legacy-data - TODO
                    --    ,(
                           --     SELECT
                           --            [legacy-data].[@name]
                           --            ,[legacy-data].[text()] as [@value]
                           --            ,[legacy-data].[@iati-equivalent]
                           --            --,[legacy-data].[text()]
                           --     FROM
                           --            [IATISchema].[legacy-data]
                           --     WHERE
                           --            [legacy-data].[iati-activityId] = [iati-activity].[iati-activityId]
                           --     FOR XML PATH ('legacy-data'), TYPE
                           --)                         
                           -- 29 conditions
                           ,(
                                  SELECT
                                         [conditions].[@attached]
                                         ,(
                                                SELECT
                                                       [@type]
                                                       ,[text()] AS [narrative]
                                                FROM
                                                       [IATISchema].[conditions/condition]
                                                WHERE
                                                       [conditionsID] = [conditions].[conditionsID]
                                                FOR XML PATH ('condition'), TYPE
                                         )
                                  FROM
                                         [IATISchema].[conditions]
                                  WHERE
                                         [conditions].[iati-activityID] = [iati-activity].[iati-activityID]
                                  FOR XML PATH ('conditions'), TYPE
                           )
                           
                           -- 30 result
                           -- TODO - Populate Result
                           

                     FROM
                           [IATISchema].[iati-activity]
                     LEFT OUTER JOIN
                           [Codelist].OrganisationIdentifier ReportingOrganisation
                     ON
                           [iati-activity].[reporting-org/@ref] = ReportingOrganisation.Code
                     LEFT OUTER JOIN
                           [Codelist].CollaborationType
                     ON
                           [iati-activity].[collaboration-type/@code] = CollaborationType.Code
                     LEFT OUTER JOIN
                           [Codelist].FlowType
                     ON
                           [iati-activity].[default-flow-type/@code] = FlowType.Code
					 --LEFT OUTER JOIN
                     --      [Codelist].AidType
                     --ON
                     --      [IATISchema].[default-aid-type].[@code] = AidType.Code
                     LEFT OUTER JOIN
                           [Codelist].FinanceType
                     ON
                           [iati-activity].[default-finance-type/@code] = FinanceType.Code
                     --LEFT OUTER JOIN
                           --[Codelist].OrganisationIdentifier OtherIdentifierOwner
                     --ON
                           --[iati-activity].[other-identifier/@owner-ref] = OtherIdentifierOwner.Code
                     LEFT OUTER JOIN
                           [Codelist].ActivityStatus
                     ON
                           [iati-activity].[activity-status/@code] = ActivityStatus.Code
                     LEFT OUTER JOIN
                           [Codelist].TiedStatus
                     ON
                           [iati-activity].[default-tied-status/@code] = TiedStatus.Code
                     WHERE
                           [iati-activity].[iati-activityId] = o.[iati-activityId]
                     ORDER BY
                           [iati-activity].[iati-identifier/text()]
                     FOR XML PATH ('iati-activity'), TYPE
              ) XML
       FROM
              [IATISchema].[iati-activity] o
)
SELECT
       [iati-activityID]
       ,[iati-activitiesID]
       ,[ProjectId]
       ,[ComponentId]
       ,[BenefittingCountryCode]
       ,[CountryCode]
       ,[RegionCode]
       ,XML AS UntypedXML
       --,CONVERT(XML ($(ActivitiesSchema).SchemaCollection), XML) AS TypedXML
FROM
       Main








GO
/****** Object:  Table [IATISchema].[iati-activities]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[iati-activities](
	[iati-activitiesID] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Notes] [nvarchar](max) NULL,
	[@version] [IATISchema].[xsd:decimal] NULL,
	[@generated-datetime] [IATISchema].[xsd:datetime] NULL,
	[ir:registry-record/@xml:lang] [IATISchema].[xml:lang] NULL,
	[ir:registry-record/@file-id] [IATISchema].[xsd:string] NOT NULL,
	[ir:registry-record/@source-url] [IATISchema].[xsd:anyURI] NOT NULL,
	[ir:registry-record/@publisher-id] [nvarchar](255) NOT NULL,
	[ir:registry-record/@publisher-role] [nvarchar](255) NOT NULL,
	[ir:registry-record/@contact-email] [IATISchema].[xsd:string] NULL,
	[ir:registry-record/@donor-id] [nvarchar](255) NOT NULL,
	[ir:registry-record/@donor-type] [int] NOT NULL,
	[ir:registry-record/@donor-country] [nchar](2) NULL,
	[ir:registry-record/@title] [IATISchema].[xsd:string] NOT NULL,
	[ir:registry-record/@activity-period] [IATISchema].[xsd:string] NULL,
	[ir:registry-record/@last-updated-datetime] [IATISchema].[xsd:datetime] NOT NULL,
	[ir:registry-record/@generated-datetime] [IATISchema].[xsd:datetime] NOT NULL,
	[ir:registry-record/@verification-status] [int] NOT NULL,
	[ir:registry-record/@format] [nvarchar](255) NOT NULL,
	[ir:registry-record/@license] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [iati-activities$pk] PRIMARY KEY CLUSTERED 
(
	[iati-activitiesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [IATISchema].[f_ActivitiesXMLFile_203]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









--DROP FUNCTION [IATISchema].[f_ActivitiesXMLFile_203]

/* Using this function to return IATI XML data from the database


--Generate IATI XML Country Files for all of the regions that currently exist in the database

SELECT 'Select TypedXML From IATISchema.f_ActivitiesXMLFile_203 (101,null,null,null,null,'''+ia.CountryCode+''',null,''DFID-'+REPLACE(REPLACE(REPLACE(rc.[text()],' ', '-'),'(',''),')','')+'-'+ia.CountryCode+')',
	   ia.CountryCode, REPLACE(REPLACE(REPLACE(rc.[text()],' ', '-'),'(',''),')','')
FROM [IATISchema].[iati-activity] ia
INNER JOIN 
[IATISchema].[recipient-country] rc
ON 
ia.[CountryCode] = rc.[@Code]
WHERE CountryCode IS NOT NULL AND CountryCode !='AC'
GROUP BY ia.CountryCode, rc.[text()]
ORDER BY ia.CountryCode



--Generate IATI XML Region Files for all of the regions that currently exist in the database - except 998 as IATISchema.f_ActivitiesXMLFile_203_998 is used 

--Test the regions that currently exist
SELECT r.*
FROM [IATISchema].[iati-activity] ia
INNER JOIN
[Codelist].[Region] r
ON
ia.RegionCode = r.[Code]
WHERE RegionCode IS NOT NULL 
GROUP BY Code, Name
ORDER BY Code


--Generate scripts
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'89','DFID-Europe-regional-89')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'189','DFID-North-of-Sahara-regional-189')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'289','DFID-Sourth-of-Sahara-regional-289')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'298','DFID-Africa-regional-298')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'380','DFID-West-Indies-regional-380')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'389','DFID-North-and-Central-America-regional-389')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'589','DFID-Middle-East-regional-589')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'679','DFID-South-Asia-regional-679')
SELECT TypedXML FROM IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'798','DFID-Asia-regional-798')


-- Return IATI XML data for the Dfid project GB-1-204024
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101,'204024',null,null,null,null,null,'Dfid-Project-204024')

-- Return IATI XML data for the Dfid level 2 project GB-1-204024-101
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101,null,'204024-101',null,null,null,null,'Dfid-L2Project-204024-101')

-- Return NonIatiRegion IATI XML data for the Dfid defined "Sahel" area
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101,null,null,'SF',null,null,null,'Dfid-Sahel-SF')

-- Return country IATI XML data for Afghanistan
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,'AF',null,'Dfid-Afghanistan-AF')

-- Return region IATI XML data for the OECD defined "Middle East Regional" area
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101,null,null,null,null,null,'589','Dfid-MiddleEastRegional-589')

-- Return all projects and related level two projects (i.e. everything) in IATI XML format 
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203 (101, '0', NULL, NULL, NULL, NULL, NULL,'Dfid-All-Projects')

-- Return all level two projects and related level one projects , i.e. everything
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101, NULL, '0', NULL, NULL, NULL, NULL, 'Dfid-All-Level-Two-Projects')

-- Return all activities associated with IATI/ISO countries
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101, NULL, NULL, NULL, NULL, '0', NULL,'Dfid-ISO-Country-Projects')

-- Return all activities associated with IATI/DAC regions
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101, NULL, NULL, NULL, NULL, NULL, 0,'Dfid-OECD-Region-Projects')

-- Return all projects that are not associated with either an IATI country or region
Select TypedXML 
From IATISchema.f_ActivitiesXMLFile_203(101, NULL, NULL, '0', 1, NULL, NULL,'Dfid-Non-Iati-Region-Projects')








*/


CREATE FUNCTION [IATISchema].[f_ActivitiesXMLFile_203]
(
	@ActivitiesId					INT
	,@ProjectId						VARCHAR(25)
	,@ComponentId					VARCHAR(25)
	,@BenefittingCountryCode		VARCHAR(25)
	,@BenefittingCountryNonIATIOnly	BIT
	,@CountryCode					NCHAR(2)
	,@RegionCode					INT
	,@URI							[IATISchema].[xsd:anyURI]
)
RETURNS
	TABLE
AS
RETURN
(
	WITH
		--XMLNAMESPACES ('http://iatiregistry.org/ns/record#' AS ir),
		SelectedComponents AS
	(
		SELECT
			*
		FROM
			[IATISchema].v_Activity_203
		WHERE
			ComponentId IS NOT NULL
			AND (@ProjectId IS NULL OR (@ProjectId = '0' AND @ProjectId IS NOT NULL) OR ProjectId = @ProjectId)
			AND (@ComponentId IS NULL OR (@ComponentId = '0' AND @ComponentId IS NOT NULL) OR ComponentId = @ComponentId)
			AND
			(
				(@BenefittingCountryCode IS NULL AND @BenefittingCountryNonIATIOnly IS NULL) -- if no parameters passed then allow everything
				OR (@BenefittingCountryCode IS NULL AND @BenefittingCountryNonIATIOnly IS NOT NULL AND BenefittingCountryCode IS NULL) -- allows us to individually select the records with no benefitting country
				OR
				(
					(@BenefittingCountryNonIATIOnly = 0 OR (CountryCode IS NULL AND RegionCode IS NULL)) -- the @BenefittingCountryNonIATIOnly flag controls whether it is possible to search for a benefitting country that has been mapped to an IATI country or region
					AND
					(
						(
							@BenefittingCountryCode = '0'
							--AND BenefittingCountryCode IS NOT NULL
						)
						OR BenefittingCountryCode = @BenefittingCountryCode
					)
				)
			)
			AND (@CountryCode IS NULL OR (@CountryCode = N'0' AND CountryCode IS NOT NULL) OR CountryCode = @CountryCode)
			AND (@RegionCode IS NULL OR (@RegionCode = 0 AND RegionCode IS NOT NULL) OR RegionCode = @RegionCode)
	)
		,RelatedProjects AS
	(
		SELECT * FROM [IATISchema].v_Activity_203 WHERE ComponentId IS NULL AND ((@ComponentId IS NULL AND ProjectId = @ProjectId) OR ProjectId IN (SELECT ProjectId FROM SelectedComponents) AND ComponentId IS NULL)
	)
		,Main AS
	(
		SELECT
			[iati-activitiesID]
			,[Name]
			,[Notes]
			,(
				SELECT
					'2.03' AS [@version]
					,[IATISchema].FormatXSDDateTime([@generated-datetime]) AS [@generated-datetime]
					--,(SELECT [IATISchema].f_ActivitiesRegistryRecord([iati-activitiesID], @URI))
					,(
						SELECT
							UntypedXML AS [*]
						FROM
						(
							SELECT
								ProjectId, ComponentId, UntypedXML
							FROM
								SelectedComponents
							UNION ALL
							SELECT
								ProjectId, ComponentId, UntypedXML
							FROM
								RelatedProjects
						) q
						ORDER BY
							ProjectId, ComponentId
						FOR XML PATH (''), TYPE
					)
				FROM
					[IATISchema].[iati-activities]
				WHERE
					[iati-activities].[iati-activitiesID] = o.[iati-activitiesID]
				FOR XML PATH ('iati-activities'), TYPE
			) XML
		FROM
			[IATISchema].[iati-activities] o
		WHERE
			[iati-activitiesID] = @ActivitiesId
	)
	SELECT
		[iati-activitiesID]
		,[Name]
		,[Notes]
		,XML AS UntypedXML
		,CONVERT(XML,CONVERT(XML ([IATISchema].[SchemaCollection_2.03]), XML)) AS TypedXML
	FROM
		Main
)







GO
/****** Object:  View [IATISchema].[v_Activity_203_Planned_Start_Date]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--DROP VIEW [IATISchema].[v_Activity_203_Planned_Start_Date]

CREATE VIEW [IATISchema].[v_Activity_203_Planned_Start_Date] AS
WITH
	Main AS
(
	SELECT
		o.[iati-activityID]
		,[iati-activitiesID]
		,[ProjectId]
		,[ComponentId]
		,[BenefittingCountryCode]
		,[CountryCode]
		,[RegionCode]
		,[@iso-date]
		,(
			SELECT
				-- iati-activity
				 [IATISchema].FormatXSDDateTime([iati-activity].[@last-updated-datetime]) AS [@last-updated-datetime]
				,[iati-activity].[@xml:lang]				
				,[iati-activity].[@default-currency]		
				,[iati-activity].[@hierarchy]			
				
				-- 1 iati-identifier
				,[iati-identifier/text()]
				
				-- 2 reporting-org
				,[iati-activity].[reporting-org/@xml:lang]
				,[iati-activity].[reporting-org/@ref]
				,[iati-activity].[reporting-org/@type]
				,ReportingOrganisation.Name AS [reporting-org/narrative]
				
				-- 3 title
				,(
					SELECT
						[title].[@xml:lang]
						,[title].[text()] as [narrative]		
					FROM
						[IATISchema].[title]
					WHERE
						[title].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('title'), TYPE
				)
				
				-- 4 description
				,(
					SELECT
						[description].[@xml:lang]
						,[description].[@type]
						,[description].[text()] as [narrative]		
					FROM
						[IATISchema].[description]
					WHERE
						[description].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('description'), TYPE
				)
				
				 -- 5 participating-org From Updated View [IATISchema].[v_Activity_203]
                ,(
                        SELECT	tpd.[@xml:lang],tpd.[@ref],tpd.[@type],tpd.[@role],tpd.[narrative] 
						FROM   (SELECT distinct
                                    [participating-org].[@xml:lang]  
                                    ,[participating-org].[@ref]             
                                    ,[participating-org].[@type]            
                                    ,[participating-org].[@role]
                                    ,[participating-org].[text()] AS [narrative]
                                FROM
                                    [IATISchema].[participating-org]
                                WHERE
                                    [participating-org].[iati-activityId] = [iati-activity].[iati-activityId]) as tpd
                        FOR XML PATH ('participating-org'), TYPE
                )

				
				 -- 5.5 other-identifier
                ,(
                        SELECT
                                [other-identifier].[@ref]
                                ,[other-identifier].[@type]
                                ,[other-identifier].[owner-org/@ref] AS [owner-org/@ref]
                                ,[other-identifier].[owner-org/text()] AS [owner-org/narrative]             
                        FROM
                                [IATISchema].[other-identifier]
                        WHERE
                                [other-identifier].[iati-activityId] = [iati-activity].[iati-activityId]
                        FOR XML PATH ('other-identifier'), TYPE
                )
                
				 -- 6 activity-status
				,[iati-activity].[activity-status/@xml:lang] 
                ,[iati-activity].[activity-status/@code]          
                ,[iati-activity].[activity-status/@type]                                      
				
				
				-- 7 activity-date
				,(
					SELECT [activity-date].[@type] as [@type]
						   ,[IATISchema].FormatXSDDate([activity-date].[@iso-date]) AS [@iso-date]						
					FROM
						[IATISchema].[activity-date]
					WHERE
						[activity-date].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('activity-date'), TYPE
				)
				
				-- 8 contact-info
				,(
					SELECT
						'1' as [@type]
						,[contact-info].[organisation/text()] AS [organisation/narrative]
						,[contact-info].[person-name/text()] AS [person-name/narrative]
						,(
							SELECT
								[contact-info/details].[telephone/text()] AS [telephone]		
								,[contact-info/details].[email/text()] AS [email]		
								--,[contact-info/details].[website/text()] AS [website] -- TODO	
								,[contact-info/details].[mailing-address/text()] AS [mailing-address/narrative]
							FROM
								[IATISchema].[contact-info/details]
							WHERE
								[contact-info/details].[contact-infoID] = [contact-info].[contact-infoID]
							FOR XML PATH (''), TYPE
						)
					FROM
						[IATISchema].[contact-info]
					WHERE
						[contact-info].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('contact-info'), TYPE
				)
				
				-- 10 activity-scope (TODO)
				
				-- 11 recipient-country
				,(
					SELECT
						[recipient-country].[@code]
						--,[recipient-country].[@type]
						--,[recipient-country].[@xml:lang]
						,[recipient-country].[@percentage]
						--,ISNULL([recipient-country].[text()], Country.Name) AS [text()]		
					FROM
						[IATISchema].[recipient-country]
					LEFT OUTER JOIN
						[Codelist].Country
					ON
						[recipient-country].[@code] = Country.Code
					WHERE
						[recipient-country].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('recipient-country'), TYPE
				)
				
				-- 12 recipient-region
				,(
					SELECT
						[recipient-region].[@code]
						--,[recipient-region].[@type]
						--,[recipient-region].[@xml:lang]
						,[recipient-region].[@percentage]
						--,ISNULL([recipient-region].[text()], Region.Name) AS [text()]
					FROM
						[IATISchema].[recipient-region]
					LEFT OUTER JOIN
						[Codelist].Region
					ON
						[recipient-region].[@code] = Region.Code
					WHERE
						[recipient-region].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('recipient-region'), TYPE
				)
				
				-- 13 location
				,(
					SELECT
						[location].[@ref]					
						,[location].[location-reach/@code]
						--,[location104].[name/narrative/@xml:lang]				
						,[location].[name/narrative]					
						--,[location104].[description/narrative/@xml:lang]			
						,[location].[description/narrative]		
						--,[location104].[activity-description/narrative/@xml:lang]			
						,[location].[activity-description/narrative]			
						,[location].[administrative/@vocabulary]	
						,[location].[administrative/@level]		
						,[location].[administrative/@code]			
						,[location].[point/@srsName]
						,[location].[point/pos]		
						,[location].[exactness/@code]		
						,[location].[location-class/@code]		
						,[location].[feature-designation/@code]		
					FROM
						[IATISchema].[location]
					WHERE
						[location].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('location'), TYPE
				)				
				
				-- 14 sector
				,(
					SELECT
						SchemaSector.[@xml:lang]
						,SchemaSector.[@vocabulary]
						,ISNULL(CONVERT(NVARCHAR(MAX), SchemaSector.[@code]), SchemaSector.[@other-code]) AS [@code]
						--,SchemaSector.[@type]
						,SchemaSector.[@percentage]
						,ISNULL(SchemaSector.[text()], CodeListSector.Name) AS [narrative]		
					FROM
						[IATISchema].[sector] SchemaSector
					LEFT OUTER JOIN
						[Codelist].DAC5DigitSector CodeListSector
					ON
						SchemaSector.[@code] = CodeListSector.Code
					WHERE
						SchemaSector.[iati-activityId] = [iati-activity].[iati-activityId]
					ORDER BY
						SchemaSector.[@vocabulary]
						,SchemaSector.[@percentage] DESC
						,ISNULL(CONVERT(NVARCHAR(MAX), SchemaSector.[@code]), SchemaSector.[@other-code])
					FOR XML PATH ('sector'), TYPE
				)
				
				-- 15 country-budget-items
				,(
					SELECT
						[country-budget-items].[@vocabulary]
						,(
							SELECT
								[@code]
								,[@percentage]
								,[text()] AS [description/narrative]
							FROM
								[IATISchema].[country-budget-items/budget-item]
							WHERE
								[country-budget-items/budget-item].[iati-activityID] = [iati-activity].[iati-activityID]
							FOR XML PATH ('budget-item'), TYPE
						)
					FROM
						[IATISchema].[country-budget-items]
					WHERE
						[country-budget-items].[iati-activityID] = [iati-activity].[iati-activityID]
					FOR XML PATH ('country-budget-items'), TYPE
				)				
				
				-- 16 policy-marker
				,(
					SELECT
						[policy-marker].[@xml:lang]		
						,[policy-marker].[@vocabulary]	
						,[policy-marker].[@code]			
						--,[policy-marker].[@type]			
						,[policy-marker].[@significance]	
						,ISNULL([policy-marker].[text()], PolicyMarker.Name) AS [narrative]
					FROM
						[IATISchema].[policy-marker]
					LEFT OUTER JOIN
						[Codelist].PolicyMarker
					ON
						[policy-marker].[@code] = PolicyMarker.Code
					WHERE
						[policy-marker].[iati-activityId] = [iati-activity].[iati-activityId]
					ORDER BY
						[policy-marker].[@code]
					FOR XML PATH ('policy-marker'), TYPE
				)
				
				-- 17 collaboration-type
				--,[iati-activity].[collaboration-type/@xml:lang]
				,[iati-activity].[collaboration-type/@code]
				--,[iati-activity].[collaboration-type/@type]
				--,ISNULL([iati-activity].[collaboration-type/text()], CollaborationType.Name) AS [collaboration-type/text()]
--				,(
--					SELECT
--						[collaboration-type].[@xml:lang]
--						,[collaboration-type].[@code]
--						,[collaboration-type].[@type]
--						,CollaborationType.Name AS [text()]		
--					FROM
--						$(ActivitiesSchema).[collaboration-type]
--					LEFT OUTER JOIN
--						$(CodeListSchema).CollaborationType
--					ON
--						[collaboration-type].[@code] = CollaborationType.Code
--					WHERE
--						[collaboration-type].[iati-activityId] = [iati-activity].[iati-activityId]
--					FOR XML PATH ('collaboration-type'), TYPE
--				)
				
				-- 18 default-flow-type
				--,[default-flow-type/@xml:lang]	
				,[default-flow-type/@code]		
				--,[default-flow-type/@type]		
				--,ISNULL([iati-activity].[default-flow-type/text()], FlowType.Name) AS [default-flow-type/text()]		
				
				-- 19 default-finance-type
				--,[default-finance-type/@xml:lang]
				,[default-finance-type/@code]	
				--,[default-finance-type/@type]
				--,ISNULL([iati-activity].[default-finance-type/text()], FinanceType.Name) AS [default-finance-type/text()]		
				
			    -- 20 default-aid-type
				,(
                    SELECT  [@code]
					FROM	[IATISchema].[default-aid-type]
					WHERE
							[IATISchema].[default-aid-type].[iati-activityID] = [IATISchema].[iati-activity].[iati-activityId]
					FOR XML PATH ('default-aid-type'), TYPE
                )
				
				-- 21 default-tied-status
				--,[default-tied-status/@xml:lang]	
				,[default-tied-status/@code]		
				--,[default-tied-status/@type]		
				--,ISNULL([default-tied-status/text()], TiedStatus.Name) AS [default-tied-status/text()]
				
				-- 22 budget
				,(
					SELECT
						[budget].[@type]
						,[IATISchema].[FormatXSDDate]([budget].[period-start/@iso-date]) as [period-start/@iso-date]
						,[budget].[period-start/text()]
						,[IATISchema].[FormatXSDDate]([budget].[period-end/@iso-date]) as [period-end/@iso-date] 
						,[budget].[period-end/text()]
						,[IATISchema].[FormatXSDDate]([budget].[value/@value-date]) as [value/@value-date]
						,[budget].[value/@currency]
						,[budget].[value/text()]						
					FROM
						[IATISchema].[budget]
					WHERE
						[budget].[iati-activityID] = [iati-activity].[iati-activityId]
					ORDER BY
						[budget].[period-start/@iso-date]
					FOR XML PATH ('budget'),TYPE
				)
				
				-- 23 planned-disbursement
				
				-- 24 capital-spend
		 	    ,(
					SELECT
						[capital-spend].[@percentage]
					FROM
						[IATISchema].[capital-spend]
					WHERE
						[capital-spend].[iati-activityId] = [iati-activity].[iati-activityId]
					FOR XML PATH ('capital-spend'), TYPE
				)				
				
				-- 25 transaction
				,(
					SELECT
						[transaction].[@ref]								
						--,[transaction].[@type]								
						--,[transaction].[transaction-type/@xml:lang]			
						,[transaction].[transaction-type/@code]				
						--,[transaction].[transaction-type/@type]				
						--,ISNULL([transaction].[transaction-type/text()], TransactionType.Name) AS [transaction-type/text()]
--								,[transaction].[status/@xml:lang]					
--								,[transaction].[status/@code]						
--								,[transaction].[status/@type]						
--								,[transaction].[status/text()]						
						,[IATISchema].FormatXSDDate([transaction].[transaction-date/@iso-date]) AS [transaction-date/@iso-date]
						--,[transaction].[transaction-date/text()]			
						,[transaction].[value/@currency]					
						,[IATISchema].FormatXSDDate([transaction].[value/@value-date]) AS [value/@value-date]
						--,[transaction].[value/@type]						
						,[transaction].[value/text()]						
						,[transaction].[description/@xml:lang]				
						,[transaction].[description/text()]	AS [description/narrative]
						--,[transaction].[provider-org/@xml:lang]				
						,[transaction].[provider-org/@provider-activity-id]	
						,[transaction].[provider-org/@ref]					
						--,[transaction].[provider-org/@type]					
						,ISNULL([transaction].[provider-org/text()], provider.Name) AS [provider-org/narrative]
						--,[transaction].[receiver-org/@xml:lang]				
						,[transaction].[receiver-org/@receiver-activity-id]	
						,[transaction].[receiver-org/@ref]					
						--,[transaction].[receiver-org/@type]					
						,ISNULL([transaction].[receiver-org/text()], receiver.Name) AS [receiver-org/narrative]
						--,[transaction].[disbursement-channel/@xml:lang]		
						,[transaction].[disbursement-channel/@code]			
						--,[transaction].[disbursement-channel/@type]			
						--,ISNULL([transaction].[disbursement-channel/text()], DisbursementChannel.Name) AS [disbursement-channel/text()]
						-- TODO: Sector
						-- TODO: Recipient Country
						-- TODO: Recipient Region
						--,[transaction].[@flow]								
						--,[transaction].[flow-type/@xml:lang]				
						,[transaction].[flow-type/@code]					
						--,[transaction].[flow-type/@type]					
						--,ISNULL([transaction].[flow-type/text()], FlowType.Name) AS [flow-type/text()]
						--,[transaction].[finance-type/@xml:lang]				
						,[transaction].[finance-type/@code]					
						--,[transaction].[finance-type/@type]					
						--,ISNULL([transaction].[finance-type/text()], FinanceType.Name) AS [finance-type/text()]
						--,[transaction].[aid-type/@xml:lang]					
						--,[transaction].[aid-type/@code]						
						--,[transaction].[aid-type/@type]						
						--,ISNULL([transaction].[aid-type/text()], AidType.Name) AS [aid-type/text()]
						--,[transaction].[tied-status/@xml:lang]				
						,[transaction].[tied-status/@code]					
						--,[transaction].[tied-status/@type]					
						--,ISNULL([transaction].[tied-status/text()], TiedStatus.Name) AS [tied-status/text()]
					FROM
						[IATISchema].[transaction]
					LEFT OUTER JOIN
						[Codelist].TransactionType
					ON
						[transaction].[transaction-type/@code] = TransactionType.Code
					LEFT OUTER JOIN
						[Codelist].OrganisationIdentifier provider
					ON
						[transaction].[provider-org/@ref] = provider.Code
					LEFT OUTER JOIN
						[Codelist].OrganisationIdentifier receiver
					ON
						[transaction].[receiver-org/@ref] = receiver.Code
					LEFT OUTER JOIN
						[Codelist].FlowType
					ON
						[transaction].[flow-type/@code] = FlowType.Code
					--LEFT OUTER JOIN
					--	[Codelist].AidType
					--ON
					--	[transaction].[aid-type/@code] = AidType.Code
					LEFT OUTER JOIN
						[Codelist].FinanceType
					ON
						[transaction].[finance-type/@code] = FinanceType.Code
					LEFT OUTER JOIN
						[Codelist].TiedStatus
					ON
						[transaction].[tied-status/@code] = TiedStatus.Code
					LEFT OUTER JOIN
						[Codelist].DisbursementChannel
					ON
						[transaction].[disbursement-channel/@code] = DisbursementChannel.Code
					WHERE
						[transaction].[iati-activityId] = [iati-activity].[iati-activityId]
					ORDER BY
						[transaction].[transaction-type/@code]
						,[transaction].[transaction-date/@iso-date]
					FOR XML PATH ('transaction'), TYPE
				)
				
				-- 26 document-link
				,(
					SELECT
						[document-link].[@format]
						,[document-link].[@url]
						--,[iati-activity/document-link].[@language]
						,(
							SELECT
								[@xml:lang]
								,[text()] AS [narrative]
							FROM
								[IATISchema].[document-link/title]
							WHERE
								[document-linkID] = [document-link].[document-linkID]
							ORDER BY
								CASE WHEN [@xml:lang] = 'en' THEN 1 ELSE 2 END
								,[@xml:lang]
								,[text()]
							FOR XML PATH ('title'), TYPE
						)
						,( -- category
							SELECT
								--[iati-activity/document-link/category].[@xml:lang]
								[document-link/category].[@code]
								--,[iati-activity/document-link/category].[@type]
								--,DocumentContentType.Name AS [text()]
							FROM
								[IATISchema].[document-link/category]
							LEFT OUTER JOIN
								[Codelist].[DocumentCategory] 
							ON
								[document-link/category].[@code] = [DocumentCategory].Code
							WHERE
								[document-link/category].[document-linkID] = [document-link].[document-linkID]
							ORDER BY
								CASE WHEN [document-link/category].[@xml:lang] = 'en' THEN 1 ELSE 2 END
								,[document-link/category].[@xml:lang]
								,[DocumentCategory].Name
							FOR XML PATH ('category'), TYPE
						)
						,( -- language
							SELECT
								[@code]
								--,[@xml:lang]
								--,[text()]
							FROM
								[IATISchema].[document-link/language]
							WHERE
								[document-linkID] = [document-link].[document-linkID]
							ORDER BY
								CASE WHEN [@xml:lang] = 'en' THEN 1 ELSE 2 END
								,[@xml:lang]
								,[text()]
							FOR XML PATH ('language'), TYPE
						)
					FROM
						[IATISchema].[document-link]
					WHERE
						[document-link].[iati-activityID] = [iati-activity].[iati-activityID]
					ORDER BY
						[document-link].QuestID
					FOR XML PATH ('document-link'), TYPE
				)
				
				-- 27 activity-website
				
				-- 28 related-activity
				,(
					SELECT
						[related-activity].[@xml:lang]			
						,[related-activity].[@ref]				
						,[related-activity].[@type]
						--,[related-activity].[text()]			
					FROM
						[IATISchema].[related-activity]
--					LEFT OUTER JOIN
--						$(CodeListSchema).RelatedActivityType
--					ON
--						[related-activity].[@type] = RelatedActivityType.Code
					WHERE
						[related-activity].[iati-activityId] = [iati-activity].[iati-activityId]
					-- order by type (parent, child, sibling), reference (Component ID)
					ORDER BY
						[related-activity].[@type]	-- parent, child then sibling
						,[related-activity].[@ref]
					FOR XML PATH ('related-activity'), TYPE
				)

				-- 31 legacy-data (TODO)
		 	--    ,(
				--	SELECT
				--		[legacy-data].[@name]
				--		,[legacy-data].[text()] as [@value]
				--		,[legacy-data].[@iati-equivalent]
				--		--,[legacy-data].[text()]
				--	FROM
				--		[IATISchema].[legacy-data]
				--	WHERE
				--		[legacy-data].[iati-activityId] = [iati-activity].[iati-activityId]
				--	FOR XML PATH ('legacy-data'), TYPE
				--)				
				-- 29 conditions
				,(
					SELECT
						[conditions].[@attached]
						,(
							SELECT
								[@type]
								,[text()] AS [narrative]
							FROM
								[IATISchema].[conditions/condition]
							WHERE
								[conditionsID] = [conditions].[conditionsID]
							FOR XML PATH ('condition'), TYPE
						)
					FROM
						[IATISchema].[conditions]
					WHERE
						[conditions].[iati-activityID] = [iati-activity].[iati-activityID]
					FOR XML PATH ('conditions'), TYPE
				)
				
				-- 30 result
				-- TODO - Populate Result
				

			FROM
				[IATISchema].[iati-activity]
			LEFT OUTER JOIN
				[Codelist].OrganisationIdentifier ReportingOrganisation
			ON
				[iati-activity].[reporting-org/@ref] = ReportingOrganisation.Code
			LEFT OUTER JOIN
				[Codelist].CollaborationType
			ON
				[iati-activity].[collaboration-type/@code] = CollaborationType.Code
			LEFT OUTER JOIN
				[Codelist].FlowType
			ON
				[iati-activity].[default-flow-type/@code] = FlowType.Code
			--LEFT OUTER JOIN
			--	[Codelist].AidType
			--ON
			--	[iati-activity].[default-aid-type/@code] = AidType.Code
			LEFT OUTER JOIN
				[Codelist].FinanceType
			ON
				[iati-activity].[default-finance-type/@code] = FinanceType.Code
			--LEFT OUTER JOIN
			--	[Codelist].OrganisationIdentifier OtherIdentifierOwner
			--ON
			--	[iati-activity].[other-identifier/@owner-ref] = OtherIdentifierOwner.Code
			LEFT OUTER JOIN
				[Codelist].ActivityStatus
			ON
				[iati-activity].[activity-status/@code] = ActivityStatus.Code
			LEFT OUTER JOIN
				[Codelist].TiedStatus
			ON
				[iati-activity].[default-tied-status/@code] = TiedStatus.Code
			WHERE
				[iati-activity].[iati-activityId] = o.[iati-activityId]
			ORDER BY
				[iati-activity].[iati-identifier/text()]
			FOR XML PATH ('iati-activity'), TYPE
		) XML
	FROM
		[IATISchema].[iati-activity] o
	INNER JOIN
		(Select [@iso-date], [iati-activityID]
		 FROM [IATISchema].[activity-date]
		 WHERE [@type] = 1) d
	 ON 
		 o.[iati-activityID] = d.[iati-activityID]	
)
SELECT
	[iati-activityID]
	,[iati-activitiesID]
	,[ProjectId]
	,[ComponentId]
	,[BenefittingCountryCode]
	,[CountryCode]
	,[RegionCode]
	,[@iso-date]
	,XML AS UntypedXML
	--,CONVERT(XML ($(ActivitiesSchema).SchemaCollection), XML) AS TypedXML
FROM
	Main
























GO
/****** Object:  Table [Codelist].[BudgetIdentifier]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetIdentifier](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[Category] [nvarchar](255) NOT NULL,
 CONSTRAINT [BudgetIdentifier$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetIdentifier$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[BudgetIdentifierSectorCategory]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetIdentifierSectorCategory](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [BudgetIdentifierSectorCategory$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetIdentifierSectorCategory$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[BudgetIdentifierSector]    Script Date: 05/09/2018 10:37:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetIdentifierSector](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[Category] [nvarchar](255) NOT NULL,
 CONSTRAINT [BudgetIdentifierSector$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetIdentifierSector$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [Codelist].[v_RecipientCountryBudgetIdentifier]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Codelist].[v_RecipientCountryBudgetIdentifier] AS SELECT A.Code,A.Name AS [Function],C.Name Category,B.Name BudgetSector FROM Codelist.BudgetIdentifier A INNER JOIN 
Codelist.BudgetIdentifierSector B ON (A.Category=B.Code)
INNER JOIN Codelist.BudgetIdentifierSectorCategory C ON (B.Category=C.Code)
GO
/****** Object:  Table [Codelist].[ActivityDateType]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ActivityDateType](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [ActivityDateType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ActivityDateType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ActivityScope]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ActivityScope](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [ActivityScope$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ActivityScope$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[AidType]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[AidType](
	[Code] [nchar](3) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CategoryCode] [nchar](1) NOT NULL,
 CONSTRAINT [AidType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AidType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[AidTypeCategory]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[AidTypeCategory](
	[Code] [nchar](1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [AidTypeCategory$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AidTypeCategory$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[AidTypeVocabulary]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[AidTypeVocabulary](
	[Code] [nchar](1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [AidTypeVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AidTypeVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[BudgetIdentifierVocabulary]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetIdentifierVocabulary](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [BudgetIdentifierVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetIdentifierVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[BudgetNotProvided]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetNotProvided](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [BudgetNotProvided$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetNotProvided$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[BudgetStatus]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetStatus](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [BudgetStatus$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetStatus$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[BudgetType]    Script Date: 05/09/2018 10:37:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[BudgetType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [BudgetType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [BudgetType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ConditionsAttached]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ConditionsAttached](
	[Code] [int] NOT NULL,
	[Text] [nvarchar](255) NOT NULL,
 CONSTRAINT [ConditionsAttached$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ConditionsAttached$uq$Text] UNIQUE NONCLUSTERED 
(
	[Text] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ConditionType]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ConditionType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [ConditionType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ConditionType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ContractType]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ContractType](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [ContractType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ContractType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[CRSAdditionalOtherFlags]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[CRSAdditionalOtherFlags](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [CRSAdditionaOtherFlags$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CRSAdditionaOtherFlags$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[CRSChannelCode]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[CRSChannelCode](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [CRSChannelCode$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[Currency]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[Currency](
	[Code] [nchar](3) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [Currency$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Currency$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[DAC3DigitSector]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[DAC3DigitSector](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [DAC3DigitSector$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [DAC3DigitSector$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[DescriptionType]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[DescriptionType](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [DescriptionType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [DescriptionType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[DocumentCategoryCategory]    Script Date: 05/09/2018 10:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[DocumentCategoryCategory](
	[Code] [nchar](1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [DocumentContentTypeCategory$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [DocumentContentTypeCategory$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[FileFormat]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[FileFormat](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Category] [nvarchar](70) NOT NULL,
 CONSTRAINT [FileFormat$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[FinanceTypeCategory]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[FinanceTypeCategory](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [FinanceTypeCategory$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [FinanceTypeCategory$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[GazetteerAgency]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[GazetteerAgency](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [GazetteerAgency$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [GazetteerAgency$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[GeographicalPrecision]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[GeographicalPrecision](
	[Code] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [GeographicalPrecision$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[GeographicExactness]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[GeographicExactness](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [GeographicExactness$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [GeographicExactness$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[GeographicLocationClass]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[GeographicLocationClass](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [LocationClass$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [LocationClass$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[GeographicLocationReach]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[GeographicLocationReach](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [LocationReach$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [LocationReach$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[GeographicVocabulary]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[GeographicVocabulary](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[URL] [varchar](255) NULL,
 CONSTRAINT [GeographicVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [GeographicVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[HumanitarianScopeType]    Script Date: 05/09/2018 10:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[HumanitarianScopeType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [HumanitarianScopeType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[HumanitarianScopeVocabulary]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[HumanitarianScopeVocabulary](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[URL] [nvarchar](max) NULL,
 CONSTRAINT [HumanitarianScopeVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[IATIOrganisationIdentifier]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[IATIOrganisationIdentifier](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[URL] [varchar](255) NULL,
 CONSTRAINT [IATIOrganisationIdentifier$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IATIOrganisationIdentifier$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[IndicatorMeasure]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[IndicatorMeasure](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [IndicatorMeasure$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IndicatorMeasure$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[IndicatorVocabulary]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[IndicatorVocabulary](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[URL] [varchar](255) NULL,
 CONSTRAINT [IndicatorVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[Language]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[Language](
	[Code] [nchar](2) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [Language$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Language$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[LoanRepaymentPeriod]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[LoanRepaymentPeriod](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [LoanRepaymentPeriod$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [LoanRepaymentPeriod$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[LoanRepaymentType]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[LoanRepaymentType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [LoanRepaymentType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [LoanRepaymentType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[LocationType]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[LocationType](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[Category] [nvarchar](2) NOT NULL,
 CONSTRAINT [LocationType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [LocationType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[LocationTypeCategory]    Script Date: 05/09/2018 10:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[LocationTypeCategory](
	[Code] [nvarchar](2) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [LocationTypeCategory$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [LocationTypeCategory$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[OrganisationIdentifier_bkp]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[OrganisationIdentifier_bkp](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[OrganisationRegistrationAgency]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[OrganisationRegistrationAgency](
	[Code] [nvarchar](30) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[Category] [nchar](2) NOT NULL,
	[URL] [varchar](max) NULL,
	[PublicDatabase] [varchar](5) NULL,
 CONSTRAINT [OrganisationRegistrationAgency$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [OrganisationRegistrationAgency$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[OrganisationRole]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[OrganisationRole](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [OrganisationRole$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [OrganisationRole$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[OrganisationType]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[OrganisationType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [OrganisationType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [OrganisationType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[OtherIdentifierType]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[OtherIdentifierType](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [OtherIdentifierType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [OtherIdentifierType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[PolicyMarkerVocabulary]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[PolicyMarkerVocabulary](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PolicyMarkerVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PolicyMarkerVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[PolicySignificance]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[PolicySignificance](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PolicySignificance$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PolicySignificance$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[PublisherType]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[PublisherType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PublisherType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [PublisherType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[RegionVocabulary]    Script Date: 05/09/2018 10:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[RegionVocabulary](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [RegionVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [RegionVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[RelatedActivityType]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[RelatedActivityType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [RelatedActivityType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [RelatedActivityType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ResultType]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ResultType](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [ResultType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ResultType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[ResultVocabulary]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[ResultVocabulary](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [ResultVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ResultVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[SectorCategory]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[SectorCategory](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[ParentCode] [int] NULL,
 CONSTRAINT [SectorCategory$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[SectorVocabulary]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[SectorVocabulary](
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[URL] [nvarchar](255) NULL,
 CONSTRAINT [SectorVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [SectorVocabulary$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[TagVocabulary]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[TagVocabulary](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[URL] [varchar](255) NULL,
 CONSTRAINT [TagVocabulary$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[VerificationStatus]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[VerificationStatus](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [VerificationStatus$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [VerificationStatus$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Codelist].[Version]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Codelist].[Version](
	[Code] [nvarchar](5) NOT NULL,
	[URL] [varchar](max) NOT NULL,
 CONSTRAINT [Version$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Configuration].[Error]    Script Date: 05/09/2018 10:37:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[Error](
	[ErrorId] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NULL,
	[Message] [nvarchar](4000) NULL,
	[Severity] [int] NULL,
	[State] [int] NULL,
	[Procedure] [nvarchar](126) NULL,
	[Line] [int] NULL,
	[Date] [datetime] NULL,
	[Login] [sysname] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Configuration].[FiscalPeriod]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[FiscalPeriod](
	[FiscalYear] [int] NOT NULL,
	[FiscalQuarter] [int] NULL,
	[FiscalPeriod] [int] NOT NULL,
	[FiscalPeriodZeroPadded] [varchar](2) NULL,
	[FiscalYearNameAndPeriodZeroPadded] [varchar](12) NULL,
	[FiscalYearShortNameAndPeriodZeroPadded] [varchar](8) NULL,
	[FiscalYearAndPeriodARIESStyle] [int] NULL,
	[FiscalPeriodFirstDay] [datetime] NULL,
	[FiscalPeriodLastDay] [datetime] NULL,
	[CalendarYear] [int] NULL,
	[CalendarMonth] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[collaboration-type]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[collaboration-type](
	[collaboration-typeID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[@code] [int] NOT NULL,
	[@type] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [collaboration-type$pk] PRIMARY KEY CLUSTERED 
(
	[collaboration-typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add](
	[crs-addID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
 CONSTRAINT [crs-add$pk] PRIMARY KEY CLUSTERED 
(
	[crs-addID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/channel-code]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/channel-code](
	[crs-add/channel-codeID] [int] IDENTITY(1,1) NOT NULL,
	[crs-addID] [int] NOT NULL,
	[text()] [nvarchar](255) NOT NULL,
 CONSTRAINT [crs-add/channel-code$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/channel-codeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-status]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-status](
	[crs-add/loan-statusID] [int] IDENTITY(1,1) NOT NULL,
	[crs-addID] [int] NOT NULL,
	[@year] [IATISchema].[xsd:decimal] NOT NULL,
	[@currency] [nchar](3) NULL,
	[@value-date] [IATISchema].[xsd:date] NULL,
 CONSTRAINT [crs-add/loan-status$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-status/interest-arrears]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-status/interest-arrears](
	[crs-add/loan-status/interest-arrearsID] [int] IDENTITY(1,1) NOT NULL,
	[loan-statusID] [int] NOT NULL,
	[text()] [IATISchema].[xsd:integer] NOT NULL,
 CONSTRAINT [crs-add/loan-status/interest-arrears$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-status/interest-arrearsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-status/interest-received]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-status/interest-received](
	[crs-add/loan-status/interest-receivedID] [int] IDENTITY(1,1) NOT NULL,
	[loan-statusID] [int] NOT NULL,
	[text()] [IATISchema].[xsd:integer] NOT NULL,
 CONSTRAINT [crs-add/loan-status/interest-received$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-status/interest-receivedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-status/principal-arrears]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-status/principal-arrears](
	[crs-add/loan-status/principal-arrearsID] [int] IDENTITY(1,1) NOT NULL,
	[loan-statusID] [int] NOT NULL,
	[text()] [IATISchema].[xsd:integer] NOT NULL,
 CONSTRAINT [crs-add/loan-status/principal-arrears$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-status/principal-arrearsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-status/principal-outstanding]    Script Date: 05/09/2018 10:37:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-status/principal-outstanding](
	[crs-add/loan-status/principal-outstandingID] [int] IDENTITY(1,1) NOT NULL,
	[loan-statusID] [int] NOT NULL,
	[text()] [IATISchema].[xsd:integer] NOT NULL,
 CONSTRAINT [crs-add/loan-status/principal-outstanding$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-status/principal-outstandingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-terms]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-terms](
	[crs-add/loan-termsID] [int] IDENTITY(1,1) NOT NULL,
	[crs-addID] [int] NOT NULL,
	[@rate-1] [IATISchema].[xsd:decimal] NOT NULL,
	[@rate-2] [IATISchema].[xsd:decimal] NULL,
 CONSTRAINT [crs-add/loan-terms$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-termsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-terms/commitment-date]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-terms/commitment-date](
	[crs-add/loan-terms/commitment-dateID] [int] IDENTITY(1,1) NOT NULL,
	[loan-termsID] [int] NOT NULL,
	[iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [crs-add/loan-terms/commitment-date$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-terms/commitment-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-terms/repayment-final-date]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-terms/repayment-final-date](
	[crs-add/loan-terms/repayment-final-dateID] [int] IDENTITY(1,1) NOT NULL,
	[loan-termsID] [int] NOT NULL,
	[iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [crs-add/loan-terms/repayment-final-date$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-terms/repayment-final-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-terms/repayment-first-date]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-terms/repayment-first-date](
	[crs-add/loan-terms/repayment-first-dateID] [int] IDENTITY(1,1) NOT NULL,
	[loan-termsID] [int] NOT NULL,
	[iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [crs-add/loan-terms/repayment-first-date$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-terms/repayment-first-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-terms/repayment-plan]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-terms/repayment-plan](
	[crs-add/loan-terms/repayment-planID] [int] IDENTITY(1,1) NOT NULL,
	[loan-termsID] [int] NOT NULL,
	[@code] [int] NOT NULL,
 CONSTRAINT [crs-add/loan-terms/repayment-plan$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-terms/repayment-planID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/loan-terms/repayment-type]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/loan-terms/repayment-type](
	[crs-add/loan-terms/repayment-typeID] [int] IDENTITY(1,1) NOT NULL,
	[loan-termsID] [int] NOT NULL,
	[@code] [int] NOT NULL,
 CONSTRAINT [crs-add/loan-terms/repayment-type$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/loan-terms/repayment-typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[crs-add/other-flags]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[crs-add/other-flags](
	[crs-add/other-flagsID] [int] IDENTITY(1,1) NOT NULL,
	[crs-addID] [int] NOT NULL,
	[@code] [nvarchar](255) NOT NULL,
	[@significance] [bit] NULL,
 CONSTRAINT [crs-add/other-flags$pk] PRIMARY KEY CLUSTERED 
(
	[crs-add/other-flagsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[document-link/description]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[document-link/description](
	[document-link/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [document-link/description$pk] PRIMARY KEY CLUSTERED 
(
	[document-link/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[document-link/document-date]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[document-link/document-date](
	[document-link/document-dateID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [document-link/document-date$pk] PRIMARY KEY CLUSTERED 
(
	[document-link/document-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[humanitarian-scope]    Script Date: 05/09/2018 10:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[humanitarian-scope](
	[humanitarian-scopeID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@type] [int] NULL,
	[@vocabulary] [nvarchar](255) NULL,
	[@code] [IATISchema].[xsd:string] NULL,
	[@vocabulary-uri] [IATISchema].[xsd:string] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [humanitarian-scope$pk] PRIMARY KEY CLUSTERED 
(
	[humanitarian-scopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[legacy-data]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[legacy-data](
	[legacy-dataID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@name] [IATISchema].[xsd:string] NOT NULL,
	[@value] [IATISchema].[xsd:string] NOT NULL,
	[@iati-equivalent] [IATISchema].[xsd:NMTOKEN] NULL,
	[text()] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [legacy-data$pk] PRIMARY KEY CLUSTERED 
(
	[legacy-dataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result](
	[resultID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@type] [int] NOT NULL,
	[@aggregation-status] [bit] NULL,
 CONSTRAINT [result$pk] PRIMARY KEY CLUSTERED 
(
	[resultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/description]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/description](
	[result/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[resultID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/description$pk] PRIMARY KEY CLUSTERED 
(
	[result/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/document-link]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/document-link](
	[result/document-linkID] [int] IDENTITY(1,1) NOT NULL,
	[resultID] [int] NOT NULL,
	[DocumentID] [varchar](15) NOT NULL,
	[@url] [IATISchema].[xsd:anyURI] NOT NULL,
	[@format] [nvarchar](255) NOT NULL,
 CONSTRAINT [result/document-link$pk] PRIMARY KEY CLUSTERED 
(
	[result/document-linkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/document-link/category]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/document-link/category](
	[result/document-link/categoryID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
 CONSTRAINT [result/document-link/category$pk] PRIMARY KEY CLUSTERED 
(
	[result/document-link/categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/document-link/description]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/document-link/description](
	[result/document-link/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/document-link/description$pk] PRIMARY KEY CLUSTERED 
(
	[result/document-link/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/document-link/document-date]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/document-link/document-date](
	[result/document-link/document-dateID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/document-link/document-date$pk] PRIMARY KEY CLUSTERED 
(
	[result/document-link/document-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/document-link/language]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/document-link/language](
	[result/document-link/languageID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](2) NOT NULL,
 CONSTRAINT [result/document-link/language$pk] PRIMARY KEY CLUSTERED 
(
	[result/document-link/languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/document-link/title]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/document-link/title](
	[result/document-link/titleID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/document-link/title$pk] PRIMARY KEY CLUSTERED 
(
	[result/document-link/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator]    Script Date: 05/09/2018 10:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator](
	[result/indicatorID] [int] IDENTITY(1,1) NOT NULL,
	[resultID] [int] NOT NULL,
	[@measure] [int] NOT NULL,
	[@ascending] [bit] NOT NULL,
	[@aggregation-status] [bit] NOT NULL,
 CONSTRAINT [result/indicator$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicatorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline](
	[result/indicator/baselineID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicatorID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NULL,
	[@year] [IATISchema].[xsd:date] NULL,
	[@value] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [result/indicator/baseline$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baselineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/comment]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/comment](
	[result/indicator/baseline/commentID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/baselineID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/baseline/comment$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/dimension]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/dimension](
	[result/indicator/baseline/dimensionID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/baselineID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/baseline/dimension$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/dimensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/document-link]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/document-link](
	[result/indicator/baseline/document-linkID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/baselineID] [int] NOT NULL,
	[DocumentID] [varchar](15) NOT NULL,
	[@url] [IATISchema].[xsd:anyURI] NOT NULL,
	[@format] [nvarchar](255) NOT NULL,
 CONSTRAINT [result/indicator/baseline/document-link$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/document-linkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/document-link/category]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/document-link/category](
	[result/indicator/baseline/document-link/categoryID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
 CONSTRAINT [result/indicator/baseline/document-link/category$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/document-link/categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/document-link/description]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/document-link/description](
	[result/indicator/baseline/document-link/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/baseline/document-link/description$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/document-link/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/document-link/document-date]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/document-link/document-date](
	[result/indicator/baseline/document-link/document-dateID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/indicator/baseline/document-link/document-date$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/document-link/document-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/document-link/language]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/document-link/language](
	[result/indicator/baseline/document-link/languageID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](2) NOT NULL,
 CONSTRAINT [result/indicator/baseline/document-link/language$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/document-link/languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/document-link/title]    Script Date: 05/09/2018 10:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/document-link/title](
	[result/indicator/baseline/document-link/titleID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/baseline/document-link/title$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/document-link/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/baseline/location]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/baseline/location](
	[result/indicator/baseline/locationID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/baselineID] [int] NOT NULL,
	[@ref] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/baseline/location$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/baseline/locationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/document-link]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/document-link](
	[result/indicator/document-linkID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicatorID] [int] NOT NULL,
	[DocumentID] [varchar](15) NOT NULL,
	[@url] [IATISchema].[xsd:anyURI] NOT NULL,
	[@format] [nvarchar](255) NOT NULL,
 CONSTRAINT [result/indicator/document-link$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/document-linkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/document-link/category]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/document-link/category](
	[result/indicator/document-link/categoryID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
 CONSTRAINT [result/indicator/document-link/category$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/document-link/categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/document-link/description]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/document-link/description](
	[result/indicator/document-link/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/document-link/description$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/document-link/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/document-link/document-date]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/document-link/document-date](
	[result/indicator/document-link/document-dateID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/indicator/document-link/document-date$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/document-link/document-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/document-link/language]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/document-link/language](
	[result/indicator/document-link/languageID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](2) NOT NULL,
 CONSTRAINT [result/indicator/document-link/language$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/document-link/languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/document-link/title]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/document-link/title](
	[result/indicator/document-link/titleID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/document-link/title$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/document-link/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period](
	[result/indicator/periodID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicatorID] [int] NOT NULL,
 CONSTRAINT [result/indicator/period$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/periodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual](
	[result/indicator/period/actualID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/periodID] [int] NOT NULL,
	[@value] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [result/indicator/period/actual$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actualID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/comment]    Script Date: 05/09/2018 10:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/comment](
	[result/indicator/period/actual/commentID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/actualID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/actual/comment$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/dimension]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/dimension](
	[result/indicator/period/actual/dimensionID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/actualID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/actual/dimension$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/dimensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/document-link]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/document-link](
	[result/indicator/period/actual/document-linkID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/actualID] [int] NOT NULL,
	[DocumentID] [varchar](15) NOT NULL,
	[@url] [IATISchema].[xsd:anyURI] NOT NULL,
	[@format] [nvarchar](255) NOT NULL,
 CONSTRAINT [result/indicator/period/actual/document-link$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/document-linkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/document-link/category]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/document-link/category](
	[result/indicator/period/actual/document-link/categoryID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
 CONSTRAINT [result/indicator/period/actual/document-link/category$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/document-link/categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/document-link/description]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/document-link/description](
	[result/indicator/period/actual/document-link/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/actual/document-link/description$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/document-link/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/document-link/document-date]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/document-link/document-date](
	[result/indicator/period/actual/document-link/document-dateID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/indicator/period/actual/document-link/document-date$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/document-link/document-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/document-link/language]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/document-link/language](
	[result/indicator/period/actual/document-link/languageID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](2) NOT NULL,
 CONSTRAINT [result/indicator/period/actual/document-link/language$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/document-link/languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/actual/location]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/actual/location](
	[result/indicator/period/actual/locationID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/actualID] [int] NOT NULL,
	[@ref] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/actual/location$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/actual/locationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/period-end]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/period-end](
	[result/indicator/period/period-endID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/periodID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/indicator/period/period-end$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/period-endID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/period-start]    Script Date: 05/09/2018 10:37:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/period-start](
	[result/indicator/period/period-startID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/periodID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/indicator/period/period-start$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/period-startID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target](
	[result/indicator/period/targetID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/periodID] [int] NOT NULL,
	[@value] [IATISchema].[xsd:string] NULL,
 CONSTRAINT [result/indicator/period/target$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/targetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/comment]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/comment](
	[result/indicator/period/target/commentID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/targetID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/target/comment$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/dimension]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/dimension](
	[result/indicator/period/target/dimensionID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/targetID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/target/dimension$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/dimensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/document-link]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/document-link](
	[result/indicator/period/target/document-linkID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/targetID] [int] NOT NULL,
	[DocumentID] [varchar](15) NOT NULL,
	[@url] [IATISchema].[xsd:anyURI] NOT NULL,
	[@format] [nvarchar](255) NOT NULL,
 CONSTRAINT [result/indicator/period/target/document-link$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/document-linkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/document-link/category]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/document-link/category](
	[result/indicator/period/target/document-link/categoryID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
 CONSTRAINT [result/indicator/period/target/document-link/category$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/document-link/categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/document-link/description]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/document-link/description](
	[result/indicator/period/target/document-link/descriptionID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/target/document-link/description$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/document-link/descriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/document-link/document-date]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/document-link/document-date](
	[result/indicator/period/target/document-link/document-dateID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@iso-date] [IATISchema].[xsd:date] NOT NULL,
 CONSTRAINT [result/indicator/period/target/document-link/document-date$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/document-link/document-dateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/document-link/language]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/document-link/language](
	[result/indicator/period/target/document-link/languageID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@code] [nchar](2) NOT NULL,
 CONSTRAINT [result/indicator/period/target/document-link/language$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/document-link/languageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/document-link/title]    Script Date: 05/09/2018 10:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/document-link/title](
	[result/indicator/period/target/document-link/titleID] [int] IDENTITY(1,1) NOT NULL,
	[document-linkID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/target/document-link/title$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/document-link/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/period/target/location]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/period/target/location](
	[result/indicator/period/target/locationID] [int] IDENTITY(1,1) NOT NULL,
	[result/indicator/period/targetID] [int] NOT NULL,
	[@ref] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/period/target/location$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/period/target/locationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/reference]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/reference](
	[result/indicator/referenceID] [int] IDENTITY(1,1) NOT NULL,
	[resultID] [int] NOT NULL,
	[@code] [varchar](255) NOT NULL,
	[@vocabulary] [int] NOT NULL,
	[@vocabulary-uri] [IATISchema].[xsd:anyURI] NULL,
 CONSTRAINT [result/indicator/reference$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/referenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/indicator/title]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/indicator/title](
	[result/indicator/titleID] [int] IDENTITY(1,1) NOT NULL,
	[indicatorID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/indicator/title$pk] PRIMARY KEY CLUSTERED 
(
	[result/indicator/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/reference]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/reference](
	[result/referenceID] [int] IDENTITY(1,1) NOT NULL,
	[resultID] [int] NOT NULL,
	[@code] [varchar](255) NOT NULL,
	[@vocabulary] [int] NOT NULL,
	[@vocabulary-uri] [IATISchema].[xsd:anyURI] NULL,
 CONSTRAINT [result/reference$pk] PRIMARY KEY CLUSTERED 
(
	[result/referenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[result/title]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[result/title](
	[result/titleID] [int] IDENTITY(1,1) NOT NULL,
	[resultID] [int] NOT NULL,
	[@xml:lang] [IATISchema].[xml:lang] NULL,
	[text()] [IATISchema].[xsd:string] NOT NULL,
 CONSTRAINT [result/title$pk] PRIMARY KEY CLUSTERED 
(
	[result/titleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[tag]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[tag](
	[tagID] [int] IDENTITY(1,1) NOT NULL,
	[iati-activityID] [int] NOT NULL,
	[@code] [IATISchema].[xsd:string] NOT NULL,
	[@vocabulary] [int] NOT NULL,
	[@vocabulary-uri] [IATISchema].[xsd:anyURI] NULL,
 CONSTRAINT [tag$pk] PRIMARY KEY CLUSTERED 
(
	[tagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [IATISchema].[transaction/aid-type]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IATISchema].[transaction/aid-type](
	[transaction/aid-typeID] [int] IDENTITY(1,1) NOT NULL,
	[transactionID] [int] NOT NULL,
	[@code] [nchar](3) NOT NULL,
	[@vocabulary] [nchar](1) NULL,
 CONSTRAINT [transaction/aid-type$pk] PRIMARY KEY CLUSTERED 
(
	[transaction/aid-typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ComponentsOnStaging]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ComponentsOnStaging](
	[ProjectCode] [nvarchar](12) NOT NULL,
	[ComponentCode] [nvarchar](15) NOT NULL,
	[DateFirstReleased] [datetime] NULL,
	[Status] [nvarchar](25) NOT NULL,
	[StatusFinData] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_ComponentsOnStaging] PRIMARY KEY CLUSTERED 
(
	[ComponentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ContractsFinderContracts]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ContractsFinderContracts](
	[ContractId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrder] [varchar](25) NOT NULL,
	[ContractTitle] [varchar](512) NOT NULL,
	[ContractUrl] [varchar](512) NOT NULL,
	[DocumentCategoryCode] [nchar](3) NOT NULL,
	[ProjectId] [varchar](25) NULL,
 CONSTRAINT [ContractsFinderContracts$pk] PRIMARY KEY CLUSTERED 
(
	[ContractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[CrossGovFundsSubheads]    Script Date: 05/09/2018 10:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[CrossGovFundsSubheads](
	[SubheadId] [varchar](4) NOT NULL,
	[SubheadCode] [varchar](4) NOT NULL,
	[Title] [varchar](100) NULL,
	[iati-orgcode] [varchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[DocumentPublicationRules]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[DocumentPublicationRules](
	[DocumentPublicationRuleId] [int] NOT NULL,
	[ProjectStage] [int] NOT NULL,
	[ProjectMustBeApprovedPostCutOffDate] [bit] NOT NULL,
	[DocumentDate] [date] NOT NULL,
	[ContentType] [nvarchar](300) NOT NULL,
	[Singular] [bit] NOT NULL,
	[RestrictedToRecord] [bit] NOT NULL,
	[LanguageSpecific] [bit] NOT NULL,
	[PdfAllowed] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[DocumentPublicationStatus]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[DocumentPublicationStatus](
	[PublicationStatusID] [int] NOT NULL,
	[PublicationStatus] [varchar](40) NULL,
 CONSTRAINT [PK_DocumentPublicationStatus] PRIMARY KEY CLUSTERED 
(
	[PublicationStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[EmergencyAidComponents]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[EmergencyAidComponents](
	[ComponentId] [varchar](25) NOT NULL,
 CONSTRAINT [EmergencyAidComponents$pk] PRIMARY KEY CLUSTERED 
(
	[ComponentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionAccount]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionAccount](
	[AccountCode] [varchar](25) NOT NULL,
	[ReplacementAccountName] [varchar](255) NULL,
 CONSTRAINT [ExclusionAccount$pk] PRIMARY KEY CLUSTERED 
(
	[AccountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionBenefittingCountry]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionBenefittingCountry](
	[BenefittingCountryCode] [varchar](25) NOT NULL,
 CONSTRAINT [ExclusionBenefittingCountry$pk] PRIMARY KEY CLUSTERED 
(
	[BenefittingCountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionBudgetCentre]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionBudgetCentre](
	[BudgetCentreCode] [varchar](25) NOT NULL,
 CONSTRAINT [ExclusionBudgetCentre$pk] PRIMARY KEY CLUSTERED 
(
	[BudgetCentreCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionDetails]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionDetails](
	[ID] [nvarchar](12) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[ParentProjectID] [nchar](10) NULL,
	[ParentProjectTitle] [nvarchar](400) NULL,
	[ExclusionType] [nvarchar](20) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[QuestApproveID] [nvarchar](15) NULL,
	[Department] [nvarchar](70) NULL,
	[ReasonForExclusion] [nvarchar](100) NULL,
	[Comments] [nvarchar](250) NULL,
	[Status] [nvarchar](10) NOT NULL,
	[StatusFinData] [nvarchar](25) NULL,
	[ExclusionLevel] [nvarchar](25) NULL,
	[ShowStatusToPRA] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionParticipatingOrg]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionParticipatingOrg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParticipatingOrgName] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionTransaction]    Script Date: 05/09/2018 10:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionTransaction](
	[ExclusionTransactionId] [int] IDENTITY(1,1) NOT NULL,
	[VoucherTypeCode] [varchar](25) NOT NULL,
	[VoucherNumber] [bigint] NULL,
	[SequenceNumber] [int] NULL,
	[TransactionKey] [bigint] NULL,
	[ReplacementSupplierName] [varchar](255) NULL,
 CONSTRAINT [ExclusionTransaction$pk] PRIMARY KEY CLUSTERED 
(
	[ExclusionTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [ExclusionTransaction$uq$VoucherTypeCode$VoucherNumber$SequenceNumber] UNIQUE NONCLUSTERED 
(
	[VoucherTypeCode] ASC,
	[VoucherNumber] ASC,
	[SequenceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ExclusionVoucherType]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ExclusionVoucherType](
	[VoucherTypeCode] [varchar](25) NOT NULL,
	[ReplacementSupplierName] [varchar](255) NULL,
 CONSTRAINT [ExclusionVoucherType$pk] PRIMARY KEY CLUSTERED 
(
	[VoucherTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[LegacyDocuments]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[LegacyDocuments](
	[LegacyDocumentId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectNumber] [varchar](10) NOT NULL,
	[QuestID] [varchar](15) NOT NULL,
	[DocumentExtension] [varchar](8) NOT NULL,
	[Format] [varchar](128) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[IatiCode] [varchar](4) NOT NULL,
	[IatiTextDesc] [varchar](40) NOT NULL,
 CONSTRAINT [LegacyDocuments $pk] PRIMARY KEY CLUSTERED 
(
	[LegacyDocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[LocationData]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[LocationData](
	[locationDataID] [int] IDENTITY(1,1) NOT NULL,
	[projectID] [int] NOT NULL,
	[@percentage] [int] NULL,
	[location-type/@xml:lang] [nchar](2) NULL,
	[location-type/@code] [nvarchar](255) NOT NULL,
	[location-type/@type] [nvarchar](255) NULL,
	[location-type/text()] [nvarchar](255) NULL,
	[name/@xml:lang] [nchar](2) NULL,
	[name/text()] [text] NULL,
	[description/@xml:lang] [nchar](2) NULL,
	[description/text()] [text] NULL,
	[administrative/@country] [nchar](2) NULL,
	[administrative/@adm1] [nvarchar](255) NULL,
	[administrative/@adm2] [nvarchar](255) NULL,
	[administrative/text()] [text] NULL,
	[coordinates/@latitude] [float] NULL,
	[coordinates/@longitude] [float] NULL,
	[coordinates/@precision] [int] NULL,
	[gazetteer-entry/@gazetteer-ref] [nvarchar](255) NULL,
	[gazetteer-entry/text()] [text] NULL,
	[LastUpdated] [datetime] NULL,
	[Confirmed] [bit] NULL,
	[Deleted] [int] NULL,
 CONSTRAINT [LocationData$pk] PRIMARY KEY CLUSTERED 
(
	[locationDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingAccount]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingAccount](
	[MappingAccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountCode] [varchar](25) NOT NULL,
	[AccountName] [varchar](255) NOT NULL,
	[ReplacementAccountName] [varchar](255) NOT NULL,
	[IncludeExclude] [char](7) NOT NULL,
	[Comments] [varchar](255) NULL,
 CONSTRAINT [MappingAccount$pk] PRIMARY KEY CLUSTERED 
(
	[MappingAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [MappingAccount$uq$AccountCode] UNIQUE NONCLUSTERED 
(
	[AccountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [MappingAccount$uq$AccountName] UNIQUE NONCLUSTERED 
(
	[AccountName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingBenefittingCountry]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingBenefittingCountry](
	[BenefittingCountryCode] [varchar](25) NOT NULL,
	[BenefittingCountryTypeCode] [int] NOT NULL,
	[IATICountryCode] [nchar](2) NULL,
	[IATIRegionCode] [int] NULL,
	[IATICountryName] [varchar](100) NULL,
 CONSTRAINT [MappingBenefittingCountry$pk] PRIMARY KEY CLUSTERED 
(
	[BenefittingCountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingBenefittingCountryType]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingBenefittingCountryType](
	[Code] [int] NOT NULL,
	[Name] [varchar](25) NULL,
 CONSTRAINT [MappingBenefittingCountryType$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [MappingBenefittingCountryType$uq$Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingDFIDRegionToDACRegion]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingDFIDRegionToDACRegion](
	[BenefittingCountryCode] [varchar](25) NOT NULL,
	[DACRegionCode] [int] NOT NULL,
 CONSTRAINT [MappingDFIDRegionToDACRegion$pk] PRIMARY KEY CLUSTERED 
(
	[BenefittingCountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingParticipatingOrg]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingParticipatingOrg](
	[MappingParticipatingOrgID] [int] IDENTITY(1,1) NOT NULL,
	[DFIDSupplierId] [nvarchar](255) NOT NULL,
	[SupplierHqDescription] [nvarchar](max) NOT NULL,
	[DACCode] [nvarchar](255) NOT NULL,
	[IATIIdentifier] [nvarchar](255) NULL,
	[IATIPublisherName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingQuestContentType]    Script Date: 05/09/2018 10:37:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingQuestContentType](
	[MappingQuestContentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[QuestContentType] [varchar](150) NOT NULL,
	[IATIContentTypeCode] [nchar](3) NULL,
 CONSTRAINT [MappingQuestContentType$pk] PRIMARY KEY CLUSTERED 
(
	[MappingQuestContentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [MappingQuestContentType$uq$QuestContentType] UNIQUE NONCLUSTERED 
(
	[QuestContentType] ASC,
	[IATIContentTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingQuestLanguage]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingQuestLanguage](
	[MappingQuestLanguageID] [int] IDENTITY(1,1) NOT NULL,
	[QuestLanguage] [varchar](50) NOT NULL,
	[IATILanguageCode] [nchar](2) NULL,
 CONSTRAINT [MappingQuestLanguage$pk] PRIMARY KEY CLUSTERED 
(
	[MappingQuestLanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [MappingQuestLanguage$uq$QuestLanguage] UNIQUE NONCLUSTERED 
(
	[QuestLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingRecipientCountryBudgetIdentifier]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingRecipientCountryBudgetIdentifier](
	[Code] [varchar](10) NOT NULL,
	[Sector] [varchar](25) NOT NULL,
 CONSTRAINT [MappingRecipientCountryBudgetIdentifier$pk] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[Sector] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingRecipientCountryRegionToLocation]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingRecipientCountryRegionToLocation](
	[mappingID] [int] IDENTITY(1,1) NOT NULL,
	[IATICountryCode] [nchar](2) NULL,
	[IATIRegionCode] [int] NULL,
	[coordinates/@latitude] [float] NULL,
	[coordinates/@longitude] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[MappingVoucherType]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[MappingVoucherType](
	[MappingVoucherTypeID] [int] IDENTITY(1,1) NOT NULL,
	[VoucherTypeCode] [varchar](25) NOT NULL,
	[VoucherTypeName] [varchar](255) NOT NULL,
	[ReplacementVoucherTypeName] [varchar](255) NOT NULL,
 CONSTRAINT [MappingVoucherType$pk] PRIMARY KEY CLUSTERED 
(
	[MappingVoucherTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [MappingVoucherType$uq$VoucherTypeCode] UNIQUE NONCLUSTERED 
(
	[VoucherTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [MappingVoucherType$uq$VoucherTypeName] UNIQUE NONCLUSTERED 
(
	[VoucherTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[NonPOSupplierMap]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[NonPOSupplierMap](
	[SupplierId] [varchar](25) NOT NULL,
	[ComponentID] [varchar](35) NOT NULL,
	[AccountCode] [varchar](45) NULL,
	[ProductCode] [varchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[Population]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[Population](
	[PopulationId] [int] IDENTITY(1,1) NOT NULL,
	[ExportedFlag] [Configuration].[Flag] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NULL,
	[SecondsForPopulation]  AS (datediff(second,[StartDateTime],[EndDateTime])),
	[VersionId] [Configuration].[Version] NOT NULL,
	[ActivitiesId] [int] NOT NULL,
	[DFIDOrganisationIdentifier] [nvarchar](255) NULL,
	[EarliestTransactionDate] [datetime] NULL,
	[LatestTransactionDate] [datetime] NULL,
	[MinimumTransactionAmount] [int] NULL,
	[ComponentSource] [sysname] NULL,
	[DocumentSource] [sysname] NULL,
 CONSTRAINT [Population$pk] PRIMARY KEY CLUSTERED 
(
	[PopulationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[PopulationComponent]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[PopulationComponent](
	[PopulationComponentId] [int] IDENTITY(1,1) NOT NULL,
	[PopulationId] [int] NOT NULL,
	[ComponentId] [varchar](25) NOT NULL,
	[StatusFinData] [nvarchar](20) NULL,
 CONSTRAINT [PopulationComponent$pk] PRIMARY KEY CLUSTERED 
(
	[PopulationComponentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectDocumentDetails]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectDocumentDetails](
	[DocumentID] [varchar](8) NOT NULL,
	[Declared] [varchar](8) NULL,
	[Title] [varchar](512) NULL,
	[CreatedDate] [varchar](32) NULL,
	[LastUpdatedDate] [varchar](32) NULL,
	[OriginalFileName] [varchar](512) NULL,
	[MimeType] [varchar](128) NULL,
	[ProjectID] [varchar](10) NULL,
	[Sec_Category] [varchar](200) NULL,
	[Content_Type] [varchar](100) NULL,
	[Author] [varchar](200) NULL,
	[Comments] [varchar](4000) NULL,
	[Owner] [varchar](100) NULL,
	[Summary] [varchar](4000) NULL,
	[Language] [varchar](2000) NULL,
	[VersionNo] [varchar](8) NULL,
	[FileSize] [varchar](16) NULL,
	[QuestID] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProjectDocumentDetails] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectDocumentSupercedeDetails]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectDocumentSupercedeDetails](
	[DocumentID] [varchar](10) NOT NULL,
	[LinkDocument] [varchar](10) NOT NULL,
	[LinkChainType] [varchar](16) NULL,
 CONSTRAINT [PK_ProjectDocumentSupercedeDetails] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC,
	[LinkDocument] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectOnStagingAudit]    Script Date: 05/09/2018 10:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectOnStagingAudit](
	[MonthlyCycleStartTime] [datetime] NULL,
	[LastMonthlyProcessEndTime] [datetime] NULL,
	[LastDailyProcessEndTime] [datetime] NULL,
	[ProcessHoldByHUB] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectOnStagingAuditLog]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectOnStagingAuditLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ExecutionStatus] [bit] NULL,
	[ErrorLog] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectPublicationStatus]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectPublicationStatus](
	[PublicationStatusID] [int] NOT NULL,
	[PublicationStatus] [varchar](40) NULL,
	[PublicationStatusMsg] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectsOnStaging]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectsOnStaging](
	[ProjectCode] [nvarchar](12) NOT NULL,
	[DoNotPublish] [nvarchar](25) NULL,
	[StatusFinData] [nvarchar](25) NULL,
 CONSTRAINT [PK_ProjectsOnStaging_1] PRIMARY KEY CLUSTERED 
(
	[ProjectCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[ProjectWebsite]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[ProjectWebsite](
	[ProjectId] [varchar](25) NOT NULL,
	[website/text()] [IATISchema].[xsd:string] NULL,
	[WebsiteId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[PublishedDocuments]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[PublishedDocuments](
	[QuestID] [nchar](8) NOT NULL,
	[VersionNo] [smallint] NOT NULL,
	[DocType] [varchar](100) NULL,
	[ExtractionDate] [date] NULL,
	[PublicationStatusID] [smallint] NULL,
	[PublishedPermissionDate] [date] NULL,
	[ProjectID] [nchar](6) NOT NULL,
	[VaultID] [varchar](10) NULL,
	[Source] [smallint] NULL,
	[Language] [varchar](100) NULL,
	[DocExtension] [nvarchar](5) NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_PublishedDocuments] PRIMARY KEY CLUSTERED 
(
	[QuestID] ASC,
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[stageComponent]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[stageComponent](
	[ProjectCode] [nvarchar](8) NULL,
	[ComponentCode] [nvarchar](12) NOT NULL,
	[ComponentTitle] [nvarchar](max) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[FundingTypeCode] [nvarchar](40) NULL,
	[PPIFundingTypeName] [nvarchar](40) NULL,
	[BudgetOriginal] [money] NULL,
	[InProcurement] [nvarchar](1) NULL,
	[StatusFinData] [nvarchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[SupplierInclusionList]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[SupplierInclusionList](
	[SupplierId] [varchar](25) NOT NULL,
 CONSTRAINT [SupplierInclusionList$pk] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PublicationControl].[UnfilteredTransactions]    Script Date: 05/09/2018 10:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PublicationControl].[UnfilteredTransactions](
	[iati-activityID] [int] NOT NULL,
	[account] [varchar](25) NOT NULL,
	[amount] [decimal](28, 3) NOT NULL,
	[apar_id] [varchar](25) NOT NULL,
	[apar_type] [char](1) NOT NULL,
	[client] [varchar](25) NOT NULL,
	[cur_amount] [decimal](28, 3) NOT NULL,
	[currency] [varchar](25) NOT NULL,
	[dc_flag] [smallint] NOT NULL,
	[description] [varchar](255) NOT NULL,
	[dim_1] [varchar](25) NOT NULL,
	[dim_4] [varchar](25) NOT NULL,
	[dim_7] [varchar](25) NOT NULL,
	[ext_inv_ref] [varchar](100) NOT NULL,
	[ext_ref] [varchar](255) NOT NULL,
	[fiscal_year] [int] NOT NULL,
	[last_update] [datetime] NOT NULL,
	[order_id] [bigint] NOT NULL,
	[period] [int] NOT NULL,
	[sequence_no] [int] NOT NULL,
	[status] [char](1) NOT NULL,
	[tax_code] [varchar](25) NOT NULL,
	[tax_system] [varchar](25) NOT NULL,
	[trans_date] [datetime] NOT NULL,
	[trans_id] [bigint] NOT NULL,
	[user_id] [varchar](25) NOT NULL,
	[voucher_date] [datetime] NOT NULL,
	[voucher_no] [bigint] NOT NULL,
	[voucher_type] [varchar](25) NOT NULL,
	[agrtid] [bigint] NOT NULL,
	[IsExpenditureAccount] [varchar](1) NOT NULL,
	[IsIncludedAccount] [varchar](1) NOT NULL,
	[IsProvisionRelated] [varchar](1) NOT NULL,
	[IsProcurementExcluded] [varchar](1) NOT NULL,
	[IsProjectExcluded] [varchar](1) NOT NULL,
	[IsComponentExcluded] [varchar](1) NOT NULL,
	[IsAccountExcluded] [varchar](1) NOT NULL,
	[IsVoucherTypeExcluded] [varchar](1) NOT NULL,
	[IsBudgetCentreExcluded] [varchar](1) NOT NULL,
	[IsBenefittingCountryExcluded] [varchar](1) NOT NULL,
	[IsTransactionExcluded] [varchar](1) NOT NULL,
	[IsSupplierExcluded] [varchar](1) NOT NULL,
	[IsDateExcluded] [varchar](1) NOT NULL,
	[IsTransactionLineAmountExcluded] [varchar](1) NOT NULL,
	[TransactionTotal] [decimal](38, 3) NULL,
	[IsGreaterThan25K] [varchar](1) NOT NULL,
	[SupplierName] [varchar](255) NULL,
	[CustomerName] [varchar](255) NULL,
	[IATIAmount] [decimal](28, 3) NOT NULL,
	[IATIAccountName] [varchar](255) NULL,
	[IATIChannelCode] [varchar](25) NULL,
	[IATICustomerSupplier] [varchar](255) NULL,
	[IsIncluded] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Codelist].[FileFormat] ADD  DEFAULT ('') FOR [Category]
GO
ALTER TABLE [Codelist].[GeographicalPrecision] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [Codelist].[LocationType] ADD  DEFAULT ('') FOR [Category]
GO
ALTER TABLE [Configuration].[Error] ADD  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [Configuration].[Error] ADD  DEFAULT (original_login()) FOR [Login]
GO
ALTER TABLE [IATISchema].[country-budget-items] ADD  DEFAULT ('1') FOR [@vocabulary]
GO
ALTER TABLE [IATISchema].[iati-activities] ADD  DEFAULT ((1.03)) FOR [@version]
GO
ALTER TABLE [IATISchema].[iati-activities] ADD  DEFAULT (getdate()) FOR [@generated-datetime]
GO
ALTER TABLE [IATISchema].[iati-activities] ADD  DEFAULT ('en') FOR [ir:registry-record/@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity] ADD  DEFAULT ('en') FOR [@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity] ADD  DEFAULT ('GBP') FOR [@default-currency]
GO
ALTER TABLE [IATISchema].[policy-marker] ADD  DEFAULT ('DAC') FOR [@vocabulary]
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging] ADD  CONSTRAINT [DF_ComponentsOnStaging_DateFirstReleased]  DEFAULT (getdate()) FOR [DateFirstReleased]
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging] ADD  CONSTRAINT [DF_ComponentsOnStaging_Status]  DEFAULT ('AwaitingPublication') FOR [Status]
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging] ADD  CONSTRAINT [DF_ComponentsOnStaging_StatusFinData]  DEFAULT ('Release') FOR [StatusFinData]
GO
ALTER TABLE [PublicationControl].[ExclusionDetails] ADD  DEFAULT ((1)) FOR [ShowStatusToPRA]
GO
ALTER TABLE [PublicationControl].[Population] ADD  CONSTRAINT [DF_Population_ExportedFlag]  DEFAULT ('N') FOR [ExportedFlag]
GO
ALTER TABLE [PublicationControl].[ProjectsOnStaging] ADD  CONSTRAINT [DF_ProjectsOnStaging_DoNotPublish]  DEFAULT ('n') FOR [DoNotPublish]
GO
ALTER TABLE [PublicationControl].[ProjectsOnStaging] ADD  CONSTRAINT [DF_ProjectsOnStaging_DoNotPublishFinData]  DEFAULT ('Release') FOR [StatusFinData]
GO
ALTER TABLE [Codelist].[AidType]  WITH NOCHECK ADD  CONSTRAINT [AidType$fk$Category] FOREIGN KEY([CategoryCode])
REFERENCES [Codelist].[AidTypeCategory] ([Code])
GO
ALTER TABLE [Codelist].[AidType] NOCHECK CONSTRAINT [AidType$fk$Category]
GO
ALTER TABLE [Codelist].[DAC5DigitSector]  WITH NOCHECK ADD  CONSTRAINT [Secot$fk$Category] FOREIGN KEY([CategoryCode])
REFERENCES [Codelist].[SectorCategory] ([Code])
GO
ALTER TABLE [Codelist].[DAC5DigitSector] NOCHECK CONSTRAINT [Secot$fk$Category]
GO
ALTER TABLE [Codelist].[DocumentCategory]  WITH NOCHECK ADD  CONSTRAINT [DocumentContentType$fk$Category] FOREIGN KEY([CategoryCode])
REFERENCES [Codelist].[DocumentCategoryCategory] ([Code])
GO
ALTER TABLE [Codelist].[DocumentCategory] NOCHECK CONSTRAINT [DocumentContentType$fk$Category]
GO
ALTER TABLE [Codelist].[FinanceType]  WITH NOCHECK ADD  CONSTRAINT [FinanceType$fk$Category] FOREIGN KEY([Category])
REFERENCES [Codelist].[FinanceTypeCategory] ([Code])
GO
ALTER TABLE [Codelist].[FinanceType] NOCHECK CONSTRAINT [FinanceType$fk$Category]
GO
ALTER TABLE [Codelist].[LocationType]  WITH NOCHECK ADD  CONSTRAINT [LocationType$fk$Category] FOREIGN KEY([Category])
REFERENCES [Codelist].[LocationTypeCategory] ([Code])
GO
ALTER TABLE [Codelist].[LocationType] NOCHECK CONSTRAINT [LocationType$fk$Category]
GO
ALTER TABLE [Codelist].[OrganisationRegistrationAgency]  WITH NOCHECK ADD  CONSTRAINT [OrganisationRegistrationAgency$fk$Category] FOREIGN KEY([Category])
REFERENCES [Codelist].[Country] ([Code])
GO
ALTER TABLE [Codelist].[OrganisationRegistrationAgency] NOCHECK CONSTRAINT [OrganisationRegistrationAgency$fk$Category]
GO
ALTER TABLE [Codelist].[SectorCategory]  WITH NOCHECK ADD  CONSTRAINT [SectorCategory$fk$ParentCategory] FOREIGN KEY([ParentCode])
REFERENCES [Codelist].[SectorCategory] ([Code])
GO
ALTER TABLE [Codelist].[SectorCategory] NOCHECK CONSTRAINT [SectorCategory$fk$ParentCategory]
GO
ALTER TABLE [IATISchema].[activity-date]  WITH NOCHECK ADD  CONSTRAINT [activity-date$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[ActivityDateType] ([Code])
GO
ALTER TABLE [IATISchema].[activity-date] NOCHECK CONSTRAINT [activity-date$fk$@type]
GO
ALTER TABLE [IATISchema].[activity-date]  WITH NOCHECK ADD  CONSTRAINT [activity-date$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[activity-date] NOCHECK CONSTRAINT [activity-date$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[activity-date]  WITH NOCHECK ADD  CONSTRAINT [activity-date$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[activity-date] NOCHECK CONSTRAINT [activity-date$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[budget]  WITH NOCHECK ADD  CONSTRAINT [budget$fk$@status] FOREIGN KEY([@status])
REFERENCES [Codelist].[BudgetStatus] ([Code])
GO
ALTER TABLE [IATISchema].[budget] NOCHECK CONSTRAINT [budget$fk$@status]
GO
ALTER TABLE [IATISchema].[budget]  WITH NOCHECK ADD  CONSTRAINT [budget$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[BudgetType] ([Code])
GO
ALTER TABLE [IATISchema].[budget] NOCHECK CONSTRAINT [budget$fk$@type]
GO
ALTER TABLE [IATISchema].[budget]  WITH NOCHECK ADD  CONSTRAINT [budget$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[budget] NOCHECK CONSTRAINT [budget$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[budget]  WITH NOCHECK ADD  CONSTRAINT [budget$fk$value/@currency] FOREIGN KEY([value/@currency])
REFERENCES [Codelist].[Currency] ([Code])
GO
ALTER TABLE [IATISchema].[budget] NOCHECK CONSTRAINT [budget$fk$value/@currency]
GO
ALTER TABLE [IATISchema].[capital-spend]  WITH NOCHECK ADD  CONSTRAINT [capital-spend$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[capital-spend] NOCHECK CONSTRAINT [capital-spend$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[collaboration-type]  WITH NOCHECK ADD  CONSTRAINT [collaboration-type$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[CollaborationType] ([Code])
GO
ALTER TABLE [IATISchema].[collaboration-type] NOCHECK CONSTRAINT [collaboration-type$fk$@code]
GO
ALTER TABLE [IATISchema].[collaboration-type]  WITH NOCHECK ADD  CONSTRAINT [collaboration-type$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[collaboration-type] NOCHECK CONSTRAINT [collaboration-type$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[collaboration-type]  WITH NOCHECK ADD  CONSTRAINT [collaboration-type$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[collaboration-type] NOCHECK CONSTRAINT [collaboration-type$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[conditions]  WITH NOCHECK ADD  CONSTRAINT [conditions$fk$@attached] FOREIGN KEY([@attached])
REFERENCES [Codelist].[ConditionsAttached] ([Code])
GO
ALTER TABLE [IATISchema].[conditions] NOCHECK CONSTRAINT [conditions$fk$@attached]
GO
ALTER TABLE [IATISchema].[conditions/condition]  WITH NOCHECK ADD  CONSTRAINT [conditions/condition$fk$conditionsID] FOREIGN KEY([conditionsID])
REFERENCES [IATISchema].[conditions] ([conditionsID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[conditions/condition] NOCHECK CONSTRAINT [conditions/condition$fk$conditionsID]
GO
ALTER TABLE [IATISchema].[conditions/condition]  WITH NOCHECK ADD  CONSTRAINT [conditions/condition$fk$value/@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[ConditionType] ([Code])
GO
ALTER TABLE [IATISchema].[conditions/condition] NOCHECK CONSTRAINT [conditions/condition$fk$value/@type]
GO
ALTER TABLE [IATISchema].[contact-info]  WITH NOCHECK ADD  CONSTRAINT [contact-info$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[contact-info] NOCHECK CONSTRAINT [contact-info$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[contact-info]  WITH NOCHECK ADD  CONSTRAINT [contact-info$fk$person-name/@xml:lang] FOREIGN KEY([person-name/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[contact-info] NOCHECK CONSTRAINT [contact-info$fk$person-name/@xml:lang]
GO
ALTER TABLE [IATISchema].[contact-info/details]  WITH NOCHECK ADD  CONSTRAINT [contact-info/details$fk$contact-infoID] FOREIGN KEY([contact-infoID])
REFERENCES [IATISchema].[contact-info] ([contact-infoID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[contact-info/details] NOCHECK CONSTRAINT [contact-info/details$fk$contact-infoID]
GO
ALTER TABLE [IATISchema].[country-budget-items]  WITH NOCHECK ADD  CONSTRAINT [country-budget-items$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[BudgetIdentifierVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[country-budget-items] NOCHECK CONSTRAINT [country-budget-items$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[country-budget-items/budget-item]  WITH CHECK ADD  CONSTRAINT [country-budget-items/budget-item$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[BudgetIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[country-budget-items/budget-item] CHECK CONSTRAINT [country-budget-items/budget-item$fk$@code]
GO
ALTER TABLE [IATISchema].[country-budget-items/budget-item]  WITH CHECK ADD  CONSTRAINT [country-budget-items/budget-item$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[country-budget-items/budget-item] CHECK CONSTRAINT [country-budget-items/budget-item$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[country-budget-items/budget-item]  WITH CHECK ADD  CONSTRAINT [country-budget-items/budget-item$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[country-budget-items/budget-item] CHECK CONSTRAINT [country-budget-items/budget-item$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[crs-add]  WITH NOCHECK ADD  CONSTRAINT [crs-add$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add] NOCHECK CONSTRAINT [crs-add$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[crs-add/channel-code]  WITH NOCHECK ADD  CONSTRAINT [crs-add/channel-code$fk$crs-addID] FOREIGN KEY([crs-addID])
REFERENCES [IATISchema].[crs-add] ([crs-addID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/channel-code] NOCHECK CONSTRAINT [crs-add/channel-code$fk$crs-addID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-status]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-status$fk$@currency] FOREIGN KEY([@currency])
REFERENCES [Codelist].[Currency] ([Code])
GO
ALTER TABLE [IATISchema].[crs-add/loan-status] NOCHECK CONSTRAINT [crs-add/loan-status$fk$@currency]
GO
ALTER TABLE [IATISchema].[crs-add/loan-status]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-status$fk$crs-addID] FOREIGN KEY([crs-addID])
REFERENCES [IATISchema].[crs-add] ([crs-addID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-status] NOCHECK CONSTRAINT [crs-add/loan-status$fk$crs-addID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/interest-arrears]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-status/interest-arrears$fk$loan-statusID] FOREIGN KEY([loan-statusID])
REFERENCES [IATISchema].[crs-add/loan-status] ([crs-add/loan-statusID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/interest-arrears] NOCHECK CONSTRAINT [crs-add/loan-status/interest-arrears$fk$loan-statusID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/interest-received]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-status/interest-received$fk$loan-statusID] FOREIGN KEY([loan-statusID])
REFERENCES [IATISchema].[crs-add/loan-status] ([crs-add/loan-statusID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/interest-received] NOCHECK CONSTRAINT [crs-add/loan-status/interest-received$fk$loan-statusID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/principal-arrears]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-status/principal-arrears$fk$loan-statusID] FOREIGN KEY([loan-statusID])
REFERENCES [IATISchema].[crs-add/loan-status] ([crs-add/loan-statusID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/principal-arrears] NOCHECK CONSTRAINT [crs-add/loan-status/principal-arrears$fk$loan-statusID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/principal-outstanding]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-status/principal-outstanding$fk$loan-statusID] FOREIGN KEY([loan-statusID])
REFERENCES [IATISchema].[crs-add/loan-status] ([crs-add/loan-statusID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-status/principal-outstanding] NOCHECK CONSTRAINT [crs-add/loan-status/principal-outstanding$fk$loan-statusID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms$fk$crs-addID] FOREIGN KEY([crs-addID])
REFERENCES [IATISchema].[crs-add] ([crs-addID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms] NOCHECK CONSTRAINT [crs-add/loan-terms$fk$crs-addID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/commitment-date]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/commitment-date$fk$loan-termsID] FOREIGN KEY([loan-termsID])
REFERENCES [IATISchema].[crs-add/loan-terms] ([crs-add/loan-termsID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/commitment-date] NOCHECK CONSTRAINT [crs-add/loan-terms/commitment-date$fk$loan-termsID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-final-date]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/repayment-final-date$fk$loan-termsID] FOREIGN KEY([loan-termsID])
REFERENCES [IATISchema].[crs-add/loan-terms] ([crs-add/loan-termsID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-final-date] NOCHECK CONSTRAINT [crs-add/loan-terms/repayment-final-date$fk$loan-termsID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-first-date]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/repayment-first-date$fk$loan-termsID] FOREIGN KEY([loan-termsID])
REFERENCES [IATISchema].[crs-add/loan-terms] ([crs-add/loan-termsID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-first-date] NOCHECK CONSTRAINT [crs-add/loan-terms/repayment-first-date$fk$loan-termsID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-plan]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/repayment-plan$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[LoanRepaymentPeriod] ([Code])
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-plan] NOCHECK CONSTRAINT [crs-add/loan-terms/repayment-plan$fk$@code]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-plan]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/repayment-plan$fk$loan-termsID] FOREIGN KEY([loan-termsID])
REFERENCES [IATISchema].[crs-add/loan-terms] ([crs-add/loan-termsID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-plan] NOCHECK CONSTRAINT [crs-add/loan-terms/repayment-plan$fk$loan-termsID]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-type]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/repayment-type$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[LoanRepaymentType] ([Code])
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-type] NOCHECK CONSTRAINT [crs-add/loan-terms/repayment-type$fk$@code]
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-type]  WITH NOCHECK ADD  CONSTRAINT [crs-add/loan-terms/repayment-type$fk$loan-termsID] FOREIGN KEY([loan-termsID])
REFERENCES [IATISchema].[crs-add/loan-terms] ([crs-add/loan-termsID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/loan-terms/repayment-type] NOCHECK CONSTRAINT [crs-add/loan-terms/repayment-type$fk$loan-termsID]
GO
ALTER TABLE [IATISchema].[crs-add/other-flags]  WITH NOCHECK ADD  CONSTRAINT [crs-add/other-flags$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[CRSAdditionalOtherFlags] ([Code])
GO
ALTER TABLE [IATISchema].[crs-add/other-flags] NOCHECK CONSTRAINT [crs-add/other-flags$fk$@code]
GO
ALTER TABLE [IATISchema].[crs-add/other-flags]  WITH NOCHECK ADD  CONSTRAINT [crs-add/other-flags$fk$crs-addID] FOREIGN KEY([crs-addID])
REFERENCES [IATISchema].[crs-add] ([crs-addID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[crs-add/other-flags] NOCHECK CONSTRAINT [crs-add/other-flags$fk$crs-addID]
GO
ALTER TABLE [IATISchema].[default-aid-type]  WITH NOCHECK ADD  CONSTRAINT [default-aid-type$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[AidType] ([Code])
GO
ALTER TABLE [IATISchema].[default-aid-type] NOCHECK CONSTRAINT [default-aid-type$fk$@code]
GO
ALTER TABLE [IATISchema].[default-aid-type]  WITH NOCHECK ADD  CONSTRAINT [default-aid-type$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[AidTypeVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[default-aid-type] NOCHECK CONSTRAINT [default-aid-type$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[default-aid-type]  WITH NOCHECK ADD  CONSTRAINT [default-aid-type$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[default-aid-type] NOCHECK CONSTRAINT [default-aid-type$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[description]  WITH NOCHECK ADD  CONSTRAINT [description$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[DescriptionType] ([Code])
GO
ALTER TABLE [IATISchema].[description] NOCHECK CONSTRAINT [description$fk$@type]
GO
ALTER TABLE [IATISchema].[description]  WITH NOCHECK ADD  CONSTRAINT [description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[description] NOCHECK CONSTRAINT [description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[description]  WITH NOCHECK ADD  CONSTRAINT [description$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[description] NOCHECK CONSTRAINT [description$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[document-link]  WITH NOCHECK ADD  CONSTRAINT [document-link$fk$@language] FOREIGN KEY([@language])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[document-link] NOCHECK CONSTRAINT [document-link$fk$@language]
GO
ALTER TABLE [IATISchema].[document-link]  WITH NOCHECK ADD  CONSTRAINT [document-link$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[document-link] NOCHECK CONSTRAINT [document-link$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[document-link/category]  WITH NOCHECK ADD  CONSTRAINT [document-link/category$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [IATISchema].[document-link/category] NOCHECK CONSTRAINT [document-link/category$fk$@code]
GO
ALTER TABLE [IATISchema].[document-link/category]  WITH NOCHECK ADD  CONSTRAINT [document-link/category$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[document-link/category] NOCHECK CONSTRAINT [document-link/category$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[document-link/category]  WITH NOCHECK ADD  CONSTRAINT [document-link/category$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[document-link] ([document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[document-link/category] NOCHECK CONSTRAINT [document-link/category$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[document-link/description]  WITH NOCHECK ADD  CONSTRAINT [document-link/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[document-link/description] NOCHECK CONSTRAINT [document-link/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[document-link/description]  WITH NOCHECK ADD  CONSTRAINT [document-link/description$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[document-link] ([document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[document-link/description] NOCHECK CONSTRAINT [document-link/description$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[document-link/document-date]  WITH NOCHECK ADD  CONSTRAINT [document-link/document-date$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[document-link] ([document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[document-link/document-date] NOCHECK CONSTRAINT [document-link/document-date$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[document-link/language]  WITH NOCHECK ADD  CONSTRAINT [document-link/language$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[document-link/language] NOCHECK CONSTRAINT [document-link/language$fk$@code]
GO
ALTER TABLE [IATISchema].[document-link/language]  WITH NOCHECK ADD  CONSTRAINT [document-link/language$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[document-link/language] NOCHECK CONSTRAINT [document-link/language$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[document-link/language]  WITH NOCHECK ADD  CONSTRAINT [document-link/language$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[document-link] ([document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[document-link/language] NOCHECK CONSTRAINT [document-link/language$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[document-link/title]  WITH NOCHECK ADD  CONSTRAINT [document-link/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[document-link/title] NOCHECK CONSTRAINT [document-link/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[document-link/title]  WITH NOCHECK ADD  CONSTRAINT [document-link/title$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[document-link] ([document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[document-link/title] NOCHECK CONSTRAINT [document-link/title$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[humanitarian-scope]  WITH NOCHECK ADD  CONSTRAINT [humanitarian-scope$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[HumanitarianScopeType] ([Code])
GO
ALTER TABLE [IATISchema].[humanitarian-scope] NOCHECK CONSTRAINT [humanitarian-scope$fk$@type]
GO
ALTER TABLE [IATISchema].[humanitarian-scope]  WITH NOCHECK ADD  CONSTRAINT [humanitarian-scope$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[HumanitarianScopeVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[humanitarian-scope] NOCHECK CONSTRAINT [humanitarian-scope$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[humanitarian-scope]  WITH NOCHECK ADD  CONSTRAINT [humanitarian-scope$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[humanitarian-scope] NOCHECK CONSTRAINT [humanitarian-scope$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$@ir:registry-record/publisher-role] FOREIGN KEY([ir:registry-record/@publisher-role])
REFERENCES [Codelist].[OrganisationRole] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$@ir:registry-record/publisher-role]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$ir:registry-record/@donor-country] FOREIGN KEY([ir:registry-record/@donor-country])
REFERENCES [Codelist].[Country] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$ir:registry-record/@donor-country]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$ir:registry-record/@donor-id] FOREIGN KEY([ir:registry-record/@donor-id])
REFERENCES [Codelist].[OrganisationIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$ir:registry-record/@donor-id]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$ir:registry-record/@donor-type] FOREIGN KEY([ir:registry-record/@donor-type])
REFERENCES [Codelist].[OrganisationType] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$ir:registry-record/@donor-type]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$ir:registry-record/@format] FOREIGN KEY([ir:registry-record/@format])
REFERENCES [Codelist].[FileFormat] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$ir:registry-record/@format]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$ir:registry-record/@publisher-id] FOREIGN KEY([ir:registry-record/@publisher-id])
REFERENCES [Codelist].[OrganisationIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$ir:registry-record/@publisher-id]
GO
ALTER TABLE [IATISchema].[iati-activities]  WITH NOCHECK ADD  CONSTRAINT [iati-activities$fk$ir:registry-record/@verification-status] FOREIGN KEY([ir:registry-record/@verification-status])
REFERENCES [Codelist].[VerificationStatus] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activities] NOCHECK CONSTRAINT [iati-activities$fk$ir:registry-record/@verification-status]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$activity-status/@code] FOREIGN KEY([activity-status/@code])
REFERENCES [Codelist].[ActivityStatus] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$activity-status/@code]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$activity-status/@xml:lang] FOREIGN KEY([activity-status/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$activity-status/@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$collaboration-type/@code] FOREIGN KEY([collaboration-type/@code])
REFERENCES [Codelist].[CollaborationType] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$collaboration-type/@code]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$collaboration-type/@xml:lang] FOREIGN KEY([collaboration-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$collaboration-type/@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$CountryCode] FOREIGN KEY([CountryCode])
REFERENCES [Codelist].[Country] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$CountryCode]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$default-finance-type/@code] FOREIGN KEY([default-finance-type/@code])
REFERENCES [Codelist].[FinanceType] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$default-finance-type/@code]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$default-finance-type/@xml:lang] FOREIGN KEY([default-finance-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$default-finance-type/@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$default-flow-type/@code] FOREIGN KEY([default-flow-type/@code])
REFERENCES [Codelist].[FlowType] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$default-flow-type/@code]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$default-flow-type/@xml:lang] FOREIGN KEY([default-flow-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$default-flow-type/@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$default-tied-status/@code] FOREIGN KEY([default-tied-status/@code])
REFERENCES [Codelist].[TiedStatus] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$default-tied-status/@code]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$default-tied-status/@xml:lang] FOREIGN KEY([default-tied-status/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$default-tied-status/@xml:lang]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$iati-activitiesID] FOREIGN KEY([iati-activitiesID])
REFERENCES [IATISchema].[iati-activities] ([iati-activitiesID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$iati-activitiesID]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$other-identifier/@owner-ref] FOREIGN KEY([other-identifier/@owner-ref])
REFERENCES [Codelist].[OrganisationIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$other-identifier/@owner-ref]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$RegionCode] FOREIGN KEY([RegionCode])
REFERENCES [Codelist].[Region] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$RegionCode]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$reporting-org/@ref] FOREIGN KEY([reporting-org/@ref])
REFERENCES [Codelist].[OrganisationIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$reporting-org/@ref]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$reporting-org/@type] FOREIGN KEY([reporting-org/@type])
REFERENCES [Codelist].[OrganisationType] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$reporting-org/@type]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$fk$reporting-org/@xml:lang] FOREIGN KEY([reporting-org/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$fk$reporting-org/@xml:lang]
GO
ALTER TABLE [IATISchema].[legacy-data]  WITH NOCHECK ADD  CONSTRAINT [legacy-data$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[legacy-data] NOCHECK CONSTRAINT [legacy-data$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$activity-description/@xml:lang] FOREIGN KEY([activity-description/narrative/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$activity-description/@xml:lang]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$description/@xml:lang] FOREIGN KEY([description/narrative/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$description/@xml:lang]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$exactness/@code] FOREIGN KEY([exactness/@code])
REFERENCES [Codelist].[GeographicLocationReach] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$exactness/@code]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$feature-designation/@code] FOREIGN KEY([feature-designation/@code])
REFERENCES [Codelist].[LocationType] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$feature-designation/@code]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$location-class/@code] FOREIGN KEY([location-class/@code])
REFERENCES [Codelist].[GeographicLocationClass] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$location-class/@code]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$location-reach/@code] FOREIGN KEY([location-reach/@code])
REFERENCES [Codelist].[GeographicLocationReach] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$location-reach/@code]
GO
ALTER TABLE [IATISchema].[location]  WITH NOCHECK ADD  CONSTRAINT [location104$fk$name/@xml:lang] FOREIGN KEY([name/narrative/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[location] NOCHECK CONSTRAINT [location104$fk$name/@xml:lang]
GO
ALTER TABLE [IATISchema].[other-identifier]  WITH NOCHECK ADD  CONSTRAINT [other-identifier$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[OtherIdentifierType] ([Code])
GO
ALTER TABLE [IATISchema].[other-identifier] NOCHECK CONSTRAINT [other-identifier$fk$@type]
GO
ALTER TABLE [IATISchema].[other-identifier]  WITH NOCHECK ADD  CONSTRAINT [other-identifier$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[other-identifier] NOCHECK CONSTRAINT [other-identifier$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[participating-org]  WITH NOCHECK ADD  CONSTRAINT [participating-org$fk$@crs-channel-code] FOREIGN KEY([@crs-channel-code])
REFERENCES [Codelist].[CRSChannelCode] ([Code])
GO
ALTER TABLE [IATISchema].[participating-org] NOCHECK CONSTRAINT [participating-org$fk$@crs-channel-code]
GO
ALTER TABLE [IATISchema].[participating-org]  WITH NOCHECK ADD  CONSTRAINT [participating-org$fk$@role] FOREIGN KEY([@role])
REFERENCES [Codelist].[OrganisationRole] ([Code])
GO
ALTER TABLE [IATISchema].[participating-org] NOCHECK CONSTRAINT [participating-org$fk$@role]
GO
ALTER TABLE [IATISchema].[participating-org]  WITH NOCHECK ADD  CONSTRAINT [participating-org$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[OrganisationType] ([Code])
GO
ALTER TABLE [IATISchema].[participating-org] NOCHECK CONSTRAINT [participating-org$fk$@type]
GO
ALTER TABLE [IATISchema].[participating-org]  WITH NOCHECK ADD  CONSTRAINT [participating-org$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[participating-org] NOCHECK CONSTRAINT [participating-org$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[participating-org]  WITH NOCHECK ADD  CONSTRAINT [participating-org$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[participating-org] NOCHECK CONSTRAINT [participating-org$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[policy-marker]  WITH NOCHECK ADD  CONSTRAINT [policy-marker$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[PolicyMarker] ([Code])
GO
ALTER TABLE [IATISchema].[policy-marker] NOCHECK CONSTRAINT [policy-marker$fk$@code]
GO
ALTER TABLE [IATISchema].[policy-marker]  WITH NOCHECK ADD  CONSTRAINT [policy-marker$fk$@significance] FOREIGN KEY([@significance])
REFERENCES [Codelist].[PolicySignificance] ([Code])
GO
ALTER TABLE [IATISchema].[policy-marker] NOCHECK CONSTRAINT [policy-marker$fk$@significance]
GO
ALTER TABLE [IATISchema].[policy-marker]  WITH NOCHECK ADD  CONSTRAINT [policy-marker$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[PolicyMarkerVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[policy-marker] NOCHECK CONSTRAINT [policy-marker$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[policy-marker]  WITH NOCHECK ADD  CONSTRAINT [policy-marker$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[policy-marker] NOCHECK CONSTRAINT [policy-marker$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[policy-marker]  WITH NOCHECK ADD  CONSTRAINT [policy-marker$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[policy-marker] NOCHECK CONSTRAINT [policy-marker$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[recipient-country]  WITH NOCHECK ADD  CONSTRAINT [recipient-country$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Country] ([Code])
GO
ALTER TABLE [IATISchema].[recipient-country] NOCHECK CONSTRAINT [recipient-country$fk$@code]
GO
ALTER TABLE [IATISchema].[recipient-country]  WITH NOCHECK ADD  CONSTRAINT [recipient-country$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[recipient-country] NOCHECK CONSTRAINT [recipient-country$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[recipient-country]  WITH NOCHECK ADD  CONSTRAINT [recipient-country$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[recipient-country] NOCHECK CONSTRAINT [recipient-country$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[recipient-region]  WITH NOCHECK ADD  CONSTRAINT [recipient-region$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Region] ([Code])
GO
ALTER TABLE [IATISchema].[recipient-region] NOCHECK CONSTRAINT [recipient-region$fk$@code]
GO
ALTER TABLE [IATISchema].[recipient-region]  WITH NOCHECK ADD  CONSTRAINT [recipient-region$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[recipient-region] NOCHECK CONSTRAINT [recipient-region$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[recipient-region]  WITH NOCHECK ADD  CONSTRAINT [recipient-region$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[recipient-region] NOCHECK CONSTRAINT [recipient-region$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[related-activity]  WITH NOCHECK ADD  CONSTRAINT [related-activity$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[RelatedActivityType] ([Code])
GO
ALTER TABLE [IATISchema].[related-activity] NOCHECK CONSTRAINT [related-activity$fk$@type]
GO
ALTER TABLE [IATISchema].[related-activity]  WITH NOCHECK ADD  CONSTRAINT [related-activity$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[related-activity] NOCHECK CONSTRAINT [related-activity$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[related-activity]  WITH NOCHECK ADD  CONSTRAINT [related-activity$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[related-activity] NOCHECK CONSTRAINT [related-activity$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[result]  WITH NOCHECK ADD  CONSTRAINT [result$fk$@type] FOREIGN KEY([@type])
REFERENCES [Codelist].[ResultType] ([Code])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result] NOCHECK CONSTRAINT [result$fk$@type]
GO
ALTER TABLE [IATISchema].[result]  WITH NOCHECK ADD  CONSTRAINT [result$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result] NOCHECK CONSTRAINT [result$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[result/description]  WITH NOCHECK ADD  CONSTRAINT [result/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/description] NOCHECK CONSTRAINT [result/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/description]  WITH NOCHECK ADD  CONSTRAINT [result/description$fk$resultID] FOREIGN KEY([resultID])
REFERENCES [IATISchema].[result] ([resultID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/description] NOCHECK CONSTRAINT [result/description$fk$resultID]
GO
ALTER TABLE [IATISchema].[result/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/document-link$fk$@format] FOREIGN KEY([@format])
REFERENCES [Codelist].[FileFormat] ([Code])
GO
ALTER TABLE [IATISchema].[result/document-link] NOCHECK CONSTRAINT [result/document-link$fk$@format]
GO
ALTER TABLE [IATISchema].[result/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/document-link$fk$resultID] FOREIGN KEY([resultID])
REFERENCES [IATISchema].[result] ([resultID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/document-link] NOCHECK CONSTRAINT [result/document-link$fk$resultID]
GO
ALTER TABLE [IATISchema].[result/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/category$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [IATISchema].[result/document-link/category] NOCHECK CONSTRAINT [result/document-link/category$fk$@code]
GO
ALTER TABLE [IATISchema].[result/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/category$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/document-link] ([result/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/document-link/category] NOCHECK CONSTRAINT [result/document-link/category$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/document-link/description] NOCHECK CONSTRAINT [result/document-link/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/description$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/document-link] ([result/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/document-link/description] NOCHECK CONSTRAINT [result/document-link/description$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/document-link/document-date]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/document-date$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/document-link] ([result/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/document-link/document-date] NOCHECK CONSTRAINT [result/document-link/document-date$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/language$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/document-link/language] NOCHECK CONSTRAINT [result/document-link/language$fk$@code]
GO
ALTER TABLE [IATISchema].[result/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/language$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/document-link] ([result/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/document-link/language] NOCHECK CONSTRAINT [result/document-link/language$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/document-link/title] NOCHECK CONSTRAINT [result/document-link/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/document-link/title$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/document-link] ([result/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/document-link/title] NOCHECK CONSTRAINT [result/document-link/title$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator]  WITH NOCHECK ADD  CONSTRAINT [result/indicator$fk$@measure] FOREIGN KEY([@measure])
REFERENCES [Codelist].[IndicatorMeasure] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator] NOCHECK CONSTRAINT [result/indicator$fk$@measure]
GO
ALTER TABLE [IATISchema].[result/indicator]  WITH NOCHECK ADD  CONSTRAINT [result/indicator$fk$resultID] FOREIGN KEY([resultID])
REFERENCES [IATISchema].[result] ([resultID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator] NOCHECK CONSTRAINT [result/indicator$fk$resultID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline$fk$result/indicatorID] FOREIGN KEY([result/indicatorID])
REFERENCES [IATISchema].[result/indicator] ([result/indicatorID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline] NOCHECK CONSTRAINT [result/indicator/baseline$fk$result/indicatorID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/comment]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/comment$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/comment] NOCHECK CONSTRAINT [result/indicator/baseline/comment$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/comment]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/comment$fk$result/indicator/baselineID] FOREIGN KEY([result/indicator/baselineID])
REFERENCES [IATISchema].[result/indicator/baseline] ([result/indicator/baselineID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/comment] NOCHECK CONSTRAINT [result/indicator/baseline/comment$fk$result/indicator/baselineID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/dimension]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/dimension$fk$result/indicator/baselineID] FOREIGN KEY([result/indicator/baselineID])
REFERENCES [IATISchema].[result/indicator/baseline] ([result/indicator/baselineID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/dimension] NOCHECK CONSTRAINT [result/indicator/baseline/dimension$fk$result/indicator/baselineID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link$fk$@format] FOREIGN KEY([@format])
REFERENCES [Codelist].[FileFormat] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link] NOCHECK CONSTRAINT [result/indicator/baseline/document-link$fk$@format]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link$fk$result/indicator/baselineID] FOREIGN KEY([result/indicator/baselineID])
REFERENCES [IATISchema].[result/indicator/baseline] ([result/indicator/baselineID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link] NOCHECK CONSTRAINT [result/indicator/baseline/document-link$fk$result/indicator/baselineID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/category$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/category] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/category$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/category$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/baseline/document-link] ([result/indicator/baseline/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/category] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/category$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/description] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/description$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/baseline/document-link] ([result/indicator/baseline/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/description] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/description$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/document-date]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/document-date$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/baseline/document-link] ([result/indicator/baseline/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/document-date] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/document-date$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/language$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/language] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/language$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/language$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/baseline/document-link] ([result/indicator/baseline/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/language] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/language$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/title] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/document-link/title$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/baseline/document-link] ([result/indicator/baseline/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/document-link/title] NOCHECK CONSTRAINT [result/indicator/baseline/document-link/title$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/location]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/baseline/location$fk$result/indicator/baselineID] FOREIGN KEY([result/indicator/baselineID])
REFERENCES [IATISchema].[result/indicator/baseline] ([result/indicator/baselineID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/baseline/location] NOCHECK CONSTRAINT [result/indicator/baseline/location$fk$result/indicator/baselineID]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link$fk$@format] FOREIGN KEY([@format])
REFERENCES [Codelist].[FileFormat] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/document-link] NOCHECK CONSTRAINT [result/indicator/document-link$fk$@format]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link$fk$result/indicatorID] FOREIGN KEY([result/indicatorID])
REFERENCES [IATISchema].[result/indicator] ([result/indicatorID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/document-link] NOCHECK CONSTRAINT [result/indicator/document-link$fk$result/indicatorID]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/category$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/category] NOCHECK CONSTRAINT [result/indicator/document-link/category$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/category$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/document-link] ([result/indicator/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/category] NOCHECK CONSTRAINT [result/indicator/document-link/category$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/description] NOCHECK CONSTRAINT [result/indicator/document-link/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/description$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/document-link] ([result/indicator/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/description] NOCHECK CONSTRAINT [result/indicator/document-link/description$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/document-date]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/document-date$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/document-link] ([result/indicator/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/document-date] NOCHECK CONSTRAINT [result/indicator/document-link/document-date$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/language$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/language] NOCHECK CONSTRAINT [result/indicator/document-link/language$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/language$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/document-link] ([result/indicator/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/language] NOCHECK CONSTRAINT [result/indicator/document-link/language$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/title] NOCHECK CONSTRAINT [result/indicator/document-link/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/document-link/title$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/document-link] ([result/indicator/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/document-link/title] NOCHECK CONSTRAINT [result/indicator/document-link/title$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period$fk$result/indicatorID] FOREIGN KEY([result/indicatorID])
REFERENCES [IATISchema].[result/indicator] ([result/indicatorID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period] NOCHECK CONSTRAINT [result/indicator/period$fk$result/indicatorID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual$fk$result/indicator/periodID] FOREIGN KEY([result/indicator/periodID])
REFERENCES [IATISchema].[result/indicator/period] ([result/indicator/periodID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual] NOCHECK CONSTRAINT [result/indicator/period/actual$fk$result/indicator/periodID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/comment]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/comment$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/comment] NOCHECK CONSTRAINT [result/indicator/period/actual/comment$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/comment]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/comment$fk$result/indicator/period/actualID] FOREIGN KEY([result/indicator/period/actualID])
REFERENCES [IATISchema].[result/indicator/period/actual] ([result/indicator/period/actualID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/comment] NOCHECK CONSTRAINT [result/indicator/period/actual/comment$fk$result/indicator/period/actualID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/dimension]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/dimension$fk$result/indicator/period/actualID] FOREIGN KEY([result/indicator/period/actualID])
REFERENCES [IATISchema].[result/indicator/period/actual] ([result/indicator/period/actualID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/dimension] NOCHECK CONSTRAINT [result/indicator/period/actual/dimension$fk$result/indicator/period/actualID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link$fk$@format] FOREIGN KEY([@format])
REFERENCES [Codelist].[FileFormat] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link$fk$@format]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link$fk$result/indicator/period/actualID] FOREIGN KEY([result/indicator/period/actualID])
REFERENCES [IATISchema].[result/indicator/period/actual] ([result/indicator/period/actualID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link$fk$result/indicator/period/actualID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/category$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/category] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/category$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/category$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/actual/document-link] ([result/indicator/period/actual/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/category] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/category$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/description] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/description$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/actual/document-link] ([result/indicator/period/actual/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/description] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/description$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/document-date]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/document-date$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/actual/document-link] ([result/indicator/period/actual/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/document-date] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/document-date$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/language$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/language] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/language$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/document-link/language$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/actual/document-link] ([result/indicator/period/actual/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/document-link/language] NOCHECK CONSTRAINT [result/indicator/period/actual/document-link/language$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/location]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/actual/location$fk$result/indicator/period/actualID] FOREIGN KEY([result/indicator/period/actualID])
REFERENCES [IATISchema].[result/indicator/period/actual] ([result/indicator/period/actualID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/actual/location] NOCHECK CONSTRAINT [result/indicator/period/actual/location$fk$result/indicator/period/actualID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/period-end]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/period-end$fk$result/indicator/periodID] FOREIGN KEY([result/indicator/periodID])
REFERENCES [IATISchema].[result/indicator/period] ([result/indicator/periodID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/period-end] NOCHECK CONSTRAINT [result/indicator/period/period-end$fk$result/indicator/periodID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/period-start]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/period-start$fk$result/indicator/periodID] FOREIGN KEY([result/indicator/periodID])
REFERENCES [IATISchema].[result/indicator/period] ([result/indicator/periodID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/period-start] NOCHECK CONSTRAINT [result/indicator/period/period-start$fk$result/indicator/periodID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target$fk$result/indicator/periodID] FOREIGN KEY([result/indicator/periodID])
REFERENCES [IATISchema].[result/indicator/period] ([result/indicator/periodID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target] NOCHECK CONSTRAINT [result/indicator/period/target$fk$result/indicator/periodID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/comment]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/comment$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/comment] NOCHECK CONSTRAINT [result/indicator/period/target/comment$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/comment]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/comment$fk$result/indicator/period/targetID] FOREIGN KEY([result/indicator/period/targetID])
REFERENCES [IATISchema].[result/indicator/period/target] ([result/indicator/period/targetID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/comment] NOCHECK CONSTRAINT [result/indicator/period/target/comment$fk$result/indicator/period/targetID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/dimension]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/dimension$fk$result/indicator/period/targetID] FOREIGN KEY([result/indicator/period/targetID])
REFERENCES [IATISchema].[result/indicator/period/target] ([result/indicator/period/targetID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/dimension] NOCHECK CONSTRAINT [result/indicator/period/target/dimension$fk$result/indicator/period/targetID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link$fk$@format] FOREIGN KEY([@format])
REFERENCES [Codelist].[FileFormat] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link] NOCHECK CONSTRAINT [result/indicator/period/target/document-link$fk$@format]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link$fk$result/indicator/period/targetID] FOREIGN KEY([result/indicator/period/targetID])
REFERENCES [IATISchema].[result/indicator/period/target] ([result/indicator/period/targetID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link] NOCHECK CONSTRAINT [result/indicator/period/target/document-link$fk$result/indicator/period/targetID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/category$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/category] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/category$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/category]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/category$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/target/document-link] ([result/indicator/period/target/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/category] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/category$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/description$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/description] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/description$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/description]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/description$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/target/document-link] ([result/indicator/period/target/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/description] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/description$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/document-date]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/document-date$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/target/document-link] ([result/indicator/period/target/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/document-date] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/document-date$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/language$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/language] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/language$fk$@code]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/language]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/language$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/target/document-link] ([result/indicator/period/target/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/language] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/language$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/title] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/document-link/title$fk$document-linkID] FOREIGN KEY([document-linkID])
REFERENCES [IATISchema].[result/indicator/period/target/document-link] ([result/indicator/period/target/document-linkID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/document-link/title] NOCHECK CONSTRAINT [result/indicator/period/target/document-link/title$fk$document-linkID]
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/location]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/period/target/location$fk$result/indicator/period/targetID] FOREIGN KEY([result/indicator/period/targetID])
REFERENCES [IATISchema].[result/indicator/period/target] ([result/indicator/period/targetID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/period/target/location] NOCHECK CONSTRAINT [result/indicator/period/target/location$fk$result/indicator/period/targetID]
GO
ALTER TABLE [IATISchema].[result/indicator/reference]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/reference$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[ResultVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/reference] NOCHECK CONSTRAINT [result/indicator/reference$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[result/indicator/reference]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/reference$fk$resultID] FOREIGN KEY([resultID])
REFERENCES [IATISchema].[result] ([resultID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/reference] NOCHECK CONSTRAINT [result/indicator/reference$fk$resultID]
GO
ALTER TABLE [IATISchema].[result/indicator/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/indicator/title] NOCHECK CONSTRAINT [result/indicator/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/indicator/title]  WITH NOCHECK ADD  CONSTRAINT [result/indicator/title$fk$indicatorID] FOREIGN KEY([indicatorID])
REFERENCES [IATISchema].[result/indicator] ([result/indicatorID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/indicator/title] NOCHECK CONSTRAINT [result/indicator/title$fk$indicatorID]
GO
ALTER TABLE [IATISchema].[result/reference]  WITH NOCHECK ADD  CONSTRAINT [result/reference$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[ResultVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[result/reference] NOCHECK CONSTRAINT [result/reference$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[result/reference]  WITH NOCHECK ADD  CONSTRAINT [result/reference$fk$resultID] FOREIGN KEY([resultID])
REFERENCES [IATISchema].[result] ([resultID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/reference] NOCHECK CONSTRAINT [result/reference$fk$resultID]
GO
ALTER TABLE [IATISchema].[result/title]  WITH NOCHECK ADD  CONSTRAINT [result/title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[result/title] NOCHECK CONSTRAINT [result/title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[result/title]  WITH NOCHECK ADD  CONSTRAINT [result/title$fk$resultID] FOREIGN KEY([resultID])
REFERENCES [IATISchema].[result] ([resultID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[result/title] NOCHECK CONSTRAINT [result/title$fk$resultID]
GO
ALTER TABLE [IATISchema].[sector]  WITH NOCHECK ADD  CONSTRAINT [sector$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[DAC5DigitSector] ([Code])
GO
ALTER TABLE [IATISchema].[sector] NOCHECK CONSTRAINT [sector$fk$@code]
GO
ALTER TABLE [IATISchema].[sector]  WITH NOCHECK ADD  CONSTRAINT [sector$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[SectorVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[sector] NOCHECK CONSTRAINT [sector$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[sector]  WITH NOCHECK ADD  CONSTRAINT [sector$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[sector] NOCHECK CONSTRAINT [sector$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[sector]  WITH NOCHECK ADD  CONSTRAINT [sector$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[sector] NOCHECK CONSTRAINT [sector$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[tag]  WITH NOCHECK ADD  CONSTRAINT [tag$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[TagVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[tag] NOCHECK CONSTRAINT [tag$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[tag]  WITH NOCHECK ADD  CONSTRAINT [tag$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[tag] NOCHECK CONSTRAINT [tag$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[title]  WITH NOCHECK ADD  CONSTRAINT [title$fk$@xml:lang] FOREIGN KEY([@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[title] NOCHECK CONSTRAINT [title$fk$@xml:lang]
GO
ALTER TABLE [IATISchema].[title]  WITH NOCHECK ADD  CONSTRAINT [title$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[title] NOCHECK CONSTRAINT [title$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$description/@xml:lang] FOREIGN KEY([description/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$description/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$disbursement-channel/@code] FOREIGN KEY([disbursement-channel/@code])
REFERENCES [Codelist].[DisbursementChannel] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$disbursement-channel/@code]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$disbursement-channel/@xml:lang] FOREIGN KEY([disbursement-channel/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$disbursement-channel/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$finance-type/@code] FOREIGN KEY([finance-type/@code])
REFERENCES [Codelist].[FinanceType] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$finance-type/@code]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$finance-type/@xml:lang] FOREIGN KEY([finance-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$finance-type/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$flow-type/@code] FOREIGN KEY([flow-type/@code])
REFERENCES [Codelist].[FlowType] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$flow-type/@code]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$flow-type/@xml:lang] FOREIGN KEY([flow-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$flow-type/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$iati-activityID] FOREIGN KEY([iati-activityID])
REFERENCES [IATISchema].[iati-activity] ([iati-activityID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$iati-activityID]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$provider-org/@ref] FOREIGN KEY([provider-org/@ref])
REFERENCES [Codelist].[OrganisationIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$provider-org/@ref]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$provider-org/@xml:lang] FOREIGN KEY([provider-org/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$provider-org/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$receiver-org/@ref] FOREIGN KEY([receiver-org/@ref])
REFERENCES [Codelist].[OrganisationIdentifier] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$receiver-org/@ref]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$receiver-org/@xml:lang] FOREIGN KEY([receiver-org/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$receiver-org/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$tied-status/@code] FOREIGN KEY([tied-status/@code])
REFERENCES [Codelist].[TiedStatus] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$tied-status/@code]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$tied-status/@xml:lang] FOREIGN KEY([tied-status/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$tied-status/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$transaction-type/@code] FOREIGN KEY([transaction-type/@code])
REFERENCES [Codelist].[TransactionType] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$transaction-type/@code]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$transaction-type/@xml:lang] FOREIGN KEY([transaction-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$transaction-type/@xml:lang]
GO
ALTER TABLE [IATISchema].[transaction]  WITH NOCHECK ADD  CONSTRAINT [transaction$fk$value/@currency] FOREIGN KEY([value/@currency])
REFERENCES [Codelist].[Currency] ([Code])
GO
ALTER TABLE [IATISchema].[transaction] NOCHECK CONSTRAINT [transaction$fk$value/@currency]
GO
ALTER TABLE [IATISchema].[transaction/aid-type]  WITH NOCHECK ADD  CONSTRAINT [transaction/aid-type$fk$@code] FOREIGN KEY([@code])
REFERENCES [Codelist].[AidType] ([Code])
GO
ALTER TABLE [IATISchema].[transaction/aid-type] NOCHECK CONSTRAINT [transaction/aid-type$fk$@code]
GO
ALTER TABLE [IATISchema].[transaction/aid-type]  WITH NOCHECK ADD  CONSTRAINT [transaction/aid-type$fk$@vocabulary] FOREIGN KEY([@vocabulary])
REFERENCES [Codelist].[AidTypeVocabulary] ([Code])
GO
ALTER TABLE [IATISchema].[transaction/aid-type] NOCHECK CONSTRAINT [transaction/aid-type$fk$@vocabulary]
GO
ALTER TABLE [IATISchema].[transaction/aid-type]  WITH NOCHECK ADD  CONSTRAINT [transaction/aid-type$fk$transactionID] FOREIGN KEY([transactionID])
REFERENCES [IATISchema].[transaction] ([transactionID])
ON DELETE CASCADE
GO
ALTER TABLE [IATISchema].[transaction/aid-type] NOCHECK CONSTRAINT [transaction/aid-type$fk$transactionID]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$administrative/@country] FOREIGN KEY([administrative/@country])
REFERENCES [Codelist].[Country] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$administrative/@country]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$coordinates/@precision] FOREIGN KEY([coordinates/@precision])
REFERENCES [Codelist].[GeographicalPrecision] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$coordinates/@precision]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$description/@xml:lang] FOREIGN KEY([description/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$description/@xml:lang]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$gazetteer-entry/@gazetteer-ref] FOREIGN KEY([gazetteer-entry/@gazetteer-ref])
REFERENCES [Codelist].[GazetteerAgency] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$gazetteer-entry/@gazetteer-ref]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$location-type/@code] FOREIGN KEY([location-type/@code])
REFERENCES [Codelist].[LocationType] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$location-type/@code]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$location-type/@xml:lang] FOREIGN KEY([location-type/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$location-type/@xml:lang]
GO
ALTER TABLE [PublicationControl].[LocationData]  WITH NOCHECK ADD  CONSTRAINT [LocationData$fk$name/@xml:lang] FOREIGN KEY([name/@xml:lang])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [PublicationControl].[LocationData] NOCHECK CONSTRAINT [LocationData$fk$name/@xml:lang]
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry]  WITH NOCHECK ADD  CONSTRAINT [MappingBenefittingCountry$fk$BenefittingCountryTypeCode] FOREIGN KEY([BenefittingCountryTypeCode])
REFERENCES [PublicationControl].[MappingBenefittingCountryType] ([Code])
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry] NOCHECK CONSTRAINT [MappingBenefittingCountry$fk$BenefittingCountryTypeCode]
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry]  WITH NOCHECK ADD  CONSTRAINT [MappingBenefittingCountry$fk$IATICountryCode] FOREIGN KEY([IATICountryCode])
REFERENCES [Codelist].[Country] ([Code])
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry] NOCHECK CONSTRAINT [MappingBenefittingCountry$fk$IATICountryCode]
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry]  WITH NOCHECK ADD  CONSTRAINT [MappingBenefittingCountry$fk$IATIRegionCode] FOREIGN KEY([IATIRegionCode])
REFERENCES [Codelist].[Region] ([Code])
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry] NOCHECK CONSTRAINT [MappingBenefittingCountry$fk$IATIRegionCode]
GO
ALTER TABLE [PublicationControl].[MappingQuestContentType]  WITH NOCHECK ADD  CONSTRAINT [MappingQuestContentType$fk$IATIContentTypeCode] FOREIGN KEY([IATIContentTypeCode])
REFERENCES [Codelist].[DocumentCategory] ([Code])
GO
ALTER TABLE [PublicationControl].[MappingQuestContentType] NOCHECK CONSTRAINT [MappingQuestContentType$fk$IATIContentTypeCode]
GO
ALTER TABLE [PublicationControl].[MappingQuestLanguage]  WITH NOCHECK ADD  CONSTRAINT [MappingQuestLanguage$fk$IATILanguageCode] FOREIGN KEY([IATILanguageCode])
REFERENCES [Codelist].[Language] ([Code])
GO
ALTER TABLE [PublicationControl].[MappingQuestLanguage] NOCHECK CONSTRAINT [MappingQuestLanguage$fk$IATILanguageCode]
GO
ALTER TABLE [PublicationControl].[PopulationComponent]  WITH NOCHECK ADD  CONSTRAINT [PopulationComponent$fk$PopulationId] FOREIGN KEY([PopulationId])
REFERENCES [PublicationControl].[Population] ([PopulationId])
ON DELETE CASCADE
GO
ALTER TABLE [PublicationControl].[PopulationComponent] NOCHECK CONSTRAINT [PopulationComponent$fk$PopulationId]
GO
ALTER TABLE [IATISchema].[budget]  WITH NOCHECK ADD  CONSTRAINT [budget$ck$value] CHECK  (([value/text()] IS NOT NULL AND [value/@value-date] IS NOT NULL OR [value/@value-date] IS NULL AND [value/@currency] IS NULL AND [value/text()] IS NULL))
GO
ALTER TABLE [IATISchema].[budget] NOCHECK CONSTRAINT [budget$ck$value]
GO
ALTER TABLE [IATISchema].[iati-activity]  WITH NOCHECK ADD  CONSTRAINT [iati-activity$ck$@hierarchy] CHECK  (([@hierarchy]='2' OR [@hierarchy]='1'))
GO
ALTER TABLE [IATISchema].[iati-activity] NOCHECK CONSTRAINT [iati-activity$ck$@hierarchy]
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging]  WITH NOCHECK ADD  CONSTRAINT [CK_ComponentsOnStaging_Status] CHECK  (([Status]='NotYetReleased' OR [Status]='ToBeWithdrawn' OR [Status]='AwaitingPublication' OR [Status]='Published' OR [Status]='Withdrawn' OR [Status]='DoNotPublish'))
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging] NOCHECK CONSTRAINT [CK_ComponentsOnStaging_Status]
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging]  WITH NOCHECK ADD  CONSTRAINT [CK_ComponentsOnStaging_StatusFinData] CHECK  (([StatusFinData]='InActiveProcurement' OR [StatusFinData]='HideFinData' OR [StatusFinData]='HideBudgetOnly' OR [StatusFinData]='Release'))
GO
ALTER TABLE [PublicationControl].[ComponentsOnStaging] NOCHECK CONSTRAINT [CK_ComponentsOnStaging_StatusFinData]
GO
ALTER TABLE [PublicationControl].[MappingAccount]  WITH NOCHECK ADD  CONSTRAINT [MappingAccount$ck$IncludeExclue] CHECK  (([IncludeExclude]='exclude' OR [IncludeExclude]='include'))
GO
ALTER TABLE [PublicationControl].[MappingAccount] NOCHECK CONSTRAINT [MappingAccount$ck$IncludeExclue]
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry]  WITH NOCHECK ADD  CONSTRAINT [MappingBenefittingCountry$ck$Geography] CHECK  (([BenefittingCountryTypeCode]=(1) AND [IATICountryCode] IS NOT NULL AND [IATIRegionCode] IS NULL OR [BenefittingCountryTypeCode]=(2) AND [IATICountryCode] IS NULL AND [IATIRegionCode] IS NULL OR [BenefittingCountryTypeCode]=(3) AND [IATICountryCode] IS NULL AND [IATIRegionCode] IS NOT NULL OR [BenefittingCountryTypeCode]=(4) AND [IATICountryCode] IS NULL AND [IATIRegionCode] IS NULL OR [BenefittingCountryTypeCode]=(5) AND [IATICountryCode] IS NULL AND [IATIRegionCode] IS NULL))
GO
ALTER TABLE [PublicationControl].[MappingBenefittingCountry] NOCHECK CONSTRAINT [MappingBenefittingCountry$ck$Geography]
GO
ALTER TABLE [PublicationControl].[Population]  WITH NOCHECK ADD  CONSTRAINT [Population$ck$ExportedFlag] CHECK  ((CONVERT([varbinary](1),[ExportedFlag],(0))=0x4E OR CONVERT([varbinary](1),[ExportedFlag],(0))=0x59))
GO
ALTER TABLE [PublicationControl].[Population] NOCHECK CONSTRAINT [Population$ck$ExportedFlag]
GO
ALTER TABLE [PublicationControl].[PopulationComponent]  WITH NOCHECK ADD  CONSTRAINT [PopulationComponent$ck$StatusFinData] CHECK  (([StatusFinData]=N'HideBudgetOnly' OR [StatusFinData]=N'HideFinData' OR [StatusFinData]=N'Release'))
GO
ALTER TABLE [PublicationControl].[PopulationComponent] NOCHECK CONSTRAINT [PopulationComponent$ck$StatusFinData]
GO
ALTER TABLE [PublicationControl].[ProjectsOnStaging]  WITH NOCHECK ADD  CONSTRAINT [CK_ProjectsOnStaging_DoNotPublish] CHECK  (([DoNotPublish]='y' OR [DoNotPublish]='n'))
GO
ALTER TABLE [PublicationControl].[ProjectsOnStaging] NOCHECK CONSTRAINT [CK_ProjectsOnStaging_DoNotPublish]
GO
ALTER TABLE [PublicationControl].[ProjectsOnStaging]  WITH NOCHECK ADD  CONSTRAINT [CK_ProjectsOnStaging_StatusFinData] CHECK  (([StatusFinData]='Release' OR [StatusFinData]='HideFinData' OR [StatusFinData]='HideBudgetOnly'))
GO
ALTER TABLE [PublicationControl].[ProjectsOnStaging] NOCHECK CONSTRAINT [CK_ProjectsOnStaging_StatusFinData]
GO
/****** Object:  StoredProcedure [Configuration].[p_ErrorHandler]    Script Date: 05/09/2018 10:37:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Configuration].[p_ErrorHandler]
AS
BEGIN
	DECLARE @OriginalText NVARCHAR(36)
	SET @OriginalText = 'Original Error Details:'

	DECLARE @ErrorNumber INT, @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT, @ErrorProcedure NVARCHAR(126), @ErrorLine INT
	SELECT @ErrorNumber = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE(), @ErrorProcedure = ERROR_PROCEDURE(), @ErrorLine = ERROR_LINE()

	IF @ErrorMessage NOT LIKE '%' + @OriginalText + '%'
	BEGIN
		SET @ErrorMessage =
			@ErrorMessage
			+ ' - ' + @OriginalText
			+ ', Number: %li'
			+ ', Procedure: %s'
			+ ', LineNumber: %li'

		IF @@TRANCOUNT = 0
			INSERT INTO Configuration.Error (Number, Message, Severity, State, [Procedure], Line) VALUES (@ErrorNumber, @ErrorMessage, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine)
	END

	RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState, @ErrorNumber, @ErrorProcedure, @ErrorLine) WITH NOWAIT
END

GO

/****** Object:  StoredProcedure [PublicationControl].[p_PrintProgress]    Script Date: 05/09/2018 10:37:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [PublicationControl].[p_PrintProgress]
(
	@Message NVARCHAR(400) -- maximum permitted size of a unicode string parameter to PRINT
)
AS
	PRINT @Message + N': ' + CONVERT(NVARCHAR(8), GETDATE(), 108)


GO

USE [master]
GO
ALTER DATABASE [IATIv203] SET  READ_WRITE 
GO
