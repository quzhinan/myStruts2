package com.qzn.struts.models;

import java.io.Serializable;

public class YearMonth implements Serializable {

	private static final long serialVersionUID = 6828174675207465081L;

	private String key;
	private String label;
	private int maxDays;
	private int firstWeekday;
	
	private String[] days = new String[31];
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public int getMaxDays() {
		return maxDays;
	}
	public void setMaxDays(int maxDays) {
		this.maxDays = maxDays;
	}
	public int getFirstWeekday() {
		return firstWeekday;
	}
	public void setFirstWeekday(int firstWeekday) {
		this.firstWeekday = firstWeekday;
	}
	public String[] getDays() {
		return days;
	}
}
