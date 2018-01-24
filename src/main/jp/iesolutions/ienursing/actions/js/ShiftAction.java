package jp.iesolutions.ienursing.actions.js;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import org.apache.struts2.json.annotations.JSON;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-json-default")
@Results( {
	@Result(
		name = ShiftAction.SUCCESS, 
		type = "json", 
		params = { "includeProperties", "result, message, schedule.*",
					"excludeProperties", "schedule.*password"}
	)
})

public class ShiftAction extends AbstractAction {

	private static final long serialVersionUID = 2443586011798939764L;
	
	private static final Log log = LogFactory.getLog(ShiftAction.class);

	@Autowired
	private EventService eventService;

	private int type; // 1: Helper, 2: Follower
	private long scheduleId;
	private long helperId;
	private String result;
	private String message;
	
	private EventItem schedule;

	public void setType(int type) {
		this.type = type;
	}

	public void setScheduleId(long scheduleId) {
		this.scheduleId = scheduleId;
	}

	public void setHelperId(long helperId) {
		this.helperId = helperId;
	}

	@JSON(name="result")
	public String getResult() {
		return result;
	}

	@JSON(name="message")
	public String getMessage() {
		return message;
	}

	@JSON(name="schedule")
	public EventItem getSchedule() {
		return schedule;
	}

	public String execute() throws Exception {

		log.info(userActionStart(log, "execute"));
		
		try {
			if (type == 1) {
				schedule = eventService.setEventItemHelperId(scheduleId, helperId);
			} else {
				schedule = eventService.setEventItemFollowerId(scheduleId, helperId);
			}
		} catch (ServiceException e) {
			if (e.getErrorInfos() != null) {
				message = getText(e.getMessage(), e.getErrorInfos());
			} else {
				message = getText(e.getMessage());
			}
			result = ERROR;
		}

		if (message == null) {
			message = getText("messages.js.plan.success");
			result = SUCCESS;
		}
		log.info(userActionEnd(log, "execute", SUCCESS, "schedule", schedule, "message", message));
		return SUCCESS;
	}
}
