DROP TABLE IF EXISTS `customer_temp`;
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
);

