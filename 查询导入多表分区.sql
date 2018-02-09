ALTER TABLE idl_taohaoquan_sms_click_tmp DROP PARTITION (ds<="{p0}");
ALTER TABLE idl_taohaoquan_item_click_tmp DROP PARTITION (ds<="{p0}");
ALTER TABLE adl_taohaoquan_agent_task_output DROP PARTITION (ds="{p0}");
ALTER TABLE adl_taohaoquan_item_output DROP PARTITION (ds="{p0}");

FROM
    (SELECT 
    data_type,
    uid,
    session_id,
    item_id,
    ip_code,
    agent_id,
    agent_info
    FROM odl_taobao_sms_click_log
    WHERE ds LIKE '{p0}%'
    )  AS table_tmp
INSERT INTO idl_taohaoquan_sms_click_tmp partition (ds="{p0}")
    SELECT 
    DISTINCT uid,
    session_id,
    ip_code,
    agent_id
INSERT INTO adl_taohaoquan_agent_task_output partition (ds="{p0}")
SELECT 
    DISTINCT agent_id,
    agent_info
INSERT INTO idl_taohaoquan_item_click_tmp partition (ds="{p0}")
    SELECT 
    DISTINCT uid,
    session_id,
    item_id,
    ip_code,
    agent_id
WHERE data_type="item_click"
INSERT INTO adl_taohaoquan_item_output partition (ds="{p0}")
SELECT 
    DISTINCT item_id
WHERE data_type="item_click";
