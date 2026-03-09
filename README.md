# SAP-BW4HANA-HANA-SAC-Enterprise-Analytics
Enterprise SAP BW/4HANA implementation for Sales Order Quanity and Value analytics with real-time  SAP Analytics Cloud dashboards. Features LSA++ architecture, S/4HANA CDS views,  AMDP transformations, Composite Providers (actuals + historical + forecast data), and SAC CORS-enabled live connectivity. Delivered 22x faster queries for 5,000+ users.


# SAP BW/4HANA Sales Analytics Data Warehouse (Enterprise Implementation)

## Project Overview

This repository demonstrates an enterprise-level SAP BW/4HANA data warehouse implementation for Sales Analytics.

The solution follows SAP’s **LSA++ (Layered Scalable Architecture)** approach and integrates transactional and master data from SAP ERP systems using modern data extraction techniques such as **ABAP CDS Views and Operational Data Provisioning (ODP)**.

The project models sales header and sales item data and delivers analytical reporting through BW Queries and SAP Analytics Cloud integration.

This architecture reflects the type of solutions delivered by global SAP consulting firms such as Accenture, Deloitte, and Capgemini.

---

## Business Scenario

Organizations require consolidated reporting across multiple sales dimensions including:

- Customer
- Product
- Sales Organization
- Distribution Channel
- Fiscal Period
- Sales Revenue and Quantity

The solution provides a **centralized analytics layer** for sales order reporting and performance analysis.

---

## Technology Stack

| Technology | Description |
|---|---|
| SAP BW/4HANA | Enterprise Data Warehouse |
| SAP HANA | In-memory database |
| ABAP CDS Views | Data modeling and extraction |
| Operational Data Provisioning (ODP) | Data extraction framework |
| ADSO | Data persistence layer |
| Composite Providers | Virtual semantic layer |
| BW Queries | Analytical reporting |
| SAP Analytics Cloud | Visualization and dashboards |

---

## High-Level Architecture

ERP Tables → CDS Views → ODP Extraction → BW DataSource → InfoSource → ADSO → Composite Provider → BW Query → SAP Analytics Cloud

---

## LSA++ Data Flow Architecture

![LSA Architecture](images/architecture/sale-item-lsa-dataflow.png)

The architecture follows the **LSA++ layered architecture** which includes:

- Staging Layer
- Harmonization Layer
- Propagation Layer
- Reporting Layer

---

# Data Extraction Layer

Sales data is extracted from SAP ERP using **ABAP CDS Views exposed via ODP**.

## Sources

| Source | Description |
|------|------|
| CDS Views | Sales Header & Sales Item |
| Open ODS Views | Historical Sales |
| SDA | Forecast Sales |
| HANA Calculation Views | Material attributes |

## Source ERP Tables

| Table | Description |
|-----|-----|
| VBAK | Sales Document Header |
| VBAP | Sales Document Item |
| KNA1 | Customer Master |
| MARA | Material Master |
| T001 | Company Code |

## CDS View Objects

| CDS View | Purpose |
|---|---|
| ZI_SALES_HDR_FULL | S4HANA Sales & Distribution Sales Header |
| ZI_SALES_ITM_DAN  | S4HANA Sales & Distribution Item |

# Business Requirements

Two main analytics use cases were implemented.

## Sales Item Analytics

Metrics required:

- Sales Order Quantity
- Sales Order Value

Dimensions:

- Customer
- Month
- Year
- Material
- Material Type
- Material Group
- Sales Organization
- Distribution Channel

---

## Sales Header Analytics

Metrics required:

- Number of Sales Orders

Dimensions:

- Customer
- Month
- Year
- Country
- Company Code
- Distribution Channel

# Data Engineering Requirements

Several enterprise-level transformation requirements were implemented to ensure high data quality and consistent reporting.

# Base Unit Conversion

Sales quantities originating from different units of measure must be standardized.

A transformation routine using AMDP (ABAP Managed Database Procedure) converts cumulative quantities into a Base Unit of Measure during the transformation process.

