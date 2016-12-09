<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>${title?default("")}</title>
<link href="${rc.contextPath}/resources/bargain/styles.css?1&Math.random()" rel="stylesheet" type="text/css" />
<script src="${rc.contextPath}/resources/bargain/js/jquery-1.11.0.min.js"></script>
<script src="${rc.contextPath}/resources/bargain/js/jquery.lazyload.js"></script>
<script>
 function mycut(){
	 
	 var concerns=true;
	 
	 if (${notSubscribe} == "1") {
	 	concerns=false
	 }
	 
	 if(concerns==false){
	 
	 	window.location.href ="qrcode?qrCodeImg=${qrCodeImg}"
	 	
	 } else {
	 
	 	 $.ajax({
                    type: "POST",
                    url: "${rc.contextPath}/bargain/participant/bargain?bargainerUuid=${accountId}",
                    data: {acountId:"${accountId}"},
                    success: function(response) {
                    	
                    	var data = JSON.parse(response);
             			console.log(data);
                     	//$("#cutPrice").text(data.cutPrice);
                     	$("#cutPrice").text(data.cutDiscount*16.9);
                     	if(data.code == "0"){
                     	
                     	// right  return
                   			document.getElementById('myhit').style.display='block'; document.getElementById('fade').style.display='block';
                   			$('#asyncPrice').html(data.price);
                     	// location.href = location.href+"&d="+Math.random();
                     	} else if (data.code == "1") {
                     	
                     		alert("该好友已达最低价格")
                     	} else if (data.code == "2") {
                     		//alert("您不能砍价了哟")
                     		$("#cut2").show();
                     		$("#fade").show();
                     	} else if (data.code == "3") {
                     		//alert("您的好友已完成七次砍价，谢谢您的好意啦")
                     		$("#cut3").show();
                     		$("#fade").show();
                     	} else {
                     	
                     	}
                    },
                    error: function (){
                    	alert("net error");
                    }
                });
	 }
	};

</script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    var appId = "${jsSdk.appId?default("")}";
    var timestamp = "${jsSdk.timestamp?default("")}";
    var noncestr = "${jsSdk.noncestr?default("")}";
    var signature = "${jsSdk.signature?default("")}";
    var participantsCurrent = "${participantsCurrent}";
    var currentOver = "${currentOver}";
    var percent = "${percent}";
    if(participantsCurrent == 0){
    	var shareTitle="朋友我看你骨骼清奇，是个人才！来，先帮我砍个价练练手！";
    }else if(participantsCurrent == 1){
    	var shareTitle="已经有1位好友帮我砍价，下一个会是你吗？";
    }else if(participantsCurrent == 2){
    	var shareTitle="已经有2位好友帮我砍价，来试试你的运气如何！";
    }else if(participantsCurrent == 3){
    	var shareTitle="已经有3位好友帮我砍价，迫切需要你的帮助！";
    }else if(participantsCurrent == 4){
    	var shareTitle="已经有4位好友帮我砍价，没有你就是不行！";
    }else if(participantsCurrent == 5){
    	var shareTitle="已经有5位好友帮我砍价，你的帮助至关重要！";
    }else if(participantsCurrent == 6){
    	var shareTitle="七缺一！在线等！快来帮我砍价！";
    }else if(currentOver == "1"){
    	var shareTitle="无敌是多么，多么寂寞！我已击败全国“"+percent+"%”的人，等你来挑战，一起砍价一起嗨！";
    }
    // var sharePath = "http://dew.waibao58.com/ygg-hqbs/bargain/activity_b_17?accountId=${accountId}";
    var sharePath = "http://weixin.cilu.com.cn/ygg-hqbs/bargain/activity_b_17?accountId=${accountId}";
    var shareImage = "http://www.cilu.com.cn/emp/u42.jpg";
    var shareContent="慈露本草关节护理膜，本草成分提炼而成，能迅速渗透皮肤，促进循环畅通，舒缓放松关节部位！";
