# CRM Analytics in Snowflake

A hands-on data warehousing and BI project to demonstrate scalable internal analytics using Snowflake SQL and built-in visualization tools.

---

## Project Architecture & Workflow Overview

This project simulates a production-grade ELT (Extract → Load → Transform) pipeline with a three-layer structure:

RAW(data upload) → STG (Staging) → CORE (Business Logic) → BI Output

---

## Folder & Layer Logic

### RAW

**Input**: CSV files representing sales, products, customers, and geolocation data from different regional sources.

### STG (Staging Layer)

**Goal**: Standardize and clean the raw data into usable relational formats.

**Cleaning Steps:**

* Renamed inconsistent column headers (e.g., `product_id` → `PRODUCT_ID`)
* Casted data types (e.g., VARCHAR to DATE, NUMBER)
* Filtered out null or invalid keys (e.g., `WHERE PRODUCTKEY IS NOT NULL`)
* Trimmed whitespace, standardized category labels (e.g., proper casing)
* Ensured referential integrity for joins (e.g., cleaned missing foreign key links)

### CORE (Business Logic Layer)

**Goal**: Build domain-specific views for analytics and reporting use.

**Actions:**

* Joined staging tables (e.g., total sales over countries, sales + product + city)
* Created dimension-style views (e.g., product, customer, geography)
* Applied transformations like:
  * Aggregated sales by product, region, or category
  * Grouped by time dimension (year, quarter)
  * Resolved hierarchy (e.g., subcategory → category → parent category)

**Outcome**: Clean, business-consumable views ready for analysis.

---

## Business Intelligence Outputs

Using Snowflake Worksheets Chart View, several queries were written and visualized (But further will be visualized in PowerBI in details)

---

## 📆 Final Core Tables Created

After staging and transformation, the following key **CORE** tables or views are established:

1. **SALES Summary Table**

   * Unified fact table combining all regional sales data.
   * Includes enriched date fields: day, month, quarter, year, and year-quarter.
   *Granular sales transactions with product, customer, and region IDs.

2. **Product Dimension Table**

   * Contains enriched product metadata including name, category, subcategory, and parent category
   * Used for segmentation and category-level reporting

3. **Customer Sales Table**

   * Extended view with customer-level fields.
   * Enables analysis like customer value, repeat purchases, etc.


4. **Product and Region Sales Table**

   * Joined fact with product and city details.
   * Enables analysis like product popularity by city or country.

These CORE tables form the foundation for ad hoc queries and dashboard metrics, allowing teams to answer strategic questions like top product categories, best-performing regions, and customer-level analysis.
