ALTER TABLE `user` 
CHANGE COLUMN `id` `id` BIGINT(20) UNSIGNED AUTO_INCREMENT NOT NULL COMMENT 'ID' ;

ALTER TABLE `user` 
CHANGE COLUMN `office_code` `office_code` VARCHAR(10) NOT NULL DEFAULT '0' COMMENT '所属事業所番号' ;

ALTER TABLE `user` 
CHANGE COLUMN `user_code` `user_code` VARCHAR(10) NOT NULL COMMENT '職員番号' ;
