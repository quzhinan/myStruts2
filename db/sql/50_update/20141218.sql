ALTER TABLE `ienursing`.`customer` 
CHANGE COLUMN `contect_pdf` `contect_pdf` VARCHAR(45) NULL DEFAULT '' COMMENT '連絡先PDF' ,
CHANGE COLUMN `nurse_plane_pdf` `nurse_plane_pdf` VARCHAR(45) NULL DEFAULT '' COMMENT '介護計画PDF' ,
ADD COLUMN `amentity` VARCHAR(45) NULL DEFAULT '' COMMENT 'アメニティ' AFTER `nurse_plane_pdf`;
