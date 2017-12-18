★★★【task配置】★★★
◎☆☆☆【HIVE脚本】☆☆☆
-- idl_taobao_coupon_subroot_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_taobao_coupon_subroot_tmp",
      "./task_file/coupon_daily/idl_taobao_coupon_subroot_tmp.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
注意:
1）涉及到新的connect_type信息,还需要到54.222.159.84的/data1/shell/job_control中配置data_source中进行配置;
2）将脚本文件上传到制定的file_path中,目前的基本集中存放在54.222.159.84的/data1/shell/job_control/task_file/;
3）上传脚本,务必谨慎,谨防覆盖其他的任务的脚本（脚本名称重名）;
4）task_type目前分为"daily"和"hour";

INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_taobao_coupon_subroot_tmp",
     "idl_taobao_coupon_subroot_tmp",
     0,
     now());
注意:is_chack是标示是否需要检查（检查执行的数量）;

INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_taobao_coupon_subroot_tmp",
     "idl_taobao_coupon_info_log",
     now());
     
◎☆☆☆【shell脚本】☆☆☆
-- split_idl_taobao_search_hot_keyword_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("split_idl_taobao_search_hot_keyword_log",
     "./task_file/coupon_daily/split_idl_taobao_search_hot_keyword_log.sh",
      now(),
      now(),
     "shell_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("split_idl_taobao_search_hot_keyword_log",
    "split_idl_taobao_search_hot_keyword_log",
     0,
     now()); 
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("split_idl_taobao_search_hot_keyword_log",
    "idl_taobao_search_hot_keyword_log",
     now());
     
◎☆☆☆【Mysql脚本】☆☆☆ 
-- adl_dataflow_msg_lulu_pending_jobs
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_dataflow_msg_lulu_pending_jobs",
     "./task_file/trade_daily/adl_dataflow_msg_lulu_pending_jobs.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_dataflow_msg_lulu_pending_jobs",
    "adl_dataflow_msg_lulu_pending_jobs",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_dataflow_msg_lulu_pending_jobs",
    "adl_dataflow_msguser_final_ft_export2mysql",
     now());   

     
★★★【job配置】★★★
INSERT INTO plan_job_config (job_name,job_type,PARAMETER,par_end,PARALLEL,begin_time,insertdt,updatedt,job_status,is_debug)
VALUES ("coupon_daily",
      "daily",
      "2017-10-25",
      "2017-01-01",
      2,
      "00:00:00",
      now(),
      now(),
      0,
      1);
注意:
1）"daily"的job仅能执行daily的task;
2）PARAMETER和par_end的格式:jobtype是"daily"时为"yyyy-mm-dd";是jobtype是"hour"时为"yyyy-mm-dd-hh";
3）job不会触发的条件是当PARAMETER大于par_end,并且当前时间大于begin_time的时候。所有我们停止某个job的触发,只需要将par_end设置成非常小的值;
4）关于当is_debug=1的情况,测试时用,par_end不会变化;当is_debug=0,par_end会随日期变化为T-1
    
-- idl_taobao_search_hot_keyword_log
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("coupon_daily",
     "idl_taobao_search_hot_keyword_log",
     now());
注意:被依赖的task会自动加进来,可以不添加到原始的task中     