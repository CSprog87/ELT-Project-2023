WITH revenue_data AS (
    SELECT
        STRFTIME('%m', O.order_delivered_customer_date) AS month_no,
        O.order_delivered_customer_date As date_income,
        COALESCE(OP.payment_value, 0.0) AS Revenue
    FROM olist_orders O
    JOIN olist_order_payments OP ON O.order_id = OP.order_id
    WHERE O.order_status = 'delivered' 
        AND O.order_delivered_customer_date IS NOT NULL 
        AND O.order_purchase_timestamp IS NOT NULL
    GROUP BY 
        O.order_id
)
SELECT
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
    SUM(CASE WHEN STRFTIME('%Y', date_income) = '2016' THEN Revenue ELSE 0.0 END) AS Year2016,
    SUM(CASE WHEN STRFTIME('%Y', date_income) = '2017' THEN Revenue ELSE 0.0 END) AS Year2017,
    SUM(CASE WHEN STRFTIME('%Y', date_income) = '2018' THEN Revenue ELSE 0.0 END) AS Year2018
FROM 
    revenue_data
GROUP BY 
    month_no
ORDER BY 
    month_no;