/*
Navicat PGSQL Data Transfer

Source Server         : 172.12.78.217
Source Server Version : 90510
Source Host           : 172.12.78.217:5432
Source Database       : ios
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90510
File Encoding         : 65001

Date: 2018-04-19 18:21:36
*/


-- ----------------------------
-- Table structure for ios_optimization_classificaition
-- ----------------------------
DROP TABLE IF EXISTS "public"."ios_optimization_classificaition";
CREATE TABLE "public"."ios_optimization_classificaition" (
"classification_id" int4 DEFAULT nextval('ios_optimization_classificaition_classification_id_seq'::regclass) NOT NULL,
"warehouse_id" int4 NOT NULL,
"product_id" int4 NOT NULL,
"skc_id" int4 NOT NULL,
"sku_id" int4 NOT NULL,
"cost_price" numeric(10,5),
"sale_price" numeric(10,5),
"opening_quantity" numeric(10,5),
"ending_quantity" numeric(10,5),
"sale_quantity" numeric(10,5),
"buyin_quantity" numeric(10,5),
"auv" numeric(24,10),
"ordering_cycle" int4,
"ordering_quantity" numeric(10,5),
"classfication_level" int4,
"algorithm_id" int4,
"status" int4,
"gen_time" timestamp(6),
"number_of_batches" int4
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Indexes structure for table ios_optimization_classificaition
-- ----------------------------
CREATE INDEX "ios_optimization_classificaition_algorithm_id" ON "public"."ios_optimization_classificaition" USING btree ("algorithm_id");
CREATE INDEX "ios_optimization_classificaition_product_id" ON "public"."ios_optimization_classificaition" USING btree ("product_id");
CREATE INDEX "ios_optimization_classificaition_skc_id" ON "public"."ios_optimization_classificaition" USING btree ("skc_id");
CREATE INDEX "ios_optimization_classificaition_sku_id" ON "public"."ios_optimization_classificaition" USING btree ("sku_id");
CREATE INDEX "ios_optimization_classificaition_warehouse_id" ON "public"."ios_optimization_classificaition" USING btree ("warehouse_id");

-- ----------------------------
-- Primary Key structure for table ios_optimization_classificaition
-- ----------------------------
ALTER TABLE "public"."ios_optimization_classificaition" ADD PRIMARY KEY ("classification_id");

-- ----------------------------
-- Foreign Key structure for table "public"."ios_optimization_classificaition"
-- ----------------------------
ALTER TABLE "public"."ios_optimization_classificaition" ADD FOREIGN KEY ("algorithm_id") REFERENCES "public"."ios_base_algorithm" ("algorithm_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_optimization_classificaition" ADD FOREIGN KEY ("product_id") REFERENCES "public"."ios_base_product" ("product_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_optimization_classificaition" ADD FOREIGN KEY ("skc_id") REFERENCES "public"."ios_base_skc" ("skc_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_optimization_classificaition" ADD FOREIGN KEY ("sku_id") REFERENCES "public"."ios_base_sku" ("sku_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_optimization_classificaition" ADD FOREIGN KEY ("warehouse_id") REFERENCES "public"."ios_base_warehouse" ("warehouse_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
