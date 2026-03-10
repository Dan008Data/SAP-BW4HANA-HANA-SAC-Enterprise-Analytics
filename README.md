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

# CDS View Extraction Objects

| CDS View | Purpose |
|---|---|
| ZI_SALES_HDR_FULL | Sales Header extraction |
| ZI_SALES_ITM_DAN | Sales Item extraction |



