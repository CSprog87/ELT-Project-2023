WITH RevenuePerState AS (
    SELECT
        C.customer_state,
        SUM(OP.payment_value) AS Revenue
    FROM
        olist_customers C
        JOIN olist_orders O ON C.customer_id = O.customer_id
        JOIN olist_order_payments OP ON O.order_id = OP.order_id
    WHERE
        O.order_status = 'delivered'
        AND O.order_delivered_customer_date IS NOT NULL
    GROUP BY
        C.customer_state
)
SELECT
    customer_state,
    Revenue
FROM
    RevenuePerState
ORDER BY
    Revenue DESC
LIMIT 10;

