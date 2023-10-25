-- Урок 1. Установка СУБД, подключение к БД, просмотр и создание таблиц

 /* Задача 1.
 Создайте таблицу с мобильными телефонами mobile_phones, используя графический интерфейс. Заполните БД данными.
    'iPhone X', 'Apple', 3, 76000
    'iPhone 8', 'Apple', 2, 51000
    'Galaxy S9', 'Samsung', 2, 56000
    'Galaxy S8', 'Samsung', 1, 41000
    'P20 Pro', 'Huawei', 5, 36000 */

DROP TABLE IF EXISTS mobile_phones;
CREATE TABLE mobile_phones(
    Id SERIAL PRIMARY KEY,
    product_name VARCHAR(45) NOT NULL,
    manufacturer VARCHAR(45) NOT NULL,
    product_count INT,
    price INT NULL);
INSERT INTO mobile_phones(product_name, manufacturer, product_count, price)
VALUES 
  ('iPhone X', 'Apple', 3, 76000),
  ('iPhone 8', 'Apple', 2, 51000),
  ('Galaxy S9', 'Samsung', 2, 56000),
  ('Galaxy S8', 'Samsung', 1, 41000),
  ('P20 Pro', 'Huawei', 5, 36000);
SELECT * FROM mobile_phones;

/* Задача 2.
 У вас есть таблица с мобильными телефонами mobile_phones.
 Вывести название (product_name), производителя (manufacturer) и 
 цену (price) для товаров из базы данных, у которых количество (product_count) больше чем 2. */

SELECT product_name, manufacturer, price
FROM mobile_phones
WHERE product_count > 2;

/* Задача 3.
 Выведите весь ассортимент товаров марки Samsung из таблицы mobile_phones, и вывести поля id, 
 product_name, manufacturer, product_count и price для этих записей. */

SELECT *
FROM mobile_phones
WHERE manufacturer LIKE '%Samsung%';

/* Задача 4*.
 Выбрать все товары из таблицы mobile_phones, в которых есть упоминание "Iphone" (независимо от регистра букв), 
 и вывести поля id, product_name, manufacturer, product_count и price для этих записей. */

SELECT *
FROM mobile_phones
WHERE product_name LIKE '%Iphone%';

/* Задача 5*.
 Выбрать все товары из таблицы mobile_phones, в которых есть упоминание "Samsung" (независимо от регистра букв), 
 и вывести поля id, product_name, manufacturer, product_count и price для этих записей. */

SELECT *
FROM mobile_phones
WHERE manufacturer LIKE '%Samsung%';

/* Задача 6*.
 Выбрать все записи из таблицы mobile_phones, где в поле product_name есть хотя бы одна цифра, и вывести поля id, 
 product_name, manufacturer, product_count и price для этих записей. */

SELECT *
FROM mobile_phones
WHERE product_name REGEXP '[0-9]+';

/* Задача7*.
 Выбрать все записи из таблицы mobile_phones, в которых поле product_name содержит цифру 8, и вывести поля id, 
 product_name, manufacturer, product_count и price для этих записей. */

SELECT *
FROM mobile_phones
WHERE product_name LIKE '%8%';