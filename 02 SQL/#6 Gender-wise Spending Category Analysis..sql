-- Do male and female customers allocate their spending differently across categories?

SELECT
    c.gender,
    s.category,
    SUM(s.spend) AS total_spending,
    ROUND(
        100.0 * SUM(s.spend)
        / SUM(SUM(s.spend)) OVER (
            PARTITION BY c.gender
        ),
        2
    ) AS category_contribution_pct
FROM fact_spends s
JOIN dim_customers c
    ON s.customer_id = c.customer_id
GROUP BY
    c.gender,
    s.category
ORDER BY
    c.gender,
    category_contribution_pct DESC;