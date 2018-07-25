/*
Navicat PGSQL Data Transfer

Source Server         : 172.12.78.211
Source Server Version : 90510
Source Host           : 172.12.78.211:5432
Source Database       : ios_20
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90510
File Encoding         : 65001

Date: 2018-04-18 10:45:24
*/


-- ----------------------------
-- Table structure for ios_base_product
-- ----------------------------
DROP TABLE IF EXISTS "public"."ios_base_product";
CREATE TABLE "public"."ios_base_product" (
"product_id" int4 DEFAULT nextval('ios_base_product_product_id_seq'::regclass) NOT NULL,
"bar_code" varchar(255) COLLATE "default",
"standard_code" varchar(255) COLLATE "default",
"name" varchar(255) COLLATE "default",
"image" varchar(255) COLLATE "default",
"stock_unit_id" int4,
"logistics_unit_id" int4,
"year" int4,
"season" int4,
"designer_user_id" int4,
"designer_user" varchar(255) COLLATE "default",
"fabric1" varchar(255) COLLATE "default",
"fabric2" varchar(255) COLLATE "default",
"fabric3" varchar(255) COLLATE "default",
"fabric4" varchar(255) COLLATE "default",
"fabric5" varchar(255) COLLATE "default",
"inner_fabric" varchar(255) COLLATE "default",
"fill_fabric" varchar(255) COLLATE "default",
"cost_price" float4,
"tag_price1" float4,
"tag_price2" float4,
"tag_price3" float4,
"tag_price4" float4,
"tag_price5" float4,
"tag_price6" float4,
"tag_price7" float4,
"tag_price8" float4,
"tag_price9" float4,
"tag_price10" float4,
"tag_price11" float4,
"tag_price12" float4,
"purchase_price" float4,
"retail_price" float4,
"tax_rate" float4,
"replenish_price" float4,
"distribution_price" float4,
"define1" varchar(255) COLLATE "default",
"define2" varchar(255) COLLATE "default",
"define3" varchar(255) COLLATE "default",
"define4" varchar(255) COLLATE "default",
"define5" varchar(255) COLLATE "default",
"define6" varchar(255) COLLATE "default",
"define7" varchar(255) COLLATE "default",
"define8" varchar(255) COLLATE "default",
"sale_days" int4,
"sart_sale_date" timestamp(6),
"gen_time" timestamp(6),
"organization_id" int4,
"project_id" int4,
"sex_id" int4,
"unit_id" int4,
"brand_id" int4,
"category_id" int4,
"series_id" int4,
"color_group_id" int4,
"size_group_id" int4,
"model_id" int4,
"rop" numeric(24,10),
"max_stock" numeric(24,10),
"min_stock" numeric(24,10),
"safe_stock" numeric(24,10),
"ordering_cycle" int4,
"ordering_quantity" numeric(24,10),
"purchase_lead_time" int4 DEFAULT 1,
"produce_lead_time" int4 DEFAULT 1,
"external_process_lead_time" int4 DEFAULT 1
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Indexes structure for table ios_base_product
-- ----------------------------
CREATE INDEX "ios_base_product_brand_id" ON "public"."ios_base_product" USING btree ("brand_id");
CREATE INDEX "ios_base_product_category_id" ON "public"."ios_base_product" USING btree ("category_id");
CREATE INDEX "ios_base_product_color_group_id" ON "public"."ios_base_product" USING btree ("color_group_id");
CREATE INDEX "ios_base_product_organization_id" ON "public"."ios_base_product" USING btree ("organization_id");
CREATE INDEX "ios_base_product_project_id" ON "public"."ios_base_product" USING btree ("project_id");
CREATE INDEX "ios_base_product_series_id" ON "public"."ios_base_product" USING btree ("series_id");
CREATE INDEX "ios_base_product_sex_id" ON "public"."ios_base_product" USING btree ("sex_id");
CREATE INDEX "ios_base_product_size_group_id" ON "public"."ios_base_product" USING btree ("size_group_id");
CREATE INDEX "ios_base_product_unit_id" ON "public"."ios_base_product" USING btree ("unit_id");
CREATE INDEX "product_brand_id" ON "public"."ios_base_product" USING btree ("brand_id");
CREATE INDEX "product_category_id" ON "public"."ios_base_product" USING btree ("category_id");
CREATE INDEX "product_color_group_id" ON "public"."ios_base_product" USING btree ("color_group_id");
CREATE INDEX "product_logistics_unit_id" ON "public"."ios_base_product" USING btree ("logistics_unit_id");
CREATE INDEX "product_organization_id" ON "public"."ios_base_product" USING btree ("organization_id");
CREATE INDEX "product_project_id" ON "public"."ios_base_product" USING btree ("project_id");
CREATE INDEX "product_series_id" ON "public"."ios_base_product" USING btree ("series_id");
CREATE INDEX "product_sex_id" ON "public"."ios_base_product" USING btree ("sex_id");
CREATE INDEX "product_size_group_id" ON "public"."ios_base_product" USING btree ("size_group_id");
CREATE INDEX "product_stock_unit_id" ON "public"."ios_base_product" USING btree ("stock_unit_id");
CREATE INDEX "product_unit_id" ON "public"."ios_base_product" USING btree ("unit_id");

-- ----------------------------
-- Primary Key structure for table ios_base_product
-- ----------------------------
ALTER TABLE "public"."ios_base_product" ADD PRIMARY KEY ("product_id");

-- ----------------------------
-- Foreign Key structure for table "public"."ios_base_product"
-- ----------------------------
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("color_group_id") REFERENCES "public"."ios_base_color_group" ("color_group_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("sex_id") REFERENCES "public"."ios_base_sex" ("sex_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("project_id") REFERENCES "public"."ios_base_project" ("project_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("size_group_id") REFERENCES "public"."ios_base_size_group" ("size_group_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("brand_id") REFERENCES "public"."ios_base_product_brand" ("brand_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("series_id") REFERENCES "public"."ios_base_series" ("series_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("organization_id") REFERENCES "public"."ios_base_organization" ("organization_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("category_id") REFERENCES "public"."ios_base_product_category" ("category_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."ios_base_product" ADD FOREIGN KEY ("unit_id") REFERENCES "public"."ios_base_unit" ("unit_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
