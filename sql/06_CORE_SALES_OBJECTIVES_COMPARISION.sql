
CREATE OR REPLACE VIEW CRM_PROJECT.CORE.SALES_OBJECTIVE_COMPARISON AS
WITH aggregated_sales AS (
    SELECT
        region,
        year_quarter,
        SUM(sale_amount) AS total_sales
    FROM CRM_PROJECT.CORE.SALES_ALL
    GROUP BY region, year_quarter
),
sales_with_objective AS (
    SELECT
        s.region,
        s.year_quarter,
        s.total_sales,
        o.target,
        o.min_target,
        o.max_target,
        (s.total_sales - o.target) AS diff_from_target,
        ROUND((s.total_sales - o.target) / o.target, 4) AS pct_from_target
    FROM aggregated_sales s
    LEFT JOIN CRM_PROJECT.STG.STG_OBJECTIVES o
        ON s.region = o.country AND s.year_quarter = o.year_quarter
),
final_with_lag AS (
    SELECT *,
        LAG(total_sales) OVER (PARTITION BY region ORDER BY year_quarter) AS prev_quarter_sales
    FROM sales_with_objective
)
SELECT *,
       (total_sales - prev_quarter_sales) AS sales_diff_qtr,
       ROUND((total_sales - prev_quarter_sales) / NULLIF(prev_quarter_sales, 0), 4) AS sales_pct_qtr
FROM final_with_lag;
