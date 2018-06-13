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
<script src="<%=basePath%>resources/js/business/addEmployeeTraining.js"></script>
<script src="<%=basePath %>resources/js/bootstrap/trainingFileUpload.js" type="text/javascript"></script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">新增从业人员信息</h4>
	</div>
	<div class="modal-body">
		<form id="formInsertInfo" method="post" action=""
			class="form-horizontal">
						<input type="hidden" name="id" id="addid" />
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>姓名:</label>
							<div class="col-sm-3">
								<input class="form-control" id="addName" name="name"></input> 
							</div>
							
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>性别:</label>
							<div class="col-sm-3">
								<select class='form-control' id="addGender" name="gender">
									<option value="0">男</option>
									<option value="1">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
						 	<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>年龄：</label>
							<div class="col-sm-3">
								<input class='form-control' type="text" id="addAge" name="age">
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>身份证号:</label>
							<div class="col-sm-3">
								<input class='form-control' type="text" name="cardNo" id="addCardNo" maxlength="18;" ">
							</div>
							
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>资格证生效日期:</label>
							<div class="col-sm-3">
								<input class="form-control" id="addQualificationStart" name="qualificationStart"></input> 
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px; '>*</span>资格证有效时长:</label>
							<div class="col-sm-3">
								<input class="form-control" style="width:120px;display:inline;" name="qualificationLong" id="addQualificationLong" type="number"></input>&nbsp;&nbsp;&nbsp;个月
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>从业资格证编号:</label>
							<div class="col-sm-3">
								<input class="form-control" id="addQualificationNo" name="qualificationNo"></input> 
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>发证机构:</label>
							<div class="col-sm-3">
								<input class="form-control" name="grantOrganize" id="addGrantOrganize"></input>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>培训签到记录表:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
								<input id="addFile1" type="hidden" name="attendanceRecord">
								<span id="addFileName1" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>培训资料:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<a style="margin-top: 5px;" onclick="upload('2');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
								<input id="addFile2" type="hidden" name="materials">
								<span id="addFileName2" style="color:#3c7897"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>考核材料:</label>
							<div class="col-sm-8">
								<!-- 记录所有附件名隐藏域 -->
								<a style="margin-top: 5px;" onclick="upload('3');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
								<input id="addFile3" type="hidden" name="examineMaterials">
								<span id="addFileName3" style="color:#3c7897"></span>
							</div>
						</div>

		</form>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭
			</button>
			<button type="button" class="btn btn-primary" onclick="submitInfo();">
				保存</button>
		</div>
	</div>
	<!-- 模态框 新增 结束 -->
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
	</div>
<!-- 上传图片END -->
</body>
</html>
