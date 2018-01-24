package com.qzn.struts.services;

import java.util.List;

import com.qzn.struts.models.User;
import com.qzn.struts.services.exceptions.ServiceException;
import com.qzn.struts.util.PaginationSupport;

public interface UserService extends Service<User, Long> {
	User authenticate(String userCode, String password) throws ServiceException;

	PaginationSupport<User> loadPage(User sessionUser, int pageSize,
			int offset, User search, String officeCode) throws ServiceException;

	PaginationSupport<User> loadStaffPage(User sessionUser, int pageSize,
			int offset, User search) throws ServiceException;

	User getUserById(User sessionUser, long id) throws ServiceException;

	void saveUser(User sessionUser, User user, boolean bModifyPassword)
			throws ServiceException;

	void deleteById(User sessionUser, long id) throws ServiceException;

	void bulkDelete(User sessionUser, Long[] ids) throws ServiceException;

	void setDeviceWithUser(String deviceToken, String userCode)
			throws ServiceException;

	String loadAllDeviceTokenOnLineByUserCode(String userCode)
			throws ServiceException;

	List<User> loadAllUserByUser(User user, boolean isService, int active)
			throws ServiceException;
}
