http://52.80.3.206:50070/dfshealth.html#tab-overview 查看空间

hadoop fs -du -s -h /user/hive/warehouse/leesdata.db/* 查询hive下表占用hdfs的空间
e.g.,
hadoop fs -du -s -h /user/hive/warehouse/leesdata.db/idl_taobao_sku_sale_stat_log
output:
33.3 M  66.6 M  /user/hive/warehouse/leesdata.db/idl_taobao_sku_sale_stat_log/ds=2017-10-02
66.7 M  133.3 M  /user/hive/warehouse/leesdata.db/idl_taobao_sku_sale_stat_log/ds=2017-10-03
hadoop fs -du -s -h /user/hive/warehouse/leesdata.db/idl_taobao_sku_sale_stat_log/*
100.0 M  199.9 M  /user/hive/warehouse/leesdata.db/idl_taobao_sku_sale_stat_log

--设置hive处理压缩
set hive.exec.compress.output=true;
--yarn
set mapreduce.output.fileoutputformat.compress=true;
set mapreduce.output.fileoutputformat.compress.codec=org.apache.hadoop.io.compress.GzipCodec;

--注:表的压缩可以减少50%的存储空间,但是会降低表的查询速度,因为数据需要先解压;
查询数据的输出会更快,总体而言应该是更优的
--查看表的创建语句
show create tablename;
e.g.,show create table idl_taobao_sku_sale_stat_log;

--创建表
CREATE TABLE `odl_limao_order_logs_compress`(
  `tid` bigint, 
  `adjust_fee` float, 
  `limao_id` bigint, 
  `limao_no` string, 
  `available_confirm_fee` string, 
  `buyer_alipay_no` string, 
  `buyer_area` string, 
  `buyer_cod_fee` string, 
  `buyer_email` string, 
  `buyer_nick` string, 
  `buyer_obtain_point_fee` string, 
  `buyer_rate` boolean, 
  `cod_fee` string, 
  `cod_status` string, 
  `commission_fee` string, 
  `consign_time` timestamp, 
  `credit_card_fee` string, 
  `discount_fee` string, 
  `end_time` timestamp, 
  `has_post_fee` string, 
  `is_3d` string, 
  `is_brand_sale` string, 
  `is_force_wlb` string, 
  `is_lgtype` string, 
  `is_part_consign` string, 
  `is_wt` string, 
  `pay_time` timestamp, 
  `payment` float, 
  `point_fee` string, 
  `post_fee` string, 
  `real_point_fee` string, 
  `received_payment` string, 
  `receiver_address` string, 
  `receiver_city` string, 
  `receiver_district` string, 
  `receiver_mobile` string, 
  `receiver_name` string, 
  `receiver_phone` string, 
  `receiver_state` string, 
  `receiver_zip` string, 
  `seller_limao_no` string, 
  `seller_can_rate` string, 
  `seller_cod_fee` string, 
  `seller_email` string, 
  `seller_flag` string, 
  `seller_mobile` string, 
  `seller_name` string, 
  `seller_nick` string, 
  `seller_phone` string, 
  `seller_rate` string, 
  `shipping_type` string, 
  `snapshot_url` string, 
  `status` string, 
  `title` string, 
  `total_fee` string, 
  `trade_from` string, 
  `type` string, 
  `modified` timestamp, 
  `created` timestamp)
PARTITIONED BY (`ds` string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ('field.delim'=',', 'serialization.format'=',') 
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat';

--根据分区压缩成一个压缩文件  
insert into odl_limao_order_logs_compress partition(ds) select * from odl_limao_order_logs where ds<'2017-10' distribute by ds;
insert into odl_limao_order_logs_compress partition(ds) select * from odl_limao_order_logs where ds>='2017-10' distribute by ds;

--将原文件命名成备份文件
alter table odl_limao_order_logs rename to odl_limao_order_logs_back;

--将压缩表命名成原表
alter table odl_limao_order_logs_compress rename to odl_limao_order_logs;

问题：
1.在倒数据到压缩表的时候,最后一个分区的数据还在增加,会导致缺少数据;
2.将原表命名之后,会导致数据丢失;
3.将最后一个分区的数据,从back表的分区文件拷贝到现在的表分区目录下(重命名的时候造成少量数据丢失可以不用管).
change-diagram
back:|----|····|
new: |----|????|····|
and  |----|····|

CREATE TABLE `odl_limao_commodity_logs_compress`(
  `tid` bigint, 
  `oid` bigint, 
  `adjust_fee` float, 
  `buyer_rate` boolean, 
  `cid` int, 
  `consign_time` timestamp, 
  `discount_fee` float, 
  `divide_order_fee` float, 
  `end_time` timestamp, 
  `invoice_no` string, 
  `is_daixiao` boolean, 
  `is_oversold` boolean, 
  `logistics_company` string, 
  `num` int, 
  `num_iid` bigint, 
  `order_from` string, 
  `outer_iid` bigint, 
  `payment` float, 
  `pic_path` string, 
  `price` float, 
  `refund_status` string, 
  `seller_rate` boolean, 
  `seller_type` string, 
  `shipping_type` string, 
  `sku_id` bigint, 
  `sku_properties_name` string, 
  `snapshot_url` string, 
  `status` string, 
  `title` string, 
  `total_fee` string, 
  `modified` timestamp, 
  `created` timestamp)
PARTITIONED BY ( 
  `ds` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'=',', 
  'serialization.format'=',') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat';

set hive.exec.compress.output=true;
set mapreduce.output.fileoutputformat.compress=true;
set mapreduce.output.fileoutputformat.compress.codec=org.apache.hadoop.io.compress.GzipCodec;
insert into odl_limao_commodity_logs_compress partition(ds) select * from odl_limao_commodity_logs where ds<'2017-09-23' distribute by ds;
insert into odl_limao_commodity_logs_compress partition(ds) select * from odl_limao_commodity_logs where ds>='2017-09-23' and ds<'2017-10' distribute by ds;
insert into odl_limao_commodity_logs_compress partition(ds) select * from odl_limao_commodity_logs where ds>='2017-10' and ds<'2017-10-15' distribute by ds;
insert into odl_limao_commodity_logs_compress partition(ds) select * from odl_limao_commodity_logs where ds>='2017-10-15' and ds<'2017-11' distribute by ds;
insert into odl_limao_commodity_logs_compress partition(ds) select * from odl_limao_commodity_logs where ds>='2017-11' distribute by ds;
alter table odl_limao_commodity_logs rename to odl_limao_commodity_logs_back;
alter table odl_limao_commodity_logs_compress rename to odl_limao_commodity_logs;

注:distribute by ds 将一个分区下的多个文件合并为一个文件