ALTER TABLE `ienursing2`.`user` 
ADD COLUMN `active` INT NULL DEFAULT 1 COMMENT '职员是否有效' AFTER `login_try_times`;

ALTER TABLE `ienursing2`.`customer` 
ADD COLUMN `active` INT NULL DEFAULT 1 COMMENT '利用者是否有效' AFTER `latitude`;
