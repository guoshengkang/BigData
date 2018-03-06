★错误1:动态分区过多
drop table tmp_kgs_thq_uid_score_unique_partition;
CREATE TABLE tmp_kgs_thq_uid_score_unique_partition
(  
uid        string, 
group_name string, 
score      FLOAT
)
PARTITIONED BY (ds string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

set hive.exec.compress.output=false;
set mapreduce.output.fileoutputformat.compress=false;
INSERT INTO tmp_kgs_thq_uid_score_unique_partition PARTITION (ds)
SELECT
uid,
group_name,
score,
concat("2018-02-",cast(dense_ranks as string)) as ds
FROM
    (SELECT
    uid,
    group_name,
    score,
    row_number()over(ORDER BY group_name) AS dense_ranks
    FROM tmp_kgs_thq_uid_score_unique
    ) t1;
    
报错:动态分区过多
Error: java.lang.RuntimeException: Hive Runtime Error while closing operators: [Error 20004]: Fatal error occurred when node tried to create too many dynamic partitions. The maximum number of dynamic partitions is controlled by hive.exec.max.dynamic.partitions and hive.exec.max.dynamic.partitions.pernode. Maximum was set to: 9999
Caused by: org.apache.hadoop.hive.ql.metadata.HiveFatalException: [Error 20004]: Fatal error occurred when node tried to create too many dynamic partitions. The maximum number of dynamic partitions is controlled by hive.exec.max.dynamic.partitions and hive.exec.max.dynamic.partitions.pernode. Maximum was set to: 9999
   
set hive.exec.compress.output=false;
set mapreduce.output.fileoutputformat.compress=false;
INSERT INTO tmp_kgs_thq_uid_score_unique_partition PARTITION (ds)
SELECT
uid,
group_name,
score,
concat("2018-02-",cast(dense_ranks as string)) as ds
FROM
    (SELECT
    uid,
    group_name,
    score,
    dense_rank()over(ORDER BY group_name) AS dense_ranks
    FROM tmp_kgs_thq_uid_score_unique
    ) t1;

★错误2:窗口函数对大量的数据会运行失败
hadoop fs -du -s -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/tmp_kgs_thq_uid_score_unique/
594.4 M  1.2 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/tmp_kgs_thq_uid_score_unique
SELECT COUNT(1) FROM tmp_kgs_thq_uid_score_unique;
35768978

set hive.auto.convert.join=false;
DROP table tmp_kgs_thq_uid_score_distribution_top10;
CREATE TABLE tmp_kgs_thq_uid_score_distribution_top10 AS
SELECT
group_name,
COUNT(1),
max(score) AS max_score,
min(score) AS min_score,
avg(score) AS avg_score
FROM 
    (SELECT
    uid,
    group_name,
    score,
    SUM(score)OVER(Partition BY group_name) AS score_t,
    SUM(score)OVER(Partition BY group_name ORDER BY score) AS score_c
    FROM tmp_kgs_thq_uid_score_unique
    ) t1
WHERE score_c/score_t>=0.9
GROUP BY group_name;

-- 用row_number()运行成功
set hive.auto.convert.join=false;
DROP table tmp_kgs_thq_uid_score_distribution_top10;
CREATE TABLE tmp_kgs_thq_uid_score_distribution_top10 AS
SELECT
group_name,
COUNT(1),
max(score) AS max_score,
min(score) AS min_score,
avg(score) AS avg_score
FROM 
    (SELECT
    t1.uid,
    t1.group_name,
    t1.score,
    t2.num,
    row_number()over(Partition BY t1.group_name ORDER BY t1.score DESC) AS ranks
    FROM tmp_kgs_thq_uid_score_unique t1
    LEFT JOIN tmp_kgs_thq_uid_score_distribution t2
    ON t1.group_name=t2.group_name
    ) t1
WHERE ranks<=INT(num*0.1)
GROUP BY group_name;

★错误3:array_intersect函数遇到空列表([])会报错,使用前需先过滤掉
add jar hdfs://172.31.6.206:8020/user/dc/func/hive-third-functions-2.1.1-shaded.jar;
create temporary function array_intersect as 'cc.shanruifeng.functions.array.UDFArrayIntersect';
CREATE TABLE tmp_kgs_car_user_with_cartag_num AS
SELECT
uid,
IF(SIZE(tag_list)<1,0,SIZE(array_intersect(tag_list, array("有车族","大众汽车","日系车","国产车")))) AS tag_num
FROM tmp_kgs_car_user_tag;
注:SIZE(array())=1,SIZE(NULL)=-1
不过奇怪的是:
※这个不报错
add jar hdfs://172.31.6.206:8020/user/dc/func/hive-third-functions-2.1.1-shaded.jar;
create temporary function array_intersect as 'cc.shanruifeng.functions.array.UDFArrayIntersect';
SELECT array_intersect(array(), array("有车族","大众汽车","日系车","国产车"));
※但这个报错
add jar hdfs://172.31.6.206:8020/user/dc/func/hive-third-functions-2.1.1-shaded.jar;
create temporary function array_intersect as 'cc.shanruifeng.functions.array.UDFArrayIntersect';
CREATE TABLE tmp_kgs_car_user_with_cartag_num AS
SELECT
uid,
SIZE(array_intersect(tag_list, array("有车族","大众汽车","日系车","国产车"))) AS tag_num
FROM tmp_kgs_car_user_tag
WHERE uid='00c50387b5ff6df41ba8bbf224b88e70';
其中:
SELECT *
FROM tmp_kgs_car_user_tag
WHERE uid='00c50387b5ff6df41ba8bbf224b88e70';
→00c50387b5ff6df41ba8bbf224b88e70	[]
