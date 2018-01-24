package com.qzn.struts.daos.hibernate;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.annotation.Transactional;

import com.qzn.struts.daos.UserDao;
import com.qzn.struts.models.User;
import com.qzn.struts.services.exceptions.CSVInvalidException;
import com.qzn.struts.services.exceptions.ServiceException;
import com.qzn.struts.util.PaginationSupport;

public class UserDaoImpl extends AbstractDao<User, Long> implements UserDao {

	public Class<User> getModelClass() throws DataAccessException {
		return User.class;
	}

	private final Log log = LogFactory.getLog(UserDaoImpl.class);
	private static final int DEFAULT_USER_CODE_BIT = 5;

	@Transactional(readOnly = true, rollbackFor = ServiceException.class)
	public PaginationSupport<User> loadPage(User search, int pageSize, int startIndex, String officeCode)
			throws DataAccessException {

		StringBuffer hql = new StringBuffer();

		hql.append("from User where 1=1 ");

		if (search != null) {

			if (!StringUtils.isEmpty(search.getUserCode())) {
				hql.append(" AND userCode LIKE '%").append(search.getUserCode()).append("%' ");
			}
			if (!StringUtils.isEmpty(search.getUserName())) {
				hql.append(" AND userName LIKE '%").append(search.getUserName()).append("%' ");
			}
			if (!StringUtils.isEmpty(search.getEmail())) {
				hql.append(" AND email LIKE '%").append(search.getEmail()).append("%' ");
			}
			if (!StringUtils.isEmpty(search.getPhoneNumber())) {
				hql.append(" AND phoneNumber LIKE '%").append(search.getPhoneNumber()).append("%' ");
			}
			if (search.getRoleType() >= 0) {
				hql.append(" AND roleType LIKE '%").append(search.getRoleType()).append("%' ");
			}

		}

		if (officeCode != null && officeCode.length() > 0 && !officeCode.equals("administrator")) {
			hql.append(" AND officeCode LIKE '%").append(officeCode).append("%' ");
		}

		hql.append(" ORDER BY sortNum, userCode");

		Query query = getSessionFactory().getCurrentSession().createQuery(hql.toString());

		return findPageByQuery(query, pageSize, startIndex);
	}

	@Override
	public PaginationSupport<User> loadStaffPage(long userId, User search, int pageSize, int startIndex)
			throws DataAccessException {
		StringBuffer hql = new StringBuffer();

		hql.append("from User where bossId = :bossId ");

		if (search != null) {

			if (!StringUtils.isEmpty(search.getUserCode())) {
				hql.append(" AND userCode LIKE '%").append(search.getUserCode()).append("%' ");
			}
			if (!StringUtils.isEmpty(search.getUserName())) {
				hql.append(" AND userName LIKE '%").append(search.getUserName()).append("%' ");
			}
			if (!StringUtils.isEmpty(search.getEmail())) {
				hql.append(" AND email LIKE '%").append(search.getEmail()).append("%' ");
			}
			if (!StringUtils.isEmpty(search.getPhoneNumber())) {
				hql.append(" AND remark LIKE '%").append(search.getPhoneNumber()).append("%' ");
			}
		}

		Query query = getSessionFactory().getCurrentSession().createQuery(hql.toString());
		query.setLong("bossId", userId);
		return findPageByQuery(query, pageSize, startIndex);
	}

	@Override
	public void setDeviceWithUser(String userCode, String deviceToken) throws DataAccessException {
		Query sqlQuery = getSessionFactory().getCurrentSession()
				.createSQLQuery("delete from user_online where user_code = :userCode");
		sqlQuery.setString("userCode", userCode);
		sqlQuery.executeUpdate();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String now = dateFormat.format(new Date());
		sqlQuery = getSessionFactory().getCurrentSession().createSQLQuery(
				"insert into user_online (device_token,user_code,create_time) values (:deviceToken,:userCode,:createTime)");
		sqlQuery.setString("deviceToken", deviceToken);
		sqlQuery.setString("userCode", userCode);
		sqlQuery.setString("createTime", now);
		sqlQuery.executeUpdate();
	}

	@Override
	public String loadAllDeviceTokenOnLineByUserCode(String userCode) throws DataAccessException {
		Query sqlQuery = getSessionFactory().getCurrentSession()
				.createSQLQuery("select device_token,user_code from user_online where user_code = :userCode");
		sqlQuery.setString("userCode", userCode);
		List<Object[]> list = sqlQuery.list();
		if (list.size() > 0) {
			Object[] objects = list.get(0);
			return objects[0].toString();
		}
		return "";
	}