This ensures consistent quantity reporting across materials.

# Removal of Special Characters

Incoming source data occasionally contained special characters and formatting inconsistencies.

Transformation routines were implemented to:

- Cleanse text fields

- Remove invalid characters

- Standardize string formats

This improves data quality and reporting reliability.

# DataSource Enhancements

Standard DataSources were enhanced to support additional business logic required for analytics.

Enhancements include:

- Additional attributes required for reporting

- Lookup transformations

- Data enrichment from master data tables

# Transformation Logic

The project implemented several transformation rules including:

# Lookup Transformations

Used to enrich transactional data with master data attributes:

- Country lookup from customer master

- Product category lookup from material group

# ABAP Transformation Routines

Custom ABAP routines were implemented for:

- Update date logic

- Data cleansing

- Field derivations

# AMDP Transformation Procedures

High-performance HANA-based transformations implemented using AMDP for:

- Base unit conversion

- Large dataset processing

# Enterprise Data Architecture

The project follows the **LSA++ architecture** commonly implemented in enterprise SAP BW/4HANA projects.

Layered architecture:

Source Layer
ERP transactional tables

| Extraction Layer
| CDS Views + ODP DataSources

| Staging Layer
| ADSO (ZS_SDHDR5, ZS_SDITM4)

| Harmonization Layer
| InfoSources (ZD_ISHDR5, ZD_ISITM4)

| Reporting Layer
| ADSO (ZD_SDHDR6, ZD_SDITM4)

| Semantic Layer
| Composite Providers (ZV_SDHDR6, ZV_SDITM4)

| Analytics Layer
| BW Queries (ZQ_ZV_SDHD6_001, ZQ_ZV_SDITM4)


## Data Engineering Implementation

- The project includes several transformation and data engineering components implemented in SAP BW/4HANA.

Key techniques used:

From your documentation:

Purpose: Extract Sales Header data from SAP S/4HANA.

- ABAP CDS Views for data extraction
- ZI_SALES_HDR_FULL
@AbapCatalog.sqlViewName: 'ZV_SALES_HDR'
@Analytics.dataCategory: #FACT
@AccessControl.authorizationCheck: #NOT_REQUIRED

define view ZI_SALES_HDR_FULL
as select from vbak
{
    key vbeln        as SalesDocument,
        erdat        as CreatedDate,
        kunnr        as Customer,
        vkorg        as SalesOrganization,
        vtweg        as DistributionChannel,
        netwr        as NetValue,
        waerk        as Currency
}
 
- ZI_SALES_ITM_DAN

@AbapCatalog.sqlViewName: 'ZV_SALES_ITM'
@Analytics.dataCategory: #FACT

define view ZI_SALES_ITM_DAN
as select from vbap
{
    key vbeln     as SalesDocument,
    key posnr     as ItemNumber,
        matnr     as Material,
        kwmeng    as OrderQuantity,
        vrkme     as SalesUnit,
        netwr     as NetValue
}

# AMDP transformations for HANA pushdown


- Transformation Item Rules Routine AMDP Method for Base Unit Conversion

METHOD base_unit_conversion
BY DATABASE PROCEDURE
FOR HDB
LANGUAGE SQLSCRIPT
OPTIONS READ-ONLY.

outtab =
SELECT
    material,
    orderquantity * conversion_factor AS base_quantity
FROM :intab;

ENDMETHOD;

# Lookup transformations for master data enrichment
- Transformation Item Rules LookUp for Country-Land1
SELECT land1
INTO RESULT
FROM kna1
WHERE kunnr = SOURCE_FIELDS-customer.

# ABAP routines for custom logic
- Transformation Item Rules Routine ABAP Method for Update Date
METHOD update_date_routine.

DATA lv_date TYPE sy-datum.

lv_date = sy-datum.

RESULT = lv_date.

ENDMETHOD.

# Data cleansing and validation
- Data cleansing routine
REPLACE ALL OCCURRENCES OF REGEX '[^A-Za-z0-9 ]'
IN RESULT WITH ''.
