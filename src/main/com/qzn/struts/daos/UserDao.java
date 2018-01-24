package com.qzn.struts.daos;

import org.springframework.dao.DataAccessException;

import com.qzn.struts.models.User;
import com.qzn.struts.util.PaginationSupport;

public interface UserDao extends Dao<User, Long> {
	
	PaginationSupport<User> loadPage(User search, int pageSize, int startIndex, String officeCode) throws DataAccessException;
	
	PaginationSupport<User> loadStaffPage(long userId, User search, int pageSize, int startIndex) throws DataAccessException;
		
	void setDeviceWithUser(String userCode, String deviceToken) throws DataAccessException;
	
	String loadAllDeviceTokenOnLineByUserCode(String userCode) throws DataAccessException;
	
}
