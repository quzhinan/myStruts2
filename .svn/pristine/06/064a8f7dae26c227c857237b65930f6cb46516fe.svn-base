DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(21) NOT NULL COMMENT '職員番号',
  `user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '職員氏名',
  `user_name_kana` varchar(16) DEFAULT NULL COMMENT '職員氏名（カナ）',
  `office_code` varchar(10) NOT NULL DEFAULT '0' COMMENT '所属事業所番号',
  `manager` int(1) DEFAULT '0' COMMENT '管理者',
  `role_type` int(1) DEFAULT '0' COMMENT '権限',
  `help_full_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（常勤）',
  `help_part_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（非常勤）',
  `address` varchar(128) DEFAULT '' COMMENT '住所',
  `address2` varchar(128) DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `email` varchar(128) DEFAULT '' COMMENT 'メール',
  `apple_id` varchar(32) DEFAULT NULL COMMENT 'Apple ID',
  `device_key` varchar(64) NOT NULL DEFAULT '0' COMMENT 'デバイスID',
  `longitude` double DEFAULT '0' COMMENT '経度',
  `latitude` double DEFAULT '0' COMMENT '緯度',
  `password` varchar(64) DEFAULT '' COMMENT 'パスワード（MD5暗号化）',
  `active` int(1) DEFAULT '1' COMMENT '职员是否有效',
  `sort_num` int(10) DEFAULT '999999999' COMMENT '職員表示順位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`),
  KEY `index1` (`id`,`user_code`,`user_name`,`office_code`,`apple_id`,`email`,`longitude`,`latitude`)
);

