package com.qzn.struts.daos;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.qzn.struts.models.Master;


public interface MasterDao extends Dao<Master, Long> {
	
	/**
	 * 
	 * 
	 * @param map
	 * @return
	 * @throws DataAccessException
	 */
	List<Master> getMasterList(String code) throws DataAccessException;
	
	/**
	 * 
	 * @param code
	 * @param value
	 * @return
	 * @throws DataAccessException
	 */
	String getLabel(String code, String value) throws DataAccessException;
	
	/**
	 * 
	 * @param code
	 * @param label
	 * @return
	 * @throws DataAccessException
	 */
	String getValue(String code, String label) throws DataAccessException;
	
	boolean updateUsingAppVersion() throws DataAccessException;
	
	String getUsingAppVersion() throws DataAccessException;
}
