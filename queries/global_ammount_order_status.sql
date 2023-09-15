SELECT
    O.order_status,
    COUNT(*) AS Ammount
FROM
    olist_orders O
GROUP BY
    O.order_status;

