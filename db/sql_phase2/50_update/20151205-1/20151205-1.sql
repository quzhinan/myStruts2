ALTER TABLE `events` 
	ADD COLUMN `update_status` INT(4) NULL DEFAULT '0' COMMENT '予定変更＆確認ステータス'  AFTER `remark` ;
	
ALTER TABLE `nursing` 
	ADD COLUMN `update_status` INT(4) NULL DEFAULT '0' COMMENT '予定変更＆確認ステータス'  AFTER `update_flag` ;
