package com.qzn.struts.daos;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.qzn.struts.services.exceptions.CSVInvalidException;


public interface Dao<T, ID extends Serializable> {
	/**
	 * 
	 * @param id
	 * @return
	 * @throws DBDaoException
	 */
	T load(ID id) throws DataAccessException;
	
	/**
	 * 
	 * @return
	 * @throws DataAccessException
	 */
	Class<T> getModelClass() throws DataAccessException;
	/**
	 * 
	 * @param ids
	 * @return
	 * @throws DataAccessException
	 */
	List<T> loadByIds(ID[] ids) throws DataAccessException;
	
	/**
	 * 
	 * @param ids
	 * @param createUserId
	 * @return
	 * @throws DataAccessException
	 */
	int deleteByIds(ID[] ids, Long createUserId) throws DataAccessException;
	
	/**
	 * 
	 * @param ids
	 * @throws DataAccessException
	 */
	void deleteByIds(ID[] ids) throws DataAccessException;
	
	/**
	 * 
	 * @param property
	 * @param value
	 * @return
	 */
	T uniqueResult(String property, Object value) throws DataAccessException;

	/**
	 * 
	 * @param propertyNameValues
	 * @return
	 * @throws DataAccessException
	 */
	T uniqueResult(@SuppressWarnings("rawtypes") Map propertyNameValues) throws DataAccessException;
	
	/**
	 * 
	 * @return
	 * @throws DBDaoException
	 */
	List<T> loadAll() throws DataAccessException;
	
	/**
	 * 
	 * @param order
	 * @return
	 * @throws DataAccessException
	 */
	List<T> loadAllOrderBy(String order) throws DataAccessException;
	
	/**
	 * insert a record
	 * 
	 * @param t
	 * @throws DBDaoException
	 */
	ID save(T t) throws DataAccessException;
	
	/**
	 * update a record
	 * 
	 * @param t
	 * @throws DataAccessException
	 */
	void update(T t) throws DataAccessException;
	
	/**
	 * delete a record
	 * 
	 * @param t
	 * @throws DBDaoException
	 */
	void delete(T t) throws DataAccessException;
	
	/**
	 * flush
	 * 
	 * @throws DBDaoException
	 */
	void flush() throws DataAccessException;
	
	/**
	 * clear
	 * 
	 * @throws DataAccessException
	 */
	void clear() throws DataAccessException;
	
	/**
	 * 
	 * @param property
	 * @return
	 */
	Object max(String property) throws DataAccessException;
	
	/**
	 * 
	 * @param t
	 * @throws DataAccessException
	 */
	void evict(T t) throws DataAccessException;
	
	/**
	 * 
	 * @param t
	 * @throws DataAccessException
	 */
	void merge(T t) throws DataAccessException;
	
	/**
	 * get count
	 * 
	 * @param property
	 * @param value
	 * @return
	 * @throws DataAccessException
	 */
	int getCountByProperty(String property, Object value) throws DataAccessException;

	/**
	 * 
	 * @param property
	 * @param values
	 * @return
	 * @throws DataAccessException
	 */
	long getCountByProperty(String property, Object[] values) throws DataAccessException;
	
	/**
	 * 
	 * @throws DataAccessException
	 */
	void deleteAll() throws DataAccessException;
	
	/**
	 * 
	 * 
	 * @param entities
	 * @throws DataAccessException
	 */
	void deleteAll(Collection<T> entities) throws DataAccessException;
	
	
	/**
	 * 
	 * @param collection
	 * @throws DataAccessException
	 */
	//void saveOrUpdateAll(Collection<T> entities) throws DataAccessException;
	
    /**
     * 
     * @return
     */
	int getCount();
	
	/**
	 * 
	 * @param maps
	 * @return
	 */
	List<T> getListByProperty(Map<Object, Object> maps) throws DataAccessException;
	
	/**
	 * 
	 * @param maps
	 * @return
	 */
	List<T> getListByCondition(String condition) throws DataAccessException;

	/**
	 * 
	 * @param maps
	 * @param order
	 * @return
	 */
	List<T> getListByProperty(Map<Object, Object> maps, String order) throws DataAccessException;
	
	/**
	 * 
	 * @param filePath
	 * @param tableIdentyfier
	 * @throws DataAccessException
	 * @throws CSVInvalidException
	 */
	String importCSV(String filePath, String officeCode) throws DataAccessException, CSVInvalidException;

}
