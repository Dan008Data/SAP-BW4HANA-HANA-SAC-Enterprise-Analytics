![Screenshot_20260218_180512_VLC (1) (1)](https://github.com/user-attachments/assets/89e54eca-20bb-4d4d-b8fb-87d27d46e3cb)# SAP-BW4HANA-HANA-SAC-Enterprise-Analytics

![SAP](https://img.shields.io/badge/SAP-BW%2F4HANA-blue)
![HANA](https://img.shields.io/badge/SAP-HANA-red)
![CDS](https://img.shields.io/badge/ABAP-CDS%20Views-green)
![ODP](https://img.shields.io/badge/Data%20Extraction-ODP-orange)
![SAC](https://img.shields.io/badge/Analytics-SAP%20Analytics%20Cloud-purple)

Enterprise SAP BW/4HANA implementation for **Sales Order Quantity and Value analytics** with real-time **SAP Analytics Cloud dashboards**.

Features:

- LSA++ architecture
- S/4HANA CDS views
- AMDP transformations
- Composite Providers (actuals + historical + forecast data)
- SAC CORS-enabled live connectivity

Delivered **22x faster queries for 5,000+ users**.

---

# Table of Contents

- [Project Overview](#project-overview)
- [Project Highlights](#project-highlights)
- [Business Scenario](#business-scenario)
- [Technology Stack](#technology-stack)
- [High-Level Architecture](#high-level-architecture)
- [LSA++ Data Architecture](#lsa-data-architecture)
- [ADSO Data Model](#adso-data-model)
- [Data Extraction](#data-extraction)
- [Data Engineering Implementation](#data-engineering-implementation)
- [Transformation Rules](#transformation-rules)
- [Semantic Data Layer](#semantic-data-layer)
- [Analytics Layer](#analytics-layer)
- [SAP Analytics Cloud Integration](#sap-analytics-cloud-integration)
- [Process Automation](#process-automation)
- [Repository Structure](#repository-structure)
- [Key Skills Demonstrated](#key-skills-demonstrated)

---

# Project Overview

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

# Project Highlights

- Implemented LSA++ architecture in SAP BW/4HANA
- Developed CDS-based extraction from S/4HANA
- Implemented delta loading using ODP
- Built ADSO staging and reporting layers
- Developed AMDP transformations for HANA pushdown
- Modeled Composite Providers for semantic analytics
- Delivered reporting through SAP Analytics Cloud

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
| ABAP CDS Views | Data extraction |
| Operational Data Provisioning | Delta loading |
| ADSO | Data persistence |
| Composite Providers | Semantic modeling |
| BW Queries | Reporting |
| SAP Analytics Cloud | Visualization |

---

# High-Level Architecture

<img width="1264" height="842" alt="Gemini_Generated_Image_v3txmlv3txmlv3tx" src="https://github.com/user-attachments/assets/a9abf1f2-dd33-4c3b-990e-a55a10187026" />


---

## LSA++ Dataflow

![Sales Item LSA++ Full Data Flow part ](https://github.com/user-attachments/assets/73c7d78d-a479-4069-a342-fc053642429d)



---

# LSA++ Data Architecture

| Layer | Description | Objects |
|------|-------------|---------|
| Source Layer | SAP transactional data | VBAK, VBAP |
| Extraction Layer | CDS extraction | ZI_SALES_HDR_FULL |
| Staging Layer | Raw data persistence | ZS_SDHDR5 |
| Harmonization Layer | Data standardization | ZD_ISHDR5 |
| Reporting Layer | Analytics-ready data | ZD_SDHDR6 |
| Semantic Layer | Virtual data model | ZV_SDHDR6 |
| Analytics Layer | Reporting | ZQ_ZV_SDHD6_001 |

---

# ADSO Data Model

### Staging ADSO

<img width="1417" height="882" alt="Sales Item Staging ADSO ZS_SDITM4 " src="https://github.com/user-attachments/assets/e7bbac04-5b76-4d34-9acb-3d5efacbba99" />


### Reporting ADSO

<img width="1408" height="887" alt="Sales Item Reporting ADSO ZD_SDITM4 " src="https://github.com/user-attachments/assets/9b7f974d-49a6-4636-a5d5-1d3ce58d6181" />


---

# Data Extraction

## Source ERP Tables

| Table | Description |
|------|-------------|
| VBAK | Sales Header |
| VBAP | Sales Item |
| KNA1 | Customer Master |
| MARA | Material Master |

---

## CDS Extraction

```sql
@AbapCatalog.sqlViewName: 'ZV_SALES_HDR'
@Analytics.dataCategory: #FACT

define view ZI_SALES_HDR_FULL
as select from vbak
{
 key vbeln as SalesDocument,
 erdat as CreatedDate,
 kunnr as Customer,
 vkorg as SalesOrganization
}
```
<img width="1433" height="717" alt="CDS View Item with Enhanced Field MTART" src="https://github.com/user-attachments/assets/778073c1-04a7-4c85-8372-d52e5af7ceef" />


---

# Data Engineering Implementation

Key techniques used:

- CDS extraction
- Delta loading via ODP
- ADSO persistence layers
- Composite Providers
- AMDP pushdown transformations
- Data cleansing routines

---

# Transformation Rules


<img width="1432" height="562" alt="Transformation Item Rules Routine AMDP Method for Base Unit Conversion" src="https://github.com/user-attachments/assets/60fd99fe-5b4b-48d3-859d-2a1a49b6f56b" />

<img width="1496" height="527" alt="Transformation Item Rules Lookup for Product Category in Material Group InfoObjects" src="https://github.com/user-attachments/assets/6cd86d6f-cd4f-4534-a54c-35f35b1fcd3c" />


---

## AMDP Example

```sql
METHOD base_unit_conversion
BY DATABASE PROCEDURE
FOR HDB
LANGUAGE SQLSCRIPT
OPTIONS READ-ONLY.

outtab =
SELECT material,
orderquantity * conversion_factor AS base_quantity
FROM :intab;

ENDMETHOD.
```

---

# Semantic Data Layer

Composite Providers combine multiple datasets.

| Composite Provider | Description |
|---|---|
| ZV_SDHDR6 | Sales Header |
| ZV_SDITM4 | Sales Item |

---

## Composite Provider
<img width="1413" height="823" alt="Composite Provider Sales Item ZV_SDITM4" src="https://github.com/user-attachments/assets/0767cd57-59a3-4620-bc31-ecc3ae6bda1f" />


<img width="1248" height="312" alt="Composite Provider Sales Item ZV_SDITM4 Data Preview " src="https://github.com/user-attachments/assets/8caac339-fcd1-467f-8333-195c31b077cb" />

---

# Analytics Layer

BW Queries provide reporting metrics.

| Query | Description |
|---|---|
| ZQ_ZV_SDHD6_001 | Sales Header |
| ZQ_ZV_SDITM4 | Sales Item |

---

## BW Query

<img width="1418" height="877" alt="Sales Header BW Query ZQ_ZV_SDHD6_001 Sheet Definition" src="https://github.com/user-attachments/assets/fb1c12bb-c869-409c-824d-dfbedbb9b4e1" />

<img width="1862" height="872" alt="BW Query ZQ_ZV_SDHD6_001 Sales Item - Sales Order Reporting Preview" src="https://github.com/user-attachments/assets/a3c9a9c0-b8ce-471e-a165-6a5bb1a9c7e0" />

---

# SAP Analytics Cloud Integration

Live connection from SAC to BW/4HANA.

Benefits:

- Real-time analytics
- No data replication
- Enterprise security
- Interactive dashboards

<img width="717" height="786" alt="SAC Live Connection Details" src="https://github.com/user-attachments/assets/1671aef7-0ebe-4ca3-aad2-2797055ab475" />

---

## SAC Dashboard
<img width="1410" height="752" alt="Sac" src="https://github.com/user-attachments/assets/77d6e405-0a7c-4570-9323-f2f2fa974d58" />


---

# Process Automation

SAP BW Process Chains automate:

- Delta data loads
- ADSO activation
- Index rebuild
- Query cache refresh
![Screenshot_20260218_180512(1) (1)](https://github.com/user-attachments/assets/10860a29-6bd9-4595-a14c-908bdf7fe100)


---

# Repository Structure

```
sap-bw4hana-hana-sac-enterprise-analytics
│
├── README.md
│
├── docs
│   │
│   ├── 01-project-overview.md
│   ├── 02-business-requirements.md
│   ├── 03-solution-architecture.md
│   ├── 04-data-architecture-lsa.md
│   ├── 05-data-extraction-cds.md
│   ├── 06-data-modeling-bw.md
│   ├── 07-transformations.md
│   ├── 08-semantic-layer.md
│   ├── 09-analytics-layer.md
│   ├── 10-sac-integration.md
│   └── 11-process-automation.md
│
├── src
│   │
│   ├── cds-views
│   │   ├── ZI_SALES_HDR_FULL.sql
│   │   └── ZI_SALES_ITM_DAN.sql
│   │
│   ├── transformations
│   │   ├── amdp-base-unit-conversion.sql
│   │   ├── lookup-country.sql
│   │   └── data-cleansing-routine.abap
│   │
│   └── bw-objects
│       ├── adso-modeling.md
│       ├── composite-provider.md
│       └── bw-queries.md
│
├── images
│   │
│   ├── architecture
│   │   ├── sap_bw4hana_architecture.png
│   │   ├── sale-item-lsa-dataflow.png
│   │   └── sales-header-lsa-part1.png
│   │
│   ├── bw
│   │   ├── adso-staging.png
│   │   ├── adso-reporting.png
│   │   ├── composite-provider.png
│   │   └── composite-provider-preview.png
│   │
│   ├── transformations
│   │   ├── amdp-base-unit.png
│   │   └── lookup-country.png
│   │
│   ├── reporting
│   │   └── bw-query-sales.png
│   │
│   └── sac
│       └── sac-dashboard.png
│
└── diagrams
    └── architecture-diagram.drawio
<img width="402" height="1321" alt="image" src="https://github.com/user-attachments/assets/55a8d243-3421-4fd5-80a3-cd7e9683ee52" />

```

---

# Key Skills Demonstrated

- SAP BW/4HANA Data Modeling
- Enterprise Data Warehouse Architecture
- ABAP CDS Development
- SAP HANA SQLScript & AMDP
- Data Engineering
- SAP Analytics Cloud Integration

---

# Author

**Daniel Mate**

Enterprise SAP Data Engineering Portfolio Project
