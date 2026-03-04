-- ALL WINDOW FUNCTION DEMO IN ONE QUERY SET

SELECT 
    st_id,
    order_date,
    amount,

    -- 1️⃣ Aggregate Window Functions
    SUM(amount) OVER(PARTITION BY st_id) AS total_amount,
    AVG(amount) OVER(PARTITION BY st_id) AS avg_amount,
    COUNT(*) OVER(PARTITION BY st_id) AS total_orders,
    MIN(amount) OVER(PARTITION BY st_id) AS min_amount,
    MAX(amount) OVER(PARTITION BY st_id) AS max_amount,

    -- 2️⃣ Ranking Functions
    ROW_NUMBER() OVER(PARTITION BY st_id ORDER BY amount DESC) AS row_number_rank,
    RANK() OVER(PARTITION BY st_id ORDER BY amount DESC) AS rank_position,
    DENSE_RANK() OVER(PARTITION BY st_id ORDER BY amount DESC) AS dense_rank_position,
    NTILE(4) OVER(ORDER BY amount DESC) AS quartile_group,

    -- 3️⃣ Value Functions
    LAG(amount) OVER(PARTITION BY st_id ORDER BY order_date) AS prev_amount,
    LEAD(amount) OVER(PARTITION BY st_id ORDER BY order_date) AS next_amount,

    -- 4️⃣ Running Total (Cumulative Sum)
    SUM(amount) OVER(
        PARTITION BY st_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,

    -- 5️⃣ Moving Average (Last 3 orders)
    AVG(amount) OVER(
        PARTITION BY st_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg

FROM orders;

-- MOM %
SELECT *,
       ROUND((amount - prev_amount) / prev_amount * 100, 2) AS mom_percentage
FROM (
    SELECT 
        st_id,
        order_date,
        amount,
        LAG(amount) OVER(PARTITION BY st_id ORDER BY order_date) AS prev_amount
    FROM orders
) t;
-- yoy %
SELECT *,
       ROUND((amount - prev_year_amount) / prev_year_amount * 100, 2) AS yoy_percentage
FROM (
    SELECT 
        st_id,
        order_date,
        amount,
        LAG(amount,12) OVER(PARTITION BY st_id ORDER BY order_date) AS prev_year_amount
    FROM orders
) t;