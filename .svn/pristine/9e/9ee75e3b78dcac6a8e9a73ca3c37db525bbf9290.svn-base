ALTER TABLE `customer` 
ADD COLUMN `comment_content` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '指示コメント内容' AFTER `active`,
ADD COLUMN `comment_create_datetime` TIMESTAMP NULL COMMENT '指示コメント作成日時' AFTER `comment_content`,
ADD COLUMN `comment_update_datetime` TIMESTAMP NULL COMMENT '指示コメント更新日時' AFTER `comment_create_datetime`;
