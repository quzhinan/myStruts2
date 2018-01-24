DROP TABLE IF EXISTS `event_items`;
CREATE TABLE `event_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_code` varchar(6) NOT NULL COMMENT 'サービスコード',
  `service_date` varchar(8) NOT NULL COMMENT 'サービス実施日（YYYYMMDD）',
  `time_start` varchar(4) NOT NULL COMMENT 'サービス開始時間（HHMM）',
  `time_end` varchar(4) NOT NULL COMMENT 'サービス終了時間（HHMM）',
  `service_time1` int(4) DEFAULT '0' COMMENT 'サービス時間１',
  `service_time2` int(4) DEFAULT '0' COMMENT 'サービス時間２',
  `helper_id` bigint(20) unsigned DEFAULT NULL COMMENT '職員ID',
  `follower_id` bigint(20) unsigned DEFAULT NULL COMMENT '従う職員ID',
  `travel_time` int(4) NOT NULL DEFAULT '0' COMMENT '移動時間（分）',
  `addition_first` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（初回）（０：なし；１：あり）',
  `addition_emergency` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（緊急）（０：なし；１：あり）',
  `type` int(4) NOT NULL DEFAULT '0' COMMENT '区分（１：計画；２：予定；３：実績）',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT 'ステータス（−２：確認済；−１：削除済；０：未使用；１：使用済；２：承認済）',
  `is_modified` int(4) NOT NULL DEFAULT '0' COMMENT '０：実施中変更なし；１：実施中変更あり',
  `update_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  KEY `service_time_INDEX` (`service_date`,`time_start`,`helper_id`),
  KEY `PK_service_idx` (`service_code`),
  KEY `PK_helper_idx` (`helper_id`),
  KEY `PK_follower_idx` (`follower_id`),
  CONSTRAINT `FK_follower` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_helper` FOREIGN KEY (`helper_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_service` FOREIGN KEY (`service_code`) REFERENCES `mst_services` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) COMMENT='イベントーアイテム';

