package com.ygg.webapp.service.bargain;

import java.util.Map;

import com.ygg.webapp.entity.ActivityBargainEntity;
import com.ygg.webapp.exception.DaoException;
import com.ygg.webapp.exception.ServiceException;

public interface ActivityBargainService {
	ActivityBargainEntity findActivityBargainInfoById(int id)
	        throws ServiceException;
	
	Map<String, Object> updateLeftCount(int leftCount,int id)
	        throws ServiceException;
}
