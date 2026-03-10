
# Data Modeling in SAP BW/4HANA

Data modeling in BW/4HANA is implemented using a layered approach.

---

## Key Modeling Objects

| Object | Description |
|---|---|
| ADSO | Data persistence layer |
| InfoSource | Harmonization layer |
| Composite Provider | Semantic layer |
| BW Query | Reporting layer |

---

## ADSO Layers

### Staging ADSO

Stores raw transactional data extracted from source systems.

### Reporting ADSO

Stores cleansed and harmonized data optimized for analytics.
