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

<script src="<%=basePath%>resources/js/business/inspectManager.js"></script>
<script src="<%=basePath%>resources/js/bootstrap/rectifyReportFileUpload.js"
	type="text/javascript"></script>
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
			<li class="active">检查管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-left: 10px;">

				       受检企业: <select id='inspectedEnterpriseNumberId' class="form-control" style="width: 200px;">
							<c:if test="${companys.size()>0 }">
								<option value="">--请选择--</option>
							</c:if>
							
							<c:forEach items="${companys }" var='company'>
								<option value='${company.code }'>${company.name}</option>
							</c:forEach>
					</select>
					
					检查结果: <select id="resultId" class="form-control" 
						style="width: 200px;">
						<option value="">全部</option>
						<option value=0>符合</option>
						<option value=1>不符合</option>
					</select> 
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
			<c:choose>
				 <c:when test='<%=userInfo.getType().equals("0")%>'>
					   <a data-toggle="modal" href="<%=basePath%>inspection/toInsert.do"
						data-target="#insertModal" type="button" class="btn btn-info"><span
						class="glyphicon glyphicon-plus"></span>&nbsp;新增</a>
			 	</c:when>
			</c:choose>
				</div>
			</form>
		</div>
		<!-- 增加弹框 -->
		<div class="modal fade" id="insertModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="margin-left: 30%;">
				<div class="modal-content"></div>
			</div>
		</div>
		<!-- 增加弹框 End -->
		<div class="row-fluid">
			<table id="dt" cellspacing="0" width="100%"></table>
		</div>
	</div>

	<!-- BS ： 修改********************************************************************************* -->

	<!-- 模态框（Modal） 修改  -->
	<div class="modal fade" id="myModalUpdateInspect" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">修改检查信息</h4>
				</div>
				<div class="modal-body">
				<form id="formupdateInfo" method="post" action=""
					class="form-horizontal">
					<input type="hidden" id="update_id">
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>受检单位:</label>
						<div class="col-sm-7">
							<input class="form-control" name="inspectedEnterpriseNumber" id='editinspectedEnterpriseNumber' disabled="disabled">
							</input>
						</div>
					</div>
		
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查单位名称:</label>
						<div class="col-sm-7">
							<input class="form-control" name="inspectEnterpriseNumber" id="editinspectEnterpriseNumberId" disabled="disabled">
							</input>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查开始时间:</label>
						<div class="col-sm-7">
							<input class="form-control" id="editinspectStartTimeId" name="inspectStartTime">
							</input>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查结束时间:</label>
						<div class="col-sm-7">
							<input class="form-control" id="editinspectEndTimeId" name="inspectEndTime">
							</input>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>主题:</label>
						<div class="col-sm-7">
							<input type="text" class='form-control' name='title' id='editTitle'></input>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>内容:</label>
						<div class="col-sm-7">
							<textarea rows="2" cols="40" class='form-control' name='content' id='editcontent' autoFocus></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>结果:</label>
						<div class="col-sm-7">
							<select type="text" class="form-control" id="editresultId" name="result">
									<option value="0">符合</option>
									<option value="1">不符合</option>
							</select>
						</div>
					</div>
		
					<div class="form-group">
						<label class="col-sm-3 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注:</label>
						<div class="col-sm-7">
							<textarea rows="2" cols="40" class="form-control" id="editresason" name="reason" autoFocus>
					</textarea>
						</div>
					</div>
					
				   <div class="form-group">
						<div class="col-sm-3" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('2');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;上传检测报告</a>
						</div>
						 <div class="col-sm-7">
						  	<!-- <input id='fileUrlId' name="fileUrl" class="imgUrl imgUrl1 form-control" value="" readonly="readonly"> -->
						  	<input id="uploadFileId2" type="hidden" name="fileUrl">
				  			<span id="uploadFileName2" style="color:#3c7897"></span>
						</div>
					</div>
					
					<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="updateInspectInfo();">提交更改</button>
				   </div>
				</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- BS ： 修改********************************************************************************* -->

	<!-- 详情modal start -->
	<div class="modal fade" id="myModalMore" tabindex="-1" role="dialog"
		aria-labelledby="myModalMore" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">检查详情信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateInspectInfo" method="post" action=""
						class="form-horizontal">
						<table cellpadding="5" align="center"
							style="border-collapse: separate; border-spacing: 10px;">

							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>受检单位:</td>
								<td><input class="form-control" type="text" id="searchInspectedEnterpriseNumberId"  data-options="required:true" disabled></input></td>
								
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查单位名称:</td>
								<td><input class="form-control" type="text" id="inspectEnterpriseNumberId"  maxlength="25" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查开始时间:</td>
								<td><input class="form-control" type="text"
									id="inspectStartTimeIdMore" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查结束时间:</td>
								<td><input class="form-control" type="text" id="inspectEndTime" maxlength="25" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>主题:</td>
								<td>
									<input class="form-control" type="text" id="titleId"  data-options="required:true" disabled></input>
								</td>
								
							</tr>
							<tr>
								<td><span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>内容:</td>
								<td>
									<textarea rows="4" cols="50" id="contentId" disabled="disabled" autoFocus></textarea>
								</td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>结果:</td>
								<td>
									<select class="form-control" id="resultId" disabled="disabled">
										<option value='0'>符合</option>
										<option value='1'>不符合</option>
										
									</select>
								</td>
								
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注:</td>
								<td>
									<textarea rows="4" cols="50" id="reasonId" disabled="disabled" autoFocus></textarea>
								</td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检测文件:</td>
								<td >
									<input id="uploadFileId3" type="hidden" name="fileUrl">
				  					<span id="uploadFileName3" style="color:#3c7897"></span>
								</td>
							</tr>
						</table>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 详情modal end -->

	
	<!-- BS ： 修改********************************************************************************* -->

	<!-- 模态框（Modal）提交整改  -->
	<div class="modal fade" id="myModalSubmitReform" tabindex="-1"
		role="dialog" aria-labelledby="myModalSubmitReform" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalSubmit">整改信息</h4>
				</div>
				<div class="modal-body">
				<form id="formSubmitReform" method="post" action=""
					class="form-horizontal">
					<input type="hidden" id="inspectId">
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改前情况</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="33" name='beforeState' autoFocus> </textarea>
						</div>
					</div>
				   <div class="form-group">
						<div class="col-sm-4" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;整改前情况附件</a>
						</div>
						 <div class="col-sm-5">
						  	<input  name="beforeStateFileUrl" class="imgUrl imgUrl1 form-control" value="" readonly="readonly">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改后情况</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="33" name='afterState' autoFocus></textarea>
						</div>
					</div>
				   <div class="form-group">
						<div class="col-sm-4" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('2');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;整改后情况附件</a>
						</div>
						 <div class="col-sm-5">
						  	<input  name="afterStateFileUrl" class="imgUrl imgUrl2 form-control" value="" readonly="readonly">
						</div>
					</div>
				  
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>开始时间</label>
						<div class="col-sm-5">
							<input name="startTime" class="form-control" id="startTimeId">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>结束时间</label>
						<div class="col-sm-5">
							<input name="endTime" class="form-control" id="endTimeId">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>地点</label>
						<div class="col-sm-5">
							<input name="address" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改负责人</label>
						<div class="col-sm-5">
							<input name="responsiblePerson" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>负责人联系电话</label>
						<div class="col-sm-5">
							<input name="responsiblePhone" class="form-control">
						</div>
					</div>
					<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="submitReform();">保存</button>
				   </div>
				</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- BS ： 修改 提交整改********************************************************************************* -->
	
	<!-- 上传图片div -->
<div style="display: none;">
		<form id="form1" name="form1" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file1" name="file1" type="file" onchange="upload_file_new('<%=basePath%>','1',$('#check_id option:selected').val())" />
		</form>
		<form id="form2" name="form2" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file2" name="file2" type="file" onchange="upload_file_new('<%=basePath%>','2',$('#check_id option:selected').val())" />
		</form>
</div>
<!-- 上传图片END -->

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
</script>
</html>
