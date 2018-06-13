<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui/themes/color.css">
<script type="text/javascript" src="<%=basePath%>resources/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/js/mainControl.js"></script>	
<script type="text/javascript" src="<%=basePath%>resources/js/PublicTools.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/easyui/easyui-lang-zh_CN.js"></script>

<!-- bootstrap start -->
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/bootstrap/bootstrap.min.css">
<script type="text/javascript" src="<%=basePath %>resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/bootstrap/bootbox.js"></script>
<!-- bootstrap start -->

<!-- bootstrap 时间控件 start -->
<link href="<%=basePath %>resources/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>resources/datetimepicker/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<!-- bootstrap 时间控件 start -->

<!-- bootstrap table start -->
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap/bootstrap-table.min.css">
<script src="<%=basePath %>resources/js/bootstrap/bootstrap-table.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap/bootstrap-table-zh-CN.min.js"></script>
<!-- bootstrap table end -->
<!-- 上传图片 -->
<script src="<%=basePath %>resources/js/bootstrap/fileUpload.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/bootstrap/jquery.form.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/bootstrap/center-loader.js"></script> 
<script src="<%=basePath%>resources/js/common.js"></script>
<script src="<%=basePath %>resources/js/business/videoSystemManager.js"></script>
<!--判空验证  -->
<link rel="stylesheet" href="<%=basePath%>resources/css/bootstrap/bootstrapValidator.css" />
<script src="<%=basePath%>resources/js/bootstrap/bootstrapValidator.js"></script> 
<!-- 视频 -->
<script src="<%=basePath %>resources/js/business/webVideoCtrl.js"></script>

<style type="text/css">
	 body {
	margin: 0;
	background: url(resources/images/body.jpg) repeat;
}/*liuxiaowei*/

.row-fluid thead {
	background: url(resources/images/toolbarbg.png) repeat-x #f3f3f3;/*liuxiaowei*/
}
.table_main {
	box-shadow: 0px 0px 4px 1px rgba(0, 0, 0, 0.1);
	-webkit-border-radius: 3px;
	background: #FFF;
	margin: 10px;
}/*liuxiaowei*/
</style>
<script type="text/javascript">
			$(document).ready(function() {
				$(window).resize(function() {
					var table_height = $(window).height();
					$(".table_main").height(table_height - 74); 
				});
				$(window).resize();
			});
</script><!--liuxiaowei-->

