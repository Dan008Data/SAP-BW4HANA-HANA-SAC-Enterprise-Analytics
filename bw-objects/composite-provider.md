# Composite Provider Modeling

## Overview

Composite Providers serve as the **semantic data layer** in SAP BW/4HANA.  
They combine multiple data sources into a unified logical model for analytical consumption.

Composite Providers allow the system to join data from multiple ADSOs without physically duplicating the data.

---

## Composite Providers Implemented

| Composite Provider | Description |
|---|---|
| ZV_SDHDR6 | Sales Header semantic model |
| ZV_SDITM4 | Sales Item semantic model |

---

## Data Sources

Composite Providers combine data from:

- Reporting ADSOs
- Master data tables
- Historical datasets
- Forecast datasets

---

## Example Composite Provider

The **Sales Item Composite Provider (ZV_SDITM4)** integrates:

- Sales transactional data
- Product attributes
- Customer attributes
- Historical sales data

### Composite Provider Model

![Composite Provider](../../images/bw/composite-provider.png)

---

## Data Preview

Composite Providers allow users to preview integrated data.

![Composite Provider Preview](../../images/bw/composite-provider-preview.png)

---

## Benefits of Composite Providers

- Virtual data modeling
- No physical data duplication
- Flexible semantic modeling
- Faster data integration

---

## Modeling Approach

The modeling strategy follows these principles:

- Keep persistence layers simple
- Build complex logic in the semantic layer
- Support multiple analytical use cases
