ALTER TABLE `ienursing2`.`nursing` 
CHANGE COLUMN `base_service_prepare` `base_service_prepare` INT(4) NULL DEFAULT 1 COMMENT 'サービス準備' ,
CHANGE COLUMN `base_healthcheck` `base_healthcheck` INT(4) NULL DEFAULT 1 COMMENT '健康チェック' ,
CHANGE COLUMN `base_envirwork` `base_envirwork` INT(4) NULL DEFAULT 1 COMMENT '環境整備' ,
CHANGE COLUMN `base_nursing` `base_nursing` INT(4) NULL DEFAULT 1 COMMENT '相談援助' ,
CHANGE COLUMN `base_record` `base_record` INT(4) NULL DEFAULT 1 COMMENT '記録記入' ;
