# Data Transformations

## Overview

Transformations are implemented to cleanse, enrich, and standardize incoming data.

---

## Transformation Types

- Field mappings
- Lookup transformations
- Data cleansing routines
- AMDP transformations

---

## AMDP Transformation Example

```sql
METHOD base_unit_conversion
BY DATABASE PROCEDURE
FOR HDB
LANGUAGE SQLSCRIPT.

outtab =
SELECT material,
orderquantity * conversion_factor AS base_quantity
FROM :intab;

ENDMETHOD.
