package com.ygg.webapp.controller.bargain;

import com.ygg.webapp.service.bargain.HcbParticipantService;
import com.ygg.webapp.util.CommonConstant;
import com.ygg.webapp.util.SessionUtil;
import com.ygg.webapp.util.WeixinMessageDigestUtil;
import com.ygg.webapp.util.YggWebProperties;
import com.ygg.webapp.util.CommonHttpClient;
import com.ygg.webapp.view.AccountView;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.tools.ant.taskdefs.Nice;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ygg.webapp.service.bargain.HcbBargainService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ygg.webapp.entity.bargain.HcbBargain;
import com.ygg.webapp.entity.bargain.HcbParticipant;
import com.ygg.webapp.entity.AccountEntity;
import com.ygg.webapp.entity.QqbsAccountEntity;
import com.ygg.webapp.service.AccountService;
import com.ygg.webapp.service.account.HqbsAccountService;

@Controller
@RequestMapping("bargain/participant")
public class HcbParticipantController {

	@Resource
	HcbBargainService bargainService;
	
	@Resource
	HcbParticipantService participantService;
	
	@Resource
	AccountService	accountService;
	
	@Resource
	HqbsAccountService hqbsAccountService;
	
	@RequestMapping("bargain")
	@ResponseBody
	public String bargain(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(required = true) String bargainerUuid)
	throws Exception {
		
		JSONObject	json = new JSONObject();
		
		AccountView av = SessionUtil.getCurrentUser(request.getSession());
		
		Double currentPrice = null;
		Double cutPrice = null;
		
		HcbBargain	bargain = null;
		//Double avg = null;//21次，31次，41次（当前价格/10）的平均数
		//int times = 0;//帮砍人数(次数)
		
		if (bargainerUuid != null) {
			
			bargain = bargainService.selectByBargainerUuid(bargainerUuid);
		}
		
		currentPrice	= Double.valueOf(bargain.getCurrentPrice());
		
		if (currentPrice <= 8.45) {
			
			json.put("code", "1");
			json.put("dsp", "该好友已达最低价格");
			
			return json.toJSONString();
		}
		
		//判断用户是否已帮砍过，用户只能砍一次
		List<HcbParticipant> participantsAll = participantService.HcbParticipantlistOfActivity();
		
		for (HcbParticipant participant : participantsAll) {
			
			if (participant.getUserUuid().equals(String.valueOf(av.getId()))) {
				
				json.put("code", "2");
				json.put("dsp", "您不能砍价了哟");
				
				return json.toJSONString();
			}
		}
		int result = 0;
		
		synchronized (this) {
			List<HcbParticipant> participants = participantService.listSelectByBargainerUuid(bargainerUuid);
			if ((participants.size()%7)>=7) {
				
				json.put("code", "3");
				json.put("dsp", "您的好友已完成七次砍价，谢谢您的好意啦");
				
				return json.toJSONString();
			}
			
			//此次砍掉的折扣
			Double cutDiscount = null;
			//当前打几折
			Double sum = (currentPrice/169.00)*10;
			
			
			Double price = Double.valueOf(bargain.getCurrentPrice())-1;
			Double d = 0d;
			int size = 7-participants.size()%7;
			if(size==1 && Double.valueOf(bargain.getCurrentPrice())>8.45){
				d = Double.valueOf(bargain.getCurrentPrice())-8.45;
			}else if(size>=4){
				d = Math.floor(Math.random()*price/7)+20;
			}else{
				d = Math.floor(Math.random()*price/size)+5;
			}
			cutDiscount = d/16.9;
			/*int pre = (int) (Math.random()*100);
			if(pre<=10){
				cutDiscount = Double.valueOf(new DecimalFormat("#.00").format((Math.random()*0.151+1.206)));
			}else if(pre>10 && pre<=20){
				cutDiscount = Double.valueOf(new DecimalFormat("#.00").format((Math.random()*0.031+1.326)));
			}else if(pre>20 && pre<=40){
				cutDiscount = Double.valueOf(new DecimalFormat("#.00").format((Math.random()*0.021+1.336)));
			}else{
				cutDiscount = Double.valueOf(new DecimalFormat("#.00").format((Math.random()*0.011+1.346)));
			}
			if(participants.size()==6 && Double.valueOf(bargain.getCurrentPrice())>17){
				cutDiscount = (Double.valueOf(bargain.getCurrentPrice())-8.45)/169;
			}*/
			sum = sum - cutDiscount;
			if((participants.size()%7)==6 && sum>3.00){
				sum = 3.00;
			}
			currentPrice = (sum/10)*169;
			cutPrice = Double.valueOf(bargain.getCurrentPrice())-currentPrice;
			bargain.setIsBargain(1);
			json.put("cutDiscount", cutDiscount);//此次砍了几折
			json.put("sum", sum);//当前打几折
			
			
			/*
			for (HcbParticipant participant : participants) {
				
				if (participant.getUserUuid().equals(String.valueOf(av.getId()))) {
					
					json.put("code", "2");
					json.put("dsp", "您已经帮好友砍过价了");
					
					return json.toJSONString();
				}
			}*/
			
			/*times = participants.size();
			int percentage = 0;
			Double arr[] = {2.23,2.12,1.15,1.02,0.67,0.27,1.07,0.88,1.34,1.05,0.55,0.91,1.52,0.28,0.84,0.39,1.66,0.59,1.08,0.38};
			if(times<=19){
				cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(arr[times]+0.56+Double.valueOf(new DecimalFormat("#0.00").format(Math.random()))*0.01*((-1)^(times))));
				currentPrice -= cutPrice;
				if (currentPrice < 1) {
					cutPrice	= (double) (Float.valueOf(bargain.getCurrentPrice()) - 1.0);
					currentPrice = (double) 1.0;
					bargain.setIsBargain(1);
				}
			}else if(times>=20 && times<30){
				percentage = (int) (Math.random()*100);
				avg = (currentPrice-1)/(30-times);
				if(percentage<=15){
					cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(avg*5/4+Double.valueOf(new DecimalFormat("#0.00").format(Math.random()))*0.01*((-1)^(times))));
				}else{
					cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(Math.random()*avg));
				}
				if(cutPrice<=0){
					cutPrice = 0.06;
				}
				currentPrice -= cutPrice;
				if (currentPrice < 1) {
					cutPrice	= (double) (Float.valueOf(bargain.getCurrentPrice()) - 1.0);
					currentPrice = (double) 1.0;
					bargain.setIsBargain(1);
				}
			}else if(times>=30 && times<40){
				percentage = (int) (Math.random()*100);
				avg = (currentPrice-1)/(40-times);
				if(percentage>15 && percentage<=85){
					cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(avg*5+Double.valueOf(new DecimalFormat("#0.00").format(Math.random()))*0.01*((-1)^(times))));
				}else{
					cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(Math.random()*avg));
				}
				if(cutPrice<=0){
					cutPrice = 0.06;
				}
				currentPrice -= cutPrice;
				if (currentPrice < 1) {
					cutPrice	= (double) (Float.valueOf(bargain.getCurrentPrice()) - 1.0);
					currentPrice = (double) 1.0;
					bargain.setIsBargain(1);
				}
			}else if(times>=40 && times<50){
				percentage = (int) (Math.random()*100);
				avg = (currentPrice-1)/(50-times);
				if(percentage>85){
					cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(avg*5/4+Double.valueOf(new DecimalFormat("#0.00").format(Math.random()))*0.01*((-1)^(times))));
				}else{
					cutPrice = Double.valueOf(new DecimalFormat("#0.00").format(Math.random()*avg));
				}
				if(cutPrice<=0){
					cutPrice = 0.06;
				}
				currentPrice -= cutPrice;
				if (currentPrice < 1) {
					cutPrice	= (double) (Float.valueOf(bargain.getCurrentPrice()) - 1.0);
					currentPrice = (double) 1.0;
					bargain.setIsBargain(1);
				}
			}
			json.put("cutPrice", cutPrice);*/
		
		
			
			bargain.setCurrentPrice(String.valueOf(currentPrice));
			bargainService.updateByPrimaryKeySelective(bargain);
			
			HcbParticipant	participant		= new HcbParticipant();
			
			participant.setCreateDatetime(new Date());
			participant.setUserUuid(String.valueOf(av.getId()));
			participant.setGoodsPrice(String.format("%.2f", cutPrice));
			participant.setBargainerUuid(bargainerUuid);
			participant.setAvatar(av.getImage());
			participant.setFullName(av.getNickname());
			
			result = participantService.insertSelective(participant);
		}
		
		if (result == 1) {
			
			String baseDefaultUrl = YggWebProperties.getInstance().getProperties("base_default_url");
			
			String appid = CommonConstant.APPID;
		    String secret = CommonConstant.APPSECRET;
			
			String token = WeixinMessageDigestUtil.getAccessToken(appid, secret);
			
			QqbsAccountEntity accountEntity = hqbsAccountService.getAccountByAccountId(Integer.valueOf(bargain.getBargainerUuid()));
			
			//取消反砍一刀
			/*JSONArray	articleList = new JSONArray();
			
			JSONObject 	article1	= new JSONObject();

			article1.put("title", "立即帮" + av.getNickname() + "砍价");
			article1.put("url", baseDefaultUrl + "bargain/activity_b?accountId=" + String.valueOf(av.getId()));
			article1.put("picurl", baseDefaultUrl + "resources/bargain/images/poster1.png");

			articleList.add(article1);
			
			JSONObject 	article2	= new JSONObject();

			article2.put("title", "别这样，你太狠了！");
			article2.put("url", baseDefaultUrl + "bargain/activity_b?accountId=" + String.valueOf(av.getId()));
			article2.put("picurl", av.getImage());

			articleList.add(article2);
			
			JSONObject 	article3	= new JSONObject();

			article3.put("title", "疯抢中! 爽肤水2折限时抢购！");
			article3.put("url", baseDefaultUrl + "product/single/18");
			article3.put("picurl", baseDefaultUrl + "resources/bargain/images/goods7.jpg");

			articleList.add(article3);
			
			JSONObject 	article4	= new JSONObject();

			article4.put("title", "囤货季！面膜23.8元限时抢购！");
			article4.put("url", baseDefaultUrl + "product/single/17");
			article4.put("picurl", baseDefaultUrl + "resources/bargain/images/goods2.jpg");

			articleList.add(article4);
			
			JSONObject 	article5	= new JSONObject();

			article5.put("title", "下次活动预告：关节护理膜砍价");
			article5.put("url", baseDefaultUrl + "bargain/next_activity_17");
			article5.put("picurl", baseDefaultUrl + "resources/bargain/images/hulimo.jpg");

			articleList.add(article5);
			
			CommonHttpClient.articleMessageCustomSend(token, accountEntity.getOpenId(), articleList);*/
			
			json.put("code", "0");
			json.put("price", String.format("%.2f", cutPrice));
		} else {
			
			json.put("code", "1");
			json.put("dsp", "fuck");
		}
		
		return json.toJSONString();
	}
}
