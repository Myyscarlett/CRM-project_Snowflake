
CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_CANADA AS
SELECT
  cityID           AS city_id,
  productID        AS product_id,
  customerID       AS customer_id,
  DATE             AS sale_date,
  SALE             AS sale_amount,
  YEAR(DATE)       AS sale_year,
  MONTH(DATE)      AS sale_month,
  DAY(DATE)        AS sale_day,
  QUARTER(DATE)    AS sale_qtr,
  CONCAT(YEAR(DATE), '-Q', QUARTER(DATE)) AS year_quarter,
  'Canada'         AS region
FROM CRM_PROJECT.PUBLIC.RAW_CANADA;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_FRANCE AS
SELECT
  cityID                             AS city_id,
  productID                          AS product_id,
  customerID                         AS customer_id,
  TO_DATE(DATE, 'DD/MM/YYYY')        AS sale_date,
  SALE                               AS sale_amount,
  YEAR(TO_DATE(DATE, 'DD/MM/YYYY'))     AS sale_year,
  MONTH(TO_DATE(DATE, 'DD/MM/YYYY'))    AS sale_month,
  DAY(TO_DATE(DATE, 'DD/MM/YYYY'))      AS sale_day,
  QUARTER(TO_DATE(DATE, 'DD/MM/YYYY'))  AS sale_qtr,
  CONCAT(YEAR(TO_DATE(DATE, 'DD/MM/YYYY')), '-Q', QUARTER(TO_DATE(DATE, 'DD/MM/YYYY'))) AS year_quarter,
  'France'                          AS region
FROM CRM_PROJECT.PUBLIC.RAW_FRANCE;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_GERMANY AS
SELECT
  cityID                             AS city_id,
  productID                          AS product_id,
  customerID                         AS customer_id,
  TO_DATE(DATE, 'DD/MM/YYYY')        AS sale_date,
  SALE                               AS sale_amount,
  YEAR(TO_DATE(DATE, 'DD/MM/YYYY'))     AS sale_year,
  MONTH(TO_DATE(DATE, 'DD/MM/YYYY'))    AS sale_month,
  DAY(TO_DATE(DATE, 'DD/MM/YYYY'))      AS sale_day,
  QUARTER(TO_DATE(DATE, 'DD/MM/YYYY'))  AS sale_qtr,
  CONCAT(YEAR(TO_DATE(DATE, 'DD/MM/YYYY')), '-Q', QUARTER(TO_DATE(DATE, 'DD/MM/YYYY'))) AS year_quarter,
  'Germany'                          AS region
FROM CRM_PROJECT.PUBLIC.RAW_GERMANY;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_CUSTOMER AS
SELECT
  CUSTOMERKEY                      AS customer_id,
  GENDER                           AS gender,
  TO_DATE(BIRTHDATE, 'DD/MM/YY') AS birthdate,
  TO_DATE(DATEFIRSTPURCHASE, 'DD/MM/YY') AS first_purchase_date,
  YEAR(TO_DATE(DATEFIRSTPURCHASE, 'DD/MM/YY')) AS first_purchase_year,
  EMAILADDRESS                     AS email,
  YEARLYINCOME                     AS yearly_income,
  TOTALCHILDREN                    AS total_children,
  COMMUTEDISTANCE                  AS commute_distance,
  HOUSEOWNERFLAG                   AS is_homeowner,
  MARITALSTATUS                    AS marital_status,
  ENGLISHEducation                 AS education_level,
  ENGLISHOCCUPATION                AS occupation,
  PHONE                            AS phone
FROM CRM_PROJECT.PUBLIC.RAW_CUSTOMER;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_CATEGORY AS
WITH cleaned AS (
    SELECT
        C1 AS PARENT_RAW,
        C2 AS CATEGORY
    FROM CRM_PROJECT.PUBLIC.RAW_CATEGORY
    WHERE C1 IS NOT NULL AND C1 <> ''
      AND LOWER(C1) <> 'parent'
),
mapped_parent AS (
    SELECT
        CATEGORY,
        CASE 
            WHEN CATEGORY = 'Corporation' THEN 'Other'
            WHEN PARENT_RAW IS NULL OR PARENT_RAW = '' THEN 'Other'
            WHEN LEFT(PARENT_RAW, 4) = 'Corp' THEN 'Corporation'
            WHEN LEFT(PARENT_RAW, 4) = 'Bike' THEN 'Bikes'
            WHEN LEFT(PARENT_RAW, 4) = 'Comp' THEN 'Components'
            WHEN LEFT(PARENT_RAW, 4) = 'Clot' THEN 'Clothing'
            WHEN LEFT(PARENT_RAW, 4) = 'Acce' THEN 'Accessories'
            ELSE 'Other'
        END AS PARENT_CATEGORY
    FROM cleaned
),
with_extra_row AS (
    SELECT * FROM mapped_parent
    UNION ALL
    SELECT 'Corporation' AS CATEGORY, 'Other' AS PARENT_CATEGORY
)
SELECT 
    PARENT_CATEGORY,
    CATEGORY
FROM with_extra_row;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_PRODUCT AS
SELECT
    CAST(ProductSubcategoryKey AS INT) AS ProductSubcategoryKey,
    CAST(ProductKey AS INT) AS ProductKey,
    ProductAlternateKey,
    EnglishProductName
FROM CRM_PROJECT.PUBLIC.RAW_PRODUCT
WHERE ProductKey IS NOT NULL;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_SUBCATEGORY AS
SELECT
    SUBCATEGORYKEY,
    SUBCATEGORYNAME
FROM CRM_PROJECT.PUBLIC.RAW_SUBCATEGORY
WHERE SUBCATEGORYKEY IS NOT NULL;

CREATE OR REPLACE VIEW CRM_PROJECT.STG.STG_CITY_COUNTRY AS
SELECT
    CITYID,
    CITY,
    COUNTRY
FROM CRM_PROJECT.PUBLIC.RAW_CITY_COUNTRY
WHERE CITYID IS NOT NULL;
