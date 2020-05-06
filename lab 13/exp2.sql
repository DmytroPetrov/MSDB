explain SELECT  group_name AS category, COUNT(db_sht.order.id) AS amount 
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