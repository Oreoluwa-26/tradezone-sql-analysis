-- Q6: Payment Method Preferences by State
-- Analyse payment method preferences across each state.
-- For each state show transaction count and total amount 
-- for each payment method.
-- Identify the most popular method per state.

WITH payment_stats AS (
    SELECT 
        c.state,
        p.payment_method,
        COUNT(p.payment_id) AS transaction_count,
        ROUND(SUM(p.amount)::NUMERIC, 2) AS total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY c.state 
            ORDER BY COUNT(p.payment_id) DESC
        ) AS rank
    FROM payments p
    JOIN orders o ON p.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.state, p.payment_method
)
SELECT 
    state,
    payment_method,
    transaction_count,
    total_amount,
    CASE WHEN rank = 1 THEN 'Most Popular' ELSE '' END AS popularity
FROM payment_stats
ORDER BY state, transaction_count DESC;Card payment dominates in FCT, Lagos and Rivers — more digitally advanced states
Cash on Delivery dominates in Kano and Oyo — suggesting lower digital payment adoption in these states
Lagos has the highest transaction volume by far with 371 card transactions alone
Mobile Money is consistently second in almost every state
Bank Transfer is least popular across all states
This is valuable for the business — marketing digital payments in Kano and Oyo could reduce operational costs of cash handling