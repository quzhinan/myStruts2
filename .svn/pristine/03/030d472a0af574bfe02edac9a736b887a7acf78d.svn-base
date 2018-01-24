
DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `office_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '事業所ID' ,
  `customer_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '利用者ID' ,
  `service_ym` VARCHAR(6) NOT NULL COMMENT '計画対象年月（YYYYMM）' ,
  `plan_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '計画ID' ,
  `schedule_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '予定ID' ,
  `achievement_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '実績_ID' ,
  `status` INT(4) NOT NULL DEFAULT 0 COMMENT 'ステータス（−１：無効；０：有効）' ,
  `remark` VARCHAR(128) NULL DEFAULT NULL COMMENT '担当への連絡' ,
  `update_status` INT(4) NULL DEFAULT '0' COMMENT '予定変更＆確認ステータス' ,
  `update_datetime` timestamp NULL COMMENT '更新日時' ,
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時' ,
  `trigger_flag` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '++ will Insert, Update, delete from Trigger ',
  PRIMARY KEY (`id`) ,
  INDEX `paln_INDEX` (`plan_id`) , 
  INDEX `schedule_INDEX` (`schedule_id`) , 
  INDEX `achievement_INDEX` (`achievement_id`) , 
  INDEX `service_INDEX` (`office_id` ASC, `service_ym` ASC, `customer_id` ASC, `status` ASC) , 
  INDEX `customer_INDEX` (`office_id` ASC, `customer_id` ASC, `service_ym` ASC, `status` ASC) 
) COMMENT='イベント';
