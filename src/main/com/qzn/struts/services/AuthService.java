package com.qzn.struts.services;


import com.qzn.struts.models.User;

public interface AuthService {

	boolean allowUserManage( User loginUser );

	
}
