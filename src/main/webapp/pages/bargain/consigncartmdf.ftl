<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="black" name="apple-mobile-web-app-status-bar-style">
		<meta content="telephone=no" name="format-detection">
		<meta content="email=no" name="format-detection" />
		<title>心动慈露</title>
		<link rel="shortcut icon"  href="${rc.contextPath}/pages/images/favicon.ico">
		<link rel="apple-touch-icon" href="custom_icon.png">
		<#include "../common/addressHeader.ftl">	
	</head>
	<body>
	    <div class="pronotice " ><img src="${rc.contextPath}/pages/images/loading1.gif">正在加载...</div>
	     <input type="hidden" id="contextPath" name="contextPath" value="${rc.contextPath}" />
		<div class="page">
			<div class="tit">
				修改地址
				<!--<a href="${rc.contextPath}/bargain_ad/listorderads/${(ordertype)!"1"}/${(isBonded)!"0"}" class="tit_la"><img src="${rc.contextPath}/pages/images/cancle.png" class="tit_center"></a> --> 
				<#if source?? && source=='orderidcardinvalid'>
				     <a href="${rc.contextPath}/bargain/create_order" class="tit_la"><img src="${rc.contextPath}/pages/images/cancle.png" class="tit_center"></a>
				<#else>
				     <a href="${rc.contextPath}/bargain_ad/listadsmgr" class="tit_la"><img src="${rc.contextPath}/pages/images/cancle.png" class="tit_center"></a>
				</#if>
				
				<a href="javascript:void(0)" class="reg tit_ra"  id="saveaddressright">保存</a>
			</div>
			<#if errorCode?exists>
			      <!--<p class="conerror" style="display:block;">${(errorCode)?default("")}</p> -->
			<#else>
			  <p class="conerror"></p>
			</#if>
			<div class="protips"></div>
			<form id="form1" name="form1" method="post" >
			<ul class="insertadd">
				<li><span>收货人</span><input type="text" name="fullName" value="${(address.fullName)!""}" id="conuser" ></li> <!-- address或address中的 fullName为空时　显示 ""-->
				<li><span>手机号码</span><input type="tel" name="mobileNumber" value="${(address.mobileNumber)!""}"  id="phoneno" ></li>
				<li><span>省份</span> 
				     <select id="province" name="province">
						<option value="0">-- 请选择 --</option>
						<#if provinceList?exists && (provinceList?size>0) >
						  <#list  provinceList as pl >
						      <#if address?exists && address.province?? && (address.province) ==(pl.provinceId) >
						         <option value="${(pl.provinceId)!"0"}" selected="selected">${(pl.name)!""}</option>
						      <#else>
						         <option value="${(pl.provinceId)!"0"}">${(pl.name)!""}</option>
						      </#if>
						  </#list>
						</#if>
					</select>
				</li>
				<li><span>城市</span>
				    <select id="city"  name="city" >
						<option value="0">-- 请选择 --</option>
						<#if cityList?exists && (cityList?size>0) >
						  <#list  cityList as cl >
						     <#if address?exists && address.city??  && (address.city) ==(cl.cityId) >
						          <option value="${(cl.cityId)!"0"}" selected="selected">${(cl.name)!""}</option>
						     <#else>
						          <option value="${(cl.cityId)!"0"}">${(cl.name)!""}</option>
						      </#if>
						  </#list>
						</#if>
					</select>
				</li>
				<li><span>地区</span>
				     <select id="region"   name="district" >
						<option value="0">-- 请选择 --</option>
						<#if districtList?exists && (districtList?size>0) >
						  <#list  districtList as dl >
						      <#if address?exists && address.district?? && (address.district) ==(dl.districtId) >
						         <option value="${(dl.districtId)!"0"}"  selected="selected">${(dl.name)!""}</option>
						      <#else>
						        <option value="${(dl.districtId)!"0"}">${(dl.name)!""}</option>
						      </#if>
						  </#list>
						</#if>
					</select>
				</li>
				<li class="txtarea"><span>详细地址</span><textarea id="detailadd" name="detailAddress">${(address.detailAddress)!""}</textarea></li>
				<#if isBonded?exists && isBonded =='1'>
				 <li class="showstar"><span>身份证号</span><input type="text" name="idCard" value="${(address.idCard)!""}"  id="userid" ></li>
				<#else>
				  <li><span>身份证号</span><input type="text" name="idCard" value="${(address.idCard)!""}"  id="userid" ></li>
				</#if>
			</ul>
			   <#if isBonded?exists && isBonded =='1'>
			     <!-- 判断是否显示海外购提醒 -->
			     <ul class="overseas">
					 <li><img src="${rc.contextPath}/pages/images/huanoverseas.png"></li> 
			     </ul>
			   </#if>
			   <!-- 判断是否显示海外购提醒 End -->
			   <a href="javascript:void(0)" onclick="deleteAddress()"><p class="consigndel">删除地址</p></a>
			
			   <a href="javascript:void(0)" id="saveaddress"><p class="save">保存地址</p></a>
			   <input type="hidden" id="isBonded" name="isBonded" value="${(isBonded)!"0"}" />
	           <input type="hidden" id="ordertype" name="ordertype" value="${(ordertype)!"1"}" />
	           <input type="hidden" name="addressId" value="${(address.addressId)!"-1"}" />
	           <input type="hidden" name="accountId" value="${(Session.yggwebapp_current_user_key.id?c)!"-1"}" />
	           <input type="hidden" name="source"  value="${(source)!""}" />
			</form>
			
			<form id="deleteAddressForm" name="deleteAddressForm" action="" method="post" />
			   <input type="hidden" id="isBonded" name="isBonded" value="${(isBonded)!"0"}" />
	           <input type="hidden" id="ordertype" name="ordertype" value="${(ordertype)!"1"}" /> 
	           <input type="hidden" name="source"  value="${(source)!""}" />
			</form>
		</div>	
		
		<script type="text/javascript">
		 var  flag = false ;   // 防重复提交
			$(function(){
				
			 <#if ordertype?? && isBonded??>
			    userid.focus();
			   
			 </#if>
			  <#if errorCode?exists>
		       var errormsg = "${(errorCode)?default("")}" ;
		       showTipMsg(errormsg);
			</#if>
			
				　$("#saveaddress").click(function(){
				    sendform();
				 });
				 $("#saveaddressright").click(function(){
				    sendform();
				 });
			})
			
			function deleteAddress()
			{
			   document.deleteAddressForm.action="${rc.contextPath}/bargain_ad/deleteads/${(address.addressId)!"0"}/${(address.accountId)!"0"}";
			   document.deleteAddressForm.submit();
			}
			function  sendform(){
			   var  checkflag = checkconsignadd();
			    if(checkflag){
			           if(!flag){
			         		document.form1.action="${rc.contextPath}/bargain_ad/ordermodifyads";
					 		document.form1.submit();
					 
					 		flag = true ;
				     		return true ;
			    		 }else{
			       			alert("正在保存!");
			   			 }
			        
			    }
			    
			}	    
	  </script>	
	  	
	</body>
</html>