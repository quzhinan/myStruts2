use ienursing2;

ALTER TABLE `ienursing2`.`user` 
ADD COLUMN `is_locked` INT(4) NULL DEFAULT 0 COMMENT '0 没有被锁\\n1被锁住' AFTER `password`,
ADD COLUMN `login_try_times` INT(4) NULL DEFAULT 0 COMMENT '登陆失败次数' AFTER `is_locked`;

DROP TABLE IF EXISTS `week`;
CREATE TABLE `week` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_code` varchar(6) NOT NULL COMMENT 'サービスコード',
  `time_start` varchar(4) NOT NULL COMMENT 'サービス開始時間（HHMM）',
  `time_end` varchar(4) NOT NULL COMMENT 'サービス終了時間（HHMM）',
  `service_time1` int(4) DEFAULT '0' COMMENT 'サービス時間１',
  `service_time2` int(4) DEFAULT '0' COMMENT 'サービス時間２',
  `customer_id` bigint(20) NOT NULL,
  `helper_id` bigint(20) NOT NULL COMMENT '職員ID',
  `follower_id` bigint(20) DEFAULT NULL COMMENT '従う職員ID',
  `travel_time` int(4) NOT NULL DEFAULT '0' COMMENT '移動時間（分）',
  `addition_first` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（初回）（０：なし；１：あり）',
  `addition_emergency` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（緊急）（０：なし；１：あり）',
  `week_flag` int(4) NOT NULL DEFAULT '0' COMMENT '2 4 8 16 32 64',
  `update_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  `active` int(4) NOT NULL DEFAULT '1' COMMENT '是否激活该週間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='週間記録';
