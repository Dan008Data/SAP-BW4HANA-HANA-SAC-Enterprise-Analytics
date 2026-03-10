# ADSO Data Modeling

## Overview

Advanced DataStore Objects (ADSOs) are the primary persistence layer in SAP BW/4HANA.  
They store transactional data extracted from SAP S/4HANA and enable structured data processing across multiple layers of the data warehouse.

This project implements ADSOs following the **LSA++ layered architecture** to ensure scalability, data integrity, and high-performance reporting.

---

## ADSO Layers

The project uses two main ADSO layers:

| ADSO | Layer | Purpose |
|-----|------|---------|
| ZS_SDITM4 | Staging | Stores raw extracted sales item data |
| ZD_SDITM4 | Reporting | Stores cleansed and harmonized data for analytics |
| ZS_SDHDR5 | Staging | Stores raw sales header data |
| ZD_SDHDR6 | Reporting | Stores reporting-ready sales header data |

---

## Staging ADSO

The **staging ADSO** stores raw transactional data extracted from SAP S/4HANA.

Characteristics:

- Contains raw transactional data
- Used for data harmonization
- Supports delta data loads
- Temporary persistence layer before transformation

### Example Staging ADSO

![Staging ADSO](../../images/bw/adso-staging.png)

---

## Reporting ADSO

The **reporting ADSO** stores cleansed and structured data optimized for analytics.

Characteristics:

- Contains harmonized data
- Supports analytical reporting
- Optimized for query performance

### Example Reporting ADSO

![Reporting ADSO](../../images/bw/adso-reporting.png)

---

## ADSO Modeling Principles

The modeling approach follows SAP best practices:

- Separate staging and reporting layers
- Maintain clear data lineage
- Use ADSO change logs for delta processing
- Optimize structures for analytical queries

---

## Benefits

- Improved query performance
- Scalable enterprise architecture
- Simplified data governance
- Clear data transformation pipeline
