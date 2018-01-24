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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_code` varchar(11) NOT NULL COMMENT '利用者番号',
  `customer_name` varchar(10) NOT NULL DEFAULT '' COMMENT '利用者氏名',
  `customer_name_kana` varchar(16) NOT NULL DEFAULT '' COMMENT '利用者氏名（カナ）',
  `user_code` varchar(6) NOT NULL DEFAULT '' COMMENT '担当サ責職員番号',
  `office_code` varchar(45) DEFAULT '',
  `address` varchar(128) NOT NULL COMMENT '住所',
  `address2` varchar(128) NOT NULL COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT 'メール',
  `contect_pdf` varchar(45) DEFAULT '' COMMENT '連絡先PDF',
  `nurse_plane_pdf` varchar(45) DEFAULT '' COMMENT '介護計画PDF',
  `amentity` varchar(45) DEFAULT '' COMMENT 'アメニティ',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`customer_code`),
  KEY `index1` (`id`,`customer_code`,`customer_name`,`email`,`longitude`,`latitude`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_temp`
--

DROP TABLE IF EXISTS `customer_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_temp` (
  `customer_code` varchar(11) NOT NULL COMMENT '利用者番号',
  `customer_name` varchar(10) NOT NULL DEFAULT '' COMMENT '利用者氏名',
  `customer_name_kana` varchar(16) NOT NULL DEFAULT '' COMMENT '利用者氏名（カナ）',
  `user_code` varchar(6) NOT NULL DEFAULT '' COMMENT '担当サ責職員番号',
  `office_code` varchar(45) DEFAULT '',
  `address` varchar(128) NOT NULL COMMENT '住所',
  `address2` varchar(128) NOT NULL COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT '' COMMENT '電話番号',
  PRIMARY KEY (`customer_code`),
  UNIQUE KEY `id_UNIQUE` (`customer_code`),
  KEY `index1` (`customer_code`,`customer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_temp`
--

LOCK TABLES `customer_temp` WRITE;
/*!40000 ALTER TABLE `customer_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_temp` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `master`
--

LOCK TABLES `master` WRITE;
/*!40000 ALTER TABLE `master` DISABLE KEYS */;
INSERT INTO `master` VALUES (1,5,5,100);
/*!40000 ALTER TABLE `master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nursing`
--

DROP TABLE IF EXISTS `nursing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nursing` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'サービス番号',
  `customer_code` varchar(12) NOT NULL COMMENT '利用者番号',
  `user_code` varchar(6) NOT NULL COMMENT '担当者番号',
  `user_code_follow` varchar(6) DEFAULT NULL COMMENT '同行者番号',
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
  `nursing_record` varchar(45) DEFAULT '' COMMENT '介護記録欄',
  `office_record` varchar(45) DEFAULT NULL COMMENT '事業所使用欄',
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
  `user_code_service` varchar(6) NOT NULL DEFAULT '' COMMENT '担当者番号サービス',
  `office_code` varchar(6) DEFAULT '' COMMENT '事業所番号',
  `status` int(4) DEFAULT '0' COMMENT '訪問状況',
  `carry_out` int(4) DEFAULT '0' COMMENT '実施',
  `update_flag` int(4) DEFAULT '0' COMMENT '変更',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=703 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nursing`
--

LOCK TABLES `nursing` WRITE;
/*!40000 ALTER TABLE `nursing` DISABLE KEYS */;
/*!40000 ALTER TABLE `nursing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nursing_temp`
--

DROP TABLE IF EXISTS `nursing_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nursing_temp` (
  `customer_code` varchar(12) NOT NULL COMMENT '利用者番号',
  `user_code` varchar(6) NOT NULL COMMENT '担当者番号',
  `user_code_follow` varchar(6) DEFAULT NULL COMMENT '同行者番号',
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
-- Dumping data for table `nursing_temp`
--

LOCK TABLES `nursing_temp` WRITE;
/*!40000 ALTER TABLE `nursing_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `nursing_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `office_code` varchar(8) NOT NULL COMMENT '事業所番号',
  `office_name` varchar(32) NOT NULL DEFAULT '' COMMENT '事業所名',
  `address` varchar(128) NOT NULL DEFAULT '' COMMENT '住所',
  `address2` varchar(128) NOT NULL DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `longitude` double NOT NULL DEFAULT '0' COMMENT '経度',
  `latitude` double NOT NULL DEFAULT '0' COMMENT '緯度',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`office_code`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_temp`
--

DROP TABLE IF EXISTS `office_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_temp` (
  `office_code` varchar(8) NOT NULL COMMENT '事業所番号',
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
-- Dumping data for table `office_temp`
--

LOCK TABLES `office_temp` WRITE;
/*!40000 ALTER TABLE `office_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(6) NOT NULL COMMENT '職員番号',
  `user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '職員氏名',
  `user_name_kana` varchar(16) DEFAULT NULL COMMENT '職員氏名（カナ）',
  `office_code` varchar(8) NOT NULL DEFAULT '0' COMMENT '所属事業所番号',
  `manager` int(1) DEFAULT '0',
  `role_type` int(1) DEFAULT '0' COMMENT '権限',
  `help_full_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（常勤）',
  `help_part_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（非常勤）',
  `address` varchar(128) DEFAULT '' COMMENT '住所',
  `address2` varchar(128) DEFAULT '' COMMENT '住所2',
  `phone_number` varchar(32) DEFAULT NULL COMMENT '電話番号',
  `email` varchar(128) NOT NULL DEFAULT '' COMMENT 'メール',
  `apple_id` varchar(32) DEFAULT NULL COMMENT 'Apple ID',
  `device_key` varchar(64) NOT NULL DEFAULT '0' COMMENT 'デバイスID',
  `longitude` double DEFAULT '0' COMMENT '経度',
  `latitude` double DEFAULT '0' COMMENT '緯度',
  `password` varchar(64) DEFAULT '' COMMENT 'パスワード（MD5暗号化）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`),
  KEY `index1` (`id`,`user_code`,`user_name`,`office_code`,`apple_id`,`email`,`longitude`,`latitude`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','Administrator','','0',0,2,0,0,'','','','example@gmail.com','example@gmail.com','0',0,0,'21232f297a57a5a743894a0e4a801fc3');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_online`
--

DROP TABLE IF EXISTS `user_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_online` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_token` varchar(64) NOT NULL COMMENT 'デバイスキー',
  `user_code` varchar(8) NOT NULL COMMENT '職員氏名',
  `create_time` varchar(20) NOT NULL COMMENT '登録日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`user_code`)
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_online`
--

LOCK TABLES `user_online` WRITE;
/*!40000 ALTER TABLE `user_online` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_temp`
--

DROP TABLE IF EXISTS `user_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_temp` (
  `user_code` varchar(6) NOT NULL COMMENT '職員番号',
  `user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '職員氏名',
  `user_name_kana` varchar(16) DEFAULT NULL COMMENT '職員氏名（カナ）',
  `office_code` varchar(8) NOT NULL DEFAULT '0' COMMENT '所属事業所番号',
  `manager` int(1) DEFAULT '0',
  `role_type` int(1) DEFAULT '0' COMMENT '権限',
  `help_full_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（常勤）',
  `help_part_time` int(1) DEFAULT '0' COMMENT 'ヘルパ（非常勤）',
  `address` varchar(128) DEFAULT '' COMMENT '住所',
  PRIMARY KEY (`user_code`),
  UNIQUE KEY `id_UNIQUE` (`user_code`),
  KEY `index1` (`user_code`,`user_name`,`office_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_temp`
--

LOCK TABLES `user_temp` WRITE;
/*!40000 ALTER TABLE `user_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ienursing'
--

--
-- Dumping routines for database 'ienursing'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-05 15:43:28