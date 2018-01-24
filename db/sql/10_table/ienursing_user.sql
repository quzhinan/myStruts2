-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1    Database: ienursing
-- ------------------------------------------------------
-- Server version	5.5.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `ienursing`.`user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ienursing`.`user` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(21) NOT NULL COMMENT '職員番号',
  `user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '職員氏名',
  `user_name_kana` varchar(16) DEFAULT NULL COMMENT '職員氏名（カナ）',
  `office_code` varchar(8) NOT NULL DEFAULT '0' COMMENT '所属事業所番号',
  `manager` int(1) DEFAULT '0' COMMENT '管理者',
  `role_type` int(1) DEFAULT '0' COMMENT '権限',
  `help_full_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（常勤）',
  `help_part_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（非常勤）',
  `address` varchar(128) DEFAULT '' COMMENT '住所',
  `address2` varchar(128) DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `email` varchar(128) DEFAULT '' COMMENT 'メール',
  `apple_id` varchar(32) DEFAULT NULL COMMENT 'Apple ID',
  `device_key` varchar(64) NOT NULL DEFAULT '0' COMMENT 'デバイスID',
  `longitude` double DEFAULT '0' COMMENT '経度',
  `latitude` double DEFAULT '0' COMMENT '緯度',
  `password` varchar(64) DEFAULT '' COMMENT 'パスワード（MD5暗号化）',
  `is_locked` int(4) DEFAULT '0' COMMENT '0 没有被锁\n1被锁住',
  `login_try_times` int(4) DEFAULT '0' COMMENT '登陆失败次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`),
  KEY `index1` (`id`,`user_code`,`user_name`,`office_code`,`apple_id`,`email`,`longitude`,`latitude`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-22 11:38:01
