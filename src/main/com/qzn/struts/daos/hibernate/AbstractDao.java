package com.qzn.struts.daos.hibernate;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate5.HibernateCallback;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import com.qzn.struts.daos.Dao;
import com.qzn.struts.services.exceptions.CSVInvalidException;
import com.qzn.struts.util.PaginationSupport;

@SuppressWarnings("unchecked")
public abstract class AbstractDao<T, ID extends Serializable> extends
		HibernateDaoSupport implements Dao<T, ID> {
	protected final Log log = LogFactory.getLog(AbstractDao.class);

	public T load(ID id) throws DataAccessException {
		return (T) getHibernateTemplate().get(getModelClass(), id);
	}

	public List<T> loadByIds(ID[] ids) throws DataAccessException {
		return (List<T>) getHibernateTemplate().find(
				"FROM " + getModelClass().getSimpleName()
						+ " obj WHERE obj.id in " + this.getString(ids));
	}

	private String getString(ID[] ids) {
		String sIds = "(";
		for (int i = 0; i < ids.length; i++) {
			ID id = ids[i];
			sIds += "'" + id.toString() + "'";
			if (i != ids.length - 1) {
				sIds += ",";
			}
		}
		sIds += ")";
		return sIds;
	}

	public void deleteByIds(ID[] ids) throws DataAccessException {
		getHibernateTemplate().bulkUpdate(
				"delete FROM " + getModelClass().getSimpleName()
						+ " obj WHERE obj.id in " + this.getString(ids));
	}

	public int deleteByIds(ID[] ids, Long createUserId)
			throws DataAccessException {
		return getHibernateTemplate().bulkUpdate(
				"delete FROM " + getModelClass().getSimpleName()
						+ " obj WHERE obj.createUserId=" + createUserId
						+ " AND obj.id in " + this.getString(ids));
	}

	public List<T> loadAll() throws DataAccessException {
		return (List<T>) getHibernateTemplate().find(
				"FROM " + getModelClass().getSimpleName() + " ORDER BY id");
	}

	public List<T> loadAllOrderBy(String order) throws DataAccessException {
		Criteria cri = getSessionFactory().getCurrentSession().createCriteria(getModelClass());
		cri.addOrder(Order.asc(order));
		return (List<T>) cri.list();
	}

	public void delete(T t) throws DataAccessException {
		if (t != null) {
			getHibernateTemplate().delete(t);
			getHibernateTemplate().flush();
			getSessionFactory().getCurrentSession().flush();
			getSessionFactory().getCurrentSession().clear();
			//getHibernateTemplate().getSessionFactory().evictQueries();
		}
	}

	public void flush() throws DataAccessException {
		getHibernateTemplate().flush();
	}

	public void clear() throws DataAccessException {
		getHibernateTemplate().clear();
	}

	public ID save(T t) throws DataAccessException {
		if (t != null) {
			return (ID) getHibernateTemplate().save(t);
		}
		return null;
	}

	public void update(T t) throws DataAccessException {
		if (t != null) {
			getHibernateTemplate().update(t);
		}

	}

	public void merge(T t) throws DataAccessException {
		if (t != null) {
			getHibernateTemplate().merge(t);
		}
	}

	public T uniqueResult(String property, Object value)
			throws DataAccessException {
		Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(getModelClass());
		criteria.add(Expression.eq(property, value));

		Object o = null;
		try {
			o = criteria.uniqueResult();
		} catch (HibernateException e) { // not unique
			log.error(e);
			o = null;
		}
		return (null == o) ? null : (T) o;
	}

	public T uniqueResult(@SuppressWarnings("rawtypes") Map propertyNameValues)
			throws DataAccessException {
		Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(getModelClass());
		criteria.add(Expression.allEq(propertyNameValues));

		Object o = null;
		try {
			o = criteria.uniqueResult();
		} catch (HibernateException e) { // not unique
			log.error(e);
			o = null;
		}
		return (null == o) ? null : (T) o;
	}

	public Object max(String property) throws DataAccessException {
		Criteria cri = getSessionFactory().getCurrentSession().createCriteria(getModelClass());
		cri.setProjection(Projections.max(property));
		;
		return cri.uniqueResult();
	}

	public int getCountByProperty(String property, Object value)
			throws DataAccessException {
		Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(getModelClass());
		criteria.add(Expression.eq(property, value));
		criteria.setProjection(Projections.count(property));
		int count = 0;
		Object o = criteria.uniqueResult();
		try {
			if (null != o) {
				count = (Integer) o;
			}
		} catch (Exception ex) {
			log.error(ex);
			count = 0;
		}
		return count;
	}

	public long getCountByProperty(String property, Object[] values)
			throws DataAccessException {
		Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(getModelClass());
		criteria.add(Expression.in(property, values));
		criteria.setProjection(Projections.count(property));
		long count = 0;
		Object o = criteria.uniqueResult();
		try {
			if (null != o) {
				count = (Long) o;
			}
		} catch (Exception ex) {
			log.error(ex);
			count = 0;
		}
		return count;
	}

	public void deleteAll() throws DataAccessException {
		getHibernateTemplate().bulkUpdate(
				"delete " + getModelClass().getSimpleName());
	}

	public void deleteAll(Collection<T> entities) throws DataAccessException {
		if (entities != null) {
			getHibernateTemplate().deleteAll(entities);
		}
	}

	public void evict(T t) throws DataAccessException {
		if (t != null)
			getHibernateTemplate().evict(t);
	}

//	public void saveOrUpdateAll(Collection<T> entities)
//			throws DataAccessException {
//		getHibernateTemplate().saveOrUpdateAll(entities);
//
//	}

	public abstract Class<T> getModelClass() throws DataAccessException;

	public List<T> findTopByCriteria(final DetachedCriteria detachedCriteria,
			final int top, final Order[] orders) throws DataAccessException {
		return (List<T>) getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException {
						Criteria criteria = detachedCriteria.getExecutableCriteria(session);
						criteria.setProjection(null);
						if (orders != null) {
							for (Order order : orders) {
								criteria.addOrder(order);
							}
						}
						List<T> items = criteria.setCacheable(true)
								.setFirstResult(0).setMaxResults(top).list();
						return items;
					}
				});
	}

	@SuppressWarnings("rawtypes")
	public List<T> findAllByCriteria(final DetachedCriteria detachedCriteria)
			throws DataAccessException {
		return (List) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException {
				Criteria criteria = detachedCriteria.getExecutableCriteria(session);
				return (List<T>) criteria.list();
			}
		});
	}

	public int getCountByCriteria(final DetachedCriteria detachedCriteria)
			throws DataAccessException {
		Integer count = (Integer) getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException {
						Criteria criteria = detachedCriteria.getExecutableCriteria(session);
						return criteria.setProjection(Projections.rowCount())
								.uniqueResult();
					}
				});
		return count.intValue();
	}

	public PaginationSupport<T> findPageByCriteria(
			final DetachedCriteria detachedCriteria, final int pageSize,
			final int startIndex, final Order[] orders)
			throws DataAccessException {
		return (PaginationSupport<T>) getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException {
						Criteria criteria = detachedCriteria.getExecutableCriteria(session);
						int totalCount = ((Integer) criteria.setProjection(
								Projections.rowCount()).uniqueResult())
								.intValue();
						criteria.setProjection(null);
						if (orders != null) {
							for (Order order : orders) {
								criteria.addOrder(order);
							}
						}
						List<T> items = criteria.setCacheable(true)
								.setFirstResult(startIndex)
								.setMaxResults(pageSize)
								// .setFetchSize(PaginationSupport.PAGESIZE)
								.list();
						PaginationSupport<T> ps = new PaginationSupport<T>(items,
								totalCount, pageSize, startIndex);
						return ps;
					}
				});
	}

	public PaginationSupport<T> findPageByQuery(final Query query,
			final int pageSize, int startIndex) throws DataAccessException {
		int totalCount = 0;
		ScrollableResults scrollableResults = query.scroll();
		scrollableResults.last();
		if (scrollableResults.getRowNumber() >= 0) {
			totalCount = scrollableResults.getRowNumber() + 1;
		}
		if (startIndex >= totalCount)
			startIndex = ((totalCount - 1) / pageSize) * pageSize;

		List<T> items = query.setFirstResult(startIndex)
				.setMaxResults(pageSize).list();
		PaginationSupport<T> ps = new PaginationSupport<T>(items, totalCount,
				pageSize, startIndex);
		return ps;
	}

	public int getCount() {
		Object count = getSessionFactory().getCurrentSession().createCriteria(getModelClass())
				.setProjection(Projections.rowCount()).uniqueResult();
		if (count == null) {
			return 0;
		}
		return (Integer) count;
	}

	public List<T> getListByProperty(Map<Object, Object> maps)
			throws DataAccessException {
		if (maps.size() > 0) {
			String hql = String.format("from %s where 1=1", getModelClass()
					.getSimpleName());
			StringBuffer sBuffer = new StringBuffer(hql);
			Iterator<Object> iter = maps.keySet().iterator();
			while (iter.hasNext()) {
				String key = (String) iter.next();
				sBuffer.append(" and " + key + "= '" + (String) maps.get(key)
						+ "'");
			}
			return this.getSessionFactory().getCurrentSession().createQuery(sBuffer.toString()).list();
		} else {
			return null;
		}
	}
	
	public List<T> getListByCondition(String condition) throws DataAccessException {
		String hql = String.format("from %s where 1=1", getModelClass()
				.getSimpleName());
		StringBuffer sBuffer = new StringBuffer(hql);
		if (condition != null && condition.length() > 0) {
			sBuffer.append(" and " + condition);
		}
		
		return this.getSessionFactory().getCurrentSession().createQuery(sBuffer.toString()).list();
	}

	public List<T> getListByProperty(Map<Object, Object> maps, String order)
			throws DataAccessException {
		if (maps.size() > 0) {
			String hql = String.format("from %s where 1=1", getModelClass()
					.getSimpleName());
			StringBuffer sBuffer = new StringBuffer(hql);
			Iterator<Object> iter = maps.keySet().iterator();
			while (iter.hasNext()) {
				String key = (String) iter.next();
				sBuffer.append(" and " + key + "= '" + (String) maps.get(key)
						+ "'");
			}
			sBuffer.append(" order by " + order);
			return this.getSessionFactory().getCurrentSession().createQuery(sBuffer.toString()).list();
		} else {
			return null;
		}
	}

	@Override
	public String importCSV(String filePath, String officeCode)
			throws DataAccessException, CSVInvalidException {
		return "";
	}
}
