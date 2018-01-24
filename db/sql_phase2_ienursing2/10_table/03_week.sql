use ienursing2;

DROP TABLE IF EXISTS `week`;
CREATE TABLE `week` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_code` varchar(6) NOT NULL COMMENT 'サービスコード',
  `time_start` varchar(4) NOT NULL COMMENT 'サービス開始時間（HHMM）',
  `time_end` varchar(4) NOT NULL COMMENT 'サービス終了時間（HHMM）',
  `service_time1` int(4) DEFAULT '0' COMMENT 'サービス時間１',
  `service_time2` int(4) DEFAULT '0' COMMENT 'サービス時間２',
  `customer_id` bigint(20) NOT NULL,
  `helper_id` bigint(20) DEFAULT NULL COMMENT '職員ID',
  `follower_id` bigint(20) DEFAULT NULL COMMENT '従う職員ID',
  `travel_time` int(4) NOT NULL DEFAULT '0' COMMENT '移動時間（分）',
  `addition_first` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（初回）（０：なし；１：あり）',
  `addition_emergency` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（緊急）（０：なし；１：あり）',
  `week_flag` int(4) NOT NULL DEFAULT '0' COMMENT '2 4 8 16 32 64',
  `update_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  `active` int(4) NOT NULL DEFAULT '1' COMMENT '是否激活该週間',
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_week_helper` FOREIGN KEY (`helper_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_week_follower` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_week_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_week_service` FOREIGN KEY (`service_code`) REFERENCES `mst_services` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='週間記録';