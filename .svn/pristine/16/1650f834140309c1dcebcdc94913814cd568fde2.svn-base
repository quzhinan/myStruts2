DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_code` varchar(20) NOT NULL COMMENT '利用者番号',
  `customer_code_fake` varchar(20) NOT NULL DEFAULT '' COMMENT '利用者番号',
  `customer_name` varchar(10) NOT NULL DEFAULT '' COMMENT '利用者氏名',
  `customer_name_kana` varchar(16) NOT NULL DEFAULT '' COMMENT '利用者氏名（カナ）',
  `user_code` varchar(21) NOT NULL DEFAULT '' COMMENT '担当サ責職員番号',
  `office_code` varchar(45) DEFAULT '事業所番号',
  `address` varchar(128) NOT NULL COMMENT '住所',
  `address2` varchar(128) DEFAULT NULL COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT '' COMMENT '電話番号',
  `email` varchar(64) DEFAULT '' COMMENT 'メール',
  `contect_pdf` varchar(45) DEFAULT '' COMMENT '連絡先PDF',
  `nurse_plane_pdf` varchar(45) DEFAULT '' COMMENT '介護計画PDF',
  `amentity` varchar(45) DEFAULT '' COMMENT 'アメニティ',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  `active` int(1) DEFAULT '1' COMMENT '利用者是否有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`customer_code`),
  KEY `index1` (`id`,`customer_code`,`customer_name`,`email`,`longitude`,`latitude`)
);

