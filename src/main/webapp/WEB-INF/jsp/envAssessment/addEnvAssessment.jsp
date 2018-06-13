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
 <script type="text/javascript"
	src="<%=basePath%>resources/easyui/jquery.min.js"></script>
<script src="<%=basePath%>resources/js/bootstrap/jquery.form.js"
	type="text/javascript"></script>
	<script src="<%=basePath%>resources/js/bootstrap/center-loader.js"></script>
<script src="<%=basePath%>resources/js/business/addEnvAssessment.js"></script>
 <script src="<%=basePath%>resources/js/bootstrap/rectifyReportFileUpload.js"
	type="text/javascript"></script>

</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">提交环评申请</h4>
	</div>
	<div class="modal-body">
		<form id="formInsertInfo" method="post" action=""
			class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>项目信息:</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="4" cols="50" name="projectInfo"></textarea>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>环境信息:</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="4" cols="50" name="envInfo"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>环评内容:</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="4" cols="50" name="content"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>有效期至：</label>
				<div class="col-sm-5">
					<input class="form-control" name="validateDate" id="validateDateId"></input>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>委托第三方企业名称：</label>
				<div class="col-sm-5">
					<input type="text" class='form-control' name='thirdCompanyName'></input>
				</div>
			</div>

			<div class="form-group">
				<div style=" ;">
						<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
						<!-- 记录所有附件名隐藏域 -->
						<a style="margin-top: 5px;margin-left: 16%;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
						<input id="uploadFileId1" name ="assessmentFile" type="hidden">
						<span id="uploadFileName1" style="color:#3c7897"></span>
				</div>
			</div>
		</form>

<!-- 上传图片END -->
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
</div>
<!-- 上传图片END -->
</body>
</html>
