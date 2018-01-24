ALTER TABLE `nursing` 
ADD COLUMN `event_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 AFTER `update_flag` ;

ALTER TABLE `nursing` 
ADD INDEX `event_INDEX` (`event_id` ASC) ;

ALTER TABLE `nursing` 
	CHANGE COLUMN `user_code` `user_code` VARCHAR(10) NOT NULL COMMENT '担当者番号'  , 
	CHANGE COLUMN `user_code_follow` `user_code_follow` VARCHAR(10) NULL DEFAULT NULL COMMENT '同行者番号'  , 
	CHANGE COLUMN `user_code_service` `user_code_service` VARCHAR(10) NOT NULL DEFAULT '' COMMENT '担当者番号サービス'  , 
	CHANGE COLUMN `office_code` `office_code` VARCHAR(10) NULL DEFAULT '' COMMENT '事業所番号'  ;

ALTER TABLE `nursing` ADD COLUMN `trigger_flag` BIGINT(20) NOT NULL DEFAULT '0'  AFTER `event_id` ;

ALTER TABLE `nursing` 
	ADD INDEX `status_INDEX` (`status` ASC) , 
	ADD INDEX `carry_out_INDEX` (`carry_out` ASC) ;

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

ALTER TABLE `nursing` 
	DROP COLUMN `type_prevent_time` , 
	DROP COLUMN `type_prevent` , 
	DROP COLUMN `type_live_time` , 
	DROP COLUMN `type_live` , 
	DROP COLUMN `type_body_time` , 
	DROP COLUMN `type_body` ;
	
ALTER TABLE `nursing` 
CHANGE COLUMN `nursing_record` `nursing_record` VARCHAR(512) NULL DEFAULT '' COMMENT '介護記録欄'  , 
CHANGE COLUMN `office_record` `office_record` VARCHAR(512) NULL DEFAULT NULL COMMENT '事業所使用欄'  ;

ALTER TABLE `nursing` 
	ADD COLUMN `update_status` INT(4) NULL DEFAULT '0' COMMENT '予定変更＆確認ステータス'  AFTER `update_flag` ;
