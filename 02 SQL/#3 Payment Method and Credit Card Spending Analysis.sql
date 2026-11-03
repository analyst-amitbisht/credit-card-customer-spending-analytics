-- How is total spending distributed across Debit Card, Credit Card, UPI, and Net Banking?

SELECT
    payment_type,
    SUM(spend) AS total_spending,
    ROUND(
        100.0 * SUM(spend) /
        (SELECT SUM(spend) FROM fact_spends),
        2
    ) AS spending_share_pct
FROM fact_spends
GROUP BY payment_type
ORDER BY spending_share_pct DESC;

-- Which occupations have the highest credit-card spending share?

SELECT
    c.occupation,
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
GROUP BY c.occupation
ORDER BY credit_card_spending_share_pct DESC;
	   