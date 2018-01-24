ALTER TABLE `mst_services` 
	DROP COLUMN `mapping_prevent` , 
	DROP COLUMN `mapping_live` , 
	DROP COLUMN `mapping_body` , 
	DROP COLUMN `mapping_key` 
, DROP INDEX `mapping_key_UNIQUE` ;

ALTER TABLE `mst_services` 
	ADD COLUMN `total_type` INT(4) NOT NULL DEFAULT '0' COMMENT '０：月単位計算；１：日割り計算；'  AFTER `unit_total` ;
	
UPDATE `mst_services`
   SET total_type = 1
 WHERE type_code = '11';
