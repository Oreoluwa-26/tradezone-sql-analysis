-- Q5: Customer Spend Segmentation
-- Segment customers based on total spend in 2024 into:
-- High Spenders: >= 100,000
-- Medium Spenders: 50,000 - 99,999
-- Low Spenders: < 50,000
-- For each group calculate customer count, 
-- average spend and total revenue contribution.

WITH customer_spend AS (
    SELECT 
        c.customer_id,
        SUM(o.total_amount) AS total_spend
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE EXTRACT(YEAR FROM o.order_date) = 2024
        AND o.order_status != 'Cancelled'
        AND o.amount_flagged = FALSE
    GROUP BY c.customer_id
),
segmented AS (
    SELECT 
        customer_id,
        total_spend,
        CASE 
            WHEN total_spend >= 100000 THEN 'High Spender'
            WHEN total_spend >= 50000 THEN 'Medium Spender'
            ELSE 'Low Spender'
        END AS spend_segment
    FROM customer_spend
)
SELECT 
    spend_segment,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(total_spend)::NUMERIC, 2) AS avg_spend_per_customer,
    ROUND(SUM(total_spend)::NUMERIC, 2) AS total_revenue_contribution
FROM segmented
GROUP BY spend_segment
ORDER BY total_revenue_contribution DESC;

High Spenders completely dominate — 551 customers generating ₦696M (99%+ of all revenue!)
Medium Spenders are surprisingly few — only 40 customers in the ₦50k-₦99k range
Low Spenders are also small — 61 customers spending under ₦50k
The average High Spender spends ₦1.26M — that seems very high, worth noting in the memo
This shows TradeZone is heavily dependent on a core group of high-value customers