#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2018-04-27 17:57:00
# @Author  : ${guoshengkang} (${kangguosheng1@huokeyi.com})

import os
import pandas as pd
from peewee import Model,PostgresqlDatabase
from playhouse.pool import PooledPostgresqlDatabase

db = PooledPostgresqlDatabase(database='ios2',
                              host='172.12.78.217',
                              port=5432,
                              user='postgres',
                              password='Password123',
                              max_connections=20,    # 可省略
                              stale_timeout=300,     # 可省略
                             )

class BaseModel(Model):
    class Meta:
        database = db

########################################################################################
#测试代码
if __name__=='__main__':

	# example 1
	print('{:-^50}'.format('通过BaseModel读取PG-SQL语句'))
	warehouse_id_list=[1,2]
	sql="""
		SELECT * 
		FROM ios_base_store 
		WHERE warehouse_id in {}
		""".format(tuple(warehouse_id_list))
	rows = BaseModel.raw(sql)
	for row in rows:
		print(row.store_id,row.warehouse_id)
    
	# example 2
	print('{:-^50}'.format('通过BaseModel读取PG-SQL语句'))
	sql="""
        SELECT
		DISTINCT
		t1."name" as p_name,
		t2."name" as c_name
		FROM ios_base_product as t1
		INNER JOIN ios_base_product_category as t2
		ON t1.category_id=t2.category_id
		LIMIT 5
		"""
	rows = BaseModel.raw(sql)
	for row in rows:
		print(row.p_name,row.c_name)

	# example 3 pandas读sql语句
	print('{:-^50}'.format('通过pd.read_sql读取PG-SQL语句'))
	print('{:*^30}'.format('pd各列的类型'))
	df=pd.read_sql(sql, db)
	print(df.dtypes)
	print('{:*^30}'.format('pd的前6行输出'))
	print(df.head(3))

'''
output
--------------通过BaseModel读取PG-SQL语句---------------
1 1
2 1
--------------通过BaseModel读取PG-SQL语句---------------
凯思奇顿兰铃花纯美保湿护体乳250ML 日用
东方宝石 土耳其精油沐浴露 500ML 日用
惠百施MEDIFIT美齿适加护牙刷 日用
浪漫樱花 可悬挂冷冻室除臭剂（蓝） 家居
张君雅草莓味甜甜圈45G 食品
-------------通过pd.read_sql读取PG-SQL语句--------------
***********pd各列的类型************
p_name    object
c_name    object
dtype: object
**********pd的前10行输出***********
                p_name c_name
0  凯思奇顿兰铃花纯美保湿护体乳250ML     日用
1  东方宝石 土耳其精油沐浴露 500ML     日用
2    惠百施MEDIFIT美齿适加护牙刷     日用
'''