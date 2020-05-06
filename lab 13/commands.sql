SELECT BENCHMARK (100, (select mycms_encode('hello')));

SELECT BENCHMARK (100, (select AES_ENCRYPT('hello', 'key-key')));

select mycms_encode('hello');
-- замовлення, що були зроблемні не більше місяця тому
EXPLAIN SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = '1233@hots.com'
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE TO_DAYS(CURRENT_DATE) - TO_DAYS(db_sht.order.ordered) <= 31
			GROUP BY category; 

EXPLAIN SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = '1233@hots.com'
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE db_sht.order.ordered >= DATE_SUB(CURRENT_DATE, INTERVAL 31 DAY)
			GROUP BY category; 

EXPLAIN SELECT id 
			FROM db_sht.order
			WHERE db_sht.order.ordered >= DATE_SUB(CURRENT_DATE, INTERVAL 31 DAY);

EXPLAIN SELECT id 
			FROM db_sht.order
			WHERE TO_DAYS(CURRENT_DATE) - TO_DAYS(db_sht.order.ordered) <= 31;

explain select * from user;
explain select id, 
first_name, 
last_name, 
email, 
password, 
registration_date, 
scope,
pass_code 
from user;

-- ANALYZE TABLE 

alter table user drop index user_coupled_index_1;
ALTER TABLE user MODIFY email text;

start transaction;

EXPLAIN SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = '1233@hots.com'
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE TO_DAYS(CURRENT_DATE) - TO_DAYS(db_sht.order.ordered) <= 31
			GROUP BY category; 

EXPLAIN SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = '1233@hots.com'
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE db_sht.order.ordered >= DATE_SUB(CURRENT_DATE, INTERVAL 31 DAY)
			GROUP BY category; 

SHOW INDEX FROM user;
ALTER TABLE user MODIFY email varchar(50);
CREATE UNIQUE INDEX user_coupled_index_1 ON user (id, email);

-- ALTER TABLE order MODIFY email varchar(50);
CREATE UNIQUE INDEX order_index_1 ON db_sht.order (id);
alter table goods drop index goods_index_1;
CREATE UNIQUE INDEX goods_index_1 ON goods (id, order_id);


SHOW INDEX FROM goods;

EXPLAIN SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = '1233@hots.com'
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE TO_DAYS(CURRENT_DATE) - TO_DAYS(db_sht.order.ordered) <= 31
			GROUP BY category; 

EXPLAIN SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = '1233@hots.com'
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE db_sht.order.ordered >= DATE_SUB(CURRENT_DATE, INTERVAL 31 DAY)
			GROUP BY category;

rollback;