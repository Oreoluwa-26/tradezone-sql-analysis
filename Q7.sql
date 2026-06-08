-- Q7: Review Ratings and Sales Performance
-- Group products based on their average review rating into:
-- High Rated: 4.0 and above
-- Mid Rated: 3.0 - 3.99
-- Low Rated: Below 3.0
-- For each category calculate product count, 
-- total revenue and average unit price.

WITH product_ratings AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        p.unit_price,
        ROUND(AVG(r.rating)::NUMERIC, 2) AS avg_rating,
        SUM(oi.line_total) AS total_revenue
    FROM products p
    LEFT JOIN reviews r ON p.product_id = r.product_id
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    LEFT JOIN orders o ON oi.order_id = o.order_id
    WHERE o.amount_flagged = FALSE
        OR o.amount_flagged IS NULL
    GROUP BY p.product_id, p.product_name, p.category, p.unit_price
),
rated AS (
    SELECT *,
        CASE 
            WHEN avg_rating >= 4.0 THEN 'High Rated'
            WHEN avg_rating >= 3.0 THEN 'Mid Rated'
            WHEN avg_rating < 3.0 THEN 'Low Rated'
            ELSE 'No Rating'
        END AS rating_category
    FROM product_ratings
)
SELECT 
    rating_category,
    COUNT(product_id) AS product_count,
    ROUND(SUM(total_revenue)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(unit_price)::NUMERIC, 2) AS avg_unit_price
FROM rated
GROUP BY rating_category
ORDER BY total_revenue DESC;Surprising finding — Mid Rated products actually generate MORE revenue than High Rated products! ₦1.64B vs ₦1.07B
High Rated products are cheaper on average — ₦45,791 vs ₦64,080 for Mid Rated
Low Rated products still generate ₦305M — meaning customers are buying poorly rated products, possibly due to lack of alternatives
This suggests ratings alone don't drive purchasing decisions on TradeZone — price and availability matter more
Worth flagging in the memo — the platform needs better quality control