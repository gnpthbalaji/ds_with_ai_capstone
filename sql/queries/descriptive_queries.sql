-- Monthly Metrics

growth_query = """
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(*) AS num_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(AVG(total_order_value), 2) AS avg_order_value,
    ROUND(SUM(total_order_value), 2) AS total_revenue,
    ROUND(AVG(review_score), 2) AS avg_review,
    ROUND(AVG(delivery_delay_days), 2) AS avg_delay_days,
    ROUND(SUM(is_delayed) * 100.0 / COUNT(*), 2) AS delay_rate
FROM order_analysis
WHERE order_status = 'delivered'
GROUP BY month
ORDER BY month;
"""

-- Peak Month Query
peak_months_query = """
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) as month,
    COALESCE(pct.product_category_name_english, p.product_category_name, 'Unknown') as category,
    c.customer_state,
    COUNT(DISTINCT o.order_id) as num_orders,
    COUNT(oi.order_item_id) as num_items,
    ROUND(SUM(oi.price), 2) as total_revenue,
    ROUND(AVG(oi.price), 2) as avg_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation pct 
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
  AND strftime('%Y-%m', o.order_purchase_timestamp) IN ('2017-11', '2018-01', '2018-03')
GROUP BY month, category, c.customer_state
ORDER BY month, num_orders DESC
"""

-- Average Month Query

avg_month_query = """
SELECT 
    ROUND(AVG(monthly_orders), 2) as avg_monthly_orders,
    ROUND(AVG(monthly_revenue), 2) as avg_monthly_revenue
FROM (
    SELECT 
        strftime('%Y-%m', order_purchase_timestamp) as month,
        COUNT(*) as monthly_orders,
        SUM(total_order_value) as monthly_revenue
    FROM order_analysis
    WHERE order_status = 'delivered'
    GROUP BY month
)
"""

-- Order Value Segmentation

value_query = """
SELECT
    total_order_value,
    review_score,
    is_delayed,
    delivery_delay_days,
    actual_delivery_days,
    customer_state,
    num_items
FROM order_analysis
WHERE order_status = 'delivered'
    AND total_order_value IS NOT NULL
    AND review_score IS NOT NULL
"""

-- Category Query

cat_query = """
SELECT 
    COALESCE(pct.product_category_name_english, p.product_category_name, 'Unknown') as category,
    COUNT(DISTINCT oi.order_id) as num_orders,
    COUNT(*) as num_items,
    ROUND(AVG(oi.price), 2) as avg_price,
    ROUND(SUM(oi.price), 2) as total_revenue,
    ROUND(AVG(r.review_score), 2) as avg_review_score,
    ROUND(AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date)), 2) as avg_delay,
    ROUND(SUM(CASE WHEN JULIANDAY(o.order_delivered_customer_date) > JULIANDAY(o.order_estimated_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as delay_rate
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY category
HAVING num_orders >= 100
ORDER BY total_revenue DESC
LIMIT 20
"""

-- Geo Concentration Query

state_query = """
SELECT 
    customer_state,
    COUNT(*) as num_orders,
    COUNT(DISTINCT customer_id) as unique_customers,
    ROUND(AVG(total_order_value), 2) as avg_order_value,
    ROUND(SUM(total_order_value), 2) as total_revenue,
    ROUND(AVG(review_score), 2) as avg_review_score,
    ROUND(AVG(actual_delivery_days), 2) as avg_delivery_days,
    ROUND(AVG(delivery_delay_days), 2) as avg_delay_days,
    ROUND(SUM(is_delayed) * 100.0 / COUNT(*), 2) as delay_rate
FROM order_analysis
WHERE order_status = 'delivered'
  AND customer_state IS NOT NULL
GROUP BY customer_state
HAVING num_orders >= 50
ORDER BY num_orders DESC
"""

-- Delay Impact Query
delay_impact_query = """
SELECT 
    delivery_delay_days,
    review_score,
    total_order_value,
    customer_state
FROM order_analysis
WHERE order_status = 'delivered'
  AND delivery_delay_days IS NOT NULL
  AND review_score IS NOT NULL
  AND delivery_delay_days BETWEEN -30 AND 60
"""

-- Customer Behavior Query

customer_behavior_query = """
SELECT 
    c.customer_unique_id,
    o.order_id,
    o.order_purchase_timestamp,
    oa.delivery_delay_days,
    oa.review_score,
    oa.total_order_value,
    CASE WHEN oa.delivery_delay_days > 0 THEN 1 ELSE 0 END as is_delayed
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_analysis oa ON o.order_id = oa.order_id
WHERE o.order_status = 'delivered'
  AND oa.delivery_delay_days IS NOT NULL
  AND oa.review_score IS NOT NULL
  AND oa.total_order_value IS NOT NULL
ORDER BY c.customer_unique_id, o.order_purchase_timestamp
"""