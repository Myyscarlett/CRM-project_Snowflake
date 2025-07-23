
CREATE OR REPLACE VIEW CRM_PROJECT.CORE.SALES_WITH_CUSTOMER AS
SELECT
  s.*,
  c.gender,
  c.birthdate,
  c.first_purchase_date,
  c.first_purchase_year,
  c.yearly_income,
  c.total_children,
  c.commute_distance,
  c.is_homeowner,
  c.marital_status,
  c.education_level,
  c.occupation
FROM CRM_PROJECT.CORE.SALES_ALL s
LEFT JOIN CRM_PROJECT.STG.STG_CUSTOMER c
  ON s.customer_id = c.customer_id;
