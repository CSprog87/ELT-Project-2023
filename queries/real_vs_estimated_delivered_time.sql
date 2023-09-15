WITH delivery_data AS (
    SELECT
    	O.order_id,
        STRFTIME('%m', O.order_purchase_timestamp) AS month_no,
        STRFTIME('%Y', O.order_purchase_timestamp) AS year,
        AVG(julianday(O.order_delivered_customer_date) - julianday(O.order_purchase_timestamp)) AS real_delivery_time,
        AVG(julianday(O.order_estimated_delivery_date) - julianday(O.order_purchase_timestamp)) AS estimated_delivery_time
    FROM
        olist_orders O
    WHERE
        O.order_status = 'delivered'
        AND O.order_delivered_customer_date IS NOT NULL
        AND O.order_approved_at IS NOT NULL
        AND O.order_purchase_timestamp  IS NOT NULL        
    GROUP BY
       STRFTIME('%Y-%m', O.order_purchase_timestamp)
)
SELECT DISTINCT 
    month_no,
    CASE
        WHEN month_no = '01' THEN 'Jan'
        WHEN month_no = '02' THEN 'Feb'
        WHEN month_no = '03' THEN 'Mar'
        WHEN month_no = '04' THEN 'Apr'
        WHEN month_no = '05' THEN 'May'
        WHEN month_no = '06' THEN 'Jun'
        WHEN month_no = '07' THEN 'Jul'
        WHEN month_no = '08' THEN 'Aug'
        WHEN month_no = '09' THEN 'Sep'
        WHEN month_no = '10' THEN 'Oct'
        WHEN month_no = '11' THEN 'Nov'
        WHEN month_no = '12' THEN 'Dec'
    END AS month,
    ROUND(AVG(CASE WHEN year = '2016' THEN real_delivery_time ELSE NULL END), 6) AS Year2016_real_time,
    ROUND(AVG(CASE WHEN year = '2017' THEN real_delivery_time ELSE NULL END), 6) AS Year2017_real_time,
    ROUND(AVG(CASE WHEN year = '2018' THEN real_delivery_time ELSE NULL END), 6) AS Year2018_real_time,
    ROUND(AVG(CASE WHEN year = '2016' THEN estimated_delivery_time ELSE NULL END), 6) AS Year2016_estimated_time,
    ROUND(AVG(CASE WHEN year = '2017' THEN estimated_delivery_time ELSE NULL END), 6) AS Year2017_estimated_time,
    ROUND(AVG(CASE WHEN year = '2018' THEN estimated_delivery_time ELSE NULL END), 6) AS Year2018_estimated_time
FROM
    delivery_data, olist_orders O
GROUP BY
    month_no, month
ORDER BY
    month_no;