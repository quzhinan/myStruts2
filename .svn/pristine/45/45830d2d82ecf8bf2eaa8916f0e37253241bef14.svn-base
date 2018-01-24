ALTER TABLE `nursing` 
ADD COLUMN `new_flag` INT(4) NOT NULL DEFAULT '0' AFTER `finished_flag`;

ALTER TABLE `nursing` 
ADD COLUMN `cancel_status` INT(4) NOT NULL DEFAULT '0' AFTER `status`;

ALTER TABLE nursing ADD INDEX nursing_user_code(user_code);
ALTER TABLE nursing ADD INDEX nursing_user_code_follow(user_code_follow);