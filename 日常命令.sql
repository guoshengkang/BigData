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
set hive.auto.convert.join=false;

◎关闭表压缩存储设置
set hive.exec.compress.output=false;
set mapreduce.output.fileoutputformat.compress=false;

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
[kangguosheng@script ~]$ hadoop fs -du -s -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/*
9.5 G  19.0 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-21
31.6 G  63.1 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-22
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-23
[kangguosheng@script ~]$ hadoop fs -du hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
10106784872  20213569744  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-06
10113643650  20227287300  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-07
10119671301  20239342602  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-08
10125099493  20250198986  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-09
10132776713  20265553426  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-10
10138240496  20276480992  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-11
10152147667  20304295334  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-12
[kangguosheng@script ~]$ hadoop fs -du -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-06
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-07
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-08
9.4 G  18.9 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-09
9.4 G  18.9 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-10
9.4 G  18.9 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-11
9.5 G  18.9 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-12-12
[kangguosheng@script ~]$ hadoop fs -du -s hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
70888364192  141776728384  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg
[kangguosheng@script ~]$ hadoop fs -du -s -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/
66.0 G  132.0 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg


◎ 将csv文件导入HIVE表(注意文件编码需为utf-8)
例一:插入分区表的某一分区
load data local inpath '/home/kangguosheng/filetransfer/conf_recom_user_class.csv' 
overwrite into table conf_recom_user_class partition(ds='2017-11-20');
例二:插入非分区表
load data local inpath '/home/kangguosheng/tmp/config_subroot_keyword_tfidf_log.csv' 
overwrite into table config_subroot_keyword_tfidf_log;

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
◎查询输出到文件
方式一：
hive -e "select * from leesdata.tmp_kgs_age_data_all limit 100" >> kgs_result.csv
方式二:(建议使用,格式可以设置,更友好)
insert overwrite local directory '/home/kangguosheng/tmp'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE
select *
from tmp_kgs_age_data_all
limit 10000;
注:
1.overwrite是必须的关键字,不可缺少
2.清空文件夹的文件,生成文件000000_0
3.STORED AS TEXTFILE可以不要

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
MAPJION会把小表全部读入内存中,在map阶段直接拿另外一个表的数据和内存中表数据做匹配,由于在map是进行了join操作,
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
ps aux|grep crawler_main

◎列出运行的Python程序
ps aux | grep python

★★★【mysqldump命令集合】★★★
◎仅表结构
mysqldump -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 -d taoapp class_prod > class_prod.csv

◎仅表数据
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod --skip-comments --no-create-info --compact > class_prod.csv

◎没有注释和建表语句
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod -t -c --compact --extended-insert=false > class_prod.csv

◎完整的insert语句lines
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod -t --compact --extended-insert=false > class_prod.csv

◎没建表语句,但有注释
mysqldump  -h sh-cdb-kfmfxpp0.sql.tencentcdb.com -ubigdata -pb2i0g1d7a6t6a6 -P 63936 taoapp class_prod --skip-comments -t > class_prod.csv

