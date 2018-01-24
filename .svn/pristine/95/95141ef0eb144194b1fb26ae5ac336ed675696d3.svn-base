ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `scan_customer_code` VARCHAR(12) NULL DEFAULT '' AFTER `trigger_flag`,
ADD COLUMN `scan_time` VARCHAR(45) NULL DEFAULT '' AFTER `scan_customer_code`,
ADD COLUMN `scan_longitude` VARCHAR(45) NULL DEFAULT '' AFTER `scan_time`,
ADD COLUMN `scan_latitude` VARCHAR(45) NULL DEFAULT '' AFTER `scan_longitude`,
ADD COLUMN `scan_status` DECIMAL(1) NULL DEFAULT 0 COMMENT '1:customer_same_address_same, 2:customer_same_address_not, 3:customer_not_address_not, 4:customer_not_address_same' AFTER `scan_latitude`;
