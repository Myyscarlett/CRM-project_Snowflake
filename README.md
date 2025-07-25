# CRM Sales Analytics in Snowflake & Power BI

A hands-on data warehousing and BI project to demonstrate scalable internal analytics using **Snowflake SQL**. This project replicates a Power BI dashboard pipeline where ETL was originally performed in Power BI. Now, all **ETL logic has been migrated to Snowflake**, separating data preparation from visualization for greater scalability and performance.

---

## Project Architecture & Workflow Overview

This project simulates a production-grade ELT (Extract → Load → Transform) pipeline with a clean **three-layer structure**:

**RAW (upload) → STG (Staging) → CORE (Business Logic) → BI Output (Power BI)**

---

## Folder & Layer Structure

### 📂 RAW

**Input**: Multiple regional CSVs (Canada, France, Germany) containing sales, customer, product, and city data, plus a new table for quarterly business objectives.

---

### 📂 STG (Staging Layer)

**Goal**: Clean and standardize raw inputs into structured relational tables.

**Key Cleaning Tasks:**

- Renamed inconsistent column headers (e.g., `product_id` → `PRODUCT_ID`)
- Casted data types (e.g., `VARCHAR` to `DATE`, `NUMBER`)
- Parsed regional date formats (e.g., `DD/MM/YY`)
- Filtered out null or invalid keys (`WHERE PRODUCTKEY IS NOT NULL`)
- Mapped category hierarchies (subcategory → category → parent category)
- Created calculated columns such as `year`, `quarter`, `year_quarter`
- Added region labels to support consolidated reporting
- Added a staging table for business targets (`STG_OBJECTIVES`), which standardizes columns like `YEAR`, `QUARTER`, `TARGET`, and constructs a `YEAR_QUARTER_COUNTRY` key for joining.

---

### 📂 CORE (Business Logic Layer)

**Goal**: Create analytics-ready, joined tables for business use cases.

**Transformations:**

- Unified regional sales into one fact table
- Joined dimensions like product, customer, geography
- Applied date breakdown (year, quarter, etc.)
- Integrated with business objectives to compare actual vs. target

---

## Business Intelligence Outputs

Although Snowflake’s Worksheet Charts were used for development previews, **all final dashboards will be created in Power BI**. This decouples logic (SQL) from presentation and enables scalability.

---

## Final CORE Views (Fact & Dimensions)

1. ### `CORE.SALES_ALL`
   * Union of Canada, France, and Germany sales.
   * Enriched with region, standardized date, and quarterly info.

2. ### `CORE.SALES_WITH_CUSTOMER`
   * Sales joined with customer demographics.
   * Enables segmentation by income, education, household, etc.

3. ### `CORE.PRODUCT_DIM`
   * Dimension table with product → subcategory → category hierarchy.

4. ### `CORE.SALES_WITH_PRODUCT_CITY`
   * Combines sales with product and city-level attributes.
   * Used for geo-product trend visualizations.

5. ### `CORE.SALES_OBJECTIVE_COMPARISON` 
   * Aggregates total sales by region and year_quarter from the sales fact table.
   * Joins with the OBJECTIVES table to compare actual performance against quarterly targets (min, target, max).
   * Calculates:
     1. Target difference (absolute and percentage) between actual sales and target.
     2. Quarter-over-quarter (QoQ) change in sales (absolute and percentage).
   * Enables performance monitoring, KPI variance tracking, and trend analysis across regions and time.

---

## Summary
  * Snowflake is better suited for complex ETL workflows, scalable storage, and cleanly separating logic into reusable views.

  * Power BI provides stronger visual capabilities and is easier for creating relationships and quick dashboards.

  * This project first built the full ETL and dashboard in Power BI, then migrated the ETL logic to Snowflake to improve scalability and transparency while keeping Power BI focused on the front-end visuals.

  * Together, Snowflake + Power BI delivers a powerful architecture for internal analytics: a cloud-based backend for data engineering and a user-friendly frontend for business insights.

