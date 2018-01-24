DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `office_id` bigint(20) unsigned NOT NULL COMMENT '事業所ID',
  `customer_id` bigint(20) unsigned NOT NULL COMMENT '利用者ID',
  `service_ym` varchar(6) NOT NULL COMMENT '計画対象年月（YYYYMM）',
  `plan_id` bigint(20) unsigned NOT NULL COMMENT '計画ID',
  `schedule_id` bigint(20) unsigned NOT NULL COMMENT '予定ID',
  `achievement_id` bigint(20) unsigned NOT NULL COMMENT '実績_ID',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT 'ステータス（−１：無効；０：有効）',
  `remark` varchar(128) DEFAULT NULL COMMENT '担当への連絡',
  `update_status` int(4) DEFAULT '0' COMMENT '予定変更＆確認ステータス',
  `update_datetime` timestamp NULL DEFAULT NULL COMMENT '更新日時',
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `trigger_flag` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `paln_INDEX` (`plan_id`),
  KEY `schedule_INDEX` (`schedule_id`),
  KEY `achievement_INDEX` (`achievement_id`),
  KEY `service_INDEX` (`office_id`,`service_ym`,`customer_id`,`status`),
  KEY `customer_INDEX` (`office_id`,`customer_id`,`service_ym`,`status`),
  KEY `FK_Office_idx` (`office_id`),
  KEY `FK_Customer_idx` (`customer_id`),
  CONSTRAINT `FK_Customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Office` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) COMMENT='イベント';

