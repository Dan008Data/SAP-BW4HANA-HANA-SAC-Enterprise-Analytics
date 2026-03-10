# Data Extraction using CDS Views

## Overview

The project uses **ABAP Core Data Services (CDS)** views to extract data from SAP S/4HANA.

CDS-based extraction provides:

- High-performance queries
- Delta-enabled extraction
- Pushdown processing on SAP HANA

---

## CDS View Example

```sql
@AbapCatalog.sqlViewName: 'ZV_SALES_HDR'
@Analytics.dataCategory: #FACT

define view ZI_SALES_HDR_FULL
as select from vbak
{
 key vbeln as SalesDocument,
 erdat as CreatedDate,
 kunnr as Customer,
 vkorg as SalesOrganization,
 vtweg as DistributionChannel
}
