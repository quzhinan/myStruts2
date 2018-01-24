ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `body_clear_all` INT(4) NULL DEFAULT '0' COMMENT '清拭全身' AFTER `body_clean_part_other`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `body_clear_part` INT(4) NULL DEFAULT '0' COMMENT '清拭部分' AFTER `body_clear_all`;
ALTER TABLE `ienursing`.`nursing` 
CHANGE COLUMN `live_clean_house` `live_clean_liveroom` INT(4) NULL DEFAULT '0' COMMENT '居室' ;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_bedroom` INT(4) NULL DEFAULT '0' COMMENT '寝室' AFTER `live_clean_liveroom`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_wc` INT(4) NULL DEFAULT '0' COMMENT 'トイレ' AFTER `live_clean_bedroom`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_bathroom` INT(4) NULL DEFAULT '0' COMMENT '浴室' AFTER `live_clean_wc`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_taisuo` INT(4) NULL DEFAULT '0' COMMENT '台所' AFTER `live_clean_bathroom`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_langxia` INT(4) NULL DEFAULT '0' COMMENT '廊下' AFTER `live_clean_taisuo`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_ximiansuo` INT(4) NULL DEFAULT '0' COMMENT '洗面所' AFTER `live_clean_langxia`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_clean_pwc` INT(4) NULL DEFAULT '0' COMMENT 'Pトイレ' AFTER `live_clean_ximiansuo`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `live_buy_medical` INT(4) NULL DEFAULT '0' COMMENT '薬取り' AFTER `live_buy_daily`;
ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `office_code` VARCHAR(6) NULL DEFAULT '' COMMENT '事業所番号' AFTER `user_code_service`;

update ienursing.nursing n left join ienursing.customer c on n.customer_code = c.customer_code set user_code_service = c.user_code where user_code_service = 'admin';
update ienursing.nursing n left join ienursing.user u on n.user_code = u.user_code set n.office_code = u.office_code where n.office_code = '';

update ienursing.nursing set today_state_sweat = 0,today_state_color = 1,today_state_appetite = 1, today_state_sleep = 1;