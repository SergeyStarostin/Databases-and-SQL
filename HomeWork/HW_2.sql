-- Урок 2. SQL – создание объектов, простые запросы выборки.

/* 1. Создать таблицу sales с тремя столбцами: id, order_date (дата заказа) и 
count_product (количество продуктов в заказе). Затем заполнить эту таблицу данными, 
включая информацию о дате заказа и количестве продуктов в каждом заказе.
Заполните ее данными.*/

DROP DATABASE IF EXISTS HW_2;
CREATE DATABASE IF NOT EXISTS HW_2;
USE HW_2;

CREATE TABLE IF not exists sales
(id INT primary key auto_increment,
 order_date DATE NOT NULL,
 count_product INT NOT NULL);
 
 INSERT INTO sales (order_date, count_product)
 VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

SELECT * 
FROM sales;

/* 2. Для данных таблицы sales укажите тип заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ,
от 100 до 300 - Средний заказ,
больше 300 - Большой заказ.
Выведите таблицу с названиями столбцов Номер заказа, Количество продукта, Тип */

SELECT 
id AS 'Номер заказа',
count_product AS 'Количество продукта',
IF(count_product < 100, 'Маленький заказ', 
    IF(count_product >=100 AND count_product <=300, 'Средний заказ',
        IF(count_product >300, 'Большой заказ', 'Неопределено'))) AS 'Тип'
FROM sales;

/* 3. Используя операторы языка SQL, создайте таблицу orders, заполните ее значениями.
'e03', '15.00', 'OPEN'
'e01', '25.50', 'OPEN'
'e05', '100.70', 'CLOSED'
'e02', '22.18', 'OPEN'
'e04', '9.50', 'CANCELLED'
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ;
CLOSED - «Order is closed»;
CANCELLED - «Order is cancelled». */

CREATE TABLE if not exists orders
( id INT primary key auto_increment,
 employee_id VARCHAR(10) NOT NULL,
 amount FLOAT NOT NULL,
 order_status VARCHAR(10) NOT NULL);

 INSERT INTO orders (employee_id, amount, order_status)
 VALUES
('s03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');
 
SELECT
id, employee_id, amount,
CASE 
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'OPEN' THEN 'Order is opened'
    ELSE 'Order is canceled'
END AS full_order_status
FROM orders; 

/* 4. Выбрать данные из таблицыorders и вывести столбцы id, employee_id, amount, и order_status 
с дополнительным столбцом full_order_status, который содержит описание статуса заказа на основе 
значения столбца 'order_status'.
OPEN – «Order is in open state» ;
CLOSED - «Order is closed»;
CANCELLED - «Order is cancelled» *в остальных случаях выведите «Not mentioned»*/

SELECT
id, employee_id, amount, order_status,
CASE 
    WHEN order_status = 'OPEN' THEN 'Order is in open state'
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
    ELSE 'Not mentioned'
END AS full_order_status
FROM orders; 
