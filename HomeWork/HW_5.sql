/*1. Определить ранг отправителей сообщений на основе количества сообщений, которые они отправили. 
Вывести ранг, имя и фамилию отправителей, а также количество сообщений, которые они отправили. 
Отсортировать результат в порядке убывания количества сообщений.
Для выполнения этой задачи используйте следующие таблицы:
users: Эта таблица содержит информацию о пользователях, включая их идентификаторы (id), имена (firstname), фамилии (lastname) и другие данные.
messages: В этой таблице хранятся записи о сообщениях, включая информацию о идентификаторах сообщений (id), 
отправителях (from_user_id) и другие детали сообщений.
*/

SELECT
  DENSE_RANK() OVER (ORDER BY COUNT(m.id) DESC) AS "rank_cnt",
  CONCAT(firstname, " ", lastname) AS "sender", 
  COUNT(m.id) AS "cnt"
FROM
  users u
LEFT JOIN
  messages m ON u.id = m.from_user_id
GROUP BY
  u.id, u.firstname, u.lastname
ORDER BY
  COUNT(m.id) DESC;

/*2. Составить список сообщений из таблицы messages, включая их уникальные идентификаторы, отправителя (from_user_id), 
получателя (to_user_id), текст сообщения (body), дату создания (created_at), а также информацию о времени, 
прошедшем между этим сообщением и следующим (lead_time и minute_lead_diff) и времени, прошедшем между этим сообщением и 
предыдущим (lag_time и minute_lag_diff). Время указано в минутах.
*/

SELECT
  m.id AS "id",
  m.from_user_id AS "from_user_id",
  m.to_user_id AS "to_user_id",
  m.body AS "body",
  m.created_at AS "created_at",
  LEAD(m.created_at) OVER (ORDER BY m.created_at) AS "lead_time",
  TIMESTAMPDIFF (MINUTE, m.created_at, LEAD(m.created_at) OVER (ORDER BY m.created_at)) AS "minute_lead_diff",
  LAG(m.created_at) OVER (ORDER BY m.created_at) AS "lag_time", 
  TIMESTAMPDIFF (MINUTE, LAG(m.created_at) OVER (ORDER BY m.created_at), m.created_at) AS "minute_lag_diff"
FROM
  messages m
ORDER BY
  m.created_at;
