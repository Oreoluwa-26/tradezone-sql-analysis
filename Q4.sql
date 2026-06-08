-- Q4: Quarterly Revenue Trends
-- Compare quarterly revenue across 2023 and 2024.
-- For each quarter, calculate total revenue, average order 
-- value and total number of orders.
-- Identify which single quarter showed strongest revenue growth.

WITH quarterly_stats AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(QUARTER FROM order_date) AS quarter,
        SUM(total_amount) AS total_revenue,
        ROUND(AVG(total_amount)::NUMERIC, 2) AS avg_order_value,
        COUNT(order_id) AS total_orders
    FROM orders
    WHERE order_status != 'Cancelled'
        AND amount_flagged = FALSE
        AND EXTRACT(YEAR FROM order_date) IN (2023, 2024)
    GROUP BY year, quarter
),
growth AS (
    SELECT 
        q1.quarter,
        q1.total_revenue AS revenue_2023,
        q2.total_revenue AS revenue_2024,
        ROUND(
            ((q2.total_revenue - q1.total_revenue) / q1.total_revenue * 100)::NUMERIC
        , 2) AS growth_pct
    FROM quarterly_stats q1
    JOIN quarterly_stats q2 
        ON q1.quarter = q2.quarter
        AND q1.year = 2023 
        AND q2.year = 2024
)
SELECT 
    qs.year,
    qs.quarter,
    qs.total_revenue,
    qs.avg_order_value,
    qs.total_orders,
    g.growth_pct
FROM quarterly_stats qs
LEFT JOIN growth g ON qs.quarter = g.quarter
ORDER BY qs.year, qs.quarter;

Q1 had the strongest growth at a massive 1,573% — the platform barely existed in Q1 2023 with only 19 orders, exploding to 283 orders in Q1 2024
Q4 2024 is the biggest revenue quarter at ₦296M with 877 orders
Revenue has been consistently growing every quarter throughout 2024
The platform is clearly scaling rapidly — total 2024 revenue dwarfs 2023