DROP TABLE IF EXISTS `mst_services`;
CREATE TABLE `mst_services` (
  `code` varchar(6) NOT NULL COMMENT 'サービスコード（サービス種類コード＋サービス項目コード）',
  `type_code` varchar(2) NOT NULL COMMENT 'サービス種類コード',
  `item_code` varchar(4) NOT NULL COMMENT 'サービス項目コード',
  `name` varchar(128) DEFAULT NULL COMMENT 'サービス略称',
  `short_name` varchar(64) DEFAULT NULL COMMENT 'サービス略称',
  `unit_total` int(6) NOT NULL DEFAULT '0' COMMENT '単位数（合成単位数）',
  `total_type` int(4) NOT NULL DEFAULT '0' COMMENT '０：月単位計算；１：日割り計算；',
  `office_code` VARCHAR(10) NULL DEFAULT '0000000000',
  `fake_code` VARCHAR(6) NULL,
  `active` INT(4) NULL DEFAULT 1,
  PRIMARY KEY (`code`),
  UNIQUE KEY `type_code_UNIQUE` (`type_code`,`item_code`)
) COMMENT='マスターサービスコード';
