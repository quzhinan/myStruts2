DROP TABLE IF EXISTS `user_online`;
CREATE TABLE `user_online` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_token` varchar(64) NOT NULL COMMENT 'デバイスキー',
  `user_code` varchar(21) NOT NULL COMMENT '職員氏名',
  `create_time` varchar(20) NOT NULL COMMENT '登録日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`)
);

