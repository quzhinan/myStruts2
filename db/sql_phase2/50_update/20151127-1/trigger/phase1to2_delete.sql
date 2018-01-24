
DROP TRIGGER IF EXISTS trigger_phase1to2_delete;

DELIMITER $$

CREATE TRIGGER `trigger_phase1to2_delete` AFTER DELETE ON nursing FOR EACH ROW
BEGIN
	IF old.trigger_flag >= 0 THEN
		UPDATE events SET trigger_flag = -1 WHERE id = old.event_id;
		DELETE FROM event_items WHERE id IN (SELECT plan_id FROM events WHERE id = old.event_id);
		DELETE FROM event_items WHERE id IN (SELECT schedule_id FROM events WHERE id = old.event_id);
		DELETE FROM event_items WHERE id IN (SELECT achievement_id FROM events WHERE id = old.event_id);
		DELETE FROM events WHERE id = old.event_id;
	END IF;
END