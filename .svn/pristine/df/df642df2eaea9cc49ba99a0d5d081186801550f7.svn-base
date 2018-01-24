
ALTER TABLE nursing ADD INDEX nursing_visit_date_status(visit_date, `status`);
ALTER TABLE nursing ADD INDEX nursing_visit_date_time_status(visit_date, from_time, `status`);
ALTER TABLE nursing ADD INDEX nursing_visit_date_time_customer(visit_date, from_time, customer_code);
ALTER TABLE nursing ADD INDEX nursing_office_code_date(office_code, visit_date);
ALTER TABLE nursing ADD INDEX nursing_carray_out_date_time(carry_out, visit_date, from_time);
ALTER TABLE nursing ADD INDEX nursing_status_visit_date_time_end(`status`, visit_date, end_time);
ALTER TABLE nursing ADD INDEX nursing_visit_status_date(`status`, visit_date);