package com.qzn.struts.services;

import java.io.Serializable;

import com.qzn.struts.services.exceptions.ServiceException;
import com.qzn.struts.util.PaginationSupport;

public interface PaginationSupportService<T extends Serializable>  {

	/**
	 * 
	 * @param model
	 * @param pageSize
	 * @param offset
	 * @return
	 * @throws ServiceException
	 */
	PaginationSupport<T> loadPage(T search, final int pageSize, final int offset) throws ServiceException ;
	
}
