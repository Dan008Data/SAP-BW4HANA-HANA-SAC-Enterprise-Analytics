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
