package com.ygg.webapp.entity;

public class LotteryActivityEntity
{
    
    private static final long serialVersionUID = 1L;
    
    private int id;
    
    private String name = "";
    
    private String startTime = "";
    
    private String endTime = "";
    
    private String remark = "";
    
    private int limitNum;
    
    private int shareNum;
    
    private String createTime = "";
    
    private String updateTime = "";
    
    private int limitShareNum;
    
    private int limitType;
    
    public int getLimitType()
    {
        return limitType;
    }
    
    public void setLimitType(int limitType)
    {
        this.limitType = limitType;
    }
    
    public int getLimitShareNum()
    {
        return limitShareNum;
    }
    
    public void setLimitShareNum(int limitShareNum)
    {
        this.limitShareNum = limitShareNum;
    }
    
    public int getId()
    {
        return id;
    }
    
    public void setId(int id)
    {
        this.id = id;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(String startTime)
    {
        this.startTime = startTime;
    }
    
    public String getEndTime()
    {
        return endTime;
    }
    
    public void setEndTime(String endTime)
    {
        this.endTime = endTime;
    }
    
    public String getRemark()
    {
        return remark;
    }
    
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    
    public int getLimitNum()
    {
        return limitNum;
    }
    
    public void setLimitNum(int limitNum)
    {
        this.limitNum = limitNum;
    }
    
    public int getShareNum()
    {
        return shareNum;
    }
    
    public void setShareNum(int shareNum)
    {
        this.shareNum = shareNum;
    }
    
    public String getCreateTime()
    {
        return createTime;
    }
    
    public void setCreateTime(String createTime)
    {
        this.createTime = createTime;
    }
    
    public String getUpdateTime()
    {
        return updateTime;
    }
    
    public void setUpdateTime(String updateTime)
    {
        this.updateTime = updateTime;
    }
    
}
