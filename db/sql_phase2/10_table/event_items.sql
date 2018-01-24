
DROP TABLE IF EXISTS `event_items`;

CREATE TABLE `event_items` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_code` VARCHAR(6) NOT NULL COMMENT 'サービスコード' ,
  `service_date` VARCHAR(8) NOT NULL COMMENT 'サービス実施日（YYYYMMDD）' ,
  `time_start` VARCHAR(4) NOT NULL COMMENT 'サービス開始時間（HHMM）' ,
  `time_end` VARCHAR(4) NOT NULL COMMENT 'サービス終了時間（HHMM）' ,
  `service_time1` INT(4) NULL DEFAULT '0' COMMENT 'サービス時間１' ,
  `service_time2` INT(4) NULL DEFAULT '0' COMMENT 'サービス時間２' ,
  `helper_id` BIGINT(20) UNSIGNED COMMENT '職員ID' ,
  `follower_id` BIGINT(20) UNSIGNED COMMENT '従う職員ID' ,
  `travel_time` INT(4) NOT NULL DEFAULT 0 COMMENT '移動時間（分）' ,
  `addition_first` INT(4) NOT NULL DEFAULT 0 COMMENT '加算チェック（初回）（０：なし；１：あり）' ,
  `addition_emergency` INT(4) NOT NULL DEFAULT 0 COMMENT '加算チェック（緊急）（０：なし；１：あり）' ,
  `type` INT(4) NOT NULL DEFAULT 0 COMMENT '区分（１：計画；２：予定；３：実績）' ,
  `status` INT(4) NOT NULL DEFAULT 0 COMMENT 'ステータス（−２：確認済；−１：削除済；０：未使用；１：使用済；２：承認済）' ,
  `update_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '更新日時' ,
  PRIMARY KEY (`id`) ,
  INDEX `service_time_INDEX` (`service_date` ASC, `time_start` ASC, `helper_id` ASC) 
) COMMENT='イベントーアイテム';
