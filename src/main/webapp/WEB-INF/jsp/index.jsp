<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.xqls.common.entity.UserInfo" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String tomcatPath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
UserInfo userInfo = (UserInfo)request.getSession().getAttribute("currentUser");
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="<%=basePath %>resources/images/favicon.png">

    <title>小桥流水java项目基础框架</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=basePath %>/resources/cleanzone/js/bootstrap/dist/css/bootstrap.css" rel="stylesheet" />
	<link rel="stylesheet" href="<%=basePath %>/resources/cleanzone/fonts/font-awesome-4/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/common.css">
   <link rel="stylesheet" type="text/css" href="<%=basePath %>/resources/cleanzone/js/jquery.gritter/css/jquery.gritter.css" />

  <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/jquery.nanoscroller/nanoscroller.css" />
  <link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/jquery.easypiechart/jquery.easy-pie-chart.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/bootstrap.switch/bootstrap-switch.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/jquery.select2/select2.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/bootstrap.slider/css/slider.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>resources/cleanzone/js/intro.js/introjs.css" />
	
  <!-- Custom styles for this template -->
  <link href="<%=basePath %>resources/cleanzone/css/style.css" rel="stylesheet" />
  
<style type="text/css">
	html, body { height:100%; overflow:hidden; }
	body { margin:0; }
	 .row-fluid thead{
	    background-color:#f5f5f5;
	 }
	 table td{border:none;}
</style>
</head>
<body>

  <!-- Fixed navbar -->
  <div id="head-nav" class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
      <div class="navbar-header" style="width: 30%;">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="fa fa-gear"></span>
        </button>
        <a class="navbar-brand" href="#" style="width:100%;">
        	<span>小桥流水java项目基础框架</span>
        </a>
      </div>
      <div class="navbar-collapse collapse">
      
    <ul class="nav navbar-nav navbar-right user-nav">
      <li class="dropdown profile_menu">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
         	<c:choose>
         	   <c:when test="${userInfo.avatar==null }">
         			<img style="width:48px;height:36px;" alt="" src="<%=basePath %>resources/cleanzone/images/av.jpg" /><span>${userInfo.userName }</span> <b class="caret"></b>
         	   </c:when>
         	   <c:otherwise>
         			<img style="width:48px;height:36px;" alt="" src="<%=tomcatPath %>imgUpload/${userInfo.avatar}" /><span>${userInfo.userName }</span> <b class="caret"></b>
         	   </c:otherwise>
         	</c:choose>
        </a>
        <ul class="dropdown-menu">
          <li><a onclick="showPasswordChange()">密码修改</a></li>
         <!--  <li><a onclick="uploadAv()">头像修改</a></li> -->
          <li><a href="<%=basePath%>userInfo/logout.do">退出</a></li>
        </ul>
      </li>
    </ul>			

      </div><!--/.nav-collapse animate-collapse -->
    </div>
  </div>

	<div id="cl-wrapper" class="">
		<div class="cl-sidebar" data-position="right" data-step="1" data-intro="<strong>Fixed Sidebar</strong> <br/> It adjust to your needs." >
			<div class="cl-toggle"><i class="fa fa-bars"></i></div>
			<div class="cl-navblock">
        <div class="menu-space">
          <div class="content">
            <ul class="cl-vnavigation">
                  <c:set value="" var ="firstMenu"></c:set>
            	<c:forEach var="UserMenu" items="${menuinfList}" varStatus="status">
				 	<li id="parent${UserMenu.id }">
				   		<a href="#" class="${UserMenu.image }">
							<span>&nbsp;&nbsp;&nbsp;${UserMenu.menuName}</span>
						</a>
						<ul class="sub-menu">
					   	 <c:forEach var="childmenuinfo" items="${UserMenu.childList}" varStatus="statuschild">
						   	     <c:if test="${status.index==0 && statuschild.index==0}">
						           <c:set value="${childmenuinfo.url}" var ="firstMenu"></c:set>
						         </c:if>
					       	 <li><a href="javascript:$.MainPageJs.ajaxSysnMainMenu('<%=basePath %>${childmenuinfo.url}')">${childmenuinfo.menuName }</a></li>
						 </c:forEach>
						</ul>
					</li>
	          	</c:forEach>
            </ul>
          </div>
        </div>
        <div class="text-right collapse-button" style="padding:7px 9px;">
          <button id="sidebar-collapse" class="btn btn-default" style=""><i style="color:#fff;" class="fa fa-angle-left"></i></button>
        </div>
			</div>
		</div>
	
		<div class="container-fluid" id="pcont" style="height:100%;">
		  
			

			<!-- <div class="row"> -->
				<iframe scrolling="yes" id="mainiframe" width="100%" style="background-color: white;border: none;height:100%;" src="<%=basePath %>${firstMenu}">
				</iframe>
		  <!--  </div>  -->
		
		</div>
