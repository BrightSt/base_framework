<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.xqls.common.entity.UserInfo" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserInfo userInfo = (UserInfo)request.getSession().getAttribute("currentUser");
	System.out.print(basePath);
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>
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
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/easyui/themes/color.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/css/common.css">
<script type="text/javascript"
	src="<%=basePath%>resources/easyui/jquery.min.js"></script>
<script src="<%=basePath%>resources/js/common.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/js/mainControl.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/js/PublicTools.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/easyui/easyui-lang-zh_CN.js"></script>

<!-- bootstrap start -->
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/css/bootstrap/bootstrap.min.css">
<script type="text/javascript"
	src="<%=basePath%>resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/js/bootstrap/bootbox.js"></script>
<!-- bootstrap start -->

<!--下拉框插件start-->
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap/bootstrap-select.css">
<script src="<%=basePath%>resources/js/bootstrap/bootstrap-select.js"></script>
<script src="<%=basePath%>resources/js/bootstrap/defaults-zh_CN.js"></script>
<!--下拉框插件end-->
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap/bootstrapValidator.css" />
<script src="<%=basePath%>resources/js/bootstrap/bootstrapValidator.js"></script>
<!-- bootstrap 时间控件 start -->
<link
	href="<%=basePath%>resources/datetimepicker/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" type="text/css" />
<script
	src="<%=basePath%>resources/datetimepicker/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script
	src="<%=basePath%>resources/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<!-- bootstrap 时间控件 start -->

<!-- bootstrap table start -->
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap/bootstrap-table.min.css">
<script src="<%=basePath%>resources/js/bootstrap/bootstrap-table.min.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-table-zh-CN.min.js"></script>
<!-- bootstrap table end -->
<!-- 上传图片 -->
<script src="<%=basePath%>resources/js/bootstrap/fileUpload.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/jquery.form.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/center-loader.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-treeview.min.js"></script>

<script src="<%=basePath%>resources/js/business/auditingUser.js"></script>


<style type="text/css">
html, body {
	height: 100%;
	overflow: hidden;
}

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
	overflow-y: auto;
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

<body>
	<div style="border-bottom: 1px solid #ccc; height: 34px;">
		<ol class="breadcrumb">
			<li><span class="glyphicon glyphicon-home"> 当前位置</span></li>
			<li class="active">企业注册审批</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-left: 10px;">
					企业编码: <input id="codeId" class="form-control" style="width: 200px;" maxlength="25">
					企业名称: <input id='nameId' class="form-control" name="companyCode" style="width: 200px;">
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
			</form>
			<div class="row-fluid">
				<table id="dt" cellspacing="0" width="100%"></table>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal3" style="overflow: auto;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" style="width:700px;height: 700px;overflow: auto;">
	      <div class="modal-content" style="margin-top: 20%;">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	            <h4 class="modal-title" id="myModalLabel">
	               	企业资料
	            </h4>
	         </div>
	         <div class="modal-body" style="width: 100%;">
	             <form id="insertEnterpriseForm3" style="text-align: center;width:100%;">
				    	<div style="margin:0 auto; width:100%;">
				    		<table  style="cellspacing:10; border-spacing:10; border-collapse:separate">
				    			<tr>
				    				<td colspan="6" align=left ><h5><b>企业基本信息:</b></h5></td>
				    			</tr>
				    			<tr>
				    				<td style="text-align: right;">企业名称：</td>
				    				<td style="text-align: left;"><input class="form-control"  name="name" id="name" maxlength="100"></input></td>
				    				<td style="text-align: right;">企业编码：</td>
				    				<td style="text-align: left;">
				    					<input class="form-control"  name="code" id="code"  maxlength="50"/>
				    				</td>
				    				
				    			</tr>
				    			<tr>
				    				<td style="text-align: right;">法定代表人：</td>
				    				<td style="text-align: left;">
				    					<input class="form-control"  name="manager" id="manager" maxlength="30"/>
				    				</td>
				    				<td style="text-align: right;" >企业电话：</td>
				    				<td style="text-align: left;"><input class="form-control"   name="phone" id="phone" maxlength="50" ></input></td>
				    			</tr>
				    			<tr>
				    				<td style="text-align: right;">企业邮箱：</td>
				    				<td style="text-align: left;">
				    					<input class="form-control"  name="email" id="email" maxlength="20"/>
				    				</td>
				    				<td style="text-align: right;">传真：</td>
				    				<td style="text-align: left;">
				    					<input class="form-control" name="fax" id="fax" maxlength="20">
				    				</td>
				    			</tr>
				    			<tr>
				    				<td style="text-align: right;">隶属关系：</td>  
			                    	<td style="text-align: left;">
			                    		<input class="form-control"  id="subjection" name="subjection"  maxlength="30"/>
			                    	</td>  
				    				<td style="text-align: right;">企业资质等级：</td>  
			                    	<td style="text-align: left;">
			                    		<input class="form-control"  id="companyLevel" name="companyLevel" />
			                    	</td>
				    			</tr>
				    			<tr>
			                    	<td style="text-align: right;" >企业地址：</td>
				    				<td style="text-align: left;" colspan="3"><input class="form-control"   name="address" id="address" maxlength="200" ></input></td>  
				    				
				    			</tr>
				    			<tr>
			                    	
				    				<td style="text-align: right;">公司简介：</td>
				    				<td style="text-align: left;" colspan="3" rowspan="2">
				    					<input  class="form-control" name="remark" id="remark" ></input>
				    				</td>
				    			</tr>
				    				<input type="hidden" name="id" id="tailInfoId"/>
				    		</table>
				    	</div>
				   </form>
				  <div class="modal-footer" style="text-align: center;">
				  	 <button type="button" class="btn btn-success" onclick="auditingPass();">核准</button>
				  	 <button type="button" class="btn btn-warning" onclick="auditingNG();">退件</button>
	         		 <button type="button" class="btn btn-default"  data-dismiss="modal">取消</button>
	        	 </div>
	         </div>
	      </div>
	   </div>
	</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModala" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header" style="padding-top:40px;">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            
           	<form class="form-inline" role="form" >
				<div div class="form-group" style="margin-left: 100px;">审核未通过原因：
					<textarea rows="10" cols="20" class="form-control" id="reason" style="width:120%;"></textarea>
				</div>
			</form>
            	<div div class="form-group" style="margin-left: 270px;"><button type="button" class="btn btn-info" onclick="hideModal();"><span>确定</span></div>
            	<input id="hideId"  type="hidden">
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
<div class="modal fade" id="roleConfModal" tabindex="-1" role="dialog"
		aria-labelledby="roleConfModal" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">用户角色配置</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" name="userid" id="userid" />
					<div id="searchTree"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary"
						onclick="insertRoleInfo();">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
<script type="text/javascript">
	$("#insertModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalUpdateInspect").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalMore").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalSubmitReform").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#checkModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
</script>
</html>
