-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: ienursing2
-- ------------------------------------------------------
-- Server version	5.6.22

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_code` varchar(20) NOT NULL COMMENT '利用者番号',
  `customer_code_fake` varchar(20) DEFAULT '',
  `customer_name` varchar(10) NOT NULL DEFAULT '' COMMENT '利用者氏名',
  `customer_name_kana` varchar(16) NOT NULL DEFAULT '' COMMENT '利用者氏名（カナ）',
  `user_code` varchar(21) NOT NULL DEFAULT '' COMMENT '担当サ責職員番号',
  `office_code` varchar(45) DEFAULT '事業所番号',
  `address` varchar(128) NOT NULL COMMENT '住所',
  `address2` varchar(128) DEFAULT NULL COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT '' COMMENT '電話番号',
  `email` varchar(64) DEFAULT '' COMMENT 'メール',
  `contect_pdf` varchar(45) DEFAULT '' COMMENT '連絡先PDF',
  `nurse_plane_pdf` varchar(45) DEFAULT '' COMMENT '介護計画PDF',
  `amentity` varchar(45) DEFAULT '' COMMENT 'アメニティ',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  `active` int(11) DEFAULT '1' COMMENT '利用者是否有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`customer_code`),
  KEY `index1` (`id`,`customer_code`,`customer_name`,`email`,`longitude`,`latitude`)
) ENGINE=InnoDB AUTO_INCREMENT=6392 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_temp`
--

