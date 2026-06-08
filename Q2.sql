-- Q2: Product Performance
-- Identify the top 10 products by total revenue in 2024.
-- Include product name, category, total revenue and 
-- total number of orders. Sort by revenue descending.

SELECT 
    p.product_name,
    p.category,
    SUM(oi.line_total) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2024
    AND o.amount_flagged = FALSE
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;
All top 10 products are Electronics 
This means Electronics is completely dominating revenue
Other categories like Fashion, Food & Beverages are not represented at all in the top 10
This could explain why "certain product categories are underperforming" as mentioned in the business scenario