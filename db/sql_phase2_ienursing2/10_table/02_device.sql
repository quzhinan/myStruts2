DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_key` varchar(64) NOT NULL COMMENT 'デバイスキー',
  `device_name` varchar(45) NOT NULL DEFAULT '' COMMENT 'デバイス名',
  `admit` int(4) DEFAULT NULL COMMENT '認識',
  `mark` varchar(128) DEFAULT NULL COMMENT '備考',
  `create_time` varchar(20) NOT NULL COMMENT '登録日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`device_key`)
);

