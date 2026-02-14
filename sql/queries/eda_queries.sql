
-- Orders over Time
monthly_query = """
SELECT
    strftime('%Y-%m', order_purchase_timestamp) as month,
    COUNT(*) as num_orders,
    COUNT(DISTINCT customer_id) as unique_customers
FROM orders
WHERE order_status = 'delivered'
GROUP BY month
ORDER BY month;
"""

-- Day of the Week Patterns
day_of_week_query = """
SELECT 
    CASE CAST(strftime('%w', order_purchase_timestamp) AS INTEGER)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END as day_of_week,
    CAST(strftime('%w', order_purchase_timestamp) AS INTEGER) as day_num,
    COUNT(*) as num_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY day_of_week, day_num
ORDER BY day_num
"""

-- Delivery Metrics from View

delivery_query = """
SELECT 
    actual_delivery_days,
    estimated_delivery_days,
    delivery_delay_days,
    is_delayed,
    review_score
FROM order_analysis
WHERE order_status = 'delivered'
  AND actual_delivery_days IS NOT NULL
  AND review_score IS NOT NULL
"""

-- Geo Query

geo_query = """
SELECT
        customer_state,
        COUNT(*) as num_orders,
        ROUND(AVG(total_order_value), 2) as avg_order_value,
        ROUND(SUM(total_order_value), 2) as total_revenue,
        ROUND(AVG(review_score), 2) as avg_review,
        ROUND(AVG(delivery_delay_days), 2) as avg_delivery_delay,
        ROUND(SUM(is_delayed) * 100.0 / COUNT(*), 2) as delay_rate
FROM order_analysis
WHERE order_status = 'delivered'
    AND customer_state IS NOT NULL
    AND total_order_value IS NOT NULL
GROUP BY customer_state
HAVING num_orders >= 100
ORDER BY num_orders DESC
"""

-- Product Category Query

product_query = """
SELECT
    COALESCE(pct.product_category_name_english, p.product_category_name, 'Unknown') as category,
    COUNT(DISTINCT oi.order_id) as num_orders,
    ROUND(AVG(oi.price), 2) as avg_price,
    ROUND(SUM(oi.price), 2) as total_revenue,
    ROUND(AVG(r.review_score), 2) as avg_review
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
JOIN ORDERS o ON oi.order_id = o.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
HAVING num_orders >= 100
ORDER BY total_revenue DESC
LIMIT 20
"""

-- Order Value Query
value_query = "SELECT " \
"total_order_value, review_score " \
"FROM order_analysis " \
"WHERE total_order_value IS NOT NULL"

