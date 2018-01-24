package com.qzn.struts.daos.hibernate;

import org.springframework.dao.DataAccessException;

import com.qzn.struts.daos.EnvironmentDao;
import com.qzn.struts.models.Environment;

public class EnvironmentDaoImpl extends AbstractDao<Environment, Long> implements EnvironmentDao {
	
	public Class<Environment> getModelClass() throws DataAccessException {
		return Environment.class;
	}
	
}
