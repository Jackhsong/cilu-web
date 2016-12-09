package com.ygg.webapp.service.bargain.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ygg.webapp.dao.bargain.ActivityBargainDao;
import com.ygg.webapp.entity.ActivityBargainEntity;
import com.ygg.webapp.exception.DaoException;
import com.ygg.webapp.exception.ServiceException;
import com.ygg.webapp.service.bargain.ActivityBargainService;

@Service("ActivityBargainService")
public class ActivityBargainServiceImpl implements ActivityBargainService {

	@Resource
	ActivityBargainDao activityBargainDao;
	
	@Override
	public ActivityBargainEntity findActivityBargainInfoById(int id) throws ServiceException {
		return activityBargainDao.findActivityBargainInfoById(id);
	}

	@Override
	public Map<String, Object> updateLeftCount(int leftCount, int id) throws ServiceException {
		Map<String,Object> result = new HashMap<>();
        result.put("status", activityBargainDao.updateLeftCount(leftCount, id));
        return result;
	}

}
