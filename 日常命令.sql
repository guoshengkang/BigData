★★★【HADOOP命令集合】★★★
◎查看任务状态 
http://52.80.3.206:8088

◎kill job进程:
/data1/services/hadoop272/bin/hadoop job  -kill job_1501464625516_0430
hadoop job  -kill job_1500621575826_0472
/data1/cloudera/parcels/CDH-5.7.6-1.cdh5.7.6.p0.6/lib/hadoop/bin/hadoop job  -kill job_1500621575826_0468

◎CTRL+C 终止当前进程

◎查看job列表:hadoop job -list

◎关闭mapjoin执行方式,转为mapreduce:
注:当脚本运行失败时,可以尝试这样设置
set hive.auto.convert.join=false;

◎关闭表压缩存储设置
set hive.exec.compress.output=false;
set mapreduce.output.fileoutputformat.compress=false;

◎压缩存储时需要设置压缩格式
SET mapreduce.output.fileoutputformat.compress.codec=org.apache.hadoop.io.compress.GzipCodec;

◎设置reduce的数量,即产生的结果文件数量
set mapreduce.job.reduces=5;

◎设置MapReduce的运行内存
set mapreduce.map.memory.mb=2048;
set mapreduce.map.java.opts=-Xmx1600m;

◎Xshell中进入HIVE数据库命令:
HADOOP_USER_NAME=hadoop hive
hive

