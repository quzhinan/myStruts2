package com.qzn.struts.pdf;

import java.util.ArrayList;
import java.util.List;

import com.qzn.struts.models.User;


/**
 * 介護記録 DATA
 */
public class CustomerNursingRecordPDFData {

	private String serviceUserName;
	private String officeName;
	private int downloadOption;
	private List<User> userList = new ArrayList<User>();
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public String getServiceUserName() {
		return serviceUserName;
	}
	public void setServiceUserName(String serviceUserName) {
		this.serviceUserName = serviceUserName;
	}
	public int getDownloadOption() {
		return downloadOption;
	}
	public void setDownloadOption(int downloadOption) {
		this.downloadOption = downloadOption;
	}
	public List<User> getUserList() {
		return userList;
	}
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}
}
