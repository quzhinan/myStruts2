ALTER TABLE `ienursing`.`user` 
CHANGE COLUMN `user_code` `user_code` VARCHAR(21) NOT NULL COMMENT '職員番号' ;
ALTER TABLE `ienursing`.`user_online` 
CHANGE COLUMN `user_code` `user_code` VARCHAR(21) NOT NULL COMMENT '職員氏名' ;
ALTER TABLE `ienursing`.`nursing_temp` 
CHANGE COLUMN `user_code` `user_code` VARCHAR(21) NOT NULL COMMENT '担当者番号' ,
CHANGE COLUMN `user_code_follow` `user_code_follow` VARCHAR(21) NULL DEFAULT NULL COMMENT '同行者番号' ;
ALTER TABLE `ienursing`.`nursing` 
CHANGE COLUMN `user_code` `user_code` VARCHAR(21) NOT NULL COMMENT '担当者番号' ,
CHANGE COLUMN `user_code_follow` `user_code_follow` VARCHAR(21) NULL DEFAULT NULL COMMENT '同行者番号' ,
CHANGE COLUMN `user_code_service` `user_code_service` VARCHAR(21) NOT NULL DEFAULT '' COMMENT '担当者番号サービス' ;
ALTER TABLE `ienursing`.`customer` 
CHANGE COLUMN `user_code` `user_code` VARCHAR(21) NOT NULL DEFAULT '' COMMENT '担当サ責職員番号' ;