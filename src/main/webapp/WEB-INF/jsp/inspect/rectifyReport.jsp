<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<script src="<%=basePath%>resources/js/bootstrap/rectifyReportFileUpload.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/jquery.form.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/center-loader.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-treeview.min.js"></script>

<script src="<%=basePath%>resources/js/business/rectifyReport.js"></script>
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
			<li class="active">整改管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-left: 10px;">
					   受检企业: <select id='inspectedEnterpriseNumberId' class="form-control" style="width: 200px;">
							<c:if test="${companys.size()>1 }">
								<option value="">--请选择--</option>
							</c:if>
							
							<c:forEach items="${companys }" var='company'>
								<option value='${company.code }'>${company.name}</option>
							</c:forEach>
					</select>
					
					<div style="display:none;">
						检查结果: <select id="resultId" class="form-control" 
						style="width: 200px; ">
						<option value=1>不符合</option>
						</select>
					</div>
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
			</form>
		</div>
		<div class="row-fluid">
			<table id="dt" cellspacing="0" width="100%"></table>
		</div>
	</div>

	<!-- BS ： 修改********************************************************************************* -->

	<!-- 模态框（Modal） 修改  -->
	<div class="modal fade" id="myModalUpdateRectify" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">修改整改信息</h4>
				</div>
				<div class="modal-body">
				<form id="formupdateInfo" method="post" action=""
					class="form-horizontal">
					<input type="hidden" id="update_id">
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>是否整改完成</label>
						<div class="col-sm-5">
							<select name="endFlag" class="form-control" id="editEndFlag">
								<option value="0">未完成</option>
								<option value="1">已完成</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改前情况</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="36" name='beforeState' id="editbeforeState"></textarea>
						</div>
					</div>
				   <div class="form-group">
						<div class="col-sm-4" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('3');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;整改前情况附件</a>
						</div>
						 <div class="col-sm-5" >
						  	<br>
						  			<input id="uploadFileId3" type="hidden" name="beforeStateFileUrl">
				  					<span id="uploadFileName3" style="color:#3c7897"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改后情况</label>
						<div class="col-sm-5">
							<textarea id="editafterState" rows="6" cols="36" name='afterState'></textarea>
						</div>
					</div>
				   <div class="form-group">
						<div class="col-sm-4" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('4');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;整改后情况附件</a>
						</div>
						 <div class="col-sm-5" >
						  	<br>
						  			<input id="uploadFileId4" type="hidden" name="afterStateFileUrl">
				  					<span id="uploadFileName4" style="color:#3c7897"></span>
						</div>
					</div>
				  
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>开始时间</label>
						<div class="col-sm-5">
							<input id="editstartTime" name="startTime" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>结束时间</label>
						<div class="col-sm-5">
							<input id="editendTime" name="endTime" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>地点</label>
						<div class="col-sm-5">
							<input id="editaddress" name="address" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改负责人</label>
						<div class="col-sm-5">
							<input id="editresponsiblePerson" name="responsiblePerson" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>负责人联系电话</label>
						<div class="col-sm-5">
							<input id="editresponsiblePhone" name="responsiblePhone" class="form-control">
						</div>
					</div>
					<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="updateRectifyInfo();">提交更改</button>
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
					<h4 class="modal-title" id="myModalUpdate">整改详情信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateInspectInfo" method="post" action=""
						class="form-horizontal">
						<table cellpadding="5" align="center"
							style="border-collapse: separate; border-spacing: 10px;">
							
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									是否整改完成:
								</td>
								<td>
									<input class="form-control" id="detailEndFlag" readonly="true"></input>
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									整改前情况:
								</td>
								<td>
									<textarea rows="6" cols="36" name='beforeState' id='beforeStateMore' readonly="true"></textarea>
								</td>
							</tr>
							
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									整改前情况附件:
								</td>
								<td id="beforeStateFileUrlMore">
						  			<input id="uploadFileId5" type="hidden" >
				  					<span id="uploadFileName5" style="color:#3c7897"></span>
								</td>
							</tr>
						    <tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									整改后情况:
								</td>
								<td>
									<textarea rows="6" cols="36" name='afterState' id="afterStateMore" readonly="true"></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									整改后情况附件:
								</td>
								<td id="afterStateFileUrlMore">
						  			<input id="uploadFileId6" type="hidden" >
				  					<span id="uploadFileName6" style="color:#3c7897"></span>
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									开始时间:
								</td>
								<td>
									<input name="startTime" class="form-control" id="startTimeMore" readonly="true">
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									结束时间:
								</td>
								<td>
									<input name="endTime" class="form-control" id="endTimeMore" readonly="true">
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									地点:
								</td>
								<td>
									<input name="address" id='addressMore' class="form-control" readonly="true">
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									整改负责人:
								</td>
								<td>
									<input name="responsiblePerson" id='responsiblePersonMore' class="form-control" readonly="true">
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>
									负责人联系电话:
								</td>
								<td>
									<input name="responsiblePhone" id='responsiblePhoneMore' class="form-control" readonly="true">
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
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>是否整改完成</label>
						<div class="col-sm-5">
							<select name="endFlag" class="form-control" id="endFlag">
								<option value="0">未完成</option>
								<option value="1">已完成</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改前情况</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="36" name='beforeState'></textarea>
						</div>
					</div>
				   <div class="form-group">
						<div class="col-sm-4" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;整改前情况附件</a>
						</div>
						 <div class="col-sm-5">
						 	<br>
						  	<input id="uploadFileId1" type="hidden" name="beforeStateFileUrl">
				  			<span id="uploadFileName1" style="color:#3c7897"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>整改后情况</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="36" name='afterState'></textarea>
						</div>
					</div>
				   <div class="form-group">
						<div class="col-sm-4" style="text-align:center;">
								<a style="margin-top: 5px;" onclick="upload('2');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;整改后情况附件</a>
						</div>
						 <div class="col-sm-5">
						  	<br>
						  	<input id="uploadFileId2" type="hidden" name="afterStateFileUrl">
				  			<span id="uploadFileName2" style="color:#3c7897"></span>
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
		<form id="form3" name="form3" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file3" name="file3" type="file" onchange="upload_file_new('<%=basePath%>','3',$('#check_id option:selected').val())" />
		</form>
		<form id="form4" name="form4" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file4" name="file4" type="file" onchange="upload_file_new('<%=basePath%>','4',$('#check_id option:selected').val())" />
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
