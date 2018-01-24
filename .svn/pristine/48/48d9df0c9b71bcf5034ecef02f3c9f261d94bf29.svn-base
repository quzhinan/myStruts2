ALTER TABLE `ienursing`.`office` CHANGE COLUMN `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID'  ;

ALTER TABLE `ienursing`.`customer` CHANGE COLUMN `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID'  ;

ALTER TABLE `ienursing`.`event_items` 
  ADD CONSTRAINT `FK_service`
  FOREIGN KEY (`service_code` )
  REFERENCES `ienursing`.`mst_services` (`code` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `PK_service_idx` (`service_code` ASC) ;

ALTER TABLE `ienursing`.`event_items` 
  ADD CONSTRAINT `FK_helper`
  FOREIGN KEY (`helper_id` )
  REFERENCES `ienursing`.`user` (`id` )
  ON DELETE SET NULL
  ON UPDATE NO ACTION
, ADD INDEX `PK_helper_idx` (`helper_id` ASC) ;

ALTER TABLE `ienursing`.`event_items` 
  ADD CONSTRAINT `FK_follower`
  FOREIGN KEY (`follower_id` )
  REFERENCES `ienursing`.`user` (`id` )
  ON DELETE SET NULL
  ON UPDATE NO ACTION
, ADD INDEX `PK_follower_idx` (`follower_id` ASC) ;

ALTER TABLE `ienursing`.`events` 
  ADD CONSTRAINT `FK_Office`
  FOREIGN KEY (`office_id` )
  REFERENCES `ienursing`.`office` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `FK_Office_idx` (`office_id` ASC) ;

ALTER TABLE `ienursing`.`events` 
  ADD CONSTRAINT `FK_Customer`
  FOREIGN KEY (`customer_id` )
  REFERENCES `ienursing`.`customer` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `FK_Customer_idx` (`customer_id` ASC) ;
