/**
 * 
 */
package com.qzn.struts.services;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.qzn.struts.services.exceptions.CSVInvalidException;
import com.qzn.struts.services.exceptions.ServiceException;

public interface Service<T, ID extends Serializable> {
	/**
	 * 
	 * @return
	 * @throws ServiceException
	 */
	abstract Class<T> getModelClass() throws ServiceException;
	/**
	 * 
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	T findById(ID id) throws ServiceException;
	
	/**
	 * 
	 * @param t
	 * @throws ServiceException
	 */
	ID save(T t) throws ServiceException;
	
	/**
	 * 
	 * @param t
	 * @throws ServiceException
	 */
	void update(T t) throws ServiceException;
	
	/**
	 * 
	 * @param id
	 * @throws ServiceException
	 */
	void deleteById(ID id) throws ServiceException;
	
	/**
	 * 
	 * @param ids
	 */
	void deleteByIds(ID[] ids) throws ServiceException;

	/**
	 * get unique object by property
	 * 
	 * @param property
	 * @param value
	 * @return
	 * @throws ServiceException
	 */
	T findByProperty(String property, Object value) throws ServiceException;
	
	/**
	 * 
	 * @param maps<property, value>
	 * @return
	 * @throws ServiceException
	 */
	List<T> getListByProperty(Map<Object, Object> maps) throws ServiceException;

	/**
	 * 
	 * @param maps
	 * @param order
	 * @return
	 * @throws ServiceException
	 */
	List<T> getListByProperty(Map<Object, Object> maps, String order) throws ServiceException;
	
	/**
	 * check if record exists
	 * 
	 * @param property
	 * @param value
	 * @return
	 * @throws ServiceException
	 */
	boolean exists(String property, Object value) throws ServiceException;
	
	/**
	 * delete all data from table
	 * 
	 * @throws ServiceException
	 */
	void deleteAll() throws ServiceException;
	
	/**
	 * load all data from table
	 * 
	 * @return
	 * @throws ServiceException
	 */
	List<T> loadAll() throws ServiceException;
	
	/**
	 * load all data from table order by "order"
	 * 
	 * @param order
	 * @return
	 * @throws ServiceException
	 */
	List<T> loadAllOrderBy(String order) throws ServiceException;
	
	/**
	 * 
	 * @param filePath
	 * @param fileName
	 * @throws DataAccessException
	 * @throws CSVInvalidException
	 * @throws ServiceException
	 */
	String importCSV(String filePath, String officeCode) throws DataAccessException, CSVInvalidException, ServiceException;
}
