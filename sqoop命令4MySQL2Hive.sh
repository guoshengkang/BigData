# 下面是一个从MYSQL表数据传到HIVE表的例子
# MYSQL表:result_article_feature_log
# HIVE表:idl_recom_result_article_feature_log
# step1:删除HIVE表的p0分区
# step2:MYSQL表数据传输到HIVE机器一个目录下
# 注:目录已经若存在,则会先删除再重建
# step3:将目录下的数据加载到HIVE表p0分区中

hive -e "alter table leesdata.idl_recom_result_article_feature_log drop partition(ds='{p0}')"; 

/data1/cloudera/parcels/CDH/bin/sqoop-import --table result_article_feature_log --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds={p0};

hive -e "load data inpath '/user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds={p0}' into table leesdata.idl_recom_result_article_feature_log partition(ds='{p0}')";

# ---------------------------------------------------------------------
# 执行mysql命令
mysql -h172.31.6.180 -P3306 -udc -pmCdlUmm3thna5ttup  -e "insert into addition_profit_db.result_article_info_agg(id,type,title,html_path,abstract) select id,type,title,html_path,abstract from addition_profit_db.result_article_info_log t1 where not exists (select id from addition_profit_db.result_article_info_agg t2 where t2.id=t1.id);"

# ---------------------------------------------------------------------------
# 执行sqoop-export命令,从HIVE表导出到MySQL
# 根据update-key做更新或插入操作
# 若该记录已存在,且是最新数据,更新不会做任何改变
/data1/cloudera/parcels/CDH/bin/sqoop-export --table result_article_info_agg --connect "jdbc:mysql://172.31.6.180:3306/addition_profit_db?useUnicode=yes&characterEncoding=UTF-8" --password mCdlUmm3thna5ttup --username dc --export-dir /user/hive/warehouse/leesdata.db/idl_recom_article_feature_info_agg/ds={p0} --columns id,keywords,classes,tag_psb,popularity --update-key id

/data1/cloudera/parcels/CDH/bin/sqoop-export --table result_article_to_article_similarity_agg --connect "jdbc:mysql://172.31.6.180:3306/addition_profit_db?useUnicode=yes&characterEncoding=UTF-8" --password mCdlUmm3thna5ttup --username dc --export-dir /user/hive/warehouse/leesdata.db/idl_recom_similarity_article_to_article_agg/ds={p0} --columns article1,article2,similarity --update-key article1,article2
