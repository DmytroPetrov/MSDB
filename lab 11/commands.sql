select * from db_sht.group;
select * from db_sht.article;
select id from db_sht.group where group_name = 'Desktop';

SELECT 
    db_sht.group.id, db_sht.group.group_name, article.goods_name, article.id as article
FROM
    (db_sht.group
    INNER JOIN article_group)
        INNER JOIN
    article ON article_group.goods_id = article.id
        AND db_sht.group.id = article_group.group_id; 

-- #1 --
SET autocommit=0;

START TRANSACTION;

insert into db_sht.group values (default, 'Desktop'), (default, 'Laptop');

set @desktop = (select id from db_sht.group where group_name = 'Desktop' limit 1);
set @laptop = (select id from db_sht.group where group_name = 'Laptop' limit 1);

select @desktop, @laptop;

select * from db_sht.group where id in (@desktop, @laptop);

insert into db_sht.article_group values (@laptop, 1), (@laptop, 15), (@desktop, 2), (@desktop, 3), (@desktop, 4), (@desktop, 13), (@desktop, 16), (@desktop, 17);

SELECT 
    db_sht.group.group_name, article.goods_name
FROM
    (db_sht.group
    INNER JOIN article_group)
        INNER JOIN
    article ON article_group.goods_id = article.id
        AND db_sht.group.id = article_group.group_id; 

ROLLBACK;

-- №2 --

START TRANSACTION;

insert into db_sht.group values (default, 'Desktop'), (default, 'Laptop');

set @desktop = (select id from db_sht.group where group_name = 'Desktop' limit 1);
set @laptop = (select id from db_sht.group where group_name = 'Laptop' limit 1);

SELECT @desktop, @laptop;

SELECT 
    *
FROM
    db_sht.group
WHERE
    id IN (@desktop , @laptop);

insert into db_sht.article_group values (@laptop, 1), (@laptop, 15), (@desktop, 2), (@desktop, 3), (@desktop, 11), (@desktop, 13), (@desktop, 16), (@desktop, 17);

SELECT 
    db_sht.group.group_name, article.goods_name
FROM
    (db_sht.group
    INNER JOIN article_group)
        INNER JOIN
    article ON article_group.goods_id = article.id
        AND db_sht.group.id = article_group.group_id; 

COMMIT;


