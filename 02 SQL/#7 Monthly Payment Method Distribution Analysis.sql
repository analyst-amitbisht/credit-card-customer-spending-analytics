-- How does the spending share of each payment type change from May through October?

SELECT
    month,
    payment_type,
    SUM(spend) AS total_spending,
    ROUND(
        100.0 * SUM(spend)
        / SUM(SUM(spend)) OVER (
            PARTITION BY month
        ),
        2
    ) AS payment_type_share_pct
FROM fact_spends
GROUP BY
    month,
    payment_type
ORDER BY
    month,
    payment_type_share_pct DESC;