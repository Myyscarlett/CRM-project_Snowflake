
CREATE OR REPLACE VIEW CRM_PROJECT.CORE.SALES_WITH_PRODUCT_CITY AS
SELECT
    f.SALE_DATE,
    f.SALE_MONTH,
    f.SALE_QTR,
    f.CUSTOMER_ID,
    f.SALE_AMOUNT,
    p.EnglishProductName,
    p.ProductAlternateKey,
    s.SubcategoryName,
    c.Category,
    c.Parent_Category,
    ct.City,
    ct.Country
FROM CRM_PROJECT.CORE.SALES_ALL f
LEFT JOIN CRM_PROJECT.STG.STG_PRODUCT p 
    ON f.PRODUCT_ID = p.ProductKey
LEFT JOIN CRM_PROJECT.STG.STG_SUBCATEGORY s 
    ON p.ProductSubcategoryKey = s.SubcategoryKey
LEFT JOIN CRM_PROJECT.STG.STG_CATEGORY c 
    ON s.SubcategoryName = c.Category
LEFT JOIN CRM_PROJECT.STG.STG_CITY_COUNTRY ct 
    ON f.CITY_ID = ct.CityID;
