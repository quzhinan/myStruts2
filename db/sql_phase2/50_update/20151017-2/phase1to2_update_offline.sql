
DROP TRIGGER IF EXISTS trigger_phase1to2_update_offline;

DELIMITER $$

CREATE TRIGGER trigger_phase1to2_update_offline BEFORE UPDATE ON nursing FOR EACH ROW
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
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '1', '0'
			);
	   	 SELECT MAX(id) into l_plan_id FROM event_items;
	   	 
		-- insert schedule & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '2', '0'
			);
	   	 SELECT MAX(id) into l_schedule_id FROM event_items;
	   	 
		-- insert achievement & get id
		INSERT INTO event_items 
			(service_code, service_date, time_start, time_end, 
			helper_id, follower_id, travel_time, addition_first, addition_emergency, `type`, status)
		VALUES 
			(new.service_code, REPLACE(new.visit_date, '-', ''), REPLACE(new.from_time, ':', ''), REPLACE(new.end_time, ':', ''),
			 l_helper_id, l_follower_id, '0', new.adding_first, new.adding_urgency, '3', '0'
			);
	   	 SELECT MAX(id) into l_achievement_id FROM event_items;
	   	 
		-- insert event & get id
		INSERT INTO events 
			(office_id, customer_id, service_ym, 
			plan_id, schedule_id, achievement_id, status, trigger_flag)
		VALUES 
			(l_office_id, l_customer_id, LEFT(REPLACE(new.visit_date, '-', ''), 6),
			 l_plan_id, l_schedule_id, l_achievement_id, '0', '1'
			);
	   	 SELECT MAX(id) into l_event_id FROM events;
	   	 
	   	 -- update event id to nursing
	   	 SET new.event_id = l_event_id;
	END IF;
	
END$$
