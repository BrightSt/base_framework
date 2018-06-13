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

<script src="<%=basePath%>resources/js/bootstrap/jquery.form.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/center-loader.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-treeview.min.js"></script>

<script src="<%=basePath%>resources/js/business/employeeTrainingPage.js"></script>
<script src="<%=basePath %>resources/js/bootstrap/trainingFileUpload.js" type="text/javascript"></script>

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
			<li class="active">从业人员培训管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-left: 10px;">
				  从业人员姓名: <input id='nameId' class="form-control"  style="width: 200px;"> </input>
				</div>
				<div class="form-group" style="margin-left: 10px;">
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
					<a data-toggle="modal" href="<%=basePath%>employeeTraining/toAdd.do"
						data-target="#insertModal" type="button" class="btn btn-info"><span
						class="glyphicon glyphicon-plus"></span>&nbsp;新增</a>
				</div>
			</form>
		</div>
		<!-- 增加弹框 -->
		<div class="modal fade" id="insertModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="margin-left: 25%;">
				<div class="modal-content" style="width:900px;"></div>
			</div>
		</div>
		<!-- 增加弹框 End -->
		<div class="row-fluid">
			<table id="dt" cellspacing="0" width="100%"></table>
		</div>
	</div>

	<!-- BS ： 修改********************************************************************************* -->

	<!-- 模态框（Modal） 修改  -->
	<div class="modal fade" id="myModalUpdateEmployeeTraining" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog" style="margin-left: 20%;">
			<div class="modal-content" style="width:900px;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">修改从业人员信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateInfo" method="post" action=""
						class="form-horizontal">
						<input type="hidden" name="id" id="update_id" />
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>姓名:</label>
							<div class="col-sm-3">
								<input class="form-control" id="editName" name="name"></input> 
							</div>
							
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>性别:</label>
							<div class="col-sm-3">
								<select class='form-control' id="editGender" name="gender">
									<option value="0">男</option>
									<option value="1">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
						 	<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>年龄：</label>
							<div class="col-sm-3">
								<input class='form-control' type="text" id="editAge" name="age">
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>身份证号:</label>
							<div class="col-sm-3">
								<input class='form-control' type="text" name="cardNo" id="editCardNo" maxlength="18" onblur="isCardNo();">
							</div>
							
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>资格证生效日期:</label>
							<div class="col-sm-3">
								<input class="form-control" id="editQualificationStart" name="qualificationStart"></input> 
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>资格证有效时长:</label>
							<div class="col-sm-3">
								<input class="form-control" name="qualificationLong" id="editQualificationLong" type="number" style="width:120px;display:inline;"></input>&nbsp;&nbsp;&nbsp;个月
							</div>
						</div>
						<div class="form-group">

							
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>从业资格证编号:</label>
							<div class="col-sm-3">
								<input class="form-control" id="editQualificationNo" name="qualificationNo"></input> 
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>发证机构:</label>
							<div class="col-sm-3">
								<input class="form-control" name="grantOrganize" id="editGrantOrganize"></input>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>培训签到记录表:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<a style="margin-top: 5px;" onclick="upload('4');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
								<input id="editFile1" type="hidden" name="attendanceRecord">
								<span id="editFileName1" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>培训资料:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<a style="margin-top: 5px;" onclick="upload('5');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
								<input id="editFile2" type="hidden" name="materials">
								<span id="editFileName2" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>考核材料:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<a style="margin-top: 5px;" onclick="upload('6');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
								<input id="editFile3" type="hidden" name="examineMaterials">
								<span id="editFileName3" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="updateInfo();">提交更改</button>
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- BS ： 修改********************************************************************************* -->
	
	<!-- 模态框（Modal） 详情 START  -->
	<div class="modal fade" id="myModalTailEmployeeTraining" tabindex="-1"
		role="dialog" aria-labelledby="myModalTail" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog" style="margin-left: 20%;">
			<div class="modal-content" style="width:900px;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">从业人员信息详情</h4>
				</div>
				<div class="modal-body">
					<form id="formTailInfo" method="post" action=""
						class="form-horizontal">
						<input type="hidden" name="id" id="update_id" />
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>姓名:</label>
							<div class="col-sm-3">
								<input class="form-control" id="tailName" name="name" readonly="readonly"></input> 
							</div>
							
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>性别:</label>
							<div class="col-sm-3">
								<select class='form-control' id="tailGender" name="gender" readonly="readonly">
									<option value="0">男</option>
									<option value="1">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
						 	<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>年龄：</label>
							<div class="col-sm-3">
								<input class='form-control' type="text" id="tailAge" name="age" readonly="readonly">
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>身份证号:</label>
							<div class="col-sm-3">
								<input class='form-control' type="text" name="cardNo" id="tailCardNo" maxlength="18" readonly="readonly">
							</div>
							
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>资格证生效日期:</label>
							<div class="col-sm-3">
								<input class="form-control" id="tailQualificationStart" name="qualificationStart" readonly="readonly"></input> 
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>资格证有效时长:</label>
							<div class="col-sm-3">
								<input class="form-control" name="qualificationLong" id="tailQualificationLong" type="number" style="width:120px;display:inline;" readonly="readonly"></input>&nbsp;&nbsp;&nbsp;个月
							</div>
						</div>
						<div class="form-group">

							
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>从业资格证编号:</label>
							<div class="col-sm-3">
								<input class="form-control" id="tailQualificationNo" name="qualificationNo" readonly="readonly"></input> 
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;' ></span>发证机构:</label>
							<div class="col-sm-3">
								<input class="form-control" name="grantOrganize" id="tailGrantOrganize" readonly="readonly"></input>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>培训签到记录表:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<input id="tailFile1" type="hidden" name="attendanceRecord">
								<span id="tailFileName1" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>培训资料:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<input id="tailFile2" type="hidden" name="materials">
								<span id="tailFileName2" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>考核材料:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<input id="tailFile3" type="hidden" name="examineMaterials">
								<span id="tailFileName3" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<!-- <button type="button" class="btn btn-primary"
								onclick="updateInfo();">提交更改</button> -->
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- BS ： 详情 END********************************************************************************* -->

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
		<form id="form5" name="form5" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file5" name="file5" type="file" onchange="upload_file_new('<%=basePath%>','5',$('#check_id option:selected').val())" />
		</form>
		<form id="form6" name="form6" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file6" name="file6" type="file" onchange="upload_file_new('<%=basePath%>','6',$('#check_id option:selected').val())" />
		</form>
	</div>
<!-- 上传图片END -->
</body>
<script type="text/javascript">
	$("#insertModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalUpdateRadiationSource").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalSelfUser").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
</script>
</html>
