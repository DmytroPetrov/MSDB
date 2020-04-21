SET GLOBAL log_bin_trust_function_creators = 1;
SET SQL_SAFE_UPDATES = 0;

select id, password, pass_code from user;
UPDATE user SET pass_code = null ORDER BY id DESC;
ALTER TABLE user MODIFY pass_code blob;

-- function 1
drop function mycms_encode;

CREATE FUNCTION mycms_encode (pass CHAR(48)) 
RETURNS BLOB 
RETURN AES_ENCRYPT(pass, 'key-key');

SELECT 
    CAST(MYCMS_ENCODE(CAST(password AS CHAR (48)))
        AS CHAR) AS blo
FROM
    user;

UPDATE user SET pass_code = mycms_encode(password) ORDER BY id DESC;

-- function 3
drop function fun_1;

create function fun_1(name char(50))
returns char(50) 
return right(name, char_length(name) - position('@' in name));

select fun_1(email), email from user;

-- function 2
drop function mycms_decode;

CREATE FUNCTION mycms_decode (pass BLOB) 
RETURNS CHAR(48) 
RETURN AES_DECRYPT(pass, 'key-key'); 

SELECT 
    MYCMS_DECODE(MYCMS_ENCODE(CAST(password AS CHAR (48)))) AS blo
FROM
    user;
    
SELECT 
    id, password, MYCMS_DECODE(pass_code)
FROM
    user;
    
-- 3 procedure
drop procedure mycms_count;

DELIMITER // 
 
CREATE PROCEDURE mycms_count (IN name CHAR(50), IN date1 DATE, IN date2 DATE) 
BEGIN 
	DECLARE error CHAR(35); 
	SET error = 'Некоректно задані дати'; 
	IF (date1<=date2) THEN 
		BEGIN 
		CREATE TABLE IF NOT EXISTS db_sht.stats (category CHAR(30), amount INT UNSIGNED); 
		TRUNCATE db_sht.stats; 

			INSERT INTO db_sht.stats 
			SELECT group_name AS category, COUNT(db_sht.order.id) AS amount 
			FROM (((db_sht.group INNER JOIN article_group) 
			INNER JOIN goods) 
			INNER JOIN db_sht.order) 
            INNER JOIN db_sht.user ON db_sht.user.email = name 
			AND user.id = db_sht.order.user_id 
			AND db_sht.order.id = goods.order_id
			AND goods.goods_id = article_group.goods_id
            AND article_group.group_id = db_sht.group.id
			WHERE db_sht.order.ordered BETWEEN date1 AND date2 
			GROUP BY category; 

		END; 
	ELSE SELECT error; 
	END IF; 
END// 
DELIMITER ; 

CALL mycms_count('1233@hots.com', '2020-01-01', '2020-05-05'); 
select * from db_sht.order where user_id = 15;
SELECT * FROM stats;
CALL mycms_count('1233@hots.com', '2020-01-01', '2010-05-05'); 