package jp.iesolutions.ienursing.actions.js;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import org.apache.struts2.json.annotations.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-json-default")
@Results({ @Result(name = EventAction.SUCCESS, type = "json", params = { "root", "action", "includeProperties",
		"result, message, event.*", "excludeProperties", "event.*password" }) })

public class EventAction extends AbstractAction implements ModelDriven<EventItem>, Preparable {

	private static final long serialVersionUID = 4825563642351715754L;

	private static final Log log = LogFactory.getLog(EventAction.class);

	@Autowired
	private NursingService nursingService;

	@Autowired
	private EventService eventService;

	@Autowired
	private OfficeService officeService;

	private User loginUser;
	private long officeId;

	private EventItem eventItem;
	private String result;
	private String message;

	private long eventId;
	private long customerId;
	private String serviceYm;
	private int copied;
	private int doLoop;
	private Event event;

	public void setEventId(long eventId) {
		this.eventId = eventId;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public void setServiceYm(String serviceYm) {
		this.serviceYm = serviceYm;
	}

	public void setCopied(int copied) {
		this.copied = copied;
	}

	public void setDoLoop(int doLoop) {
		this.doLoop = doLoop;
	}

	@Override
	public EventItem getModel() {
		return eventItem;
	}

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	@JSON(name = "message")
	public String getMessage() {
		return message;
	}

	@JSON(name = "event")
	public Event getEvent() {
		return event;
	}

	@Override
	public void prepare() throws Exception {

		log.info(userActionStart(log, "prepare"));

		loginUser = getUserFromSession();

		Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());
		if (office != null) {
			officeId = office.getId();
		}

		eventItem = new EventItem();
		copied = 0;

		log.info(userActionEnd(log, "prepare", SUCCESS, "officeId", officeId, "eventItem", eventItem));
	}

	private boolean isTimeCorrect() {
		boolean checkTimeEqual = true;
		int timeStartHour = eventItem.getIntTimeStartHour();
		int timeStartMinute = eventItem.getIntTimeStartMinute();
		int timeEndHour = eventItem.getIntTimeEndHour();
		int timeEndMinute = eventItem.getIntTimeEndMinute();

		int totalMinutes = (timeEndHour * 60 + timeEndMinute) - (timeStartHour * 60 + timeStartMinute);
		return checkTimeEqual || totalMinutes == (eventItem.getServiceTime1() + eventItem.getServiceTime2());
	}

	public String save() throws Exception {

		log.info(userActionStart(log, "save", "eventItem", eventItem, "doLoop", doLoop, "officeId", officeId, "eventId",
				eventId, "customerId", customerId, "serviceYm", serviceYm));

		if (eventItem.getServiceDate() == null || eventItem.getServiceDate().length() != 8) {
			message = getText("messages.js.plan.service.date.required");
		} else if (!isTimeCorrect()) {
			message = getText("errors.common.time.not.equals");
		}

		if (message != null) {
			result = ERROR;
			log.info(userActionEnd(log, "save", result));
			return SUCCESS;
		}

		try {
			if (doLoop == 1) {
				event = eventService.saveEventItemInfoWeekLoop(officeId, eventId, customerId, serviceYm, eventItem,
						(copied == 1));
			} else {
				event = eventService.saveEventItemInfo(officeId, eventId, customerId, serviceYm, eventItem,
						(copied == 1));
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
		log.info(userActionEnd(log, "save", SUCCESS, "result", result, "event", event, "message", message));
		return SUCCESS;
	}

	public String copy() throws Exception {

		if (eventId > 0) {
			copied = 1;
		}
		return save();
	}

	public String delete() throws Exception {

		log.info(userActionStart(log, "delete", "officeId", officeId, "eventId", eventId, "eventItemType",
				eventItem.getType()));

		try {
			event = eventService.deleteEventItemInfo(officeId, eventId, eventItem.getType());
		} catch (ServiceException e) {
			message = getText(e.getMessage());
			result = ERROR;
		}

		if (message == null) {
			message = getText("messages.js.plan.success");
			result = SUCCESS;
		}
		log.info(userActionEnd(log, "delete", SUCCESS, "event", event, "message", message, "result", result));
		return SUCCESS;
	}

	public String cancel() throws Exception {

		log.info(userActionStart(log, "cancel", "officeId", officeId, "eventId", eventId));

		try {
			save();
			nursingService.cancelNursing(eventId, true);
			event = eventService.findById(eventId);
		} catch (ServiceException e) {
			message = getText(e.getMessage());
			result = ERROR;
		}

		if (message == null) {
			message = getText("messages.js.plan.success");
			result = SUCCESS;
		}

		log.info(userActionEnd(log, "cancel", SUCCESS, "message", message, "result", result));

		return SUCCESS;
	}

	public String notCancel() throws Exception {

		log.info(userActionStart(log, "notCancel", "officeId", officeId, "eventId", eventId));

		try {
			save();
			nursingService.cancelNursing(eventId, false);
			event = eventService.findById(eventId);
		} catch (ServiceException e) {
			message = getText(e.getMessage());
			result = ERROR;
		}

		if (message == null) {
			message = getText("messages.js.plan.success");
			result = SUCCESS;
		}

		log.info(userActionEnd(log, "notCancel", SUCCESS, "message", message, "result", result));

		return SUCCESS;
	}
}
