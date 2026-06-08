-- Q8: Top Seller Bonus Qualification
-- Identify top 10 sellers in 2024 by total revenue who:
-- Completed at least 10 orders AND
-- Have an average customer rating of 4.0 or above.
-- Include total orders, average rating and total revenue.

SELECT 
    s.seller_id,
    s.seller_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.rating)::NUMERIC, 2) AS avg_rating,
    ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue
FROM sellers s
JOIN orders o ON s.seller_id = o.seller_id
JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN reviews r ON o.order_id = r.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2024
    AND o.order_status != 'Cancelled'
    AND o.amount_flagged = FALSE
GROUP BY s.seller_id, s.seller_name
HAVING COUNT(DISTINCT o.order_id) >= 10
    AND ROUND(AVG(r.rating)::NUMERIC, 2) >= 4.0
ORDER BY total_revenue DESC
LIMIT 10;StyleKraft NG is the clear winner — highest revenue AND highest rating
All 10 sellers maintain 4.0+ ratings while handling 20+ orders — genuinely high quality
Beauty and fitness sellers dominate the bonus list — interesting given Electronics dominated Q2
These are the sellers TradeZone should spotlight and learn from