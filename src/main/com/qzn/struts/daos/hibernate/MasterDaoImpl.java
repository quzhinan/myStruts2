package com.qzn.struts.daos.hibernate;

import java.util.List;

import org.hibernate.Query;
import org.springframework.dao.DataAccessException;

import com.qzn.struts.daos.MasterDao;
import com.qzn.struts.models.Master;


public class MasterDaoImpl extends AbstractDao<Master, Long> implements MasterDao {
	
	
	private String appVersionCode = "app.version";
	
	
	
	public Class<Master> getModelClass() throws DataAccessException {
		return Master.class;
	}

	@SuppressWarnings("unchecked")
	public List<Master> getMasterList(String code) throws DataAccessException {
		String hql = "FROM Master where code=:code ORDER BY value";
		Query query = getSessionFactory().getCurrentSession().createQuery(hql);
		query.setString("code", code);
		query.setCacheable(true);
		List<Master> masters = (List<Master>)query.list();
		return masters;
	}

	@SuppressWarnings("unchecked")
	public String getLabel(String code, String value)
			throws DataAccessException {
		String hql = "SELECT master.label from Master master WHERE master.code=:code AND master.value=:value";
		Query query = getSessionFactory().getCurrentSession().createQuery(hql);
		query.setString("code", code);
		query.setString("value", value);
		List<String> labels = (List<String>)query.list();
		
		return labels.size() > 0 ? labels.get(0) : "";
	}

	@SuppressWarnings("unchecked")
	public String getValue(String code, String label)
			throws DataAccessException {

		String hql = "SELECT master.value from Master master WHERE master.code=:code AND master.label=:label";
		Query query = getSessionFactory().getCurrentSession().createQuery(hql);
		query.setString("code", code);
		query.setString("label", label);
		List<String> values = (List<String>)query.list();
		
		return values.size() > 0 ? values.get(0) : "";
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Master> loadAll() throws DataAccessException {
		String hql = "FROM Master ORDER BY id";
		return (List<Master>) getHibernateTemplate().find(hql);
	}
	
	@Override
	public boolean updateUsingAppVersion() throws DataAccessException {
		
		Query query=getSessionFactory().getCurrentSession().createSQLQuery("select version from apps where time <= now() order by time desc ");
		
		List<Object> list = query.list();
		
		Object object = null;
		
		if(list.size() > 0){
			object = list.get(0);
			for(int i = 1; i < list.size(); i ++){
				Object o = list.get(i);
				String[] objects = object.toString().split("\\.");
				String[] os = o.toString().split("\\.");
				int min = Math.min(objects.length, os.length);
				boolean larger = os.length > min;
				for(int j = 0; j < min; j ++){
					int objecti = Integer.parseInt(objects[j]);
					int oi = Integer.parseInt(os[j]);
					if(objecti < oi){
						larger = true;
						break;
					}else if(objecti > oi){
						larger = false;
						break;
					}
				}
				if(larger){
					object = o;
				}
			}
		}
		
		if(object == null){
			object = "1.0";
		}
		
		query=getSessionFactory().getCurrentSession().createSQLQuery("update masters set value = :version where code = :code and label = :label ");
		query.setString("code", appVersionCode);
		query.setString("label", appVersionCode);
		query.setString("version", object.toString());
		if(query.executeUpdate() > 0){
			return true;
		}
		return false;
		
	}
	
	@Override
	public String getUsingAppVersion() throws DataAccessException {
		return getValue(appVersionCode, appVersionCode);
	}
}
