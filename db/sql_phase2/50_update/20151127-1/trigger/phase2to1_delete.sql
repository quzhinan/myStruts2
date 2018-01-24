
DROP TRIGGER IF EXISTS trigger_phase2to1_delete;

DELIMITER $$

CREATE TRIGGER `trigger_phase2to1_delete` AFTER DELETE ON events FOR EACH ROW
BEGIN
	IF old.trigger_flag >= 0 THEN
		UPDATE nursing SET trigger_flag = -1 WHERE event_id = old.id;
		DELETE FROM nursing WHERE event_id = old.id;
	END IF;
END