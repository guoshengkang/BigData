★★★★★★【创建表】★★★★★★
--serial为设置为自增的字段
create table ios_sale_up_to_new
( 
record_id		serial PRIMARY KEY,
store_id		INT	NOT NULL,
warehouse_id	INT NOT NULL,
product_id		INT NOT NULL,
skc_id			INT,
sku_id			INT,
book_date		DATE NOT NULL,
first_quanttiy	FLOAT,
status			INT NOT NULL,
gen_time 		DATE DEFAULT (now())
); 

--设置多个字段为主键
create table ios_product_feature_value
( 
warehouse_id	INT,
id				INT,
book_date 		DATE,
feature_name	varchar,
feature_type	INT DEFAULT 0,
feature_value	FLOAT,
PRIMARY KEY (warehouse_id,id,sale_date,feature_name,feature_type)
); 

create table ios_product_feature
( 
feature_name	varchar,
feature_type	INT DEFAULT 0,
description		varchar,
PRIMARY KEY (feature_name)
); 

★★★★★★【更新表】★★★★★★
(1) 根据where语句查询待更新的数据记录
UPDATE ios_base_work_calendar t1
set is_holiday=0
WHERE holiday_type=0
(2) 从其它表中查询待更新的数据记录及字段值
-- example 1
UPDATE ios_base_work_calendar t1
set holiday_type=t2.holiday
FROM config_date_holiday_season_weekend t2
WHERE t1.work_day=date(t2.date);
-- example 2
UPDATE ios_base_product t1
SET tag_price12=t2.tag_price12
FROM
	(SELECT
	DISTINCT
	条码 AS bar_code,
	配送价 AS tag_price12
	FROM tmp_product
	WHERE 配送价 is NOT NULL
	) t2
WHERE t1.bar_code=t2.bar_code;
(3) 用表中其它字段数据类更新
UPDATE ios_sale_order_line 
SET amount=sale_price*quantity

★★★★★★【插入数据】★★★★★★
--注意插入的字段和输出字段数目要一致
(1)
INSERT INTO ios_sale_up_to_new(store_id,warehouse_id,product_id,skc_id,sku_id,book_date,first_quanttiy,status,gen_time)
SELECT
t1.store_id,
1 AS warehouse_id,
t2.product_id,
t2.skc_id,
t2.sku_id,
min(t1.sale_date) AS book_date,
1 AS first_quanttiy,
1 AS status,
NOW() AS gen_time
FROM ios_sale_order t1
INNER JOIN ios_sale_order_line t2
ON t1.order_id=t2.order_id
WHERE t1.store_id=1
GROUP BY t1.store_id,t2.product_id, t2.skc_id,t2.sku_id
(2)
INSERT INTO "public"."ios_base_organization" ("organization_id", "industry_id", "name", "logo_icon", "gen_time", "status") 
VALUES 
('1', '1', 'KK馆1', '1', '2018-05-07 12:00:00', '1'),
('2', '2', 'KK馆2', '2', '2018-05-07 12:00:00', '2');

★★★★★★【删除数据】★★★★★★
DELETE from ios_sale_order_line
WHERE order_id in
(SELECT t2.order_id
FROM tmp_order_line_sunshine t1
INNER JOIN ios_sale_order t2
On t1."单据编号"=t2.order_code);

★★★★★★【字段类型转换】★★★★★★
(1) varchar to date: DATE(t1.date) AS work_day, CAST(销售日期 AS date)
(2) 转成字符串类型: CAST(tiaoma AS VARCHAR), CAST(lingshoujia AS FLOAT), 
CAST(t2.skc_id AS INT), CAST(t2.week_num AS INTEGER)
(3) 获取当前时间戳: NOW() AS gen_time
(4) 获取当天日期
SELECT CURRENT_DATE AS today,CAST(CURRENT_DATE AS TIMESTAMP) As gen_time
(5) 字段连接: CONCAT(parent_id,'_',category_id)
(6) 多个字段连接: concat_ws('_',t1.classfication_level,t3."name",t2."name")
(7) 保留小数位数: round(CAST("金额"/"数量" AS numeric ),1)

★★★★★★【字段信息提取】★★★★★★
(1) 从date类型中获取月份: EXTRACT(MONTH from t1.work_day)
(2) 从date类型中获取年份: CONCAT(EXTRACT(YEAR from t1."date"),'-',EXTRACT(MONTH from t1."date"))=t4.promotion_date
(3) 从date类型中获取一年中的第几个星期: EXTRACT(WEEK FROM sale_date)
date	week_num
2017-01-01	52
2017-01-02	1
2017-01-03	1
2017-01-04	1
2017-01-05	1
2017-01-06	1
2017-01-07	1
2017-01-08	1
2017-01-09	2
2017-01-10	2
2017-01-11	2
2017-01-12	2
2017-01-13	2
2017-01-14	2
2017-01-15	2
2017-01-16	3
2017-01-17	3

★★★★★★【根据查询结果生成新表】★★★★★★
SELECT
t1.id,count(1) AS days into tmp_kgs_selected_class6_skus
FROM tmp_kgs_all_data t1
INNER JOIN 
	(SELECT
	product_id
	FROM ios_optimization_classificaition
	WHERE warehouse_id=1
	AND classfication_level=6
	) t2
ON t1."id"=t2.product_id
WHERE t1."date">='2018-01-01'
GROUP BY t1.id HAVING count(1)>=85

★★★★★★【函数调用】★★★★★★
(1) row_number
row_number() over(partition by classfication_level ORDER BY days DESC) AS rank
(2)GROUP BY ** having **
SELECT id,count(1) days into tmp_kgs_selected_id_50days
FROM tmp_kgs_all_data
WHERE date>='2018-01-01'
GROUP BY id having count(1)>=50;
(3) random,UNION去重,UNION ALL不去重
SELECT
id,std,rank,class into tmp_kgs_seleted_id_final
FROM
	(
		(SELECT
		id,std,rank,1 AS class
		FROM tmp_kgs_id_std_rank
		WHERE rank<=100
		ORDER BY random()
		limit 5
		)
	UNION
		(SELECT
		id,std,rank,2 AS class
		FROM tmp_kgs_id_std_rank
		WHERE rank>100 and rank<=200
		ORDER BY random()
		limit 5
		)
	) t
ORDER BY class

★★★★★★【WHERE条件】★★★★★★
(1) "功能号"in (1,48,97)
(2) classfication_level IS NOT NULL
(3) classfication_level <> 0 与 feature_value!=0等价,为null的记录均不会被查询到
注:postgresql中不同的数据类型无法作比较,需要先做类型转换

★★★★★★【cross join笛卡尔积】★★★★★★
SELECT
t1.feature_name AS f1,
t2.feature_name AS f2
FROM
	(SELECT DISTINCT feature_name
	FROM ios_product_feature_value
	) t1
cross join
	(SELECT DISTINCT feature_name
	FROM ios_product_feature_value
	) t2


