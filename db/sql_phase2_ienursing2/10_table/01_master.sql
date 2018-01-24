DROP TABLE IF EXISTS `master`;
CREATE TABLE `master` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `begin_time` int(4) NOT NULL DEFAULT '0' COMMENT '事前開始時間',
  `end_time` int(4) NOT NULL DEFAULT '0' COMMENT '完全終了までの時間',
  `radius` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

