# SAP-BW4HANA-HANA-SAC-Enterprise-Analytics

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

![Architecture](images/architecture/sap_bw4hana_architecture.png)

---

## LSA++ Dataflow

![LSA Dataflow](images/architecture/sale-item-lsa-dataflow.png)

![Sales Header Dataflow](images/architecture/sales-header-lsa-part1.png)

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

![ADSO Staging](images/bw/adso-staging.png)

### Reporting ADSO

![ADSO Reporting](images/bw/adso-reporting.png)

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

![AMDP Transformation](images/transformations/amdp-base-unit.png)

![Lookup Transformation](images/transformations/lookup-country.png)

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

![Composite Provider](images/bw/composite-provider.png)

![Composite Provider Preview](images/bw/composite-provider-preview.png)

---

# Analytics Layer

BW Queries provide reporting metrics.

| Query | Description |
|---|---|
| ZQ_ZV_SDHD6_001 | Sales Header |
| ZQ_ZV_SDITM4 | Sales Item |

---

## BW Query

![BW Query](images/reporting/bw-query-sales.png)

---

# SAP Analytics Cloud Integration

Live connection from SAC to BW/4HANA.

Benefits:

- Real-time analytics
- No data replication
- Enterprise security
- Interactive dashboards

---

## SAC Dashboard

![SAC Dashboard](images/sac/sac-dashboard.png)

---

# Process Automation

SAP BW Process Chains automate:

- Delta data loads
- ADSO activation
- Index rebuild
- Query cache refresh

---

# Repository Structure

```
sap-bw4hana-sales-analytics
│
├── README.md
├── docs
├── images
├── src
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
