package com.qzn.struts.data.helper;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.qzn.struts.models.Master;
import com.qzn.struts.services.MasterService;

public class MasterHelper {

	private static final Log log = LogFactory.getLog(MasterHelper.class);

	private static SimpleDateFormat dateFormatShort = new SimpleDateFormat("yyyyMMdd HHmm");
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	private static Master master = null;

	private static MasterHelper instance;

	@Autowired
	private MasterService masterService;

	public void setMasterService(MasterService masterService) {
		this.masterService = masterService;
	}

	public void setInstance(MasterHelper masterHelper) throws Exception {
		instance = masterHelper;
		instance.refresh();
	}

	public synchronized void refresh() throws Exception {
		master = masterService.findByProperty("id", 1);
		if (master == null) {
			master = new Master();
		}
	}

	public static MasterHelper get() {
		return instance;
	}

	private MasterHelper() {

	}

	public static boolean isToday(Date systemDate, String day) {
		return new SimpleDateFormat("yyyy-MM-dd").format(systemDate).equals(day);
	}

	public static boolean isBeforeServiceTime(String day, String startTime) {
		return isBeforeServiceTime(new Date(), day, startTime);
	}

	public static boolean isBeforeServiceTime(Date systemDate, String day, String startTime) {

		try {
			SimpleDateFormat format = null;
			if (day != null && day.length() == 8) {
				format = dateFormatShort;
			} else {
				format = dateFormat;
			}

			Calendar calendar = Calendar.getInstance();

			Date startDate = format.parse(day + " " + startTime);
			calendar.setTime(startDate);
			calendar.add(Calendar.MINUTE, -1 * master.getBeginTime());
			startDate = calendar.getTime();

			if (systemDate.getTime() < startDate.getTime()) {
				return true;
			}
		} catch (ParseException e) {
		}
		return false;
	}

	public static boolean isAfterServiceTime(String day, String endTime) {
		return isAfterServiceTime(new Date(), day, endTime);
	}

	public static boolean isAfterServiceTime(Date systemDate, String day, String endTime) {

		try {
			SimpleDateFormat format = null;
			if (day != null && day.length() == 8) {
				format = dateFormatShort;
			} else {
				format = dateFormat;
			}

			Calendar calendar = Calendar.getInstance();

			Date endDate = format.parse(day + " " + endTime);
			calendar.setTime(endDate);
			calendar.add(Calendar.MINUTE, master.getEndTime());
			endDate = calendar.getTime();

			if (systemDate.getTime() > endDate.getTime()) {
				return true;
			}
		} catch (ParseException e) {
		}
		return false;
	}

	public static boolean isInServiceTime(String day, String startTime, String endTime) {
		return isInServiceTime(new Date(), day, startTime, endTime);
	}

	public static boolean isInServiceTime(Date systemDate, String day, String startTime, String endTime) {
		return !isAfterServiceTime(systemDate, day, endTime) && !isBeforeServiceTime(systemDate, day, startTime);
	}

}
