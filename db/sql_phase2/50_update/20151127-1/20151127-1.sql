ALTER TABLE `nursing` 
CHANGE COLUMN `nursing_record` `nursing_record` VARCHAR(512) NULL DEFAULT '' COMMENT '介護記録欄'  , 
CHANGE COLUMN `office_record` `office_record` VARCHAR(512) NULL DEFAULT NULL COMMENT '事業所使用欄'  ;

ALTER TABLE `events` 
ADD COLUMN `remark` VARCHAR(128) NULL DEFAULT NULL COMMENT '担当への連絡'  AFTER `status` ;

ALTER TABLE `event_items` 
ADD COLUMN `service_time1` INT(4) NULL DEFAULT '0' COMMENT 'サービス時間１'  AFTER `time_end` , 
ADD COLUMN `service_time2` INT(4) NULL DEFAULT '0' COMMENT 'サービス時間２'  AFTER `service_time1` ;
