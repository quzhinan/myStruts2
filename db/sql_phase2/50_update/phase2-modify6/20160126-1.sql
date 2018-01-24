ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `finished_flag` INT(4) NOT NULL DEFAULT '0' COMMENT '承認OKフラグ' AFTER `scan_status`;
