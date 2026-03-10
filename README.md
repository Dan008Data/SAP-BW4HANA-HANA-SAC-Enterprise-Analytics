# SAP-BW4HANA-HANA-SAC-Enterprise-Analytics
Enterprise SAP BW/4HANA implementation for Sales Order Quanity and Value analytics with real-time  SAP Analytics Cloud dashboards. Features LSA++ architecture, S/4HANA CDS views,  AMDP transformations, Composite Providers (actuals + historical + forecast data), and SAC CORS-enabled live connectivity. Delivered 22x faster queries for 5,000+ users.

## Enterprise SAP Data Engineering Project

---

## Project Overview

This repository demonstrates an **enterprise-level SAP BW/4HANA data warehouse implementation for Sales Analytics**.

The solution follows **SAP's LSA++ (Layered Scalable Architecture)** and integrates transactional and master data from **SAP S/4HANA Sales & Distribution (SD)** using modern extraction techniques such as:

- ABAP CDS Views
- Operational Data Provisioning (ODP)
- SAP BW/4HANA Data Modeling
- SAP HANA SQLScript & AMDP

The project models **Sales Header and Sales Item data** and delivers analytical reporting through:

- SAP BW Queries
- SAP Analytics Cloud (SAC)

The architecture reflects the type of solutions delivered by enterprise consulting firms such as **Accenture, Deloitte, and Capgemini**.

---

# Business Scenario

Organizations require consolidated reporting across multiple **sales dimensions** to monitor business performance and support strategic decision-making.

### Key Dimensions

- Customer
- Product
- Sales Organization
- Distribution Channel
- Fiscal Period
- Country
- Company Code
- Material
- Material Group
- Material Type

### Key Metrics

- Sales Order Quantity
- Sales Order Value
- Number of Sales Orders

---

# Technology Stack

| Technology | Description |
|---|---|
| SAP BW/4HANA | Enterprise Data Warehouse |
| SAP HANA | In-memory database |
| ABAP CDS Views | Data extraction and modeling |
| Operational Data Provisioning (ODP) | Delta extraction framework |
| ADSO | Persistent storage layer |
| Composite Providers | Semantic data modeling |
| BW Queries | Analytical reporting |
| SAP Analytics Cloud | Visualization dashboards |
---
# High-Level Architecture
<img width="1264" height="842" alt="Gemini_Generated_Image_v3txmlv3txmlv3tx" src="https://github.com/user-attachments/assets/4da65765-9a6e-4ed9-a21e-3ab29fd9710b" />

---
---

# LSA++ Data Architecture

The solution follows SAP's **LSA++ (Layered Scalable Architecture)** to ensure scalable and maintainable enterprise data pipelines.

| Layer | Description | Objects |
|------|-------------|---------|
| Source Layer | SAP transactional data | VBAK, VBAP |
| Extraction Layer | CDS-based extraction | ZI_SALES_HDR_FULL, ZI_SALES_ITM_DAN |
| Staging Layer | Raw data persistence | ZS_SDHDR5, ZS_SDITM4 |
| Harmonization Layer | Data standardization | ZD_ISHDR5, ZD_ISITM4 |
| Reporting Layer | Analytics ready data | ZD_SDHDR6, ZD_SDITM4 |
| Semantic Layer | Virtual data model | ZV_SDHDR6, ZV_SDITM4 |
| Analytics Layer | Reporting | ZQ_ZV_SDHD6_001, ZQ_ZV_SDITM4 |

---
# Source ERP Tables

| Table | Description |
|------|-------------|
| VBAK | Sales Document Header |
| VBAP | Sales Document Item |
| KNA1 | Customer Master |
| MARA | Material Master |
| T001 | Company Code |

---

# CDS View Extraction Objects

| CDS View | Purpose |
|---|---|
| ZI_SALES_HDR_FULL | Sales Header extraction |
| ZI_SALES_ITM_DAN | Sales Item extraction |

---

# Example CDS View

