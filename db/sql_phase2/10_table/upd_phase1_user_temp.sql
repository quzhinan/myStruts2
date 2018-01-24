DROP TABLE IF EXISTS `user_temp`;

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
  `phone_number` varchar(13) COMMENT '電話番号',
  `phone_number2_type` varchar(20) COMMENT '電話区分2',
  `phone_number2` varchar(13) COMMENT '電話番号2',
  `start_job_date` varchar(8) COMMENT '勤務開始日',
  `end_job_date` varchar(8) COMMENT '勤務終了日',
  `job_status` varchar(1) COMMENT '勤務形態',
  PRIMARY KEY (`code`)
) COMMENT='一時ー職員台帳（基本情報）CSV';
