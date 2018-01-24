package com.qzn.struts.services.hibernate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.qzn.struts.daos.Dao;
import com.qzn.struts.daos.MasterDao;
import com.qzn.struts.models.Master;
import com.qzn.struts.services.MasterService;
import com.qzn.struts.services.exceptions.ServiceException;


public class MasterServiceImpl extends AbstractService<Master, Long> implements MasterService {
	
	@Autowired
	private MasterDao masterDao;

	public void setMasterDao(MasterDao masterDao) {
		this.masterDao = masterDao;
	}

	@Override
	public Dao<Master, Long> getDao() throws ServiceException {
		return masterDao;
	}

	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public List<Master> getMasterList(String code) throws ServiceException {
		return masterDao.getMasterList(code);
	}
	
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public String getLabel(String code, String value) throws ServiceException {
		return masterDao.getLabel(code, value);
	}
	
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public String getValue(String code, String label) throws ServiceException {
		return masterDao.getLabel(code, label);
	}
	
	@Override
	@Transactional(readOnly=true, rollbackFor=ServiceException.class)
	public String getUsingAppVersion() throws ServiceException{
		return masterDao.getUsingAppVersion();
	}
	
	@Override
	@Transactional(rollbackFor=ServiceException.class)
	public boolean updateUsingAppVersion() throws ServiceException {
		return masterDao.updateUsingAppVersion();
	}
}
