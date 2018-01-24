
DROP TRIGGER IF EXISTS trigger_phase1to2_delete;
DROP TRIGGER IF EXISTS trigger_phase1to2_insert;
DROP TRIGGER IF EXISTS trigger_phase1to2_update;
DROP TRIGGER IF EXISTS trigger_phase2to1_delete;
DROP TRIGGER IF EXISTS trigger_phase2to1_insert;
DROP TRIGGER IF EXISTS trigger_phase2to1_update;

ALTER TABLE `nursing` 
	ADD COLUMN `customer_name_offline` VARCHAR(64) NULL DEFAULT '' COMMENT 'OFFLINE備考' AFTER `customer_code`,
	ADD COLUMN `user_name_offline` VARCHAR(64) NULL DEFAULT '' COMMENT 'OFFLINE備考' AFTER `user_code`,
	ADD COLUMN `user_name_follow_offline` VARCHAR(64) NULL DEFAULT '' COMMENT 'OFFLINE備考' AFTER `user_code_follow`,
	ADD COLUMN `service_code` VARCHAR(6) NULL DEFAULT '' COMMENT 'サービスコード' AFTER `end_time`,
	ADD COLUMN `service_name_offline` VARCHAR(64) NULL DEFAULT '' COMMENT 'OFFLINE備考' AFTER `service_code`,
	ADD COLUMN `service_time1` INT(4) NULL DEFAULT '0' COMMENT 'サービス時間１' AFTER `service_name`,
	ADD COLUMN `service_time2` INT(4) NULL DEFAULT '0' COMMENT 'サービス時間２' AFTER `service_time1`,
	ADD COLUMN `onoff_line_type` INT(1) NULL DEFAULT '0' COMMENT '１：ONLINE；２：OFFLINE；' AFTER `service_time2`,
	ADD COLUMN `onoff_line_creator` VARCHAR(64) NULL DEFAULT '' COMMENT 'OFFLINE備考' AFTER `onoff_line_type`;
	
update nursing n left join mst_services s 
	on n.type_body = s.mapping_body 
   and n.type_live = s.mapping_live
   and n.type_prevent = s.mapping_prevent
set n.service_code = IFNULL(s.code, '');

update nursing set service_time1 = type_body_time, service_time1 = type_live_time + type_prevent_time;

ALTER TABLE `nursing` 
	DROP COLUMN `type_prevent_time` , 
	DROP COLUMN `type_prevent` , 
	DROP COLUMN `type_live_time` , 
	DROP COLUMN `type_live` , 
	DROP COLUMN `type_body_time` , 
	DROP COLUMN `type_body` ;
	
	
