ALTER TABLE `ienursing`.`nursing` 
CHANGE COLUMN `nursing_record` `nursing_record` VARCHAR(400) NULL DEFAULT '' COMMENT '介護記録欄' ,
CHANGE COLUMN `office_record` `office_record` VARCHAR(400) NULL DEFAULT NULL COMMENT '事業所使用欄' ;