◎导出hdfs文件
hadoop fs -get hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/tmp_kgs_age_data_all/ds=2017-11-21/* /home/kangguosheng/tmp

◎查看hive表的大小
#-du 统计个目录下各个文件大小
#-h  以G为单位显示文件大小
[kangguosheng@script ~]$ hadoop fs -du -s -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/*
9.5 G  19.0 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-21
31.6 G  63.1 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-22
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-23
#不带参数-h,输出如下:
[kangguosheng@script ~]$ hadoop fs -du hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
10106784872  20213569744  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-06
10113643650  20227287300  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-07
10119671301  20239342602  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-08
[kangguosheng@script ~]$ hadoop fs -du -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-06
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-07
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-08
[kangguosheng@script ~]$ hadoop fs -du -s hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
70888364192  141776728384  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg
[kangguosheng@script ~]$ hadoop fs -du -s -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
66.0 G  132.0 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg

◎传输/查看/创建/删除文件
-- 将目录下的所有文件传输到hdfs目录
hadoop fs -put /root/kgstmp/output_files/* hdfs://172.31.31.115:8020/tmp/kgstmp
-- 查看目录下的文件列表
hadoop fs -ls hdfs://172.31.31.115:8020/tmp/kgstmp
-- 以下两个创建目录的命令是等价的
hadoop fs -mkdir /tmp/kgs
hadoop fs -mkdir hdfs://172.31.31.115:8020/tmp/kgs
-- 删除文件夹
hadoop fs -rm -r hdfs://172.31.31.115:8020/tmp/kgs
-- 删除文件
hadoop fs -rm hdfs://172.31.31.115:8020/user/hive/warehouse/leesdata.db/tmp_kgs_test_load_score/derby.log

★★★【git命令集合】★★★
git后台:http://deploy.leesrobots.com/  浏览器登录
git客户端:SourceTree
http://deploy.leesrobots.com:3000/DataCenter/scripts.git
http://deploy.leesrobots.com:3000/DataCenter/filetransfer.git

git clone http://deploy.leesrobots.com:3000/DataCenter/filetransfer.git
git pull
git status
git add file
git commit -m mycomment
git push

git config --global user.name kangguosheng
git add .
git commit -m del
git push
git checkout -- file可以丢弃工作区的修改

★★★【HIVE命令集合】★★★
◎直接创建表
DROP TABLE IF EXISTS table_name;
DROP TABLE table_name;
CREATE TABLE if not exists table_name
(
signature          STRING COMMENT '短信签名',
msg_num            INT    COMMENT '发送短信数量',
score              FLOAT  COMMENT '得分',
name_list          ARRAY<STRING> COMMENT '名字列表',
msg_type_map       MAP<STRING,STRING> COMMENT '类别'
) 
comment "签名发送短信统计表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

◎删除分区
ALTER TABLE table_name DROP IF EXISTS  PARTITION (ds="2017-12-12");
ALTER TABLE table_name DROP PARTITION (ds<="{p3}");
ALTER TABLE table_name DROP PARTITION (ds="{p0}");

◎创建分区
ALTER TABLE table_name ADD IF NOT EXISTS PARTITION (ds="2017-12-12");
◎创建分区并导入数据
INSERT INTO table_name PARTITION (ds="{p0}")
SELECT *
FROM      
    (SELECT *
    FROM table_name_input
    WHERE ds="{p0}"
    ) t1;
注1:查询输出的字段数目必须和导入表的字段数目一样,对应的字段类型也必须一致(或者符合类型自动转换规则),但字段名称可以不一致
注2:查询数据的亦可一次导入到多表的分区,例如:
FROM ( 
    SELECT distinct limao_id,buyer_nick,buyer_email,created 
    FROM odl_limao_order_logs 
	WHERE ds="2016-01-01" 
    )  
AS tmp_table  
INSERT INTO TABLE idl_limao_user_main_agg PARTITION (ds='2015')
SELECT limao_id,buyer_nick,buyer_email,created,FROM_UNIXTIME(UNIX_TIMESTAMP(),'Y-M-d') as insertd 
INSERT INTO TABLE adl_limao_user_input PARTITION (ds='2015')
SELECT buyer_nick 

◎HIVE查询输出创建表
CREATE TABLE tmp_kgs_all_uids_with_title AS
SELECT
DISTINCT uid
FROM idl_limao_user_title_agg
WHERE ds="2018-01-03";

◎ 将文件导入HIVE表(注意文件编码需为utf-8)
例一:导入分区表的某一分区,若分区不存在会自动创建分区
load data local inpath '/home/kangguosheng/filetransfer/conf_recom_user_class.csv' 
overwrite into table conf_recom_user_class partition(ds='2017-11-20');
例二:导入非分区表
load data local inpath '/home/kangguosheng/tmp/config_subroot_keyword_tfidf_log.csv' 
overwrite into table config_subroot_keyword_tfidf_log;
#将文件加下的所有文件都加载到表中,加载后原hdfs目录下的文件将被移除(非hdfs目录,导入后不会被移除)
load data inpath '/tmp/kgstmp/*' overwrite into table leesdata.tmp_kgs_test_load_score
案例解析:
DROP TABLE tmp_kgs_test_load_load;
CREATE TABLE tmp_kgs_test_load_load
(
top_id          STRING COMMENT 'top_id',
top_name        STRING COMMENT 'top_name',
union_root      STRING COMMENT 'union_root'
)
comment "hotkeyword_subroot"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;
load data local inpath '/home/kangguosheng/tmp/tmp_kgs_test_load_load.csv' 
overwrite into table tmp_kgs_test_load_load;
[kangguosheng@script ~]$ hadoop fs -ls /user/hive/warehouse/leesdata.db/tmp_kgs_test_load_load
Found 1 items
-rwxr-xr-x   2 kangguosheng supergroup  114 2017-12-06 09:37 /user/hive/warehouse/leesdata.db/tmp_kgs_test_load_load/tmp_kgs_test_load_load.csv

◎查询输出到文件
方式一:命令行输出重定向
hive -e "select * from leesdata.tmp_kgs_age_data_all limit 100" >> kgs_result.csv
方式二:自定义格式输出(建议使用,格式可以设置,更友好)
# order by rand() 随机抽样
insert overwrite local directory '/home/kangguosheng/tmp'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE
select *
from tmp_kgs_age_data_all
order by rand()
limit 10000;
注:
1.overwrite是必须的关键字,不可缺少
2.清空文件夹的文件,生成文件000000_0
3.STORED AS TEXTFILE可以不要
4.若不指定格式,则导出如下
insert overwrite local directory '/home/kangguosheng/tmp/aaa.txt' select cp_id,union_root,catergory_info from idl_taobao_coupon_group_info_agg limit 10;
10058男女装&男女装配件feature保暖category手套
10045男女装&男女装配件category腰带
注:
-->','
-->':'
-->';'

◎窗口函数
-- 分组
NTILE(10) over(partition by label order by score desc ) ds
-- 分组求和
SUM(tfidf)OVER(Partition BY keyword) AS tfidf_t
-- 分组累计求和
SUM(tfidf)OVER(Partition BY keyword  ORDER BY ranks) AS tfidf_c
-- 排序号
row_number()over(Partition BY cp_id ORDER BY weight DESC) AS ranks
注:使用row_number()时,若表分区数据为空时将报错,例如
SELECT 
limao_nick,
uid,
row_number()over(partition BY limao_nick ORDER BY weigth DESC) AS ranks
FROM ald_limao_receiver_tmp
WHERE ds='2018-01-08';
Error: java.lang.RuntimeException: Error in configuring object

◎array/map展开(LATERAL VIEW outer explode / LATERAL VIEW explode)
#去掉outer关键字,则null不展开
LATERAL VIEW explode(token) mytable AS keyword
LATERAL VIEW explode(subroot) mytable AS union_root,weight
例子:
SELECT
uid,
keyword
FROM tmp_kgs_all_test_user_token
LATERAL VIEW explode(token) mytable AS keyword;

◎mapjoin方式执行
把
SELECT f.a,  f.b
FROM A t
JOIN B f 
ON (f.a=t.a AND f.ftime=20110802)
写作
SELECT /*+ mapjoin(A)*/ f.a, f.b
FROM A t
JOIN B f 
ON (f.a=t.a AND f.ftime=20110802)
MAPJION会把小表全部读入内存中,在map阶段直接拿另外一个表的数据和内存中表数据做匹配,由于在map时进行了join操作,
省去了reduce运行的效率也会高很多
mapjoin还有一个很大的好处是能够进行不等连接的join操作,如果将不等条件写在where中,
那么mapreduce过程中会进行笛卡尔积,运行效率特别低,如果使用mapjoin操作,
在map的过程中就完成了不等值的join操作,效率会高很多。