	@Override
	public String importCSV(String filePath, String officeCode) throws DataAccessException, CSVInvalidException {

		int preUserSize = getSessionFactory().getCurrentSession().createSQLQuery("select * from user").list().size();

		String successMessage = "";
		String sql = "";
		log.info("load data to table ->user_temp");

		// truncate table
		Query query = getSessionFactory().getCurrentSession().createSQLQuery("truncate user_temp");
		query.executeUpdate();
		getSessionFactory().getCurrentSession().flush();
		sql = "LOAD DATA LOCAL INFILE '" + filePath + "' INTO TABLE user_temp"
				+ " FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '\"'  LINES TERMINATED BY '\\r\\n' IGNORE 0 LINES;";
		query = getSessionFactory().getCurrentSession().createSQLQuery(sql);
		query.executeUpdate();
		getSessionFactory().getCurrentSession().flush();
		if (officeCode.equals("administrator"))
			throw new CSVInvalidException("AdminユーザはCSVファイルを導入できません。");

		// 检查内容中第三列是否为5位的数值类型
		if (getSessionFactory().getCurrentSession()
				.createSQLQuery(
						"select * from user_temp where lpad(code + 0, " + DEFAULT_USER_CODE_BIT + ", '0') != code")
				.list().size() > 0)
			throw new CSVInvalidException("ファイル内の職員番号に誤りがあります。");

		// 获取上传的件数
		int size = getSessionFactory().getCurrentSession().createSQLQuery("select * from user_temp").list().size();
		try {
			query = getSessionFactory().getCurrentSession()
					.createSQLQuery("update user u inner join user_temp t on u.user_code = concat(t.code,'" + User.SLASH
							+ "','" + officeCode
							+ "') set u.user_name = t.name,u.user_name_kana = t.name_kana,u.office_code = '"
							+ officeCode
							+ "',u.address = CONCAT(t.address, ' ', t.address2),u.phone_number = t.phone_number");
			query.executeUpdate();
			getSessionFactory().getCurrentSession().flush();

			// 插入user表中时，先将userCode和officeCode进行拼接
			query = getSessionFactory().getCurrentSession().createSQLQuery(
					"insert into user (user_code, user_name, user_name_kana, office_code, address, phone_number) select CONCAT(code,'"
							+ User.SLASH + "','" + officeCode + "'), name, name_kana, '" + officeCode
							+ "', CONCAT(address, ' ', address2), phone_number from user_temp where CONCAT(code,'"
							+ User.SLASH + "','" + officeCode + "') not in (select user_code from user)");
			query.executeUpdate();
			getSessionFactory().getCurrentSession().flush();

			query = getSessionFactory().getCurrentSession()
					.createSQLQuery("update user set password = md5('kaigo') where password = ''");
			query.executeUpdate();
			getSessionFactory().getCurrentSession().flush();
		} catch (Exception e) {
			throw new CSVInvalidException("ファイル内の形式に誤りがあります。");
		}

		query = getSessionFactory().getCurrentSession()
				.createSQLQuery("select count(*) from user where user_name = 'admin'");
		if (query.list().size() < 0) {
			query = getSessionFactory().getCurrentSession().createSQLQuery(
					"INSERT INTO `ienursing`.`user` (`id`, `user_code`, `user_name`, `password`, `user_name_kana`, `address`, `email`, `phone_number`, `apple_id`, `device_key`, `office_code`, `role_type`,`help_full_time`,`help_part_time`, `longitude`, `latitude`) VALUES ('1', 'admin', 'Administrator', md5('admin'), '', '', 'example@gmail.com', '', 'example@gmail.com', '0', '0', '2','0','0', '0', '0');");
			query.executeUpdate();
			getSessionFactory().getCurrentSession().flush();
		}

		// 将本次导入的csv中记录的条数写入log
		int nowUserSize = getSessionFactory().getCurrentSession().createSQLQuery("select * from user").list().size();
		int newSize = nowUserSize - preUserSize;
		int updateSize = size - newSize;
		log.info("　　　　担当者のcsvファイルにはレコード数は　" + size + "　件です。" + "新規レコード数" + newSize + "　件です。" + "更新レコード数" + updateSize
				+ "　件です。");
		successMessage += "○合計レコード数　　　　　　　　　 " + size + "　件 <br><br>" + "○新規レコード数　　　　　　　　　 " + newSize + "　件 <br><br>"
				+ "○更新レコード数　　　　　　　　　 " + updateSize + "　件";

		return successMessage;
	}

}
