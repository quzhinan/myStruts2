ALTER TABLE `event_items` 
ADD COLUMN `comment_content` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '指示コメント内容' AFTER `update_datetime`,
ADD COLUMN `comment_update_datetime` TIMESTAMP NULL COMMENT '指示コメント更新日時' AFTER `comment_content`,
ADD COLUMN `comment_confirm_status` INT(4) NOT NULL DEFAULT '0' COMMENT '指示コメント確認ステータス（0:指示ない;1:未確認;2:確認済）' AFTER `comment_update_datetime`;
