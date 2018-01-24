CREATE  OR REPLACE VIEW `view_test_event_sch_info` AS
SELECT event_id, nursing_id, sch_status, service_ym, office_code, customer_code, customer_name,
       sch_service_code, sch_service_date, sch_service_time, 
       sch_helper_code, sch_helper_name, sch_follower_code, sch_follower_name,
       sch_addition_first, sch_addition_emergency, event_update_datetime, event_create_datetime
  FROM view_test_event_all_info
;
