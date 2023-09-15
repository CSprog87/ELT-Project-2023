WITH delivered_orders AS (
    SELECT
        T.product_category_name_english AS Category,
        COUNT(DISTINCT OP.order_id) AS Num_order,
        SUM(OP.payment_value) AS Revenue
    FROM
        olist_order_payments OP 
        JOIN olist_order_items OI ON OP.order_id = OI.order_id
        JOIN olist_orders O ON O.order_id = OI.order_id
        JOIN olist_products P ON OI.product_id = P.product_id
        JOIN product_category_name_translation T ON T.product_category_name = P.product_category_name
    WHERE   
        O.order_status = 'delivered'
        AND P.product_category_name IS NOT NULL
        AND O.order_delivered_customer_date IS NOT NULL
    GROUP BY
        Category
)
SELECT
    Category,
    Num_order,
    Revenue
FROM    
    delivered_orders
ORDER BY
    Revenue DESC
LIMIT 10;