wx.config({
    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId: appId, // 必填，公众号的唯一标识
    timestamp: timestamp, // 必填，生成签名的时间戳
    nonceStr: noncestr, // 必填，生成签名的随机串
    signature: signature,// 必填，签名，见附录1
    jsApiList: ['onMenuShareAppMessage','onMenuShareTimeline','onMenuShareQQ','onMenuShareWeibo','onMenuShareQZone','hideMenuItems','showMenuItems']
});	
wx.ready(function(){ 
		wx.hideMenuItems({
    		menuList: ['menuItem:copyUrl','menuItem:share:qq','menuItem:share:email'
        ,'menuItem:openWithSafari','menuItem:favorite','menuItem:readMode'
        ,'menuItem:share:QZone'
        ,'menuItem:share:qq'
        ,'menuItem:share:weiboApp'
        ] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
		});
		wx.onMenuShareAppMessage({
    	   title: shareTitle, // 分享标题
           desc: shareContent, // 分享描述
           link: sharePath, // 分享链接
           imgUrl: shareImage, // 分享图标
           success: function () { 
                 // 用户确认分享后执行的回调函数
            },
           cancel: function () { 
               // 用户取消分享后执行的回调函数
            },
           fail: function (res) { 
           }
		});
      	wx.onMenuShareTimeline({
             title: shareTitle, // 分享标题
             link: sharePath, // 分享链接
             imgUrl: shareImage, // 分享图标
             success: function () { 
                   // 用户确认分享后执行的回调函数
               },
             cancel: function () { 
                  // 用户取消分享后执行的回调函数
             },
            fail: function (res) {  
            }
		});
	});
	
	wx.error(function(res){
	});
</script>
<link rel="stylesheet" href="${rc.contextPath}/resources/bargain/css/swiper.min.css">
</head>
<body style="background:#f6ebd9;">
<div class="box_a">
<img src="${rc.contextPath}/resources/bargain/images/goods6c_02.png" width="100%">
<div class="guize" onClick="document.getElementById('rules').style.display='block'; document.getElementById('fade').style.display='block';"><p>查看详情</p></div>

<!--弹幕 start-->
<!--条件1:大于8元弹幕 start-->
<div class="danmu" id="condition1">
<p><span>太会砍了，师父！请收我为徒！</span></p>
<p><span>您今天人品爆发！砍价什么的简直太小意思了！继续邀请好友帮你砍价吧！</span></p>
<p><span>主银，我等着急了，邀请更多好友砍价就能把我带走啦！</span></p>
<p><span>还差一点点，赶快邀请更多好友帮你砍价！</span></p>
<p><span>砍了很多了，快去炫耀一下你的战绩！</span></p>
<p><span>关节的贴心护理专家~</span></p>
<p><span>促进循环畅通，舒缓放松关节部位！</span></p>
<p><span>植物活性成分提炼而成，渗透快，效果好！</span></p>
<p><span>大师专业配方，20年钻研成果！</span></p>
<p><span>用最贴心的礼物送最爱的人是世界上最棒的事！</span></p>
<p><span>所有不以下单为目的砍价都是耍流氓！更何况这个价已经值哭了好嘛！</span></p>
<p><span>机会万年难得！犹豫1秒就错过啦，立即下单！</span></p>
<p><span>历史最低折扣价，此时不下单更待何时？！</span></p>
<p><span>爸妈老早就看上了，这次下单这么划算，正好哄他们开心！</span></p>
<p><span>送礼首选！好而不贵！下单下单！</span></p>
</div>
<!--条件1弹幕 end-->

<!--弹幕 end-->
<div class="guize" style="opacity: 0; filter:Alpha(opacity=0);"  onClick="document.getElementById('rules').style.display='block'; document.getElementById('fade').style.display='block';"><p>查看详情</p></div>

</div>


<div class="box2">

<!--发起者头像 start-->
<#if accountViewImage ? exists>
	<div class="countimg"><img src="${accountViewImage}" width="60px" height="60px"></div>
<#else>
	<div class="countimg"><img src="${rc.contextPath}/resources/bargain/images/1_ico.png" width="60px" height="60px"></div>
</#if>
<!--发起者头像　end-->

<!--价格 start-->
<div class="jia_lf">产品原价:<span>169.00</span>
</div>
<div class="jia_lf">
<span style="font-size:1.1em;">当前价格:</span>
<span id="nowprice">${bargain.currentPrice}</span>
</div>
<!--价格 end-->

<div class="myclear"></div>

<!--按钮 start-->
<div class="mybuttom">
	<#if isSoldOut == "1">
		<div class="find_bt" > 商品售罄</div>
	<#elseif currentOver ? exists &&  currentOver == "1">	
		<div class="find_bt" > 砍价结束</div>
	<#else>
		<div class="find_bt" id="cut_button" onClick="mycut()" > 帮他砍价</div>
	</#if>

	<a href="activity_a_17"><div class="find_bt"> 我要参加</div></a>
</div>
<!--按钮 end-->

<!--库存显示 start-->
<div class="jia_lf">已抢成功:<span id="soldedSpan" >${soldNumber}</span>
</div>
<div class="jia_lf">
剩余库存:<span id="surplus">${leftNumber}</span>
</div>
<!--库存显示 end-->
<div class="myclear"></div>

