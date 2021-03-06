<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的二维码</title>
	<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="black" name="apple-mobile-web-app-status-bar-style">
	<meta content="telephone=no" name="format-detection">
	<meta content="email=no" name="format-detection" />
	<script type="text/javascript" src="${rc.contextPath}/scripts/js/zepto.min.js"></script>
	<script type="text/javascript" src="${rc.contextPath}/scripts/js/h5self-adaption.js"></script>
	<#include "../common/otherShare.ftl">
	<link rel="stylesheet" type="text/css" href="${rc.contextPath}/scripts/css/qrcode.css">
	<link href="../images/favicon.ico" rel="shortcut icon">
  <style>
   .co_top{width:100%;height:auto;position:relative;}
   .co_head{width:40px; height:40px; background:#000000; position:absolute;bottom:-20px;left:50%;margin-left:-20px;}
  </style>
</head>
<body>
   <div class="main" style="padding:10px;">
	   <div class="co_top"><img src="${rc.contextPath}/scripts/images/co_top.jpg" style="width:100%;">
       <div class="co_head">
          <img src="${image}" width="40" height="40">
       </div>
       </div>
       <img src="${rc.contextPath}/scripts/images/co_bottom.jpg" style="width:100%;">
	 </div>
</body>
</html>
