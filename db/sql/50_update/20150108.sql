ALTER TABLE `ienursing`.`nursing` 
ADD COLUMN `body_excretion_excange` INT(4) NULL DEFAULT 0 COMMENT '交換' AFTER `body_excretion_portablewc`,
ADD COLUMN `body_clean_bath` INT(4) NULL DEFAULT 0 COMMENT '部分浴' AFTER `body_clean_shower`,
ADD COLUMN `body_clear` INT(4) NULL DEFAULT 0 COMMENT '清拭' AFTER `body_clean_part_other`,
ADD COLUMN `body_clean_face` INT(4) NULL DEFAULT 0 COMMENT '整容' AFTER `body_clean_mouse`,
ADD COLUMN `body_move_day` INT(4) NULL DEFAULT 0 COMMENT 'デイ' AFTER `body_move_out_other`,
ADD COLUMN `live_wash_launderette` INT(4) NULL DEFAULT 0 COMMENT 'コインランドリー' AFTER `live_wash_iron`,
ADD COLUMN `live_clean_other` INT(4) NULL DEFAULT 0 COMMENT 'その他' AFTER `live_clean_pwc`,
ADD COLUMN `body_move_help` INT(4) NULL DEFAULT 0 COMMENT '外出介助' AFTER `body_move_move_help`;
