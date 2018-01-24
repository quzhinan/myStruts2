/*
 * Copyright 2006 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package jp.iesolutions.ienursing.actions;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import jp.iesolutions.ienursing.services.PaginationSupportService;
import jp.iesolutions.ienursing.util.PaginationSupport;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Preparable;


public abstract class AbstractPageAction<T extends Serializable> extends AbstractAction implements Preparable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -47703144817610586L;

	public final String SESSION_PAGE_OFFSET = "page_offset_device_list_" + this.getClass().getSimpleName();
	
	protected PaginationSupportService<T> service;
	
	protected PaginationSupport<T> pagination;
	
	protected PaginationSupport<T> pager;
	
	protected int startIndex = 0;
	
	private boolean bGoLast = false;
	
	public static int PAGESIZE = PaginationSupport.PAGESIZE;
	
	public void setService(PaginationSupportService<T> service) {
		this.service = service;
	}
	
	public PaginationSupport<T> getPagination() {
		return pagination;
	}
	
	public void setPager(PaginationSupport<T> pager) {
		this.pager = pager;
	}

	public void saveStartIndex(int index) {
		session.put(SESSION_PAGE_OFFSET, "" + index);
	}
	
	public int getStartIndex() {
		return Integer.parseInt((String)session.get(SESSION_PAGE_OFFSET));
	}
	
	public void clearStartIndex() {
		session.remove(SESSION_PAGE_OFFSET);
		startIndex = 0;
	}
	
	public void setGolast(boolean value ) {
		this.bGoLast = value;
	}

	public void prepare() throws Exception {
		
		if( this.getClear() ) {
			clearSearchCondition();
			clearStartIndex();
		}
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String s = request.getParameter("pager.offset");
		if (StringUtils.isEmpty(s)) {
			startIndex = 0;
			s = (String)session.get(SESSION_PAGE_OFFSET);
			if (!StringUtils.isEmpty(s)) {
				startIndex = Integer.parseInt(s);
			}
		} else {
			startIndex = Integer.parseInt(s);
			session.put(SESSION_PAGE_OFFSET, s);
		}
		
		if( bGoLast )
			startIndex = 999999999;
	}
}