<!--七刀砍价进度 start-->
<div class="knife" style="width:86%; margin-left:7%; position:relative;">
<ul>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
<li><img src="${rc.contextPath}/resources/bargain/images/knife_a.png" width="100%" /></li>
</ul>
<div></div>

</div>
<!--七刀砍价进度 end-->


<div class="myclear"></div>

<#if participantList ? exists>
<!--好友助力列表 start-->
<div class="helplist">
<div class="titleA_bt">好友砍价列表</div>

<div class="swiper-container" style="margin-top:10px; height:60px;">

<ul class="swiper-wrapper" >

<#list participantList as participant>

<li class="swiper-slide">
<div class="helperimg">
	<#if participant.avatar ? exists>
		<img src="${participant.avatar}" width="40px" height="40px">
	<#else>
		<img src="${rc.contextPath}/resources/bargain/images/1_ico.png" width="40px" height="40px">
	</#if>
</div>
<div class="namenum">
<div class="helpername">
		<#if participant.fullName ? exists>
			${participant.fullName}
		<#else>
			${participant.userUuid}
		</#if>
</div>
<div class="helpernum">砍掉<span>${(participant.goodsPrice?number)?string('0.00')}</span>元</div>
</div>
</li>

</#list>

</ul>
<div class="swiper-button-prev" style="background:url(${rc.contextPath}/resources/bargain/images/left_03.png) no-repeat; background-size:9px 12px;top:60%;width:9px; height:12px; left:5px;"></div>
<div class="swiper-button-next" style="background:url(${rc.contextPath}/resources/bargain/images/right_05.png) no-repeat; background-size:9px 12px; top:60%; width:9px; height:12px;"></div>
</div> </div> 
 <!--好友助力列表 end-->
 
 </#if>
</div>
 <!--商品详情 start-->
 <div class="myclear"></div>
<div class="product_details">
产品详情</div>
<div class="mydetails" id="mydetails">
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_a.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_b.jpg"  width="100%"/>
	   <a href="http://weixin.cilu.com.cn/ygg-hqbs//product/single/19"><img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_c.jpg"  width="100%"/></a>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_01.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_02.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_03.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_04.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_05.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_06.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_07.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_08.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_09.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_10.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_11.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_12.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_13.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_14.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_15.jpg"  width="100%"/>
	   <img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_16.jpg"  width="100%"/>
<a href="next_activity_17"><img  class="lazy" data-original="${rc.contextPath}/resources/bargain/images/next3_d.jpg"  width="100%"/></a>
</div>
<br/><br/>
<!--商品详情 end-->
 <!--背景变暗 start-->
  <div id="fade" class="black_overlay" onClick="document.getElementById('cut2').style.display='none';document.getElementById('cut3').style.display='none';document.getElementById('myhit').style.display='none';document.getElementById('rules').style.display='none';  document.getElementById('fade').style.display='none';"></div> 

 <!--背景变暗 end--> 

 

 <!--活动规则弹窗 start-->
  <div id="fade" class="black_overlay" ></div> 
 <div class="rules" id="rules"> 
 <div class="rules_top">活动规则</div>
 <br/>
