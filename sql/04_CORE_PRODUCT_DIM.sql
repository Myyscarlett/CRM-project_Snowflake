
CREATE OR REPLACE VIEW CRM_PROJECT.CORE.PRODUCT_DIM AS
SELECT
    p.ProductKey,
    p.ProductAlternateKey,
    p.EnglishProductName AS ProductName,
    s.SubcategoryKey,
    s.SubcategoryName,
    c.CATEGORY AS CategoryName,          
    c.PARENT_CATEGORY AS ParentCategory  
FROM CRM_PROJECT.STG.STG_PRODUCT p
LEFT JOIN CRM_PROJECT.STG.STG_SUBCATEGORY s
    ON p.ProductSubcategoryKey = s.SubcategoryKey
LEFT JOIN CRM_PROJECT.STG.STG_CATEGORY c
    ON s.SubcategoryName = c.CATEGORY;
