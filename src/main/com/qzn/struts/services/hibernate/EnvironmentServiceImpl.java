package com.qzn.struts.services.hibernate;

import org.springframework.beans.factory.annotation.Autowired;

import com.qzn.struts.daos.Dao;
import com.qzn.struts.daos.EnvironmentDao;
import com.qzn.struts.models.Environment;
import com.qzn.struts.services.EnvironmentService;
import com.qzn.struts.services.exceptions.ServiceException;

public class EnvironmentServiceImpl extends AbstractService<Environment, Long> implements EnvironmentService {

	@Autowired
	private EnvironmentDao environmentDao;

	@Override
	public Dao<Environment, Long> getDao() throws ServiceException {
		return environmentDao;
	}

}
