# BW Query Modeling

## Overview

BW Queries provide the **analytics layer** of the SAP BW/4HANA data warehouse.  
They enable business users to analyze data using predefined measures and dimensions.

BW Queries are built on top of **Composite Providers** and serve as the data source for reporting tools such as **SAP Analytics Cloud**.

---

## Queries Implemented

| Query | Description |
|---|---|
| ZQ_ZV_SDHD6_001 | Sales Header analytics |
| ZQ_ZV_SDITM4 | Sales Item analytics |

---

## Query Measures

The queries provide the following metrics:

- Sales Order Quantity
- Sales Order Value
- Number of Sales Orders

---

## Query Dimensions

Key reporting dimensions include:

- Customer
- Material
- Material Group
- Sales Organization
- Distribution Channel
- Fiscal Period

---

## Example Query

The **Sales Item Query** enables analysis of product sales across multiple dimensions.

### BW Query Example

![BW Query](../../images/reporting/bw-query-sales.png)

---

## Query Features

The queries support several analytical features:

- Aggregations
- Drill-down analysis
- Filters and variables
- Time-based analysis

---

## SAP Analytics Cloud Integration

The BW Queries serve as the data source for **SAP Analytics Cloud dashboards**, enabling interactive visualization and advanced analytics.

---

## Benefits

- Self-service analytics
- High-performance reporting
- Real-time business insights