</head>
<body onunload="closePage()">
	<div style="border-bottom: 1px solid #ccc;height: 34px;">
		<ol class="breadcrumb">
		  <li><span class="glyphicon glyphicon-home">  当前位置</span></li>
		  <li class="active">视频参数管理</li>
		</ol>
		<span style="position:absolute;top:10px;right:20px;" id ="time" class="glyphicon glyphicon-calendar"></span>
	</div>
	<!-- 增加弹框 -->
  	<div  class="modal fade" id="insertSysDataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   		<div  class="modal-dialog">
      		<div class="modal-content" style="width:500px;">
      			<form id="videoInsertForm" class="form-horizontal">
      			
    				<div style="margin:0 auto;width: 100%">
    					<div class="modal-header">
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">保存视频参数</h4>
      					</div>
      					<input type="hidden" name="systemFlag" id="systemFlag2">
      					<!-- 1代表海康 -->
      					<input type="hidden" name="type" id="videoType2" >  
      					<div style="margin-top: 20px;">
      			   			<div class="form-group">
      							<label  class="col-sm-3 control-label">IP地址：</label> 
      						<div class="col-sm-7">
                    			<input class="form-control" value="" name="ip" id="addip" ></input>
                    		</div>
              				</div>
             			</div>
             			<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">端口：</label>
      								<div class="col-sm-7">
                    					<input class="form-control" value="" name="port"  id="addport" ></input>
                    				</div>
              					</div>
              			</div>
             			<div style="margin-top: 20px;">
      			   			<div class="form-group">
      							<label  class="col-sm-3 control-label">用户名：</label>
      							<div class="col-sm-7">
                    				<input class="form-control" value="" name="userName" id="adduserName" ></input>
                    			</div>
              				</div>
             			</div>
             			<div style="margin-top: 20px;">
      			   			<div class="form-group">
      							 <div class="col-xs-3"  style="text-align: right">
					    		<!-- <span style='color:red;font-size:20px;position:relative;top:7px;right:2px'>*</span> -->
					    		<label class="control-label rowTxt " for="title" >密码：</label>
								</div>	
      							<div class="col-sm-7">
                    				<input class="form-control" value="" name="passWord" id="addpassWord" maxlength="50px" type="password"></input>
                    			</div>
              				</div>
             			</div>
             		</div>
    				<div style="text-align: center;margin-bottom: 30px;">
    					<a id="addInfoBtn" type="button" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;保存</a>
       					<a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 取消</a>
    				</div>
  				 </form>
      		</div>
   		</div>
	</div>
	<!-- 增加监控点信息 -->
  	<div  class="modal fade" id="insertVideoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   		<div  class="modal-dialog">
      		<div class="modal-content" style="width:500px;">
      			<form id="addVideoForm" class="form-horizontal">
      					<input type="hidden" name="systemFlag" id="systemFlag" >
      				<!-- 1代表海康 -->
      						<input type="hidden" name="type" id="videoType" > 
    				<div style="margin:0 auto;width: 100%">
    					<div class="modal-header">
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">新增通道参数</h4>
      					</div>
      						
      						
      						<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">通道号：</label> 
      							<div class="col-sm-7">
      								<select class="form-control" id="channels" name="channel"></select>
                    			</div>
              				</div>
             		</div>
             		<div style="margin-top: 20px;">
      			   		<div class="form-group">
      						<label  class="col-sm-3 control-label">监控点名称：</label>
      						<div class="col-sm-7">
                    			<input class="form-control" value="" id="videoName" name="videoName"  ></input>
                    		</div>
              			</div>
             		</div>
             		<div style="margin-top: 20px;">
      			   		<div class="form-group">
      						 <div class="col-xs-3"  style="text-align: right">
					    		
					    		<label class="control-label rowTxt " for="title" >监控点位置：</label>
						</div>	
      					<div class="col-sm-7">
                    		<input class="form-control" value="" name="addressInfo" id="addressInfo" ></input>
                    	</div>
              			</div>
             		</div>
             				<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">用途：</label>
      								<div class="col-sm-7">
                    					<input class="form-control" value="" name="useInfo"  id="useInfo" ></input>
                    				</div>
              					</div>
              				</div>
    				</div>
    				
    					<div style="text-align: center;margin-bottom: 30px;">
    						<a id="addVideoInfo" type="button" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;保存</a>
       						<a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 取消</a>
    				</div>
  				 </form>
      		</div>
   		</div>
	</div>
	<!-- 修改监控点详细信息 -->
  	<div  class="modal fade" id="updateVideoModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   		<div  class="modal-dialog">
      		<div class="modal-content" style="width:500px;">
      			<form id="updateVideoForm" class="form-horizontal">
      					<input type="hidden" name="id" id="updateId" >
      					<input type="hidden" name="systemFlag" id="updateSystemFlag" >
      				<!-- 1代表海康 -->
      						<input type="hidden" name="type" id="updateVideoType" > 
    				<div style="margin:0 auto;width: 100%">
    					<div class="modal-header">
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">修改监控点信息</h4>
      					</div>
      						
      						
      						<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">通道号：</label> 
      							<div class="col-sm-7">
      								<select class="form-control" id="updateChannels" name="channel"></select>
                    			</div>
              				</div>
             		</div>
             		<div style="margin-top: 20px;">
      			   		<div class="form-group">
      						<label  class="col-sm-3 control-label">监控点名称：</label>
      						<div class="col-sm-7">
                    			<input class="form-control" value="" id="updateVideoName" name="videoName"  ></input>
                    		</div>
              			</div>
             		</div>
             		<div style="margin-top: 20px;">
      			   		<div class="form-group">
      						 <div class="col-xs-3"  style="text-align: right">
					    		
					    		<label class="control-label rowTxt " for="title" >监控点位置：</label>
						</div>	
      					<div class="col-sm-7">
                    		<input class="form-control" value="" name="addressInfo" id="updateAddressInfo" ></input>
                    	</div>
              			</div>
             		</div>
             				<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">用途：</label>
      								<div class="col-sm-7">
                    					<input class="form-control" value="" name="useInfo"  id="updateUseInfo" ></input>
                    				</div>
              					</div>
              				</div>
    				</div>
    				
    					<div style="text-align: center;margin-bottom: 30px;">
    						<a onclick="saveUpdateInfo();" type="button" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;保存</a>
       						<a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 取消</a>
    				</div>
  				 </form>
      		</div>
   		</div>
	</div>
	
	<div  class="modal fade" id="videoUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">	
      	<div  class="modal-dialog">
      		<div class="modal-content" style="width:750px;">
      	<form id="videoUpdateForm" class="form-horizontal" onclick="checkAddOrUpdate();" >
      		<div style="margin:0 auto;width: 100%">
    			<input type="hidden" value="${videoInfo.companyCode}" id="userCode" name="companyCode">
      			<input type="hidden" value="${videoInfo.id}" id="id" name="id">
      			
      			<div style="margin-top: 20px;">
      				
      			   	<div class="form-group">
      					<label  class="col-sm-2 control-label float:left">IP地址：</label>
      					<div class="col-sm-3">
                    		<input class="form-control" value="${videoInfo.ip }" name="ip" id="ip" ></input>
                    	</div>
             			<label  class="col-sm-2 control-label">端口：</label>
      					<div class="col-sm-3">
                    		<input class="form-control" value="${videoInfo.port }" name="port"  id="port" ></input>
                    	</div>
                 </div>
                </div>
             	<div style="margin-top: 20px;">
      			   	<div class="form-group">
      					<label  class="col-sm-2 control-label float:left">用户名：</label>
      					<div class="col-sm-3">
                    		<input class="form-control" value="${videoInfo.userName }" name="userName" id="userName" ></input>
                    	</div>
              			<div class="col-xs-2"  style="text-align: right">
					    	<label class="control-label rowTxt " for="title " >密码：</label>
						</div>	
      					<div class="col-sm-3">
                    		<input class="form-control" value="${videoInfo.passWord }" name="passWord" id="passWord" type="password" maxlength=""></input>
                    	</div>
              			</div>
             		</div>
    		</div>
    		<div style="text-align: center;margin-bottom: 30px;">
    			<a id="updateInfoBtn" type="button" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;修改保存</a>
       			<!-- <a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 刷新</a> -->
    		</div>
  		 </form>
  		 </div>
  	</div> 
  </div>
  <div style="padding: 10px 10px;" class="table_main">
	<div id="cond" style="margin-top: 10px;">
  		 <form class="form-inline" role="form">
					 所属企业名称: <select id='companyCodeId' class="form-control"
						name="companyCode" style="width: 200px;">
							<c:if test="${companys.size()>1 }">
								<option value="">--请选择--</option>
							</c:if>
							<c:forEach items="${companys }" var='company'>
								<option value='${company.code }'>${company.name}</option>
							</c:forEach>
					</select>
					<button type="button" class="btn btn-warning" onclick="changeCompany();">
						<span class="glyphicon glyphicon-share"></span>更换企业
					</button>
					 监测点地址信息: <input id='qaddressInfo'class="form-control" style="width: 200px;">
					 用途: <input id="quseInfo" class="form-control" style="width: 200px;" maxlength="25">
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
					<button type="button" class="btn btn-info" onclick="addVideoInfo();">
						<span class="glyphicon glyphicon-plus"></span>新增
					</button>
					<%-- <a data-toggle="modal"
						href="<%=basePath%>companyInfo/toInsertInfo.do"
						data-target="#insertModal" type="button" class="btn btn-info"><span
						class="glyphicon glyphicon-plus"></span>&nbsp;新增</a> --%>
				</div>
			</form>
		<div style="margin-top: 20px;">
  			<div class="row-fluid">
				<table id="dt" cellspacing="0" width="100%" ></table>
			</div>
		</div>
	</div>
</div>
		<div style="width:1px;height:1px;">
			<div id="divPlugin" class="plugin" ></div>
		</div>
	<select id="loginIp" style="display:none" ></select>	
</body>
<script type="text/javascript">
$("#insertSysDataModal").on("hidden.bs.modal", function() {
	$(this).removeData("bs.modal");  
});
$("#updateSysDataModal").on("hidden.bs.modal", function() {
	$(this).removeData("bs.modal");  
});
</script>
</html>