package com.ygg.webapp.dao.bargain;

import com.ygg.webapp.entity.ActivityBargainEntity;
import com.ygg.webapp.exception.DaoException;

public interface ActivityBargainDao {
	ActivityBargainEntity findActivityBargainInfoById(int id)
	        throws DaoException;
	
	int updateLeftCount(int leftCount,int id) throws DaoException;
}
