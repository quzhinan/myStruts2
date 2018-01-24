CREATE  OR REPLACE VIEW `view_test_event_all_info` AS
SELECT e.id as event_id, n.id as nursing_id, 
       IFNULL(e.update_datetime, e.create_datetime) as event_update_datetime, e.create_datetime as event_create_datetime,
       p.status as plan_status, s.status as sch_status, a.status as achv_status, 
       e.service_ym as service_ym, o.office_code as office_code, 
       c.customer_code as customer_code, c.customer_name as customer_name,
       p.service_code as plan_service_code, s.service_code as sch_service_code, a.service_code as achv_service_code,
       CONCAT(LEFT(p.service_date, 4), '-', SUBSTRING(p.service_date, 5, 2), '-', RIGHT(p.service_date, 2)) as plan_service_date,
       CONCAT(LEFT(p.time_start, 2), ':', RIGHT(p.time_start, 2), '~', LEFT(p.time_end, 2), ':', RIGHT(p.time_end, 2)) as plan_service_time,
       CONCAT(LEFT(s.service_date, 4), '-', SUBSTRING(s.service_date, 5, 2), '-', RIGHT(s.service_date, 2)) as sch_service_date,
       CONCAT(LEFT(s.time_start, 2), ':', RIGHT(s.time_start, 2), '~', LEFT(s.time_end, 2), ':', RIGHT(s.time_end, 2)) as sch_service_time,
       CONCAT(LEFT(a.service_date, 4), '-', SUBSTRING(a.service_date, 5, 2), '-', RIGHT(a.service_date, 2)) as achv_service_date,
       CONCAT(LEFT(a.time_start, 2), ':', RIGHT(a.time_start, 2), '~', LEFT(a.time_end, 2), ':', RIGHT(a.time_end, 2)) as achv_service_time,
       ph.user_code as plan_helper_code, ph.user_name as plan_helper_name, pf.user_code as plan_follower_code, pf.user_name as plan_follower_name,
       sh.user_code as sch_helper_code, sh.user_name as sch_helper_name, sf.user_code as sch_follower_code, sf.user_name as sch_follower_name,
       ah.user_code as achv_helper_code, ah.user_name as achv_helper_name, af.user_code as achv_follower_code, af.user_name as achv_follower_name,
       p.addition_first as plan_addition_first, s.addition_first as sch_addition_first, a.addition_first as achv_addition_first,
       p.addition_emergency as plan_addition_emergency, s.addition_emergency as sch_addition_emergency, a.addition_emergency as achv_addition_emergency
  FROM events e
	   INNER JOIN office o ON o.id = e.office_id
	   INNER JOIN customer c ON c.id = e.customer_id
	   INNER JOIN event_items p ON p.id = e.plan_id
	   LEFT JOIN user ph ON ph.id = p.helper_id
	   LEFT JOIN user pf ON pf.id = p.follower_id
	   INNER JOIN event_items s ON s.id = e.schedule_id
	   LEFT JOIN user sh ON sh.id = s.helper_id
	   LEFT JOIN user sf ON sf.id = s.follower_id
	   INNER JOIN event_items a ON a.id = e.achievement_id
	   LEFT JOIN user ah ON ah.id = s.helper_id
	   LEFT JOIN user af ON af.id = s.follower_id
	   LEFT JOIN nursing n ON n.event_id = e.id
  ORDER BY event_update_datetime DESC
;
