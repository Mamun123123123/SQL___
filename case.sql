SELECT column1,
       CASE
           WHEN condition1 THEN result1
           WHEN condition2 THEN result2
           ELSE result3
       END AS new_column
FROM table_name;
-- example
order_id | customer_name | amount
1        | Mamun         | 100
2        | Rahim         | 150
3        | Karim         | 200

SELECT customer_name, amount,
       CASE
           WHEN amount < 100 THEN 'Low'
           WHEN amount BETWEEN 100 AND 150 THEN 'Medium'
           ELSE 'High'
       END AS order_category
FROM orders;