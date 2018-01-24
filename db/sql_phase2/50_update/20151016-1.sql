
TRUNCATE TABLE `mst_environments`;

INSERT INTO `mst_environments` VALUES (201001, 'work.time.drag.start', '業務（移動画面）開始時間（時）', 				'8', '値：０〜２４');
INSERT INTO `mst_environments` VALUES (201002, 'work.time.drag.end', '業務（移動画面）終了時間（時）', 				'18', '値：０〜２４');
INSERT INTO `mst_environments` VALUES (201003, 'work.time.drag.unit', '業務（移動画面）時間最小単位（分）', 			'5', '値：１、２、３、４、５・・・');
INSERT INTO `mst_environments` VALUES (201004, 'work.time.drop.start', '業務（選択画面）開始時間（時）', 				'0', '値：０〜２４');
INSERT INTO `mst_environments` VALUES (201005, 'work.time.drop.end', '業務（選択画面）終了時間（時）', 				'24', '値：０〜２４');
INSERT INTO `mst_environments` VALUES (201006, 'work.time.drop.start.unit', '業務（選択画面）開始時間最小単位（分）', 	'5', '値：１、２、３、４、５・・・');
INSERT INTO `mst_environments` VALUES (201007, 'work.time.drop.end.unit', '業務（選択画面）終了時間最小単位（分）', 		'1', '値：１、２、３、４、５・・・');
