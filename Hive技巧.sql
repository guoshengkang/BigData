技巧1:向表中插入小数据
INSERT INTO tmp_lj_data_packages_0_config PARTITION (ds='2018-01-23')
select array("游戏玩家") as tag,
       array("充值","IOS","游戏","QQ","礼包","英雄联盟","阴阳师","自动充值") as keywords,
       "youxiwanjia" as types,
       180 AS duration
union all
select array("移动游戏玩家") as tag,
       array("IOS","账号","手游","皮肤","茨木","开局","王者荣耀","礼包") as keywords,
       "yidongyouxiwanjia" as types,
       1100 AS duration
union all
select array("氪金") as tag,
       array("充值","IOS","QQ","LOL","阴阳师","自动充值","自动发货") as keywords,
       "kejin" as types,
       1100 AS duration
union all
select array("爱美","爱自拍","爱读书","送好友","初为人父母","恋爱中","大学生") as tag,
       array("礼物","礼品","礼盒","创意","大礼","女友","礼包","送女友","新年","送礼")  as keywords,
       "christmas" as types,
       30 AS duration;