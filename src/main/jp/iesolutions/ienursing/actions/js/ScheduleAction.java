package jp.iesolutions.ienursing.actions.js;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Nursing;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-json-default")
@Results( {
	@Result(
		name = ScheduleAction.SUCCESS, 
		type = "json", 
		params = { "includeProperties", "result, message, events.*",
					"excludeProperties", "events.*password"}
	),
	@Result(
			name = "nursing-id", 
			type = "json", 
			params = { "includeProperties", "nursingId",}
		)
})

public class ScheduleAction extends AbstractAction implements Preparable {

	private static final long serialVersionUID = 1506064790527021944L;

	private static final Log log = LogFactory.getLog(ScheduleAction.class);

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private EventService eventService;
	

	@Autowired
	private OfficeService officeService;
	
	private User loginUser;
	private long officeId;
	private String selectedDay;

	private String result;
	private String message;
	
	private List<Event> events;

	@JSON(name="result")
	public String getResult() {
		return result;
	}

	@JSON(name="message")
	public String getMessage() {
		return message;
	}

	@JSON(name="events")
	public List<Event> getSchedule() {
		return events;
	}
	
	private long nursingId;

	@JSON(name="nursingId")
	public long getNursingId() {
		return nursingId;
	}
	public void setNursingId(long nursingId) {
		this.nursingId = nursingId;
	}

	@Autowired
	private NursingService nursingService;
	

	@Override
	public void prepare() throws Exception {
		
		log.info(userActionStart(log,"prepare"));

		loginUser = getUserFromSession();

		EventItem searchItem = (EventItem) getSearchCondition();

		if (searchItem != null) {

			String selectedYm = searchItem.getSearchServiceYm();
			String selectedD = searchItem.getSearchServiceDay();
			
			if (selectedYm != null && selectedYm.length() == 6 && selectedD != null && selectedD.length() > 0) {
				selectedD = "00" + selectedD;
				selectedDay = selectedYm + selectedD.substring(selectedD.length() - 2, selectedD.length());
			}
		}

		Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());
		
		if (office != null) {
			officeId = office.getId();
		}
		log.info(userActionEnd(log,"prepare",SUCCESS,"selectedDay",selectedDay,"officeid",office.getId()));
	}

	public String execute() throws Exception {

		log.info(userActionStart(log,"execute","officeId",officeId,"selectedDay",selectedDay));

		
		try {
			if (officeId > 0 && selectedDay != null) {
				events = eventService.loadEventsWithItemInDays(officeId, new Integer[]{EventItem.TYPE_SCHEDULE, EventItem.TYPE_ACHIEVEMENT}, selectedDay, selectedDay, new Integer[]{EventItem.STATUS_COMPLETED, EventItem.STATUS_COMPLETED_APPROVED});
			} else {
				message = getText("messages.js.plan.failed");
				result = ERROR;
			}
		} catch (ServiceException e) {
			message = getText(e.getMessage());
			result = ERROR;
		}

		if (message == null) {
			message = getText("messages.js.plan.success");
			result = SUCCESS;
		}
		log.info(userActionEnd(log,"execute",SUCCESS,"events",events,"result",result,"message",message));
		return SUCCESS;
	}
	
	public String toNursingId() throws Exception {
		
		log.info(userActionStart(log,"toNursingId","nursingId",nursingId));
		
		Nursing nursing = nursingService.findByProperty("eventId", nursingId);
		if (nursing != null) {
			nursingId = nursing.getId();
		} else {
			nursingId = 0;
		}
		log.info(userActionEnd(log,"toNursingId","nursing-id","nursingId",nursingId));
		return "nursing-id";
	}
}
