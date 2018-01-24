ALTER TABLE `event_items` 
	ADD COLUMN `is_modified` INT(4) NOT NULL DEFAULT '0' COMMENT '０：実施中変更なし；１：実施中変更あり'  AFTER `status` ;
