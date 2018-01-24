delete from week where helper_id not in (select id from user);

delete from week where follower_id not in (select id from user);

delete from week where customer_id not in (select id from customer);

delete from week where service_code not in (select code from mst_services);

ALTER TABLE `ienursing2`.`week` 
CHANGE COLUMN `customer_id` `customer_id` BIGINT(20) UNSIGNED NOT NULL ,
CHANGE COLUMN `helper_id` `helper_id` BIGINT(20) UNSIGNED NULL DEFAULT NULL COMMENT '職員ID' ,
CHANGE COLUMN `follower_id` `follower_id` BIGINT(20) UNSIGNED NULL DEFAULT NULL COMMENT '従う職員ID' ;

ALTER TABLE `ienursing2`.`week` 
ADD CONSTRAINT `FK_week_helper`
  FOREIGN KEY (`helper_id`)
  REFERENCES `ienursing2`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
 
ALTER TABLE `ienursing2`.`week` 
ADD CONSTRAINT `FK_week_follower`
  FOREIGN KEY (`follower_id`)
  REFERENCES `ienursing2`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `ienursing2`.`week` 
ADD CONSTRAINT `FK_week_customer`
  FOREIGN KEY (`customer_id`)
  REFERENCES `ienursing2`.`customer` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `ienursing2`.`week` 
ADD CONSTRAINT `FK_week_service`
  FOREIGN KEY (`service_code`)
  REFERENCES `ienursing2`.`mst_services` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
