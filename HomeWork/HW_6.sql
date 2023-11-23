-- Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы.

/*1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'
*/

DROP FUNCTION IF EXISTS format_seconds;
DELIMITER $$
CREATE FUNCTION format_seconds(num_seconds INT)
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE seconds INT;

    SET days = num_seconds DIV (24 * 60 * 60);
    SET hours = ((num_seconds DIV (60 * 60)) % 24);    
    SET minutes = (num_seconds DIV 60) % 60;
    SET seconds = num_seconds % 60;

    RETURN CONCAT(days, " days ", hours, " hours ", minutes, " minutes ", seconds, " seconds ");
END $$

SELECT format_seconds(123456) AS "пересчет секунд";

/*2. Выведите только четные числа от 1 до 10. 
Пример: 2,4,6,8,10
*/

DROP FUNCTION IF EXISTS get_even_numbers;
DELIMITER //
CREATE FUNCTION get_even_numbers()
RETURNS VARCHAR(50) DETERMINISTIC 
BEGIN
	DECLARE result VARCHAR(50) DEFAULT "";
	DECLARE start_value INT DEFAULT 2;
	DECLARE stop_value INT DEFAULT 10;
    DECLARE n INT DEFAULT 0;
	SET n = IF(start_value % 2 = 0, start_value, start_value + 1);
	IF n <= stop_value THEN 
		REPEAT
			IF LENGTH(result) > 0 THEN
				SET result = CONCAT(result, ", ");
            END IF;
			SET result = CONCAT(result, n);
			SET n = n + 2;
			UNTIL n > stop_value
		END REPEAT;
	END IF;
	RETURN result;
END//

SELECT get_even_numbers() AS "четные числа";
