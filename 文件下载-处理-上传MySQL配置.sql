★★★【文件下载-处理-上传MySQL配置】★★★
-- 配置下载的task
INSERT INTO config_task_log
(task_type, source_folder, insertdt, result_path, result_folder, code_file) 
VALUES 
('ua_cont', 'ua_cont', NOW(), 'resultdata', 'ua_cont', '/data1/shell/data_tool/task_file/ua_cont/main.py');

-- 配置数据传递路径,上传至表odl_taohaoquan_agent_task_log
INSERT INTO config_load_data_log
(source_path, server_url, table_name, insertdt, data_desc, data_base) 
VALUES 
('/data1/shell/data_tool/resultdata/ua_cont', 'hdfs://172.31.6.206:8020/user/hive/warehouse/leesdata.db', 'odl_taohaoquan_agent_task_log',NOW(), '下载user_agents', 'leesdata');

-- 配置程序使用的api,task_id来自于表config_task_log
INSERT INTO config_api_log
(api_url, parallel_num, task_id, insertdt, updatedt, data_desc) 
VALUES 
('url is not exist', 2, 8, NOW(), NOW(), 'user_agents解析');


★★★【执行下载上传task的脚本命令】★★★
#!/bin/bash

# 参数说明:
# 	第一个参数:	表名组成的列表
#		可以是一个表名,也可以是多个表名,多个表名之间以逗号分隔,注意不要有空格
#	第二个参数:	开始日期
#		表需要下载的HDFS数据文件所在分区的日期
#	第三个参数:	天数
#		以开始日期开始下载几天的数据
#	第四个参数:	本地保存目录
#	切分后的文件命名以原文件名加下标的形式保存,如原文件名为abc则切分后文件的文件名为abc_0001,abc_0002...

# 功能说明
# 	可以下载一个或多个表的分区数据
#	可以下载多个分区的数据
#	下载的文件会在本地保存目录下根据表名和日期创建新的目录并将文件放在此目录下

# 命令样本:
# python hdfs_main.py 表名1,表名2,表名3 分区字段名 开始日期 天数 本地保存目录

# 执行主程序
# 调度框架会将{p0｝替换

# 脚本所在目录
original_path=`pwd`

# 转到主程序目录
cd /data1/shell/split_file/

# 执行程序
python /data1/shell/split_file/hdfs_main.py adl_taohaoquan_agent_task_output ds {p0} 1 /data1/shell/data_tool/sourcedata/ua_cont

# 返回脚本目录
cd ${original_path}
# python /data1/shell/split_file/hdfs_main.py idl_limao_info_dim ds 2017-02-07 1 /data1/shell/split_file/HDFS_data


★★★【执行Python程序的脚本命令】★★★
#!/bin/bash

original_path=`pwd`

# 转到主程序目录
cd /data1/shell/job_control/task_file/coupon_daily/python_code/

# 执行程序
python /data1/shell/job_control/task_file/coupon_daily/python_code/coupon_main.py {p0}

# 返回脚本目录
cd ${original_path}