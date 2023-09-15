WITH DeliveryTimes AS (
    SELECT
        C.customer_state AS State,
        ROUND(AVG(julianday(O.order_estimated_delivery_date) - 
        julianday(STRFTIME('%Y-%m-%d',O.order_delivered_customer_date))),1) AS Delivery_Difference
    FROM
        olist_orders O
        JOIN olist_customers C ON O.customer_id = C.customer_id
    WHERE
        O.order_status = 'delivered'
        AND O.order_delivered_customer_date IS NOT NULL
    GROUP BY
        State
)
SELECT
    State,
    CAST(Delivery_Difference AS INTEGER) AS Delivery_Difference
FROM
    DeliveryTimes
ORDER BY 
    Delivery_Difference;



