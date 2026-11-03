-- Which spending categories contribute the most to each occupation's total spending?

SELECT
    c.occupation,
    s.category,
    SUM(s.spend) AS total_spending,
    ROUND(
        100.0 * SUM(s.spend)
        / SUM(SUM(s.spend)) OVER (
            PARTITION BY c.occupation
        ),
        2
    ) AS category_contribution_pct
FROM fact_spends s
JOIN dim_customers c
    ON s.customer_id = c.customer_id
GROUP BY
    c.occupation,
    s.category
ORDER BY
    c.occupation,
    category_contribution_pct DESC;