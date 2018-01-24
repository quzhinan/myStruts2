
DROP TRIGGER IF EXISTS trigger_phase1to2_update;

DELIMITER $$

CREATE TRIGGER `trigger_phase1to2_update` AFTER UPDATE ON nursing FOR EACH ROW
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
       		ei.status = (CASE WHEN n.status=7 THEN '-12' WHEN n.status=0 THEN '-11' WHEN n.status=6 THEN '-2' WHEN n.status=5 THEN '2'  WHEN n.status=1 OR n.status=2 OR n.status=8 THEN '1' ELSE '0' END),
       		ei.comment_content = n.comment_content,
       		ei.comment_update_datetime = n.comment_update_datetime,
       		ei.comment_confirm_status = n.comment_confirm_status;
	
    	UPDATE events e
    		INNER JOIN nursing n ON n.event_id = e.id AND n.event_id = new.event_id
	   		INNER JOIN customer c ON c.customer_code = n.customer_code
	   	SET e.customer_id = c.id,
	   		e.remark = n.remark,
	   		e.update_status = new.update_status,
	    	e.trigger_flag = e.trigger_flag + 1	;
	END IF;
	
END