<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog"
   aria-labelledby="myModalUpdate" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalUpdate">
               	修改用户密码
            </h4>
         </div>
         <div class="modal-body">
     			<form id="formupdateUserInfo" method="post" action="" class="form-horizontal">
     				<input type="hidden" name="id" id="update_id"/>
     				<input id="huancun" type="hidden">
			    	<table cellpadding="5" align="center">

			    		<tr style="background-color:white;">
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>用户名:</td>
			    			<td><input class="form-control" type="text" id="updatecode" name="code" data-options="required:true" disabled></input></td>
			    		</tr>
			    		<tr style="background-color:white;">
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>当前密码:</td>
			    			<td>
			    				<input class="form-control" type="password" name="password" id="updatepassword" maxlength="25" onblur="checkPassword(this.value)"></input>
			    				<span style="font-weight: bold;color: red;"><div id="xianshi"></div></span>
			    				<input type="hidden" id="passwordStatus">
			    			</td>
			    		</tr>
			    		<tr style="background-color:white;">
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>新密码:</td>
			    			<td>
			    				<input class="form-control" type="password" id="updatenewpassword" name="newpassword" data-options="required:true" onblur="passworldLength(this.value)"></input>
			    				<span style="font-weight: bold;color: red;"><div id="xianshiPassword"></div></span>
			    			</td>
			    		</tr>
			    		<tr style="background-color:white;">
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>确认新密码:</td>
			    			<td>
			    				<input class="form-control" type="password" name="confimpassword" id="updateconfimpassword" maxlength="25" onblur="chenkConfimPassword(this.value)"></input>
			    				<span style="font-weight: bold;color: red;"><div id="xianshiConfimPassword"></div></span>
			    			</td>
			    		</tr>

			    	</table>
			    	<div class="modal-footer" style="background-color:white;">
			            <button type="button" class="btn btn-default"
			               data-dismiss="modal">关闭
			            </button>
			            <button type="button" class="btn btn-primary" onclick="updateUserInfo();">
			               	提交更改
			            </button>
			         </div>
			    </form>
         </div>
      </div>
</div>
</div>

<!-- 用户头像上传 start  -->
<div class="modal fade" id="myModalUpdateAv" tabindex="-1" role="dialog"
   aria-labelledby="myModalUpdateAv" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalUpdateAv">
               	修改用户头像
            </h4>
         </div>
         <div class="modal-body">
         	<form id="formInsertImg" method="post" action="" class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>用户头像</label>
                <div class="col-sm-6">
               			<div style="text-align:center;">
               			
<%--                			<c:choose>
			         	   <c:when test="${userInfo.avatar!='' }">
			         			<img class="btn_upload btn_upload1" title="预览图片" id="imgUrlAddress"  
								src="<%=tomcatPath %>imgUpload/${userInfo.avatar}" style="width:142px;height:120px;">
			         	   </c:when>
			         	   <c:otherwise>
			         			<img class="btn_upload btn_upload1" title="预览图片" id="imgUrlAddress" src="<%=basePath %>resources/cleanzone/images/av.jpg" style="width:142px;height:120px;">
			         	   </c:otherwise>
			         	</c:choose> --%>
							<input  name="UI_IMGURL" class="imgUrl imgUrl1" type="hidden"  value="">
							<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-info"><span class="glyphicon glyphicon-upload"></span>&nbsp;上传图片</a>
						</div>
                </div>
              </div>
              <div class="modal-footer">
	            <button type="button" class="btn btn-default"
	               data-dismiss="modal">关闭
	            </button>
<%-- 	            <button type="button" class="btn btn-primary" onclick="submitInfo(${userInfo.id});">
	               	保存
	            </button> --%>
	            
	        </div>
            </form>
         </div>
      </div>
</div>
</div>
<!-- 用户头像上传  end-->
  <script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.gritter/js/jquery.gritter.js"></script>

  <script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.nanoscroller/jquery.nanoscroller.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/behaviour/general.js"></script>
  <script src="<%=basePath %>/resources/cleanzone/js/jquery.ui/jquery-ui.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.sparkline/jquery.sparkline.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.easypiechart/jquery.easy-pie-chart.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.nestable/jquery.nestable.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/bootstrap.switch/bootstrap-switch.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/bootstrap.datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
  <script src="<%=basePath %>/resources/cleanzone/js/jquery.select2/select2.min.js" type="text/javascript"></script>
  <script src="<%=basePath %>/resources/cleanzone/js/skycons/skycons.js" type="text/javascript"></script>
  <script src="<%=basePath %>/resources/cleanzone/js/bootstrap.slider/js/bootstrap-slider.js" type="text/javascript"></script>
  <script src="<%=basePath %>/resources/js/mainControl.js" type="text/javascript"></script>
  <script src="<%=basePath %>/resources/cleanzone/js/intro.js/intro.js" type="text/javascript"></script>

  <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript">
      $(document).ready(function(){
        //initialize the javascript
        App.init();
        App.dashBoard();        
        
         /*  introJs().setOption('showBullets', false).start(); */
      });
