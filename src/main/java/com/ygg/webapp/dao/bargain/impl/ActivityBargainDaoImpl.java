package com.ygg.webapp.dao.bargain.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ygg.webapp.dao.bargain.ActivityBargainDao;
import com.ygg.webapp.dao.impl.mybatis.base.BaseDaoImpl;
import com.ygg.webapp.entity.ActivityBargainEntity;
import com.ygg.webapp.exception.DaoException;

@Repository("ActivityBargainDao")
public class ActivityBargainDaoImpl extends BaseDaoImpl implements ActivityBargainDao{

	@Override
	public ActivityBargainEntity findActivityBargainInfoById(int id) throws DaoException {
		ActivityBargainEntity activityBargainEntity = this.getSqlSession().selectOne("ActivityBargainMapper.findActivitiesInfoById", id);
        return activityBargainEntity;
	}

	@Override
	public int updateLeftCount(int leftCount, int id) throws DaoException {
		Map<String, Object> para = new HashMap<>();
        para.put("leftCount", leftCount);
        para.put("id", id);
        return getSqlSession().update("ActivityBargainMapper.updateLeftCount", para);
	}

}
