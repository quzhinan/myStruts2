package com.qzn.struts.services.hibernate;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qzn.struts.models.User;
import com.qzn.struts.services.AuthService;

public class AuthServiceImpl implements AuthService {

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public boolean allowUserManage( User loginUser ) {
		
		if( loginUser == null )
			return false;
		
		if( loginUser.getRoleType() == User.SUPER_ADMIN_NAME)
			return true;
		
		return false;
	}

	
}
