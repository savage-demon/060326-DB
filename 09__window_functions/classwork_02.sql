-- ================== АГРЕГАЦИЯ ДАННЫХ ===================

USE northwind;
SELECT * FROM products;

-- 01 Из таблицы products выведите максимальный list_price для каждой строки, имя продукта и его list_price.

SELECT
    product_name,
    list_price,
    max(list_price) OVER () lp_max
FROM
    products;

-- 02 Используя предыдущий запрос, посчитайте разницу в процентах между ценой продукта и максимальной ценой.

SELECT
    product_name,
    list_price,
    max(list_price) OVER () lp_max,
    round((max(list_price) OVER () - list_price) / list_price * 100, 2) percent_diff,
    round(list_price * 100 / max(list_price) OVER (), 2) percent_diff_rate
FROM
    products;

/* 03 Посчитайте количество продуктов в каждой категории с помощью оконной функции.
Оптимально ли использование оконной функции для выполнения этого задания. */

SELECT
    category,
    count(*) OVER (PARTITION BY category) product_count
FROM
    products;

SELECT
    DISTINCT category,
    count(*) OVER (PARTITION BY category) product_count
FROM
    products;

SELECT
    category,
    count(*) product_count
FROM
    products
GROUP BY category;



-- 04 Найдите разницу между standard_cost продукта и средним list_price по всей таблицы для каждой строки.

SELECT
    product_name,
    list_price,
    standard_cost,
    avg(list_price) OVER () lp_avg,
    abs(standard_cost - avg(list_price) OVER ()) diff
FROM
    products;

-- 05 Можно ли решить предыдущее задание без оконных функций. Каким образом?


SELECT
    product_name,
    list_price,
    standard_cost,
    avg(list_price) OVER () lp_avg,
    abs(standard_cost - avg(list_price) OVER ()) diff,
    abs(standard_cost - (SELECT avg(list_price) FROM products)) diff_subquery
FROM
    products
GROUP BY product_name;


-- ================== ПОДСЧЁТ КУМУЛЯТИВНЫХ ЗНАЧЕНИЙ ===================
SELECT * FROM orders;

/* 01 Рассчитать кумулятивную сумму платы за доставку shipping_fee по всей таблице заказов orders 
с сортировкой по дате заказа order_date. */

SELECT
    *,
    sum(shipping_fee) OVER (
    ORDER BY
        order_date
    ) cum_sum
FROM
    orders;


/* 02 Рассчитать кумулятивную сумму платы за доставку shipping_fee по всей таблице заказов orders
с сортировкой по дате заказа order_date и группировкой по клиентам customer_id. */


SELECT
    *,
    sum(shipping_fee) OVER (
    PARTITION BY customer_id
    ORDER BY
        order_date
    ) cum_sum
FROM
    orders;








--- проверка goup и over
select 
    o.id, 
    max(oi.quantity) OVER () as quantity,
    max(oi.quantity) AS mq,
    oi.quantity,
    count(*) product_count
from orders o
join order_details oi on o.id = oi.order_id
join products p on oi.product_id = p.id
group by o.id
;
