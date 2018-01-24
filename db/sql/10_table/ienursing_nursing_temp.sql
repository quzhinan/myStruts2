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
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
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
