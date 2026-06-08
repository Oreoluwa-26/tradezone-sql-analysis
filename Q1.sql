-- Q1: Customer Acquisition & 30-Day Conversion
-- Find top 5 states by new customer sign-ups in 2024.
-- Calculate what percentage made at least one purchase 
-- within their first 30 days of signing up.

SELECT 
    c.state,
    COUNT(DISTINCT c.customer_id) AS new_customers,
    COUNT(DISTINCT CASE 
        WHEN o.order_date <= c.signup_date + INTERVAL '30 days' 
        THEN c.customer_id 
    END) AS converted_customers,
    ROUND(
        COUNT(DISTINCT CASE 
            WHEN o.order_date <= c.signup_date + INTERVAL '30 days' 
            THEN c.customer_id 
        END) * 100.0 / COUNT(DISTINCT c.customer_id), 2
    ) AS conversion_rate_pct
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM c.signup_date) = 2024
GROUP BY c.state
ORDER BY new_customers DESC
LIMIT 5;

Lagos dominates new customer acquisition with 146 sign-ups
Lagos also has the best conversion at 49.32% — nearly 1 in 2 new customers buys within 30 days
Kano is the weakest — only 31% of new customers make a purchase within 30 days
Overall, more than half of new customers across all states never buy within their first 30 days — a retention problem worth flagging in the memo