/*        $(function(){
       	  initLoadInfo();
       })  */
          
      function initLoadInfo(){
      	      var windowheight = $(window).height();
		       	  var heigthdiv = windowheight-100;
		       	  $("#leftHeightMiddleDiv").css("height",heigthdiv);
		       	  $("#pcont").css("height",heigthdiv);
		       	  $(".shrinkMenuBox").css("height",heigthdiv);
		       	  $(".treeViewBox").css("height",heigthdiv);
		       	  $(".shrinkMenuBox>p").css({"height":heigthdiv,"line-height":heigthdiv+'px'});
		       	  $("#totalHeightMiddleDiv").css("height",windowheight);
		       	  
		       	  var leftMenuUlDiv = $("#leftHeightMiddleDiv").css("width");
		       	  var lastwidthuidiv = parseFloat(leftMenuUlDiv) -4;
		       	  $("#menuUlId").attr("style","width:"+lastwidthuidiv+"px");
		       	  $("#leftHeightMiddleDivSearch").attr("style","width:"+(lastwidthuidiv-52)+"px");
		       	  var mainWidth=$('.mainContentBox');
		       	  var shrinkMenuBox=$('.shrinkMenuBox');
		       	  $('.mapAndTreeView').width(mainWidth.width()-shrinkMenuBox.outerWidth()-8);
		       	  //添加行宽度
		       	 $('.currentBox').width($(window).width()-30);
      }
      function showPasswordChange(){
     	  $("#myModalUpdate").modal("show");
    	  $("#updatecode").val("").val("<%=userInfo.getUserName()%>");
    	  $("#updatepassword").val("");
    	  $("#updatenewpassword").val("");
    	  $("#updateconfimpassword").val("");
      } 
      function uploadAv(){
    	  $("#myModalUpdateAv").modal("show");
      }
      
      function checkPassword(password){
    	  var code = $("#updatecode").val();
    	  var password = $("#updatepassword").val();
    	  if(password == "" || password == null ){
    		  document.getElementById("xianshi").innerHTML="密码不能为空！";
    		  $("#passwordStatus").val("false");
    		  return;
    	  }
    	  $.commonReq({
    		  url:"<%=basePath%>user/checkPassword.do",
    		  data:{"code":code,"password":password},
    		  success:function(result){
    			  if(result.data){
    				  //密码正确
    				  document.getElementById("xianshi").innerHTML="";
    				  $("#passwordStatus").val("true");
    			  }else{
    				  document.getElementById("xianshi").innerHTML="密码不正确！";
    				  $("#passwordStatus").val("false");
    			  }
    		  },
    		  error:function(){
    			  
    		  }
    	  });
      }
      
      function passworldLength(password){
    	  if(password.length<6){
    		  document.getElementById("xianshiPassword").innerHTML="请输入6位以上密码！";
    		  return;
    	  }else{
    		  document.getElementById("xianshiPassword").innerHTML="";
    	  }
      }
      
      function chenkConfimPassword(confimPassword){
    	  var password = $("#updatenewpassword").val();
    	  if(password != confimPassword){
    		  document.getElementById("xianshiConfimPassword").innerHTML="密码不一致，请确认！";
    	  }else{
    		  document.getElementById("xianshiConfimPassword").innerHTML="";
    	  }
      }
      
      function updateUserInfo(){
     	  var id = "<%=userInfo.getId()%>";
    	  var password = $("#updateconfimpassword").val();
    	  $.commonReq({
    		  url:"<%=basePath%>/userInfo/update.do",
    		  data:{"id":id,"password":password},
    		  success:function(result){
    			  $("#myModalUpdate").modal("hide");
    			  if(result.data){
    				  bootbox.alert("密码修改成功！");
    			  }else{
    				  bootbox.alert("密码修改失败！");
    			  }
    		  }
    		  
    	  })
      }
    </script>
    <script src="<%=basePath %>/resources/cleanzone/js/behaviour/voice-commands.js"></script>
    <script src="<%=basePath %>/resources/cleanzone/js/bootstrap/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.flot/jquery.flot.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.flot/jquery.flot.pie.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.flot/jquery.flot.resize.js"></script>
	<script type="text/javascript" src="<%=basePath %>/resources/cleanzone/js/jquery.flot/jquery.flot.labels.js"></script>
	<script src="<%=basePath %>resources/js/common.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/bootstrap/bootbox.js"></script>
	<script src="<%=basePath %>resources/js/bootstrap/jquery.form.js" type="text/javascript"></script>
	<script src="<%=basePath %>resources/js/bootstrap/center-loader.js"></script>
 	<script src="<%=basePath %>/resources/js/business/index.js" type="text/javascript"></script>
 <!-- 上传图片div -->
<div style="display: none;">
<%-- 		<form id="form1" name="form1" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file1" name="file1" type="file" onchange="upload_img('<%=basePath%>/user/upload.do','1','${userInfo.username }')" />
		</form> --%>
		<form id="form2" name="form2" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file2" name="file2" type="file" onchange="upload_img('<%=basePath%>','2',$('#check_id option:selected').val())" />
		</form>
</div>
<!-- 上传图片END -->
  </body>

<!-- Mirrored from condorthemes.com/cleanzone/ by HTTrack Website Copier/3.x [XR&CO'2013], Mon, 31 Mar 2014 14:32:27 GMT -->
</html>