<p>1、活动时间：8月16日开始，砍完即止！</p>
<p>2、每位参与砍价的用户只可帮助1位好友砍价。</p>
<p>3、用户通过微信平台进入活动页面参与活动，每位用户完成购买后可重新发起砍价，购买不限次数。</p>
<p>4、活动发起人需要邀请7位好友为他砍价，原价169元，优惠折数越砍越低，最终可以砍到0.5折—6折购买（限量1000瓶，先砍先得，砍完为止），也可以按当时实际砍到的金额购买，每位用户既可帮好友砍价也可同时自己参与砍价活动。</p>
<p>5、活动结束后按付款时间的先后顺序发货。</p>
   <br/>
   <hr size="1" noshade="noshade" style="border:1px #cccccc dashed;"/>
 <div class="rules_bottom" onClick="document.getElementById('rules').style.display='none'; document.getElementById('fade').style.display='none';">知道了</div>
 </div>
 <!--活动规则弹窗 end--> 
 
   <div id="fade" class="black_overlay"></div> 

  <!--砍价弹窗 start-->
 <div class="myhit" id="myhit"> 
 <p> 太给力啦！</p>
 <p> 您帮好友成功砍掉<span id="cutPrice"></span>元！</p>
 <div class="rules_bottom1" onClick="document.getElementById('myhit').style.display='none'; document.getElementById('fade').style.display='none';location.reload();">知道了</div>
 </div>
 <!--砍价弹窗 end--> 
  <!--不能再砍1 start-->
 <div class="myhit" id="cut2"> 
 	<p>真可惜，您的砍价机会已经用掉了哦，不能再砍啦！点击我要参加，赶紧邀请好友为您砍价吧！</p>
 <div class="rules_bottom1" onClick="document.getElementById('cut2').style.display='none'; document.getElementById('fade').style.display='none';location.reload();">知道了</div>
 <div class="close" onClick="document.getElementById('cut2').style.display='none'; document.getElementById('fade').style.display='none';">×</div>
 </div>
 <!--不能再砍1 end--> 
  <!--不能再砍2 start-->
 <div class="myhit" id="cut3"> 
 	 <p>您朋友的帮砍人数已达上限，您暂时不能帮他再砍价了哦！</p>
 <div class="rules_bottom1" onClick="document.getElementById('cut3').style.display='none'; document.getElementById('fade').style.display='none';location.reload();">知道了</div>
 <div class="close" onClick="document.getElementById('cut3').style.display='none'; document.getElementById('fade').style.display='none';">×</div>
 </div>
 <!--不能再砍2 end--> 
 
   <!--侧边按钮 start--> 
<div id="to_top">
<a href="http://weixin.cilu.com.cn/ygg-hqbs//product/single/19"><img  src="${rc.contextPath}/resources/bargain/images/cico_01.png"/></a>
<a href="next_activity_17"><img  src="${rc.contextPath}/resources/bargain/images/cico_02.png"/></a>
<img onclick="document.documentElement.scrollTop = document.body.scrollTop =0;" src="${rc.contextPath}/resources/bargain/images/cico_03.png"/>
</div>
<!--侧边按钮 end-->
 
<br/><br/><br/>

<!--底部导航 Start-->
<span  id="showCartCount4" name="showCartCount4"></span>
 <div id="footBar">
		<a href="http://weixin.cilu.com.cn/ygg-hqbs/hqbsHomeInfo/getHomeInfo#wechat_redirect">
			<div class="house"></div>
			<div class="text01">商城首页</div>
		</a>

		<a href="http://weixin.cilu.com.cn/ygg-hqbs/spcart/listsc#wechat_redirect">
			<div class="car">
				<span  id="showCartCount4" name="showCartCount4" class="carNum"></span>
			     <!-- <div class="carNum">0</div> -->
			</div>
			<div class="text01">购物车</div>
		</a><a href="http://weixin.cilu.com.cn/ygg-hqbs/order/list/0#wechat_redirect">
			<div class="person"></div>
			<div class="text01">我的订单</div>
		</a><a href="http://weixin.cilu.com.cn/ygg-hqbs/spokesPerson/getList#wechat_redirect">
			<div class="star"></div>
			<div class="text01">我是行动派</div>
		</a>
		
</div> 
<!--底部导航 End-->
<script src="${rc.contextPath}/resources/bargain/js/myjs.js"></script>
<script src="${rc.contextPath}/resources/bargain/js/swiper.min.js"></script>
<script type="text/javascript">
  var mySwiper = new Swiper('.swiper-container',{
    loop: false,
	slidesPerView : 3,
	autoplay: 3000,
	nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
  });
  
	$(document).ready(function() { 
		var mysur=$("#surplus").html();
		var myprice=$("#nowprice").html();
		mydanmu(1);
		var mynum="${participantsCurrent}";
		for(var k=0;k<mynum;k++){
			$(".knife").find("li").eq(k).children("img").attr('src','${rc.contextPath}/resources/bargain/images/knife_b.png');;	
		}
	}); 
	
	function mydanmu(n){
		var l;
        l=$("#"+"condition"+n).children("p").length;
	

		for(var j=1;j<=88;j++){
			for(i=0;i<l;i++){
				mytop=getRandom()*10;
				$("#"+"condition"+n).find("p").eq(i).css("top",mytop+"%");
				(function(i,j){
      				setTimeout(function(){
          				List(i,j);
      				},i*5000+(j-1)*l*5000);
  				})(i,j);
			}
        }
		function List(i,j){
 			$("#"+"condition"+n).find('p').eq(i).css("left","100%");
 			$("#"+"condition"+n).find('p').eq(i).animate({left:'-150%'},{duration:25000});
		}
	}
	
	 function getRandom(){
        return Math.floor(Math.random()*8+1);
     };
	
</script>
</body>
</html>