DROP TABLE IF EXISTS `customer_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_temp` (
  `update_type` varchar(1) DEFAULT NULL COMMENT '更新区分',
  `office_code` varchar(10) NOT NULL COMMENT '自機関番号',
  `code` varchar(20) NOT NULL COMMENT '利用者番号',
  `name` varchar(30) DEFAULT NULL COMMENT '利用者氏名',
  `name_kana` varchar(30) DEFAULT NULL COMMENT 'ﾌﾘｶﾞﾅ',
  `sex` varchar(4) DEFAULT NULL COMMENT '性別',
  `age_type` varchar(1) DEFAULT NULL COMMENT '年齢算出区分',
  `birthday` varchar(8) DEFAULT NULL COMMENT '生年月日',
  `age` varchar(3) DEFAULT NULL COMMENT '年齢',
  `age_get_date` varchar(8) DEFAULT NULL COMMENT '年齢算出日',
  `zip_code` varchar(8) DEFAULT NULL COMMENT '郵便番号',
  `address` varchar(40) DEFAULT NULL COMMENT '住所',
  `address2` varchar(40) DEFAULT NULL COMMENT '住所2',
  `phone_number` varchar(13) DEFAULT NULL COMMENT '電話番号',
  `phone_number2_type` varchar(20) DEFAULT NULL COMMENT '電話区分2',
  `phone_number2` varchar(13) DEFAULT NULL COMMENT '電話番号2',
  `job` varchar(30) DEFAULT NULL COMMENT '職業',
  `grade_type_single` varchar(1) DEFAULT NULL COMMENT '世帯区分(独居世帯)',
  `grade_type_elderly` varchar(1) DEFAULT NULL COMMENT '世帯区分(老人世帯)',
  `death_date` varchar(8) DEFAULT NULL COMMENT '死亡日',
  `remark` varchar(1280) DEFAULT NULL COMMENT '備考',
  `account_delete_flag` varchar(1) DEFAULT NULL COMMENT '総合台帳削除FLG',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_key` varchar(64) NOT NULL COMMENT 'デバイスキー',
  `device_name` varchar(45) NOT NULL DEFAULT '' COMMENT 'デバイス名',
  `admit` int(4) DEFAULT NULL COMMENT '認識',
  `mark` varchar(128) DEFAULT NULL COMMENT '備考',
  `create_time` varchar(20) NOT NULL COMMENT '登録日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`device_key`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_items`
--

DROP TABLE IF EXISTS `event_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_code` varchar(6) NOT NULL COMMENT 'サービスコード',
  `service_date` varchar(8) NOT NULL COMMENT 'サービス実施日（YYYYMMDD）',
  `time_start` varchar(4) NOT NULL COMMENT 'サービス開始時間（HHMM）',
  `time_end` varchar(4) NOT NULL COMMENT 'サービス終了時間（HHMM）',
  `service_time1` int(4) DEFAULT '0' COMMENT 'サービス時間１',
  `service_time2` int(4) DEFAULT '0' COMMENT 'サービス時間２',
  `helper_id` bigint(20) unsigned DEFAULT NULL COMMENT '職員ID',
  `follower_id` bigint(20) unsigned DEFAULT NULL COMMENT '従う職員ID',
  `travel_time` int(4) NOT NULL DEFAULT '0' COMMENT '移動時間（分）',
  `addition_first` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（初回）（０：なし；１：あり）',
  `addition_emergency` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（緊急）（０：なし；１：あり）',
  `type` int(4) NOT NULL DEFAULT '0' COMMENT '区分（１：計画；２：予定；３：実績）',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT 'ステータス（−２：確認済；−１：削除済；０：未使用；１：使用済；２：承認済）',
  `is_modified` int(4) NOT NULL DEFAULT '0' COMMENT '０：実施中変更なし；１：実施中変更あり',
  `update_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  KEY `service_time_INDEX` (`service_date`,`time_start`,`helper_id`),
  KEY `PK_service_idx` (`service_code`),
  KEY `PK_helper_idx` (`helper_id`),
  KEY `PK_follower_idx` (`follower_id`),
  CONSTRAINT `FK_follower` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_helper` FOREIGN KEY (`helper_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_service` FOREIGN KEY (`service_code`) REFERENCES `mst_services` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='イベントーアイテム';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `office_id` bigint(20) unsigned NOT NULL COMMENT '事業所ID',
  `customer_id` bigint(20) unsigned NOT NULL COMMENT '利用者ID',
  `service_ym` varchar(6) NOT NULL COMMENT '計画対象年月（YYYYMM）',
  `plan_id` bigint(20) unsigned NOT NULL COMMENT '計画ID',
  `schedule_id` bigint(20) unsigned NOT NULL COMMENT '予定ID',
  `achievement_id` bigint(20) unsigned NOT NULL COMMENT '実績_ID',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT 'ステータス（−１：無効；０：有効）',
  `remark` varchar(128) DEFAULT NULL COMMENT '担当への連絡',
  `update_status` int(4) DEFAULT '0' COMMENT '予定変更＆確認ステータス',
  `update_datetime` timestamp NULL DEFAULT NULL COMMENT '更新日時',
  `create_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `trigger_flag` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `paln_INDEX` (`plan_id`),
  KEY `schedule_INDEX` (`schedule_id`),
  KEY `achievement_INDEX` (`achievement_id`),
  KEY `service_INDEX` (`office_id`,`service_ym`,`customer_id`,`status`),
  KEY `customer_INDEX` (`office_id`,`customer_id`,`service_ym`,`status`),
  KEY `FK_Office_idx` (`office_id`),
  KEY `FK_Customer_idx` (`customer_id`),
  CONSTRAINT `FK_Customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Office` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='イベント';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_phase2to1_insert` AFTER INSERT ON events FOR EACH ROW
BEGIN
	DECLARE sysdate int(10);
	IF new.trigger_flag = 0 THEN
		SET sysdate = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y%m%d');
		INSERT INTO nursing 
			(event_id, trigger_flag, office_code, user_code_service, status, 
			 visit_date, from_time, end_time, 
			 service_time1, service_time2, remark,
			 customer_code, user_code, user_code_follow, 
			 service_code, adding_first, adding_urgency
			)
		SELECT e.id, '1', o.office_code, c.user_code, (CASE WHEN ei.service_date = sysdate THEN '3' ELSE '4' END), 
			   CONCAT(LEFT(ei.service_date, 4), '-', SUBSTRING(ei.service_date, 5, 2), '-', RIGHT(ei.service_date, 2)), 
			   CONCAT(LEFT(ei.time_start, 2), ':', RIGHT(ei.time_start, 2)), 
			   CONCAT(LEFT(ei.time_end, 2), ':', RIGHT(ei.time_end, 2)),
			   ei.service_time1, ei.service_time2, e.remark,
			   c.customer_code, IFNULL(h.user_code, ''), IFNULL(f.user_code, ''),
			   ei.service_code, ei.addition_first, ei.addition_emergency
		  FROM events e 
			   INNER JOIN event_items ei ON e.achievement_id = ei.id
			   INNER JOIN office o ON e.office_id = o.id
			   INNER JOIN customer c ON e.customer_id = c.id
			   LEFT JOIN `user` h ON ei.helper_id = h.id
			   LEFT JOIN `user` f ON ei.follower_id = f.id
		 WHERE e.id = new.id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trigger_phase2to1_update` AFTER UPDATE ON events FOR EACH ROW
BEGIN
	DECLARE sysdate int(10);
	IF old.trigger_flag = new.trigger_flag THEN
		SET sysdate = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y%m%d');
		UPDATE nursing n
	       INNER JOIN events e ON e.id = n.event_id
		   INNER JOIN event_items ei ON e.achievement_id = ei.id
		   INNER JOIN office o ON e.office_id = o.id
		   INNER JOIN customer c ON e.customer_id = c.id
		   LEFT JOIN `user` h ON ei.helper_id = h.id
		   LEFT JOIN `user` f ON ei.follower_id = f.id
		SET n.office_code = o.office_code,
			n.status = (CASE WHEN ei.status > 0 THEN n.status ELSE (CASE WHEN ei.status = -2 OR ei.status = -1 THEN '6'  WHEN ei.status = -12 THEN '7' WHEN ei.service_date = sysdate THEN '3' ELSE '4' END) END),
		    n.visit_date = CONCAT(LEFT(ei.service_date, 4), '-', SUBSTRING(ei.service_date, 5, 2), '-', RIGHT(ei.service_date, 2)), 
		    n.from_time = CONCAT(LEFT(ei.time_start, 2), ':', RIGHT(ei.time_start, 2)),
		    n.end_time = CONCAT(LEFT(ei.time_end, 2), ':', RIGHT(ei.time_end, 2)),
		    n.customer_code = c.customer_code,
		    n.user_code = IFNULL(h.user_code, ''), 
		    n.user_code_follow = IFNULL(f.user_code, ''),
		    n.service_code = ei.service_code, 
		    n.adding_first = ei.addition_first, 
		    n.service_time1 = ei.service_time1,
		    n.service_time2 = ei.service_time2,
		    n.adding_urgency = ei.addition_emergency,
		    n.remark = e.remark,
	   		n.update_status = e.update_status,
		    n.trigger_flag = n.trigger_flag + 1	   
		 WHERE n.event_id = new.id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_phase2to1_delete` AFTER DELETE ON events FOR EACH ROW
BEGIN
	IF old.trigger_flag >= 0 THEN
		UPDATE nursing SET trigger_flag = -1 WHERE event_id = old.id;
		DELETE FROM nursing WHERE event_id = old.id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `master`
--

DROP TABLE IF EXISTS `master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `begin_time` int(4) NOT NULL DEFAULT '0' COMMENT '事前開始時間',
  `end_time` int(4) NOT NULL DEFAULT '0' COMMENT '完全終了までの時間',
  `radius` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_constants`
--

DROP TABLE IF EXISTS `mst_constants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mst_constants` (
  `id` bigint(20) unsigned NOT NULL,
  `code` varchar(128) NOT NULL,
  `label` varchar(128) NOT NULL,
  `value` varchar(128) NOT NULL,
  `remark` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_environments`
--

DROP TABLE IF EXISTS `mst_environments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mst_environments` (
  `id` bigint(20) unsigned NOT NULL,
  `param_key` varchar(128) NOT NULL,
  `param_name` varchar(128) NOT NULL,
  `param_value` varchar(128) NOT NULL,
  `remark` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_services`
--

DROP TABLE IF EXISTS `mst_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mst_services` (
  `code` varchar(6) NOT NULL COMMENT 'サービスコード（サービス種類コード＋サービス項目コード）',
  `type_code` varchar(2) NOT NULL COMMENT 'サービス種類コード',
  `item_code` varchar(4) NOT NULL COMMENT 'サービス項目コード',
  `name` varchar(128) DEFAULT NULL COMMENT 'サービス略称',
  `short_name` varchar(64) DEFAULT NULL COMMENT 'サービス略称',
  `unit_total` int(6) NOT NULL DEFAULT '0' COMMENT '単位数（合成単位数）',
  `total_type` int(4) NOT NULL DEFAULT '0' COMMENT '０：月単位計算；１：日割り計算；',
  `office_code` varchar(10) DEFAULT '0000000000',
  `fake_code` varchar(6) DEFAULT NULL,
  `active` int(4) DEFAULT '1',
  PRIMARY KEY (`code`),
  UNIQUE KEY `type_code_UNIQUE` (`type_code`,`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='マスターサービスコード';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mst_services_temp`
--

DROP TABLE IF EXISTS `mst_services_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mst_services_temp` (
  `code` varchar(6) NOT NULL COMMENT 'サービスコード（サービス種類コード＋サービス項目コード）',
  `type_code` varchar(2) NOT NULL COMMENT 'サービス種類コード',
  `item_code` varchar(4) NOT NULL COMMENT 'サービス項目コード',
  `name` varchar(128) DEFAULT NULL COMMENT 'サービス名称',
  `short_name` varchar(64) DEFAULT NULL COMMENT 'サービス略称',
  `unit_total` int(6) NOT NULL DEFAULT '0' COMMENT '単位数（合成単位数）',
  `total_type` int(4) NOT NULL DEFAULT '0' COMMENT '０：月単位計算；１：日割り計算；',
  PRIMARY KEY (`code`),
  UNIQUE KEY `type_code_UNIQUE` (`type_code`,`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nursing`
--

DROP TABLE IF EXISTS `nursing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nursing` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'サービス番号',
  `customer_code` varchar(20) NOT NULL COMMENT '利用者番号',
  `customer_name_offline` varchar(64) DEFAULT '' COMMENT 'OFFLINE備考',
  `user_code` varchar(21) NOT NULL COMMENT '担当者番号',
  `user_name_offline` varchar(64) DEFAULT '' COMMENT 'OFFLINE備考',
  `user_code_follow` varchar(21) DEFAULT NULL COMMENT '同行者番号',
  `user_name_follow_offline` varchar(64) DEFAULT '' COMMENT 'OFFLINE備考',
  `visit_date` varchar(10) NOT NULL COMMENT '訪問日',
  `from_time` varchar(8) NOT NULL DEFAULT '' COMMENT '开始时刻',
  `end_time` varchar(8) NOT NULL DEFAULT '' COMMENT '结束时刻',
  `service_code` varchar(6) DEFAULT '' COMMENT 'サービスコード',
  `service_name_offline` varchar(64) DEFAULT '' COMMENT 'OFFLINE備考',
  `service_time1` int(4) DEFAULT '0' COMMENT 'サービス時間１',
  `service_time2` int(4) DEFAULT '0' COMMENT 'サービス時間２',
  `onoff_line_type` int(1) DEFAULT '0' COMMENT '１：ONLINE；２：OFFLINE；',
  `onoff_line_creator` varchar(64) DEFAULT '' COMMENT 'OFFLINE備考',
  `adding_first` int(4) DEFAULT '0' COMMENT '加算・初回',
  `adding_urgency` int(4) DEFAULT '0' COMMENT '加算・緊急時訪問介護',
  `base_service_prepare` int(4) DEFAULT '1' COMMENT 'サービス準備',
  `base_healthcheck` int(4) DEFAULT '1' COMMENT '健康チェック',
  `base_envirwork` int(4) DEFAULT '1' COMMENT '環境整備',
  `base_nursing` int(4) DEFAULT '1' COMMENT '相談援助',
  `base_record` int(4) DEFAULT '1' COMMENT '記録記入',
  `body_excretion_wc` int(4) DEFAULT '0' COMMENT 'トイレ',
  `body_excretion_portablewc` int(4) DEFAULT '0' COMMENT 'ポータブルトイレ',
  `body_excretion_excange` int(4) DEFAULT '0' COMMENT '交換',
  `body_excretion_diaper` int(4) DEFAULT '0' COMMENT 'オムツ交換',
  `body_excretion_pants` int(4) DEFAULT '0' COMMENT 'リハビリパンツ交換',
  `body_excretion_pat` int(4) DEFAULT '0' COMMENT 'パット交換',
  `body_excretion_clean` int(4) DEFAULT '0' COMMENT '陰部・臀部の保清',
  `body_excretion_urination_observe` varchar(128) DEFAULT '' COMMENT '排尿の観察・記録',
  `body_excretion_bowel_observe` varchar(128) DEFAULT '' COMMENT '排便の観察・記録',
  `body_eat_help` int(4) DEFAULT '0' COMMENT '食事介助',
  `body_eat_observe` varchar(128) DEFAULT '0' COMMENT '食事内容量の観察・記録',
  `body_eat_water` varchar(128) DEFAULT '0' COMMENT '水分補給・量の記録',
  `body_eat_special` int(4) DEFAULT '0' COMMENT '特別食の調理',
  `body_clean_all` int(4) DEFAULT '0' COMMENT '全身浴',
  `body_clean_shower` int(4) DEFAULT '0' COMMENT 'シャワー浴',
  `body_clean_bath` int(4) DEFAULT '0' COMMENT '部分浴',
  `body_clean_part_hand` int(4) DEFAULT '0' COMMENT '部分浴  手',
  `body_clean_part_foot` int(4) DEFAULT '0' COMMENT '部分浴  足',
  `body_clean_part_other` int(4) DEFAULT '0' COMMENT '部分浴  その他',
  `body_clear` int(4) DEFAULT '0' COMMENT '清拭',
  `body_clear_all` int(4) DEFAULT '0' COMMENT '清拭全身',
  `body_clear_part` int(4) DEFAULT '0' COMMENT '清拭部分',
  `body_clean_gown` varchar(128) DEFAULT '' COMMENT '更衣',
  `body_clean_hair` int(4) DEFAULT '0' COMMENT '洗髪',
  `body_clean_mouse` int(4) DEFAULT '0' COMMENT '口腔ケア',
  `body_clean_face` int(4) DEFAULT '0' COMMENT '整容',
  `body_clean_face_hair` int(4) DEFAULT '0' COMMENT '整容 整髪',
  `body_clean_face_nail` int(4) DEFAULT '0' COMMENT '整容 爪切',
  `body_clean_face_higesu` int(4) DEFAULT '0' COMMENT '整容 髭剃り',
  `body_move_change` varchar(128) DEFAULT '' COMMENT '体位交換',
  `body_move_error_help` int(4) DEFAULT '0' COMMENT '移乗介助',
  `body_move_move_help` varchar(128) DEFAULT '' COMMENT '移動介助',
  `body_move_help` int(4) DEFAULT '0' COMMENT '外出介助',
  `body_move_out_buy` int(4) DEFAULT '0' COMMENT '外出介助  買い物',
  `body_move_out_other` varchar(128) DEFAULT '' COMMENT '外出介助  その他',
  `body_move_day` int(4) DEFAULT '0' COMMENT 'デイ',
  `body_move_day_in` int(4) DEFAULT '0' COMMENT '迎え入れ',
  `body_move_day_out` int(4) DEFAULT '0' COMMENT '送り出し',
  `body_move_hostipal` int(4) DEFAULT '0' COMMENT '通院介助',
  `body_getup_help` int(4) DEFAULT '0' COMMENT '起床介助',
  `body_getup_sleep` int(4) DEFAULT '0' COMMENT '就寝介助',
  `body_medical_help` int(4) DEFAULT '0' COMMENT '服薬介助',
  `body_medical_sure` int(4) DEFAULT '0' COMMENT '服薬確認',
  `body_medical_app` int(4) DEFAULT '0' COMMENT '薬の塗布',
  `body_medical_other` varchar(128) DEFAULT '' COMMENT 'その他',
  `body_self_cook` int(4) DEFAULT '0' COMMENT 'ともに行う調理',
  `body_self_clean` int(4) DEFAULT '0' COMMENT 'ともに行う掃除',
  `body_self_wash` int(4) DEFAULT '0' COMMENT 'ともに行う洗濯',
  `body_self_other` varchar(128) DEFAULT '' COMMENT 'その他',
  `live_clean_liveroom` int(4) DEFAULT '0' COMMENT '居室',
  `live_clean_bedroom` int(4) DEFAULT '0' COMMENT '寝室',
  `live_clean_wc` int(4) DEFAULT '0' COMMENT 'トイレ',
  `live_clean_bathroom` int(4) DEFAULT '0' COMMENT '浴室',
  `live_clean_taisuo` int(4) DEFAULT '0' COMMENT '台所',
  `live_clean_langxia` int(4) DEFAULT '0' COMMENT '廊下',
  `live_clean_ximiansuo` int(4) DEFAULT '0' COMMENT '洗面所',
  `live_clean_pwc` int(4) DEFAULT '0' COMMENT 'Pトイレ',
  `live_clean_other` int(4) DEFAULT '0' COMMENT 'その他',
  `live_clean_trash` int(4) DEFAULT '0' COMMENT 'ゴミ処理',
  `live_wash_wash` int(4) DEFAULT '0' COMMENT '洗う',
  `live_wash_dra` int(4) DEFAULT '0' COMMENT '干す',
  `live_wash_incorporating` int(4) DEFAULT '0' COMMENT '取入れ',
  `live_wash_receipt` int(4) DEFAULT '0' COMMENT '収納',
  `live_wash_iron` int(4) DEFAULT '0' COMMENT 'アイロン',
  `live_wash_launderette` int(4) DEFAULT '0' COMMENT 'コインランドリー',
  `live_wash_launderette_wash` int(4) DEFAULT '0' COMMENT 'コインランドリー　洗う',
  `live_wash_launderette_dry` int(4) DEFAULT '0' COMMENT 'コインランドリー　乾燥',
  `live_cloth_org` int(4) DEFAULT '0' COMMENT '衣類の整理',
  `live_cloth_repair` varchar(128) DEFAULT '0' COMMENT '被服の補修',
  `live_bedding_making` int(4) DEFAULT '0' COMMENT 'ベッドメイキング',
  `live_bedding_linen_change` int(4) DEFAULT '0' COMMENT 'リネン交換',
  `live_bedding_futon` int(4) DEFAULT '0' COMMENT '布団干し',
  `live_buy_food` int(4) DEFAULT '0' COMMENT '食品の買い物',
  `live_buy_daily` int(4) DEFAULT '0' COMMENT '日用品の買い物',
  `live_buy_medical` int(4) DEFAULT '0' COMMENT '薬取り',
  `live_buy_other` varchar(128) DEFAULT '0' COMMENT 'その他',
  `live_cook_mise` int(4) DEFAULT '0' COMMENT '下ごしらえ',
  `live_cook_normal` varchar(128) DEFAULT '' COMMENT '一般的な調理',
  `live_cook_zen` int(4) DEFAULT '0' COMMENT '配下膳',
  `live_cook_clean` int(4) DEFAULT '0' COMMENT '後片付け',
  `live_buy_destination` varchar(45) DEFAULT '' COMMENT '薬の受け取り',
  `live_buy_deposit` int(4) DEFAULT '0' COMMENT '預かり金',
  `live_buy_usegold` int(4) DEFAULT '0' COMMENT '使用金',
  `live_buy_refund` int(4) DEFAULT '0' COMMENT '返金',
  `today_state_sweat` int(4) DEFAULT '0' COMMENT '発汗',
  `today_state_crossponding` varchar(128) DEFAULT '' COMMENT 'ある場合の対応',
  `today_state_color` int(4) DEFAULT '1' COMMENT '顔色',
  `today_state_appetite` int(4) DEFAULT '1' COMMENT '食欲',
  `today_state_sleep` int(4) DEFAULT '1' COMMENT '睡眠',
  `nursing_record` varchar(400) DEFAULT '' COMMENT '介護記録欄',
  `office_record` varchar(400) DEFAULT NULL COMMENT '事業所使用欄',
  `remark` varchar(128) DEFAULT NULL COMMENT '担当への連絡',
  `photo_one` varchar(45) DEFAULT '' COMMENT '画像',
  `photo_two` varchar(45) DEFAULT '' COMMENT '画像',
  `photo_three` varchar(45) DEFAULT '' COMMENT '画像',
  `voice_one` varchar(45) DEFAULT '' COMMENT '録音',
  `voice_two` varchar(45) DEFAULT '' COMMENT '録音',
  `voice_three` varchar(45) DEFAULT '' COMMENT '録音',
  `type_insurance_out_service` int(4) DEFAULT '0' COMMENT '保険外サービス',
  `type_disability_body` int(4) DEFAULT '0' COMMENT '身体',
  `type_disability_housework` int(4) DEFAULT '0' COMMENT '家事',
  `type_disability_hospital` int(4) DEFAULT '0' COMMENT '通院',
  `type_disability_heavy` int(4) DEFAULT '0' COMMENT '重訪',
  `type_disability_accompanying` int(4) DEFAULT '0' COMMENT '同行',
  `type_disability_move` int(4) DEFAULT '0' COMMENT '移動',
  `user_code_service` varchar(21) NOT NULL DEFAULT '' COMMENT '担当者番号サービス',
  `office_code` varchar(10) DEFAULT '' COMMENT '事業所番号',
  `status` int(4) DEFAULT '0' COMMENT '訪問状況',
  `cancel_status` int(4) NOT NULL DEFAULT '0',
  `carry_out` int(4) DEFAULT '0' COMMENT '実施',
  `update_flag` int(4) DEFAULT '0' COMMENT '変更',
  `update_status` int(4) DEFAULT '0' COMMENT '予定変更＆確認ステータス',
  `event_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `trigger_flag` bigint(20) NOT NULL DEFAULT '0',
  `scan_customer_code` varchar(20) DEFAULT '',
  `scan_time` varchar(45) DEFAULT '',
  `scan_longitude` varchar(45) DEFAULT '',
  `scan_latitude` varchar(45) DEFAULT '',
  `scan_status` decimal(1,0) DEFAULT '0' COMMENT '1:customer_same_address_same, 2:customer_same_address_not, 3:customer_not_address_not, 4:customer_not_address_same',
  `finished_flag` int(4) NOT NULL DEFAULT '0' COMMENT '承認OKフラグ',
  `new_flag` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `event_INDEX` (`event_id`),
  KEY `index3` (`status`),
  KEY `index4` (`carry_out`),
  KEY `nursing_visit_date` (`visit_date`),
  KEY `nursing_from_time` (`from_time`),
  KEY `nursing_end_time` (`end_time`),
  KEY `nursing_status` (`status`),
  KEY `nursing_service_code` (`service_code`),
  KEY `nursing_visit_date_time_customer` (`visit_date`,`from_time`,`customer_code`),
  KEY `nursing_office_code_date` (`office_code`,`visit_date`),
  KEY `nursing_carry_out_date_time` (`carry_out`,`visit_date`,`from_time`),
  KEY `nursing_visit_date_time_status` (`visit_date`,`from_time`,`status`),
  KEY `nursing_visit_date_status` (`visit_date`,`status`),
  KEY `nursing_user_code` (`user_code`),
  KEY `nursing_user_code_follow` (`user_code_follow`),
  KEY `nursing_customer_code` (`customer_code`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_phase1to2_insert` BEFORE INSERT ON nursing FOR EACH ROW
BEGIN
	
	DECLARE l_event_id, l_plan_id, l_schedule_id, l_achievement_id BIGINT(20);
	DECLARE l_office_id, l_customer_id, l_helper_id, l_follower_id BIGINT(20);
	
	IF new.trigger_flag = 0 AND new.service_code <> '' AND new.customer_code <> '' THEN
	
		-- get master values
		SELECT id into l_office_id FROM office WHERE office_code = new.office_code;
		SELECT id into l_customer_id FROM customer WHERE customer_code = new.customer_code;
		SELECT id into l_helper_id FROM `user` WHERE user_code = new.user_code;
		SELECT id into l_follower_id FROM `user` WHERE user_code = new.user_code_follow;
	
		-- insert plan & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			service_time1, service_time2,
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 new.service_time1, new.service_time2,
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '1', '0'
			);
	   	 SELECT MAX(id) into l_plan_id FROM event_items;
	   	 
		-- insert schedule & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			service_time1, service_time2,
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 new.service_time1, new.service_time2,
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '2', '0'
			);
	   	 SELECT MAX(id) into l_schedule_id FROM event_items;
	   	 
		-- insert achievement & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			service_time1, service_time2,
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 new.service_time1, new.service_time2,
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '3', '0'
			);
	   	 SELECT MAX(id) into l_achievement_id FROM event_items;
	   	 
		-- insert event & get id
		INSERT INTO events 
			(office_id, customer_id, service_ym, 
			plan_id, schedule_id, achievement_id, status, remark, trigger_flag)
		VALUES 
			(l_office_id, l_customer_id, LEFT(REPLACE(new.visit_date, '-', ''), 6),
			 l_plan_id, l_schedule_id, l_achievement_id, '0', new.remark, '1'
			);
	   	 SELECT MAX(id) into l_event_id FROM events;
	   	 
	   	 -- update event id to nursing
	   	 SET new.event_id = l_event_id;
	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_phase1to2_update_offline` BEFORE UPDATE ON nursing FOR EACH ROW
BEGIN
	
	DECLARE l_event_id, l_plan_id, l_schedule_id, l_achievement_id BIGINT(20);
	DECLARE l_office_id, l_customer_id, l_helper_id, l_follower_id BIGINT(20);
	
	IF old.trigger_flag = new.trigger_flag AND old.event_id = '0' AND new.service_code <> '' AND new.customer_code <> '' THEN
	
		-- get master values
		SELECT id into l_office_id FROM office WHERE office_code = new.office_code;
		SELECT id into l_customer_id FROM customer WHERE customer_code = new.customer_code;
		SELECT id into l_helper_id FROM `user` WHERE user_code = new.user_code;
		SELECT id into l_follower_id FROM `user` WHERE user_code = new.user_code_follow;
	
		-- insert plan & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			service_time1, service_time2,
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 new.service_time1, new.service_time2,
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '1', '0'
			);
	   	 SELECT MAX(id) into l_plan_id FROM event_items;
	   	 
		-- insert schedule & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			service_time1, service_time2,
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 new.service_time1, new.service_time2,
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '2', '0'
			);
	   	 SELECT MAX(id) into l_schedule_id FROM event_items;
	   	 
		-- insert achievement & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			service_time1, service_time2,
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 new.service_time1, new.service_time2,
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '3', '0'
			);
	   	 SELECT MAX(id) into l_achievement_id FROM event_items;
	   	 
		-- insert event & get id
		INSERT INTO events 
			(office_id, customer_id, service_ym, 
			plan_id, schedule_id, achievement_id, status, remark, trigger_flag)
		VALUES 
			(l_office_id, l_customer_id, LEFT(REPLACE(new.visit_date, '-', ''), 6),
			 l_plan_id, l_schedule_id, l_achievement_id, '0', new.remark, '1'
			);
	   	 SELECT MAX(id) into l_event_id FROM events;
	   	 
	   	 -- update event id to nursing
	   	 SET new.event_id = l_event_id;
	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trigger_phase1to2_update` AFTER UPDATE ON nursing FOR EACH ROW
BEGIN
	
	IF old.trigger_flag = new.trigger_flag AND new.service_code <> '' AND new.customer_code <> '' THEN
		UPDATE event_items ei
       		INNER JOIN events e ON e.achievement_id = ei.id
       		INNER JOIN nursing n ON n.event_id = e.id AND n.event_id = new.event_id
	   		LEFT JOIN `user` h ON h.user_code = n.user_code
	   		LEFT JOIN `user` f ON f.user_code = n.user_code_follow
       	SET ei.service_code = n.service_code,
       		ei.service_date = REPLACE(n.visit_date, '-', ''),
       		ei.time_start = REPLACE(n.from_time, ':', ''),
       		ei.time_end = REPLACE(n.end_time, ':', ''),
       		ei.service_time1 = n.service_time1,
       		ei.service_time2 = n.service_time2,
       		ei.helper_id = h.id,
       		ei.follower_id = f.id,
       		ei.addition_first = n.adding_first,
       		ei.addition_emergency = n.adding_urgency,
       		ei.is_modified = (CASE WHEN n.status=8 THEN '2' WHEN n.status=2 THEN '1' ELSE '0' END),
       		ei.status = (CASE WHEN n.status=7 THEN '-12' WHEN n.status=0 THEN '-11' WHEN n.status=6 THEN '-2' WHEN n.status=5 THEN '2'  WHEN n.status=1 OR n.status=2 OR n.status=8 THEN '1' ELSE '0' END);
	
    	UPDATE events e
    		INNER JOIN nursing n ON n.event_id = e.id AND n.event_id = new.event_id
	   		INNER JOIN customer c ON c.customer_code = n.customer_code
	   	SET e.customer_id = c.id,
	   		e.remark = n.remark,
	   		e.update_status = new.update_status,
	    	e.trigger_flag = e.trigger_flag + 1	;
	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_phase1to2_delete` AFTER DELETE ON nursing FOR EACH ROW
BEGIN
	IF old.trigger_flag >= 0 THEN
		UPDATE events SET trigger_flag = -1 WHERE id = old.event_id;
		DELETE FROM event_items WHERE id IN (SELECT plan_id FROM events WHERE id = old.event_id);
		DELETE FROM event_items WHERE id IN (SELECT schedule_id FROM events WHERE id = old.event_id);
		DELETE FROM event_items WHERE id IN (SELECT achievement_id FROM events WHERE id = old.event_id);
		DELETE FROM events WHERE id = old.event_id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nursing_temp`
--

DROP TABLE IF EXISTS `nursing_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nursing_temp` (
  `customer_code` varchar(20) NOT NULL COMMENT '利用者番号',
  `user_code` varchar(21) NOT NULL COMMENT '担当者番号',
  `user_code_follow` varchar(21) DEFAULT NULL COMMENT '同行者番号',
  `visit_date` varchar(10) NOT NULL COMMENT '訪問日',
  `from_time` varchar(8) NOT NULL DEFAULT '' COMMENT '开始时刻',
  `end_time` varchar(8) NOT NULL DEFAULT '' COMMENT '结束时刻',
  `type_body` int(4) DEFAULT '0' COMMENT '身体',
  `type_body_time` int(4) DEFAULT '0' COMMENT '身体・時間',
  `type_live` int(4) DEFAULT '0' COMMENT '生活',
  `type_live_time` int(4) DEFAULT '0' COMMENT '生活・時間',
  `type_prevent` int(4) DEFAULT '0' COMMENT '予防',
  `type_prevent_time` int(4) DEFAULT '0' COMMENT '予防・時間',
  `adding_first` int(4) DEFAULT '0' COMMENT '加算・初回',
  `adding_urgency` int(4) DEFAULT '0' COMMENT '加算・緊急時訪問介護',
  `base_service_prepare` int(4) DEFAULT '0' COMMENT 'サービス準備',
  `base_healthcheck` int(4) DEFAULT '0' COMMENT '健康チェック',
  `base_envirwork` int(4) DEFAULT '0' COMMENT '環境整備',
  `base_nursing` int(4) DEFAULT '0' COMMENT '相談援助',
  `base_record` int(4) DEFAULT '0' COMMENT '記録記入',
  `body_excretion_wc` int(4) DEFAULT '0' COMMENT 'トイレ',
  `body_excretion_portablewc` int(4) DEFAULT '0' COMMENT 'ポータブルトイレ',
  `body_excretion_excange` int(4) DEFAULT '0' COMMENT '交換',
  `body_excretion_diaper` int(4) DEFAULT '0' COMMENT 'オムツ交換',
  `body_excretion_pants` int(4) DEFAULT '0' COMMENT 'リハビリパンツ交換',
  `body_excretion_pat` int(4) DEFAULT '0' COMMENT 'パット交換',
  `body_excretion_clean` int(4) DEFAULT '0' COMMENT '陰部・臀部の保清',
  `body_excretion_urination_observe` varchar(128) DEFAULT '' COMMENT '排尿の観察・記録',
  `body_excretion_bowel_observe` varchar(128) DEFAULT '' COMMENT '排便の観察・記録',
  `body_eat_help` int(4) DEFAULT '0' COMMENT '食事介助',
  `body_eat_observe` varchar(128) DEFAULT '0' COMMENT '食事内容量の観察・記録',
  `body_eat_water` varchar(128) DEFAULT '0' COMMENT '水分補給・量の記録',
  `body_eat_special` int(4) DEFAULT '0' COMMENT '特別食の調理',
  `body_clean_all` int(4) DEFAULT '0' COMMENT '全身浴',
  `body_clean_shower` int(4) DEFAULT '0' COMMENT 'シャワー浴',
  `body_clean_bath` int(4) DEFAULT '0' COMMENT '部分浴',
  `body_clean_part_hand` int(4) DEFAULT '0' COMMENT '部分浴  手',
  `body_clean_part_foot` int(4) DEFAULT '0' COMMENT '部分浴  足',
  `body_clean_part_other` int(4) DEFAULT '0' COMMENT '部分浴  その他',
  `body_clear` int(4) DEFAULT '0' COMMENT '清拭',
  `body_clear_all` int(4) DEFAULT '0' COMMENT '清拭全身',
  `body_clear_part` int(4) DEFAULT '0' COMMENT '清拭部分',
  `body_clean_gown` varchar(128) DEFAULT '' COMMENT '更衣',
  `body_clean_hair` int(4) DEFAULT '0' COMMENT '洗髪',
  `body_clean_mouse` int(4) DEFAULT '0' COMMENT '口腔ケア',
  `body_clean_face` int(4) DEFAULT '0' COMMENT '整容',
  `body_clean_face_hair` int(4) DEFAULT '0' COMMENT '整容 整髪',
  `body_clean_face_nail` int(4) DEFAULT '0' COMMENT '整容 爪切',
  `body_clean_face_higesu` int(4) DEFAULT '0' COMMENT '整容 髭剃り',
  `body_move_change` varchar(128) DEFAULT '' COMMENT '体位交換',
  `body_move_error_help` int(4) DEFAULT '0' COMMENT '移乗介助',
  `body_move_move_help` varchar(128) DEFAULT '' COMMENT '移動介助',
  `body_move_help` int(4) DEFAULT '0' COMMENT '外出介助',
  `body_move_out_buy` int(4) DEFAULT '0' COMMENT '外出介助  買い物',
  `body_move_out_other` varchar(128) DEFAULT '' COMMENT '外出介助  その他',
  `body_move_day` int(4) DEFAULT '0' COMMENT 'デイ',
  `body_move_day_in` int(4) DEFAULT '0' COMMENT '迎え入れ',
  `body_move_day_out` int(4) DEFAULT '0' COMMENT '送り出し',
  `body_move_hostipal` int(4) DEFAULT '0' COMMENT '通院介助',
  `body_getup_help` int(4) DEFAULT '0' COMMENT '起床介助',
  `body_getup_sleep` int(4) DEFAULT '0' COMMENT '就寝介助',
  `body_medical_help` int(4) DEFAULT '0' COMMENT '服薬介助',
  `body_medical_sure` int(4) DEFAULT '0' COMMENT '服薬確認',
  `body_medical_app` int(4) DEFAULT '0' COMMENT '薬の塗布',
  `body_medical_other` varchar(128) DEFAULT '' COMMENT 'その他',
  `body_self_cook` int(4) DEFAULT '0' COMMENT 'ともに行う調理',
  `body_self_clean` int(4) DEFAULT '0' COMMENT 'ともに行う掃除',
  `body_self_wash` int(4) DEFAULT '0' COMMENT 'ともに行う洗濯',
  `body_self_other` varchar(128) DEFAULT '' COMMENT 'その他',
  `live_clean_liveroom` int(4) DEFAULT '0' COMMENT '居室',
  `live_clean_bedroom` int(4) DEFAULT '0' COMMENT '寝室',
  `live_clean_wc` int(4) DEFAULT '0' COMMENT 'トイレ',
  `live_clean_bathroom` int(4) DEFAULT '0' COMMENT '浴室',
  `live_clean_taisuo` int(4) DEFAULT '0' COMMENT '台所',
  `live_clean_langxia` int(4) DEFAULT '0' COMMENT '廊下',
  `live_clean_ximiansuo` int(4) DEFAULT '0' COMMENT '洗面所',
  `live_clean_pwc` int(4) DEFAULT '0' COMMENT 'Pトイレ',
  `live_clean_other` int(4) DEFAULT '0' COMMENT 'その他',
  `live_clean_trash` int(4) DEFAULT '0' COMMENT 'ゴミ処理',
  `live_wash_wash` int(4) DEFAULT '0' COMMENT '洗う',
  `live_wash_dra` int(4) DEFAULT '0' COMMENT '干す',
  `live_wash_incorporating` int(4) DEFAULT '0' COMMENT '取入れ',
  `live_wash_receipt` int(4) DEFAULT '0' COMMENT '収納',
  `live_wash_iron` int(4) DEFAULT '0' COMMENT 'アイロン',
  `live_wash_launderette` int(4) DEFAULT '0' COMMENT 'コインランドリー',
  `live_wash_launderette_wash` int(4) DEFAULT '0' COMMENT 'コインランドリー　洗う',
  `live_wash_launderette_dry` int(4) DEFAULT '0' COMMENT 'コインランドリー　乾燥',
  `live_cloth_org` int(4) DEFAULT '0' COMMENT '衣類の整理',
  `live_cloth_repair` varchar(128) DEFAULT '0' COMMENT '被服の補修',
  `live_bedding_making` int(4) DEFAULT '0' COMMENT 'ベッドメイキング',
  `live_bedding_linen_change` int(4) DEFAULT '0' COMMENT 'リネン交換',
  `live_bedding_futon` int(4) DEFAULT '0' COMMENT '布団干し',
  `live_buy_food` int(4) DEFAULT '0' COMMENT '食品の買い物',
  `live_buy_daily` int(4) DEFAULT '0' COMMENT '日用品の買い物',
  `live_buy_medical` int(4) DEFAULT '0' COMMENT '薬取り',
  `live_buy_other` varchar(128) DEFAULT '0' COMMENT 'その他',
  `live_cook_mise` int(4) DEFAULT '0' COMMENT '下ごしらえ',
  `live_cook_normal` varchar(128) DEFAULT '' COMMENT '一般的な調理',
  `live_cook_zen` int(4) DEFAULT '0' COMMENT '配下膳',
  `live_cook_clean` int(4) DEFAULT '0' COMMENT '後片付け'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `office_code` varchar(10) NOT NULL COMMENT '事業所番号',
  `office_name` varchar(32) NOT NULL DEFAULT '' COMMENT '事業所名',
  `address` varchar(128) NOT NULL DEFAULT '' COMMENT '住所',
  `address2` varchar(128) NOT NULL DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`office_code`)
) ENGINE=InnoDB AUTO_INCREMENT=593 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `office_temp`
--

DROP TABLE IF EXISTS `office_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_temp` (
  `office_code` varchar(10) NOT NULL COMMENT '事業所番号',
  `office_name` varchar(32) NOT NULL DEFAULT '' COMMENT '事業所名',
  `address` varchar(128) NOT NULL DEFAULT '' COMMENT '住所',
  `address2` varchar(128) NOT NULL DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  PRIMARY KEY (`office_code`),
  UNIQUE KEY `id_UNIQUE` (`office_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_message`
--

DROP TABLE IF EXISTS `push_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(45) DEFAULT NULL,
  `send_time` varchar(45) DEFAULT NULL,
  `sender_id` bigint(20) DEFAULT NULL,
  `message_type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_send`
--

DROP TABLE IF EXISTS `push_send`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_send` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_id` bigint(20) DEFAULT NULL,
  `receiver_id` bigint(20) NOT NULL,
  `unread_flag` int(11) DEFAULT NULL COMMENT '0 unread  1 read',
  PRIMARY KEY (`id`),
  KEY `push_send_index` (`unread_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_token`
--

DROP TABLE IF EXISTS `push_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(100) NOT NULL,
  `reg_date` datetime NOT NULL,
  `badge` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_UNIQUE` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_plans`
--

DROP TABLE IF EXISTS `tmp_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_plans` (
  `val001_no` varchar(4) DEFAULT NULL COMMENT '連番',
  `val002_code` varchar(1) DEFAULT NULL COMMENT '識別コード',
  `val003` varchar(2) DEFAULT NULL COMMENT '在マネ用事業者グループ',
  `val004_customer_code` varchar(20) DEFAULT NULL COMMENT '在マネ用利用者コード',
  `val005` varchar(30) DEFAULT NULL COMMENT '連番',
  `val006_ym` varchar(6) DEFAULT NULL COMMENT '計画対象年月',
  `val007_service_code` varchar(6) DEFAULT NULL COMMENT 'サービスコード',
  `val008` varchar(3) DEFAULT NULL COMMENT '所要時間',
  `val009_time_start` varchar(4) DEFAULT NULL COMMENT 'サービス開始時間',
  `val010_time_end` varchar(4) DEFAULT NULL COMMENT 'サービス終了時間',
  `val011` varchar(10) DEFAULT NULL COMMENT '在マネ用サービス担当事業者コード',
  `val012` varchar(10) DEFAULT NULL COMMENT '在マネ用サービス担当者コード',
  `val013_day01` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１日',
  `val014_day02` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２日',
  `val015_day03` varchar(1) DEFAULT NULL COMMENT 'サービス実施日３日',
  `val016_day04` varchar(1) DEFAULT NULL COMMENT 'サービス実施日４日',
  `val017_day05` varchar(1) DEFAULT NULL COMMENT 'サービス実施日５日',
  `val018_day06` varchar(1) DEFAULT NULL COMMENT 'サービス実施日６日',
  `val019_day07` varchar(1) DEFAULT NULL COMMENT 'サービス実施日７日',
  `val020_day08` varchar(1) DEFAULT NULL COMMENT 'サービス実施日８日',
  `val021_day09` varchar(1) DEFAULT NULL COMMENT 'サービス実施日９日',
  `val022_day10` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１０日',
  `val023_day11` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１１日',
  `val024_day12` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１２日',
  `val025_day13` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１３日',
  `val026_day14` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１４日',
  `val027_day15` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１５日',
  `val028_day16` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１６日',
  `val029_day17` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１７日',
  `val030_day18` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１８日',
  `val031_day19` varchar(1) DEFAULT NULL COMMENT 'サービス実施日１９日',
  `val032_day20` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２０日',
  `val033_day21` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２１日',
  `val034_day22` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２２日',
  `val035_day23` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２３日',
  `val036_day24` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２４日',
  `val037_day25` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２５日',
  `val038_day26` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２６日',
  `val039_day27` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２７日',
  `val040_day28` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２８日',
  `val041_day29` varchar(1) DEFAULT NULL COMMENT 'サービス実施日２９日',
  `val042_day30` varchar(1) DEFAULT NULL COMMENT 'サービス実施日３０日',
  `val043_day31` varchar(1) DEFAULT NULL COMMENT 'サービス実施日３１日',
  `val044` varchar(3) DEFAULT NULL COMMENT 'サービス実施回数計',
  `val045` varchar(6) DEFAULT NULL COMMENT 'サービス単位数（１回あたり）',
  `val046` varchar(7) DEFAULT NULL COMMENT '単位数単価',
  `val047` varchar(6) DEFAULT NULL COMMENT '割引',
  `val048` varchar(10) DEFAULT NULL COMMENT '在マネ用計画事業者コード',
  `val049` varchar(10) DEFAULT NULL COMMENT '在マネ用計画担当者コード',
  `val050` varchar(10) DEFAULT NULL COMMENT '確定日',
  `val051` varchar(10) DEFAULT NULL COMMENT '初回認定情報の認定日',
  `val052` varchar(10) DEFAULT NULL COMMENT '変更認定情報の認定日',
  `val053` varchar(11) DEFAULT NULL COMMENT '在マネ用更新事業者',
  `val054` varchar(10) DEFAULT NULL COMMENT '在マネ用更新日',
  `val055` varchar(2) DEFAULT NULL COMMENT '在マネ用事業者グループ（登録）',
  `val056` varchar(2) DEFAULT NULL COMMENT '暫定時用介護状態区分',
  `val057` varchar(10) DEFAULT NULL COMMENT '暫定時用保険者番号',
  `val058` varchar(128) DEFAULT NULL COMMENT '月単位定額用商用時間',
  `val059` varchar(128) DEFAULT NULL COMMENT '在マネ用福祉用具貸与導入理由',
  `val060` varchar(128) DEFAULT NULL COMMENT '日割り',
  `val061_monthly_type` varchar(2) DEFAULT NULL COMMENT '月定額報酬用区分',
  `val062` varchar(3) DEFAULT NULL COMMENT '在マネ用並び替え用コード',
  `val063` varchar(8) DEFAULT NULL COMMENT '施設所在保険者番号（住所地特例用）',
  KEY `number_INDEX` (`val001_no`,`val002_code`),
  KEY `code_INDEX` (`val002_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一時ー提供票CSVファイル';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(21) NOT NULL COMMENT '職員番号',
  `user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '職員氏名',
  `user_name_kana` varchar(16) DEFAULT NULL COMMENT '職員氏名（カナ）',
  `office_code` varchar(10) NOT NULL DEFAULT '0' COMMENT '所属事業所番号',
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
  `is_locked` int(4) DEFAULT '0' COMMENT '0 没有被锁\\n1被锁住',
  `login_try_times` int(4) DEFAULT '0' COMMENT '登陆失败次数',
  `active` int(11) DEFAULT '1' COMMENT '职员是否有效',
  `sort_num` int(10) NOT NULL DEFAULT '999999999' COMMENT '職員表示順位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`),
  KEY `index1` (`id`,`user_code`,`user_name`,`office_code`,`apple_id`,`email`,`longitude`,`latitude`)
) ENGINE=InnoDB AUTO_INCREMENT=2565 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_online`
--

DROP TABLE IF EXISTS `user_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_online` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_token` varchar(64) NOT NULL COMMENT 'デバイスキー',
  `user_code` varchar(21) NOT NULL COMMENT '職員氏名',
  `create_time` varchar(20) NOT NULL COMMENT '登録日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1835 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_temp`
--

DROP TABLE IF EXISTS `user_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_temp` (
  `update_type` varchar(1) NOT NULL COMMENT '更新区分',
  `office_code` varchar(10) NOT NULL COMMENT '自機関番号',
  `code` varchar(10) NOT NULL COMMENT '訪問職員コード',
  `service_connect_code` varchar(10) NOT NULL COMMENT 'サービス関係者コード',
  `name` varchar(30) NOT NULL COMMENT '氏名（漢字）',
  `name_kana` varchar(30) NOT NULL COMMENT 'ﾌﾘｶﾞﾅ',
  `sex` varchar(10) NOT NULL COMMENT '性別',
  `birthday` varchar(8) NOT NULL COMMENT '生年月日',
  `zip_code` varchar(8) NOT NULL COMMENT '郵便番号',
  `address` varchar(40) NOT NULL COMMENT '住所',
  `address2` varchar(40) NOT NULL COMMENT '住所2',
  `phone_number` varchar(13) DEFAULT NULL COMMENT '電話番号',
  `phone_number2_type` varchar(20) DEFAULT NULL COMMENT '電話区分2',
  `phone_number2` varchar(13) DEFAULT NULL COMMENT '電話番号2',
  `start_job_date` varchar(8) DEFAULT NULL COMMENT '勤務開始日',
  `end_job_date` varchar(8) DEFAULT NULL COMMENT '勤務終了日',
  `job_status` varchar(1) DEFAULT NULL COMMENT '勤務形態',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一時ー職員台帳（基本情報）CSV';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `view_test_event_achv_info`
--

DROP TABLE IF EXISTS `view_test_event_achv_info`;
/*!50001 DROP VIEW IF EXISTS `view_test_event_achv_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_test_event_achv_info` AS SELECT 
 1 AS `event_id`,
 1 AS `nursing_id`,
 1 AS `achv_status`,
 1 AS `service_ym`,
 1 AS `office_code`,
 1 AS `customer_code`,
 1 AS `customer_name`,
 1 AS `achv_service_code`,
 1 AS `achv_service_date`,
 1 AS `achv_service_time`,
 1 AS `achv_helper_code`,
 1 AS `achv_helper_name`,
 1 AS `achv_follower_code`,
 1 AS `achv_follower_name`,
 1 AS `achv_addition_first`,
 1 AS `achv_addition_emergency`,
 1 AS `event_update_datetime`,
 1 AS `event_create_datetime`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_test_event_all_info`
--

DROP TABLE IF EXISTS `view_test_event_all_info`;
/*!50001 DROP VIEW IF EXISTS `view_test_event_all_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_test_event_all_info` AS SELECT 
 1 AS `event_id`,
 1 AS `nursing_id`,
 1 AS `event_update_datetime`,
 1 AS `event_create_datetime`,
 1 AS `plan_status`,
 1 AS `sch_status`,
 1 AS `achv_status`,
 1 AS `service_ym`,
 1 AS `office_code`,
 1 AS `customer_code`,
 1 AS `customer_name`,
 1 AS `plan_service_code`,
 1 AS `sch_service_code`,
 1 AS `achv_service_code`,
 1 AS `plan_service_date`,
 1 AS `plan_service_time`,
 1 AS `sch_service_date`,
 1 AS `sch_service_time`,
 1 AS `achv_service_date`,
 1 AS `achv_service_time`,
 1 AS `plan_helper_code`,
 1 AS `plan_helper_name`,
 1 AS `plan_follower_code`,
 1 AS `plan_follower_name`,
 1 AS `sch_helper_code`,
 1 AS `sch_helper_name`,
 1 AS `sch_follower_code`,
 1 AS `sch_follower_name`,
 1 AS `achv_helper_code`,
 1 AS `achv_helper_name`,
 1 AS `achv_follower_code`,
 1 AS `achv_follower_name`,
 1 AS `plan_addition_first`,
 1 AS `sch_addition_first`,
 1 AS `achv_addition_first`,
 1 AS `plan_addition_emergency`,
 1 AS `sch_addition_emergency`,
 1 AS `achv_addition_emergency`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_test_event_plan_info`
--

DROP TABLE IF EXISTS `view_test_event_plan_info`;
/*!50001 DROP VIEW IF EXISTS `view_test_event_plan_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_test_event_plan_info` AS SELECT 
 1 AS `event_id`,
 1 AS `nursing_id`,
 1 AS `plan_status`,
 1 AS `service_ym`,
 1 AS `office_code`,
 1 AS `customer_code`,
 1 AS `customer_name`,
 1 AS `plan_service_code`,
 1 AS `plan_service_date`,
 1 AS `plan_service_time`,
 1 AS `plan_helper_code`,
 1 AS `plan_helper_name`,
 1 AS `plan_follower_code`,
 1 AS `plan_follower_name`,
 1 AS `plan_addition_first`,
 1 AS `plan_addition_emergency`,
 1 AS `event_update_datetime`,
 1 AS `event_create_datetime`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_test_event_sch_info`
--

DROP TABLE IF EXISTS `view_test_event_sch_info`;
/*!50001 DROP VIEW IF EXISTS `view_test_event_sch_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_test_event_sch_info` AS SELECT 
 1 AS `event_id`,
 1 AS `nursing_id`,
 1 AS `sch_status`,
 1 AS `service_ym`,
 1 AS `office_code`,
 1 AS `customer_code`,
 1 AS `customer_name`,
 1 AS `sch_service_code`,
 1 AS `sch_service_date`,
 1 AS `sch_service_time`,
 1 AS `sch_helper_code`,
 1 AS `sch_helper_name`,
 1 AS `sch_follower_code`,
 1 AS `sch_follower_name`,
 1 AS `sch_addition_first`,
 1 AS `sch_addition_emergency`,
 1 AS `event_update_datetime`,
 1 AS `event_create_datetime`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `week`
--

DROP TABLE IF EXISTS `week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `week` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_code` varchar(6) NOT NULL COMMENT 'サービスコード',
  `time_start` varchar(4) NOT NULL COMMENT 'サービス開始時間（HHMM）',
  `time_end` varchar(4) NOT NULL COMMENT 'サービス終了時間（HHMM）',
  `service_time1` int(4) DEFAULT '0' COMMENT 'サービス時間１',
  `service_time2` int(4) DEFAULT '0' COMMENT 'サービス時間２',
  `customer_id` bigint(20) unsigned NOT NULL,
  `helper_id` bigint(20) unsigned DEFAULT NULL COMMENT '職員ID',
  `follower_id` bigint(20) unsigned DEFAULT NULL COMMENT '従う職員ID',
  `travel_time` int(4) NOT NULL DEFAULT '0' COMMENT '移動時間（分）',
  `addition_first` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（初回）（０：なし；１：あり）',
  `addition_emergency` int(4) NOT NULL DEFAULT '0' COMMENT '加算チェック（緊急）（０：なし；１：あり）',
  `week_flag` int(4) NOT NULL DEFAULT '0' COMMENT '2 4 8 16 32 64',
  `update_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  `active` int(4) NOT NULL DEFAULT '1' COMMENT '是否激活该週間',
  PRIMARY KEY (`id`),
  KEY `FK_week_helper` (`helper_id`),
  KEY `FK_week_follower` (`follower_id`),
  KEY `FK_week_customer` (`customer_id`),
  KEY `FK_week_service` (`service_code`),
  CONSTRAINT `FK_week_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_week_follower` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_week_helper` FOREIGN KEY (`helper_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_week_service` FOREIGN KEY (`service_code`) REFERENCES `mst_services` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='週間記録';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ienursing2'
--

--
-- Dumping routines for database 'ienursing2'
--
/*!50003 DROP PROCEDURE IF EXISTS `f_generate_car` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `f_generate_car`(in p int)
begin
	
	declare code varchar(45) default '';
	declare name varchar(45) default '';
    
	while p > 0 do
	set code = right(concat('0000',p),5);
	set name = right(concat('艾瑞泽1',p),5);
	insert into `wecar`.`cars` (`code`, `name`, `factory_name`, `start_generate_year`, `generate_date`, `sale_year`, `oil_use`, `dealers`, `license`) values (code, name, '奇瑞', '2015-10-01', '2015-10-15', '2016-01-03', '6', '123456789, 123456788', 'qwu89a76a789sva7t687');
    set p = p - 1;
    
	end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `f_generate_message` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `f_generate_message`(in p int)
begin
	
	declare message_type Int default '0';
	declare title varchar(64) default '';
	declare subtitle varchar(128) default '';
    
	while p > 0 do
	set message_type = p;
	set title = concat('This is title content sentences', p);
	set subtitle = concat('This is subtitle content sentences', p);
	insert into `wecar`.`messages` (`breviary_type`, `message_type`, `title`, `subtitle`, `user_id`, `comment_count`) values (1, message_type, title, subtitle, 1, 109);
    set p = p - 1;
    
	end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `f_generate_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `f_generate_user`(in p int)
begin
	
	declare code varchar(45) default '';
	declare name varchar(45) default '';
    
	while p > 0 do
	set code = right(concat('0000',p),5);
	set name = right(concat('1111',p),5);
	insert into `wecar`.`users` (`code`, `password`, `name`) values (code, md5('admin'), name);
    set p = p - 1;
    
	end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_test_event_achv_info`
--

/*!50001 DROP VIEW IF EXISTS `view_test_event_achv_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_test_event_achv_info` AS select 1 AS `event_id`,1 AS `nursing_id`,1 AS `achv_status`,1 AS `service_ym`,1 AS `office_code`,1 AS `customer_code`,1 AS `customer_name`,1 AS `achv_service_code`,1 AS `achv_service_date`,1 AS `achv_service_time`,1 AS `achv_helper_code`,1 AS `achv_helper_name`,1 AS `achv_follower_code`,1 AS `achv_follower_name`,1 AS `achv_addition_first`,1 AS `achv_addition_emergency`,1 AS `event_update_datetime`,1 AS `event_create_datetime` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_test_event_all_info`
--

/*!50001 DROP VIEW IF EXISTS `view_test_event_all_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_test_event_all_info` AS select 1 AS `event_id`,1 AS `nursing_id`,1 AS `event_update_datetime`,1 AS `event_create_datetime`,1 AS `plan_status`,1 AS `sch_status`,1 AS `achv_status`,1 AS `service_ym`,1 AS `office_code`,1 AS `customer_code`,1 AS `customer_name`,1 AS `plan_service_code`,1 AS `sch_service_code`,1 AS `achv_service_code`,1 AS `plan_service_date`,1 AS `plan_service_time`,1 AS `sch_service_date`,1 AS `sch_service_time`,1 AS `achv_service_date`,1 AS `achv_service_time`,1 AS `plan_helper_code`,1 AS `plan_helper_name`,1 AS `plan_follower_code`,1 AS `plan_follower_name`,1 AS `sch_helper_code`,1 AS `sch_helper_name`,1 AS `sch_follower_code`,1 AS `sch_follower_name`,1 AS `achv_helper_code`,1 AS `achv_helper_name`,1 AS `achv_follower_code`,1 AS `achv_follower_name`,1 AS `plan_addition_first`,1 AS `sch_addition_first`,1 AS `achv_addition_first`,1 AS `plan_addition_emergency`,1 AS `sch_addition_emergency`,1 AS `achv_addition_emergency` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_test_event_plan_info`
--

/*!50001 DROP VIEW IF EXISTS `view_test_event_plan_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_test_event_plan_info` AS select 1 AS `event_id`,1 AS `nursing_id`,1 AS `plan_status`,1 AS `service_ym`,1 AS `office_code`,1 AS `customer_code`,1 AS `customer_name`,1 AS `plan_service_code`,1 AS `plan_service_date`,1 AS `plan_service_time`,1 AS `plan_helper_code`,1 AS `plan_helper_name`,1 AS `plan_follower_code`,1 AS `plan_follower_name`,1 AS `plan_addition_first`,1 AS `plan_addition_emergency`,1 AS `event_update_datetime`,1 AS `event_create_datetime` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_test_event_sch_info`
--

/*!50001 DROP VIEW IF EXISTS `view_test_event_sch_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_test_event_sch_info` AS select 1 AS `event_id`,1 AS `nursing_id`,1 AS `sch_status`,1 AS `service_ym`,1 AS `office_code`,1 AS `customer_code`,1 AS `customer_name`,1 AS `sch_service_code`,1 AS `sch_service_date`,1 AS `sch_service_time`,1 AS `sch_helper_code`,1 AS `sch_helper_name`,1 AS `sch_follower_code`,1 AS `sch_follower_name`,1 AS `sch_addition_first`,1 AS `sch_addition_emergency`,1 AS `event_update_datetime`,1 AS `event_create_datetime` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-11  8:57:00
