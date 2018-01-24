package com.qzn.struts.services;

import java.util.List;

import com.qzn.struts.models.Master;
import com.qzn.struts.services.exceptions.ServiceException;


public interface MasterService extends Service<Master, Long> {
	/**
	 * 
	 * @param ownerId
	 * @return
	 * @throws ServiceException
	 */
	List<Master> getMasterList(String code) throws ServiceException;
	
	/**
	 * 
	 * @param code
	 * @param value
	 * @return
	 * @throws ServiceException
	 */
	String getLabel(String code, String value) throws ServiceException;
	
	/**
	 * 
	 * @param code
	 * @param label
	 * @return
	 * @throws ServiceException
	 */
	String getValue(String code, String label) throws ServiceException;
	
	boolean updateUsingAppVersion() throws ServiceException;
	
	String getUsingAppVersion() throws ServiceException;
}
