USE northwind;
SELECT * FROM purchase_order_details;

-- 01 Для каждого заказа purchase_order_id выведите минимальный, максимальный и средний unit_cost.

SELECT 
	purchase_order_id, 
	unit_cost , 
	MIN(unit_cost) OVER(PARTITION BY purchase_order_id) AS min_uc,
	MAX(unit_cost) OVER(PARTITION BY purchase_order_id) AS max_uc,
	AVG(unit_cost) OVER(PARTITION BY purchase_order_id) AS avg_uc
FROM purchase_order_details;

-- 02 ставьте только уникальные строки из предыдущего запроса.

SELECT DISTINCT
	purchase_order_id, 
	unit_cost , 
	MIN(unit_cost) OVER(PARTITION BY purchase_order_id) AS min_uc,
	MAX(unit_cost) OVER(PARTITION BY purchase_order_id) AS max_uc,
	AVG(unit_cost) OVER(PARTITION BY purchase_order_id) AS avg_uc
FROM purchase_order_details;
    
/* 03 Посчитайте стоимость продукта в заказе как quantity * unit_cost.
Выведите суммарную стоимость продуктов с помощью оконной функции
для каждого purchase_order_id.
Сделайте то же самое с помощью GROUP BY. */
-- OVER (с повторами номеров заказа)

SELECT
    purchase_order_id, 
    sum(quantity * unit_cost) OVER(PARTITION BY purchase_order_id) AS sum_price
FROM purchase_order_details;
    
-- OVER (без повторов номеров заказа)

SELECT DISTINCT
    purchase_order_id, 
    sum(quantity * unit_cost) OVER(PARTITION BY purchase_order_id) AS sum_price
FROM purchase_order_details;

-- GROUP BY

SELECT
    purchase_order_id, 
    sum(quantity * unit_cost) sum_price
FROM purchase_order_details
GROUP BY purchase_order_id


/* 04 Посчитайте количество заказов по дате получения и posted_to_inventory.
Если оно превышает 1 то выведите '>1' в противном случае '=1'.
Выведите posted_to_inventory, date_received и вычисленный столбец. */

SELECT
    date_received,
    posted_to_inventory,
    IF (
        count(DISTINCT purchase_order_id) > 1,
        '>1',
        '=1'
    ) res,
    count(DISTINCT purchase_order_id) cnt
FROM
    purchase_order_details
GROUP BY
    date_received,
    posted_to_inventory;


