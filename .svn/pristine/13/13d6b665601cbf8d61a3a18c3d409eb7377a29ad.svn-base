
DROP TRIGGER IF EXISTS trigger_phase2to1_update;

DELIMITER $$

CREATE TRIGGER trigger_phase2to1_update AFTER UPDATE ON events FOR EACH ROW
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
			n.status = (CASE WHEN ei.status > 0 THEN n.status ELSE (CASE WHEN ei.status = -2 OR ei.status = -1 THEN '6' WHEN ei.service_date = sysdate THEN '3' ELSE '4' END) END),
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
		    n.remark = e.remark,
		    n.adding_urgency = ei.addition_emergency,
		    n.trigger_flag = n.trigger_flag + 1	   
		 WHERE n.event_id = new.id;
	END IF;
END$$