```sql
@AbapCatalog.sqlViewName: 'ZV_SALES_HDR'
@Analytics.dataCategory: #FACT
@AccessControl.authorizationCheck: #NOT_REQUIRED

define view ZI_SALES_HDR_FULL
as select from vbak
{
    key vbeln as SalesDocument,
    erdat as CreatedDate,
    kunnr as Customer,
    vkorg as SalesOrganization,
    vtweg as DistributionChannel,
    netwr as NetValue,
    waerk as Currency
}
```
# Data Engineering Implementation
The project includes several enterprise-level data engineering components implemented in SAP BW/4HANA.
Key Techniques
- ABAP CDS Views for modern data extraction
- Delta-enabled loading using ODP
- ADSO-based data persistence
- Composite Providers for semantic modeling
- HANA pushdown transformations using AMDP
- Data cleansing routines
- Lookup transformations for master data enrichment

# AMDP Transformation Example
High-performance transformation logic implemented using AMDP (ABAP Managed Database Procedures).
Base Unit Conversion
```
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

ENDMETHOD.
```
# Lookup Transformation Example
Lookup logic used to enrich transactional data with master data attributes.
```
SELECT land1
INTO RESULT
FROM kna1
WHERE kunnr = SOURCE_FIELDS-customer.
```
# Data Cleansing Routine
Data quality rules implemented to remove invalid characters and standardize data.
```
REPLACE ALL OCCURRENCES OF REGEX '[^A-Za-z0-9 ]'
IN RESULT WITH ''.
```
---

# Data Quality Engineering

Several data quality techniques were implemented during transformation:

- Base unit conversion using AMDP
- Removal of special characters
- Standardization of master data attributes
- Lookup enrichment using master data tables

These transformations ensure reliable and consistent reporting.

---

# Open ODS View Integration

Open ODS Views are used to integrate external or historical datasets without physically loading them into BW.

Typical use cases include:

- Historical sales data
- Flat file integrations
- HANA external tables

Example Object:

| Object | Purpose |
|------|---------|
| ZS_ODITM4 | External Sales Item data integration |

---

# Semantic Data Layer

Composite Providers combine multiple data sources into a unified analytics model.

| Composite Provider | Description |
|---|---|
| ZV_SDHDR6 | Sales Header semantic model |
| ZV_SDITM4 | Sales Item semantic model |

These objects allow flexible modeling without duplicating data.

---

# Analytics Layer

The final analytics layer exposes the data through **BW Queries and SAP Analytics Cloud dashboards**.

### BW Queries

| Query | Description |
|---|---|
| ZQ_ZV_SDHD6_001 | Sales Header analytics |
| ZQ_ZV_SDITM4 | Sales Item analytics |

These queries provide insights into:

- Sales Order Quantity
- Sales Order Value
- Sales Order Count

---

# SAP Analytics Cloud Integration

The BW Queries are exposed to **SAP Analytics Cloud using a Live Connection**.

Benefits include:

- Real-time analytics
- No data replication
- Enterprise security integration
- Interactive dashboards and stories

---

# Process Automation

Data pipelines can be automated using **SAP BW Process Chains**.

Typical automated processes include:

- Delta data loads
- ADSO activation
- Index rebuilding
- Query cache refresh

---

# Repository Structure

```
sap-bw4hana-sales-analytics
│
├── README.md
│
├── docs
│   ├── architecture.md
│   ├── data-model.md
│   ├── transformations.md
│
├── images
│   ├── architecture
│   ├── bw-modeling
│   ├── transformations
│   ├── reporting
│
└── src
    ├── cds
    ├── transformations
    └── bw-objects
```

---

# Key Skills Demonstrated

- SAP BW/4HANA Data Modeling
- Enterprise Data Warehouse Architecture
- ABAP CDS Development
- SAP HANA SQLScript & AMDP
- ETL Data Engineering
- SAP Analytics Cloud Integration
- Data Quality & Data Governance

---

# Author

Enterprise SAP Data Engineering Portfolio Project
