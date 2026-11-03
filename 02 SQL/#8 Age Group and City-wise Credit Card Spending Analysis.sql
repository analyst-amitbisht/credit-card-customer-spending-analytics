-- credit-card spending by age group and city

SELECT
    c.age_group,
	c.city,
	COUNT(DISTINCT c.customer_id) AS customer_count,
    SUM(s.spend) AS total_spending,
    SUM(
        CASE
            WHEN s.payment_type = 'Credit Card'
            THEN s.spend
            ELSE 0
        END
    ) AS credit_card_spending,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN s.payment_type = 'Credit Card'
                THEN s.spend
                ELSE 0
            END
        ) / NULLIF(SUM(s.spend), 0),
        2
    ) AS credit_card_spending_share_pct
FROM dim_customers c
JOIN fact_spends s
    ON c.customer_id = s.customer_id
GROUP BY c.age_group, c.city
ORDER BY credit_card_spending_share_pct DESC;