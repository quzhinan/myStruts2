DROP TABLE IF EXISTS `office`;
CREATE TABLE `office` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `office_code` varchar(10) NOT NULL COMMENT '事業所番号',
  `office_name` varchar(32) NOT NULL DEFAULT '' COMMENT '事業所名',
  `address` varchar(128) NOT NULL DEFAULT '' COMMENT '住所',
  `address2` varchar(128) NOT NULL DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`office_code`)
);

