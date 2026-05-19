-- Задания для отработки оконных функций (функции агрегации)
--
-- ER-диаграмма БД цветочного магазина
-- ![блок-схема](./block-shema.jpg)
--
--
--
-- Задача 1:
-- Для каждой позиции заказа выведите:
-- количество товара
-- общее количество всех проданных товаров

select 
	o.*, 
	sum(oi.quantity) as quantity,
	count(*) product_count
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by o.order_id
;


-- Задача 2:
-- Для каждой позиции заказа выведите:
-- количество товара
-- общее количество товаров в этом заказе

-- Повтор


-- Задача 3:
-- Для каждой позиции заказа выведите:
-- количество товара
-- среднее количество товаров в заказах

select 
	o.*, 
	avg(oi.quantity) as quantity,
	count(*) product_count
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by o.order_id
;

-- Задача 4:
-- Для каждой позиции заказа выведите:
-- количество товара
-- максимальное количество товара в любой позиции

select 
	o.*, 
	max(oi.quantity) over () as quantity,
	count(*) product_count
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by o.order_id
;


-- Задача 5:
-- Для каждой позиции заказа выведите:
-- количество товара
-- максимальное количество товара в рамках этого заказа

select 
	o.*, 
	max(oi.quantity) as quantity,
	count(*) product_count
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by o.order_id
;

-- Задача 6:
-- Для каждой позиции заказа выведите:
-- выручку по позиции (quantity * price)
-- общую выручку по всем заказам

select 
	oi.*, 
	oi.quantity * p.price total_price,
	sum(oi.quantity * p.price) over () as total_price_all_orders
from order_items oi
join products p on oi.product_id = p.product_id
;

-- Задача 7:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- общую выручку по этому заказу

select 
	oi.*, 
	oi.quantity * p.price total_price,
	sum(oi.quantity * p.price) over (partition by oi.order_id) as total_price_all_orders
from order_items oi
join products p on oi.product_id = p.product_id
;

-- Задача 8:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- среднюю выручку по всем позициям
-- ;

select 
	oi.*, 
	oi.quantity * p.price total_price,
	avg(oi.quantity * p.price) over () as average_price_all_orders
from order_items oi
join products p on oi.product_id = p.product_id
;


-- Задача 9:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- накопительную выручку по дате заказа

select 
	oi.*, 
	oi.quantity * p.price total_price,
	sum(oi.quantity * p.price) over (partition by o.order_date) as total_price_all_orders
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
;

-- Задание 10:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- накопительную выручку по заказу (по product_id)

select 
	oi.*, 
	oi.quantity * p.price total_price,
	sum(oi.quantity * p.price) over (partition by p.product_id) as total_price_all_orders
from order_items oi
join products p on oi.product_id = p.product_id
;

-- Задание 11:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- долю этой позиции в общей выручке всех заказов

select 
	oi.*, 
	oi.quantity * p.price total_price,
	oi.quantity * p.price total_price * 100 / sum(oi.quantity * p.price) over () as part_of_total_revenue_all_orders,
from order_items oi
join products p on oi.product_id = p.product_id
;


-- Задание 12:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- долю этой позиции в выручке конкретного заказа


-- Задание 13:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- общую выручку заказа
-- среднюю выручку по позициям заказа


-- Задание 14:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- максимальную выручку среди позиций этого заказа
-- минимальную выручку среди позиций этого заказа

-- Задача 15:
-- Для каждой позиции заказа выведите:
-- выручку по позиции
-- накопительную выручку по заказу
-- общую выручку заказа





