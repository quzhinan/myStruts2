DROP TABLE IF EXISTS `mst_services_temp`;

CREATE TABLE `mst_services_temp` (
  `code` VARCHAR(6) NOT NULL COMMENT 'サービスコード（サービス種類コード＋サービス項目コード）' ,
  `type_code` VARCHAR(2) NOT NULL COMMENT 'サービス種類コード' ,
  `item_code` VARCHAR(4) NOT NULL COMMENT 'サービス項目コード' ,
  `name` VARCHAR(128) NULL COMMENT 'サービス名称' ,
  `short_name` VARCHAR(64) NULL COMMENT 'サービス略称' ,
  `unit_total` INT(6) NOT NULL DEFAULT 0 COMMENT '単位数（合成単位数）' ,
  `total_type` INT(4) NOT NULL DEFAULT 0 COMMENT '０：月単位計算；１：日割り計算；',
  PRIMARY KEY (`code`) ,
  UNIQUE INDEX `type_code_UNIQUE` (`type_code` ASC, `item_code` ASC) 
) COMMENT='マスターサービスコード';
