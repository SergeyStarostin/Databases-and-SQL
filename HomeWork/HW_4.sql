/* 1. Подсчитать общее количество лайков, поставленных пользователями, чей возраст меньше 12 лет к текущей дате. 
Для этого объединить таблицы likes, media, и profiles, и учесть только лайки, оставленные пользователями, 
возраст которых составляет менее 12 лет с момента их дня рождения.
*/
SELECT COUNT(*) 
FROM profiles p 
INNER JOIN media m ON m.user_id=p.user_id
INNER JOIN likes l ON l.user_id=p.user_id
WHERE DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), birthday)), '%Y')<12;

----------------------------

SELECT COUNT(*) -- количество лайков
FROM likes l
JOIN media m ON l.media_id = m.id
JOIN profiles p ON p.user_id = m.user_id
WHERE  TIMESTAMPDIFF(YEAR,p.birthday,NOW())<12;

/*2. Подсчитать количество лайков, оставленных пользователями, в зависимости от их гендера. 
Для этого объединить таблицы likes и profiles, сгруппировать данные по полу пользователей и 
вывести результат в убывающем порядке, начиная с наибольшего количества лайков.
*/

SELECT COUNT(likes.id) AS cnt, profiles.gender
FROM likes
JOIN profiles ON likes.user_id = profiles.user_id
GROUP BY profiles.gender
ORDER BY cnt DESC;

/*3. Выбрать пользователей из таблицы users, которые не отправили ни одного сообщения 
(не имеют записей в таблице 'messages').
*/

SELECT u.id, 
CONCAT(firstname, ' ', lastname) AS user
FROM users u
LEFT JOIN messages m ON u.id = m.from_user_id
WHERE m.id IS NULL;

/*4. У вас есть база данных с тремя таблицами: users (пользователи),messages (сообщения) и 
friend_requests (запросы на добавление в друзья).
Каждая запись в таблице usersсодержит информацию о пользователе, включая уникальный идентификатор (id), 
имя (firstname), и фамилию (lastname).
Таблица friend_requests содержит информацию о запросах на добавление в друзья с полями: 
уникальный идентификатор (id), идентификатор инициатора запроса (initiator_user_id), 
идентификатор целевого пользователя (target_user_id) и статус запроса (status), 
где 'approved' указывает на утвержденные запросы.
Таблица messages содержит информацию о сообщениях с полями: уникальный идентификатор (id), 
идентификатор отправителя (from_user_id), идентификатор получателя (to_user_id) и текст сообщения (message_text).
Ваша задача состоит в том, чтобы написать SQL-запрос, который вернет идентификатор и имя отправителя, 
который отправил наибольшее количество сообщений пользователю с идентификатором 1, при условии, 
что запросы на добавление в друзья между отправителем и получателем сообщений имеют статус 'approved'.
Также, учтите, что некоторые пользователи могут быть отправителями сообщений, 
но не обязательно быть друзьями (не иметь утвержденных запросов на добавление в друзья).
*/

SELECT u.id AS from_user_id,
CONCAT (u.firstname,' ', u.lastname) AS 'От кого', 
COUNT(*) AS cnt
FROM users u
INNER JOIN friend_requests fr
ON u.id = fr.initiator_user_id
INNER JOIN messages msg
ON u.id = msg.from_user_id
WHERE fr.status = 'approved' 
AND msg.to_user_id = 1
GROUP BY u.id, CONCAT (u.firstname, ' ', u.lastname);

------------------------------------

SELECT  
 m.from_user_id, 
 CONCAT(u.firstname, ' ', u.lastname)  AS 'От кого',  
 COUNT(*) AS cnt  
FROM messages m  
JOIN users u ON u.id=m.from_user_id 
JOIN friend_requests fr ON (fr.initiator_user_id=m.to_user_id AND fr.target_user_id=m.from_user_id) 
                            OR (fr.target_user_id =m.to_user_id AND fr.initiator_user_id=m.from_user_id) 
WHERE fr.status='approved' AND m.to_user_id=1 
GROUP BY m.from_user_id 
ORDER BY cnt DESC 
LIMIT 1;
