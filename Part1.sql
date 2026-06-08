-- Q3: Seller Fulfilment Efficiency
-- Calculate average time in hours between order placement 
-- and delivery for each seller.
-- Return top 20 sellers with fastest average fulfilment times
-- among sellers who have completed at least 20 orders.
-- Include total completed orders and average customer rating.

SELECT 
    s.seller_id,
    s.seller_name,
    COUNT(DISTINCT o.order_id) AS total_completed_orders,
    ROUND(
        AVG(
            (o.delivery_date - o.order_date) * 24.0
        )::NUMERIC, 2
    ) AS avg_fulfilment_hours,
    ROUND(AVG(r.rating)::NUMERIC, 2) AS avg_customer_rating
FROM sellers s
JOIN orders o ON s.seller_id = o.seller_id
LEFT JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'Delivered'
    AND o.delivery_date IS NOT NULL
GROUP BY s.seller_id, s.seller_name
HAVING COUNT(DISTINCT o.order_id) >= 20
ORDER BY avg_fulfilment_hours ASC
LIMIT 20;