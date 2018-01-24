
DROP TRIGGER IF EXISTS trigger_phase2to1_insert;

DELIMITER $$

CREATE TRIGGER `trigger_phase2to1_insert` AFTER INSERT ON events FOR EACH ROW
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
END


