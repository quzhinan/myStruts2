package com.qzn.struts.util;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;


import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;

public class ClassUtils {

	private static final Log log = LogFactory.getLog(ClassUtils.class);
	
	public void enumStringProperties(Object obj, String [] excludeProperties) {
		
		PropertyDescriptor [] pds = BeanUtils.getPropertyDescriptors(obj.getClass());
		
		for( PropertyDescriptor pd : pds ) {
			
			if( pd.getPropertyType().equals(String.class) ) {
				
				Method methodGet = pd.getReadMethod();
				
				if( methodGet == null )
					continue;
				
				if( ! Modifier.isPublic( methodGet.getModifiers() ) )
					continue;
				
				if( methodGet.getParameterTypes().length != 0 )
					continue;
				
				Method methodSet = pd.getWriteMethod();
				
				if( methodSet == null )
					continue;
				
				String methodName = pd.getName().toLowerCase();
				
				if( excludeProperties != null ) {
					boolean bIgnore = false;
					for( String pname : excludeProperties ) {
						if( methodName.indexOf(pname) > -1 ) {
							bIgnore = true;
							break;
						}
					}
					if( bIgnore )
						continue;
				}
				
				try {
					
					String valGet = (String)methodGet.invoke(obj, new Object[] {});
					
					valGet = onEnumString( pd.getName(), valGet );
					
					methodSet.invoke(obj, new Object[] { (valGet==null)?null:valGet.trim() });
					
				} catch (Throwable t) {
					
					log.error(t.getMessage());
				}
			}
		}
	}
	
	protected String onEnumString( String PropertyName, String originalValue ) {
		
		return originalValue;
	}
}
