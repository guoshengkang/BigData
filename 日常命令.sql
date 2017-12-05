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

◎导出数据
hadoop fs -get hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/tmp_kgs_age_data_all/ds=2017-11-21/* /home/kangguosheng/tmp

◎查看hive表的大小
[kangguosheng@script ~]$ hadoop fs -du -s -h hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/*
9.5 G  19.0 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-21
31.6 G  63.1 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-22
9.4 G  18.8 G  hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db/idl_limao_uid_agg/ds=2017-11-23

◎ 将csv文件导入HIVE表(注意文件编码需为utf-8)
例一:插入分区表的某一分区
load data local inpath '/home/kangguosheng/filetransfer/conf_recom_user_class.csv' 
overwrite into table conf_recom_user_class partition(ds='2017-11-20');
例二:插入非分区表
load data local inpath '/home/kangguosheng/tmp/config_subroot_keyword_tfidf_log.csv' 
overwrite into table config_subroot_keyword_tfidf_log;

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
hive -e "select * from leesdata.tmp_kgs_age_data_all limit 100" >> kgs_result.csv

◎insert overwrite local directory '/home/kangguosheng/tmp'
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

