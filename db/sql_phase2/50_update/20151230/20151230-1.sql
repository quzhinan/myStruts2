ALTER TABLE `ienursing`.`mst_services` 
CHANGE COLUMN `name` `name` VARCHAR(128) NULL DEFAULT NULL COMMENT 'サービス略称' AFTER `item_code`;


DROP TABLE IF EXISTS `mst_services_temp`;

CREATE TABLE `mst_services_temp` (
  `code` varchar(6) NOT NULL COMMENT 'サービスコード（サービス種類コード＋サービス項目コード）',
  `type_code` varchar(2) NOT NULL COMMENT 'サービス種類コード',
  `item_code` varchar(4) NOT NULL COMMENT 'サービス項目コード',
  `name` varchar(128) DEFAULT NULL COMMENT 'サービス名称',
  `short_name` varchar(64) DEFAULT NULL COMMENT 'サービス略称',
  `unit_total` int(6) NOT NULL DEFAULT '0' COMMENT '単位数（合成単位数）',
  `total_type` int(4) NOT NULL DEFAULT '0' COMMENT '０：月単位計算；１：日割り計算；',
  PRIMARY KEY (`code`),
  UNIQUE KEY `type_code_UNIQUE` (`type_code`,`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='マスターサービスコード';
