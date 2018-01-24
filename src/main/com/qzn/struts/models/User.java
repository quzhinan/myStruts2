package com.qzn.struts.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "user")
public class User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8025718060359889887L;

	public static final int SUPER_ADMIN_NAME = 2;
	public static final String SLASH = "#";

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private long id;

	@Column(name = "user_code")
	private String userCode;

	@Column(name = "user_name")
	private String userName;

	@Column(name = "password")
	private String password;

	@Column(name = "user_name_kana")
	private String userNameKaNa;

	@Column(name = "address")
	private String address;

	@Column(name = "address2")
	private String address2;

	@Column(name = "help_full_time")
	private int helpFullTime;

	@Column(name = "help_part_time")
	private int helpPartTime;

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public int getHelpFullTime() {
		return helpFullTime;
	}

	public void setHelpFullTime(int helpFullTime) {
		this.helpFullTime = helpFullTime;
	}

	public int getHelpPartTime() {
		return helpPartTime;
	}

	public void setHelpPartTime(int helpPartTime) {
		this.helpPartTime = helpPartTime;
	}

	@Column(name = "latitude")
	private double latitude;

	@Column(name = "longitude")
	private double longitude;

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	@Column(name = "phone_number")
	private String phoneNumber;

	@Column(name = "apple_id")
	private String appleID;

	@Column(name = "email")
	private String email;

	@Column(name = "device_key")
	private String deviceKey;

	@Column(name = "office_code")
	private String officeCode;

	@Column(name = "role_type")
	private int roleType;

	@Column(name = "is_locked")
	private int isLocked;

	@Column(name = "login_try_times")
	private int loginTryTimes;

	@Column(name = "active")
	private int active;

	@Column(name = "sort_num")
	private int sortNum;

	@Transient
	private boolean allowLogin;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAppleID() {
		return appleID;
	}

	public void setAppleID(String appleID) {
		this.appleID = appleID;
	}

	public int getRoleType() {
		return roleType;
	}

	public void setRoleType(int roleType) {
		this.roleType = roleType;
		resetUsercode();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserNameKaNa() {
		return userNameKaNa;
	}

	public void setUserNameKaNa(String userNameKaNa) {
		this.userNameKaNa = userNameKaNa;
	}

	public String getDeviceKey() {
		return deviceKey;
	}

	public void setDeviceKey(String deviceKey) {
		this.deviceKey = deviceKey;
	}

	public String getOfficeCode() {
		return officeCode;
	}

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
		resetUsercode();
	}

	public String getUserCodeShort() {
		return this.userCode == null ? null : this.userCode.split(SLASH)[0];
	}

	public void setUserCodeShort(String userCodeShort) {

		this.userCode = userCodeShort;
		resetUsercode();
	}

	private void resetUsercode() {
		String usercode = this.userCode == null ? null : this.userCode.split(SLASH)[0];

		if (this.roleType == 0) {
			if (usercode != null && usercode.length() > 0 && this.officeCode != null && this.officeCode.length() > 0) {
				usercode = usercode + SLASH + this.officeCode;
			}
		}

		this.userCode = usercode;
	}

	public int getIsLocked() {
		return isLocked;
	}

	public void setIsLocked(int isLocked) {
		this.isLocked = isLocked;
	}

	public int getLoginTryTimes() {
		return loginTryTimes;
	}

	public void setLoginTryTimes(int loginTryTimes) {
		this.loginTryTimes = loginTryTimes;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public int getSortNum() {
		return sortNum;
	}

	public void setSortNum(int sortNum) {
		this.sortNum = sortNum;
	}

	public boolean isAllowLogin() {
		return allowLogin;
	}

	public void setAllowLogin(boolean allowLogin) {
		this.allowLogin = allowLogin;
	}

}
