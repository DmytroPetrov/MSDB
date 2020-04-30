SET SQL_SAFE_UPDATES = 0;

-- after update order decrease amount of article  
drop trigger update_order_status;

delimiter //
CREATE 
    TRIGGER  update_order_status
 AFTER UPDATE ON db_sht.order FOR EACH ROW 
    BEGIN -- old
    if (NEW.status = 'accomplished') then
		BEGIN
        set @error = "amount error";
        
         -- set @newArt = (select goods_id from goods where order_id = new.id);
		set @che = (select count(id) from article where id in(select goods_id from goods where order_id = new.id) and amount < 0); 
        
        if (@che < 1) then
			update article set amount = amount -1 where id in(select goods_id from goods where order_id = new.id) and amount > 0;
        end if;
		END;
    END IF;
    END//
delimiter ;

-- DUMP --
start transaction;
set @ord = 12;
-- select * from db_sht.order where id = @ord;
-- select * from goods where goods_id = @ord;
SELECT 
    goods.id as goods, goods_id as article, order_id, article.id as art_id, goods_name, article.amount, o.id as ord, o.status
FROM
    (goods
    INNER JOIN article)
        INNER JOIN
    db_sht.order AS o ON goods.goods_id = article.id
        AND o.id = goods.order_id
WHERE
    order_id = @ord;
-- accomplished
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;
update db_sht.order as o set o.status = 'accomplished' where id = @ord limit 1;

 SELECT 
    goods.id as goods, goods_id as article, order_id, article.id as art_id, goods_name, article.amount, o.id as ord, o.status
FROM
    (goods
    INNER JOIN article)
        INNER JOIN
    db_sht.order AS o ON goods.goods_id = article.id
        AND o.id = goods.order_id
WHERE
    order_id = @ord;

rollback;
-- -----------------------------------------------------------------------------------


-- delete article
drop trigger delete_article;

delimiter //
CREATE 
    TRIGGER  delete_article
 BEFORE DELETE ON article FOR EACH ROW 
    BEGIN
    delete article_group from article_group where goods_id = old.id;
   -- insert into article value (55, 'test', 15, 1, 'beh');
    set @testid = (select id from article where goods_name = 'TEST' limit 1);
    update goods set goods_id = @testid where goods_id = old.id;
    END//
 delimiter ;
 
 -- insert into article value (50, "TEST", 50, 1, "jojo");
 -- DUMP --
START TRANSACTION;
select * from article;
delete article from article where id = 12;
select * from article;
select * from goods;
ROLLBACK; 
-- ----------------------------------------------------------------------------------



-- article grpoups 
insert into db_sht.article_group values (20, 1), (21, 15), (22, 2), (23, 3), (24, 11), (25, 13), (34, 16), (35, 17), (36, 11), (37, 11);

drop trigger delete_group;

CREATE 
    TRIGGER  delete_group
 BEFORE DELETE ON db_sht.group FOR EACH ROW 
    DELETE db_sht . article_group FROM db_sht.article_group WHERE
        group_id = OLD.id;

-- DUMP --
START TRANSACTION;

SELECT * FROM db_sht.group;
SELECT * FROM article_group;
    
DELETE db_sht.group FROM db_sht.group 
WHERE
    id = 18;
    
SELECT * FROM db_sht.group;
SELECT * FROM article_group;  
    
ROLLBACK;


drop trigger update_test;

CREATE 
    TRIGGER  update_test
 after INSERT ON db_sht.test FOR EACH ROW 
    update db_sht.test SET test.text = 'plaa' where test.id = new.id;
    
    insert into test value(default, 'text');
    
    
    select * from test;
    
    drop table test;
    
CREATE TABLE `test` (
	`id` int NOT NULL AUTO_INCREMENT,
	`text` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);
