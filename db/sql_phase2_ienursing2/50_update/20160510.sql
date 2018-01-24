ALTER TABLE `ienursing2`.`event_items` 
DROP FOREIGN KEY `FK_follower`,
DROP FOREIGN KEY `FK_helper`;

ALTER TABLE `ienursing2`.`event_items` 
ADD CONSTRAINT `FK_follower`
  FOREIGN KEY (`follower_id`)
  REFERENCES `ienursing2`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_helper`
  FOREIGN KEY (`helper_id`)
  REFERENCES `ienursing2`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  