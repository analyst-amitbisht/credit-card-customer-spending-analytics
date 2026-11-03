-- How does average monthly spending compare with average monthly income across occupations?

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(spend) / 6.0 AS avg_monthly_spend
    FROM fact_spends
    GROUP BY customer_id
)
SELECT
    c.occupation,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    ROUND(AVG(c.avg_income), 2) AS avg_monthly_income,
    ROUND(AVG(cs.avg_monthly_spend), 2)
        AS avg_monthly_spend_per_customer,
    ROUND(
        100.0 * AVG(cs.avg_monthly_spend)
        / NULLIF(AVG(c.avg_income), 0),
        2
    ) AS spending_to_income_pct
FROM dim_customers c
JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
GROUP BY c.occupation
ORDER BY spending_to_income_pct DESC;