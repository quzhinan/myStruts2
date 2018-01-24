package com.qzn.struts.util;

import java.util.List;

/**
 * 
 * @author xiang.guo
 * @since 0.0.1
 * 
 */
public class PaginationSupport<T> {
    public final static int PAGESIZE = 10;  
  
    private int pageSize = PAGESIZE;  
  
    private List<T> items;  
  
    private int totalCount;  
    
    private int offset = 0;
    
    public PaginationSupport() {
    	
    }

	public PaginationSupport(List<T> items, int totalCount) {  
        this.totalCount = totalCount;
        this.items = items;
    }  
  
    public PaginationSupport(List<T> items, int totalCount, int offset) {   
    	this.offset = offset;
        this.totalCount = totalCount;
        this.items = items;
    }  
  
    public PaginationSupport(List<T> items, int totalCount, int pageSize, int offset) {
    	this.pageSize = pageSize;
    	this.offset = offset;
        this.totalCount = totalCount;
        this.items = items;
    }
  
    public List<T>  getItems() {  
        return items;  
    }  
  
    public void setItems(List<T>  items) {  
        this.items = items;  
    }  
  
    public int getPageSize() {  
        return pageSize;  
    }  
  
    public void setPageSize(int pageSize) {  
        this.pageSize = pageSize;  
    }  

    public int getTotalCount() {  
        return totalCount;  
    }  
  
    public void setTotalCount(int totalCount) { 
    	this.totalCount = totalCount;
    }  
  
    public int getOffset() {  
        return offset;  
    }  
  
    public void setOffset(int offset) {  
        this.offset = offset;
    }
    
    public int getItemsCount() {
    	if (items != null) {
    		return items.size();
		}
    	return 0;
    }
    
    public int getMaxPageNumber() {
    	return (int)Math.ceil( (totalCount * 1.0) / (pageSize * 1.0));
    }
    
    public int getCurrentPageNumber() {
    	
    	return (offset / pageSize) + (offset % pageSize == 0 ? 0 : 1) + 1;
    }
} 
