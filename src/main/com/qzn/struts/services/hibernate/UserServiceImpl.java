package com.qzn.struts.services.hibernate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import com.qzn.struts.daos.Dao;
import com.qzn.struts.daos.UserDao;
import com.qzn.struts.models.User;
import com.qzn.struts.services.UserService;
import com.qzn.struts.services.exceptions.AuthenticationException;
import com.qzn.struts.services.exceptions.MultipleException;
import com.qzn.struts.services.exceptions.PermissionsException;
import com.qzn.struts.services.exceptions.ServiceException;
import com.qzn.struts.util.PaginationSupport;

public class UserServiceImpl extends AbstractService<User, Long> implements UserService {

	private final Log log = LogFactory.getLog(UserServiceImpl.class);

	@Autowired
	private UserDao userDao;

	@Override
	public Dao<User, Long> getDao() throws ServiceException {
		return userDao;
	}

	private int maxUserTotal;

	public void setMaxUserTotal(int num) {
		this.maxUserTotal = num;
	}

	private int maxLoginTimes;

	public void setMaxLoginTimes(int maxLoginTimes) {
		this.maxLoginTimes = maxLoginTimes;
	}

	@Transactional(readOnly = false, rollbackFor = ServiceException.class)
	public User authenticate(String userCode, String password) throws ServiceException {
		Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
		String md5Password = md5PasswordEncoder.encodePassword(password.toLowerCase(), null);
		User user = userDao.uniqueResult("userCode", userCode.toLowerCase());

		if (user == null) {
			log.error(userCode + " is not existing.");
			throw new AuthenticationException("errors.login.failed");
		} else if (user.getIsLocked() == 1) {
			log.error(userCode + " is Locked.");
			throw new AuthenticationException("errors.login.locked");
		} else if (!user.getPassword().equals(md5Password)) {
			int newTimes = user.getLoginTryTimes() + 1;
			user.setLoginTryTimes(newTimes);
			if (newTimes >= maxLoginTimes) {
				user.setIsLocked(1);
			}
			userDao.update(user);
			user.setAllowLogin(false);

		} else {
			user.setLoginTryTimes(0);
			userDao.update(user);
			user.setAllowLogin(true);
		}

		return user;
	}

	@Transactional(rollbackFor = ServiceException.class)
	public void logoutFromDevice(long userId) throws ServiceException {
		User user = userDao.load(userId);
		userDao.update(user);
	}

	@Transactional(readOnly = true, rollbackFor = ServiceException.class)
	public PaginationSupport<User> loadPage(User sessionUser, int pageSize, int offset, User search, String officeCode)
			throws ServiceException {
		return userDao.loadPage(search, pageSize, offset, officeCode);
	}

	@Transactional(readOnly = true, rollbackFor = ServiceException.class)
	public User getUserById(User sessionUser, long id) throws ServiceException {
		User user = userDao.load(id);
		if (!allowDealUser(sessionUser, user)) {
			throw new PermissionsException("errors.permissions.roletype.error");
		}
		return user;
	}

	@Transactional(rollbackFor = ServiceException.class)
	public void saveUser(User sessionUser, User user, boolean bModifyPassword) throws ServiceException {
		if (!allowDealUser(sessionUser, user)) {
			throw new PermissionsException("errors.permissions.roletype.error");
		}
		Map<Object, Object> maps = new HashMap<Object, Object>();
		maps.put("userCode", user.getUserCode());
		List<User> userList = userDao.getListByProperty(maps);

		if (userList.size() > 0) {

			if (user.getId() == 0 || userList.size() > 1)

				throw new ServiceException("errors.user.add.exists");

			else {

				if (userList.get(0).getId() != user.getId()) {

					throw new ServiceException("errors.user.add.exists");
				}

				userDao.evict(userList.get(0));
			}
		}

		if (user.getId() == 0) {

			if (maxUserTotal > 0) {

				int total = userDao.getCount();

				if (total > maxUserTotal) { // +1 : for admin

					throw new MultipleException("<errors.user.total.max>",
							MultipleException.createMsgPiece("<errors.user.total.max>").addArg("<max>", maxUserTotal));
				}
			}

			Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();

			String md5Password = md5PasswordEncoder.encodePassword(user.getPassword().toLowerCase(), null);

			user.setPassword(md5Password);

			userDao.save(user);

		} else {

			if (bModifyPassword) {

				Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();

				String md5Password = md5PasswordEncoder.encodePassword(user.getPassword().toLowerCase(), null);

				user.setPassword(md5Password);
			}

			userDao.update(user);
		}
	}

	@Transactional(rollbackFor = ServiceException.class)
	public void deleteById(User sessionUser, long id) throws ServiceException {
		User user = userDao.load(id);
		if (!allowDealUser(sessionUser, user)) {
			throw new PermissionsException("errors.permissions.roletype.error");
		}

		if (user != null) {
			List<User> users = new ArrayList<User>();
			users.add(user);
			this.checkIsUsingServiceUser(users);
			userDao.delete(user);
		}
	}

	@Transactional(rollbackFor = ServiceException.class)
	public void bulkDelete(User sessionUser, Long[] ids) throws ServiceException {
		List<User> users = userDao.loadByIds(ids);
		for (int i = 0; i < users.size(); i++) {
			if (sessionUser.getId() == users.get(i).getId()) {
				throw new PermissionsException("errors.permissions.deleteself");
			} else {
				if (!allowDealUser(sessionUser, users.get(i))) {
					throw new PermissionsException("errors.permissions.roletype.error");
				}
			}
		}
		this.checkIsUsingServiceUser(users);
		userDao.deleteByIds(ids);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = ServiceException.class)
	public PaginationSupport<User> loadStaffPage(User sessionUser, int pageSize, int offset, User search)
			throws ServiceException {
		if (!allowDealUser(sessionUser, search)) {
			throw new PermissionsException("errors.permissions.roletype.error");
		}
		return userDao.loadStaffPage(sessionUser.getId(), search, pageSize, offset);
	}

	@Override
	@Transactional(rollbackFor = ServiceException.class)
	public void setDeviceWithUser(String deviceToken, String userCode) throws ServiceException {
		userDao.setDeviceWithUser(userCode, deviceToken);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = ServiceException.class)
	public String loadAllDeviceTokenOnLineByUserCode(String userCode) throws ServiceException {
		return userDao.loadAllDeviceTokenOnLineByUserCode(userCode);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = ServiceException.class)
	public List<User> loadAllUserByUser(User user, boolean isService, int active) throws ServiceException {
		Map<Object, Object> maps = new HashMap<Object, Object>();
		if (active == 1) {
			maps.put("active", String.valueOf(1));
		}

		if (isService) {
			maps.put("roleType", String.valueOf(1));
		} else {
			maps.put("roleType", String.valueOf(0));
		}
		if (user.getRoleType() >= 1) {
			maps.put("officeCode", user.getOfficeCode());
		}
		return userDao.getListByProperty(maps, "sortNum, userCode");
	}
	
	private void checkIsUsingServiceUser(List<User> users) throws DataAccessException {
		
		List<String> usersCode = new ArrayList<String>();
		
		if (users != null && users.size() > 0) {
			for (User user : users) {
				if (user.getUserCode() != null && user.getUserCode().length() > 0) {
					usersCode.add(user.getUserCode());
				}
			}
		}
	}
}
