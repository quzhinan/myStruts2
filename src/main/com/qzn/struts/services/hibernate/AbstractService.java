package com.qzn.struts.services.hibernate;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.annotation.Transactional;

import com.qzn.struts.daos.Dao;
import com.qzn.struts.models.User;
import com.qzn.struts.services.Service;
import com.qzn.struts.services.exceptions.CSVInvalidException;
import com.qzn.struts.services.exceptions.ServiceException;

public abstract class AbstractService<T, ID extends Serializable> implements Service<T, ID> {
	/**
	 * 
	 * @return
	 * @throws ServiceException
	 */
	private static final Log log = LogFactory.getLog(AbstractService.class);
	
	public  Class<T> getModelClass() throws ServiceException {
		return getDao().getModelClass();
	}

	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public T findById(ID id) throws ServiceException {
		return getDao().load(id);
	}
	
	public abstract Dao<T, ID> getDao() throws ServiceException;

	@Transactional(rollbackFor=ServiceException.class)
	public void deleteById(ID id) throws ServiceException {
		T t = getDao().load(id);
		getDao().delete(t);
	}

	@Transactional(rollbackFor=ServiceException.class)
	public ID save(T t) throws ServiceException {
		return getDao().save(t);
	}

	@Transactional(rollbackFor=ServiceException.class)
	public void update(T t) throws ServiceException {
		getDao().update(t);
		
	}

	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public T findByProperty(String property, Object value)
			throws ServiceException {
		return getDao().uniqueResult(property, value);
	}

	@Override
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public List<T> getListByProperty(Map<Object, Object> maps)
			throws ServiceException {
		return getDao().getListByProperty(maps);
	}

	@Override
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public List<T> getListByProperty(Map<Object, Object> maps, String order)
			throws ServiceException {
		return getDao().getListByProperty(maps, order);
	}
	
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public boolean exists(String property, Object value) throws ServiceException {
		// get count
		int count = getDao().getCountByProperty(property, value);
		return count > 0;
	}
	
	@Transactional(rollbackFor=ServiceException.class)
	public void deleteAll() throws ServiceException {
		getDao().deleteAll();
	}
	
	@Transactional(rollbackFor=ServiceException.class)
	public void deleteByIds(ID[] ids) throws ServiceException {
		// List<T> entities = getDao().loadByIds(ids);
		// getDao().deleteAll(entities);
		getDao().deleteByIds(ids);
	}
	
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public List<T> loadAll() throws ServiceException {
		return getDao().loadAll();
	}
	
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public List<T> loadAllOrderBy(String order) throws ServiceException {
		return getDao().loadAllOrderBy(order);
	}
	
	public void copyFile(File file, String path) {
		BufferedInputStream bufferedInput = null;
		BufferedOutputStream bufferedOutput = null;
		try {
			if (file == null) {
				return;
			}
			bufferedInput = new BufferedInputStream(new FileInputStream(file));
			File outFile = new File(path);
			bufferedOutput = new BufferedOutputStream(new FileOutputStream(
					outFile));
			byte[] b = new byte[1024];
			int count = -1;
			while ((count = bufferedInput.read(b)) != -1) {
				bufferedOutput.write(b, 0, count);
			}
		} catch (FileNotFoundException e) {
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		} finally {
			try {
				if (bufferedInput != null) {
					bufferedInput.close();
				}
				if (bufferedOutput != null) {
					bufferedOutput.flush();
					bufferedOutput.close();
				}
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@Transactional(readOnly=false, rollbackFor=ServiceException.class)
	public String importCSV(String filePath, String officeCode) throws DataAccessException, CSVInvalidException, ServiceException {
		return getDao().importCSV(filePath, officeCode);
	}
	
	protected boolean allowDealUser(User sessionUser, User dealedUser) {
		boolean result = false;
		String officeCode = dealedUser.getOfficeCode();
		if (officeCode != null) {
			result = allowDealUser(sessionUser, officeCode);
		}
		return result;
	}
	
	protected boolean allowDealUser(User sessionUser, String dealOfficeCode) {
		boolean result = false;
		if (sessionUser != null && sessionUser.getRoleType() == User.SUPER_ADMIN_NAME){
			result = true;
		} else {
			if (dealOfficeCode != null && dealOfficeCode.equals(sessionUser.getOfficeCode())) {
				result = true;
			}
		}
		return result;
	}
}