◎后台运行HIVE脚本
nohup hive -f kgs.sql output.out &
e.g.,
cd /data1/shell/data_tool/tmp
nohup hive -f Wednesday_job.sql > Wednesday_job.out &
ps aux | grep keyword #看在不在跑

★★★【python命令集合】★★★
◎后台运行python脚本
nohup python -u keyword.py >>keyword.log 2>&1 &
tail -f keyword.log

nohup python crawler_main.py &
ps aux|grep crawler_main 或者 ps aux|grep python
ls -al|grep pip #列出包含pip的文件

◎列出运行的Python程序
ps aux | grep python

★★★【mysqldump命令集合】★★★
◎仅表结构
mysqldump -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 -d taoapp class_prod > class_prod.csv

◎仅表数据
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod --skip-comments --no-create-info --compact > class_prod.csv

◎没有注释和建表语句
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod -t -c --compact --extended-insert=false > class_prod.csv

◎完整的insert语句lines(每条记录一行插入语句)
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod -t --compact --extended-insert=false > class_prod.csv

◎没建表语句,但有注释
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod --skip-comments -t > class_prod.csv

◎Xshell命令行远程连接MySQL数据库
mysql -h 594a3c818fff7.sh.cdb.myqcloud.com -udatacenter -pJHd7yb3g234 -P 15050

◎mysql查询输出到本地文件,字段TAB隔开(-N:去掉输出结果中列名)
注:目录必须存在,文件名存在的话会自动替换
mysql -h 594a3c818fff7.sh.cdb.myqcloud.com -udatacenter -pJHd7yb3g234 -P 15050  \
-e "select name,content,url,type,channels_info,status,sessionid from sms_sender.sendtasks;" -N > /home/kangguosheng/tmp/mysqlheh.txt
sed命令将TAB换为',',注意添加管道符
mysql -h 594a3c818fff7.sh.cdb.myqcloud.com -udatacenter -pJHd7yb3g234 -P 15050  \
-e "select name,content,url,type,channels_info,status,sessionid from sms_sender.sendtasks;" -N | sed 's/\t/,/g' > /home/kangguosheng/tmp/haha.txt

