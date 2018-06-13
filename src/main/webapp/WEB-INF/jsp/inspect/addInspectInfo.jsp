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
<script src="<%=basePath%>resources/js/business/addInspectInfo.js"></script>
<script src="<%=basePath%>resources/js/bootstrap/rectifyReportFileUpload.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">新增检查信息</h4>
	</div>
	<div class="modal-body">
		<form id="formInsertInfo" method="post" action=""
			class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>受检单位：</label>
				<div class="col-sm-7">
					<select class="form-control" name="inspectedEnterpriseNumber">
						<c:if test="${companys.size()>0 }">
							<option value="">--请选择--</option>
						</c:if>
						<c:forEach items="${companys }" var = "company">
							<option value="${company.code }">${company.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查单位名称：</label>
				<div class="col-sm-7">
					<select class="form-control" name="inspectEnterpriseNumber">
						<option value="${company.companyCode}">${company.name }</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查开始时间：</label>
				<div class="col-sm-7">
					<input class="form-control" id="inspectStartTimeId" name="inspectStartTime">
					</input>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>检查结束时间：</label>
				<div class="col-sm-7">
					<input class="form-control" id="inspectEndTimeId" name="inspectEndTime">
					</input>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>主题：</label>
				<div class="col-sm-7">
					<input type="text" class='form-control' name='title'></input>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>内容：</label>
				<div class="col-sm-7">
					<textarea rows="4" cols="50" class='form-control' name='content' autoFocus></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>结果：</label>
				<div class="col-sm-7">
					<select type="text" class="form-control" id="resultId" name="result">
							<option value=0>符合</option>
							<option value=1>不符合</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注：</label>
				<div class="col-sm-7">
					<textarea rows="4" cols="50" class="form-control" name="reason" autoFocus>
					</textarea>
				</div>
			</div>
			
		   <div class="form-group">
				<div class="col-sm-3" style="text-align:center;">
						<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;上传检测报告</a>
				</div>
				 <div class="col-sm-7">
				  	<!-- <input  name="fileUrl" class="imgUrl imgUrl1 form-control" value="" readonly="readonly"> -->
				  	<br>
				  	<input id="uploadFileId1" type="hidden" name="fileUrl">
				  	<span id="uploadFileName1" style="color:#3c7897"></span>
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
</div>
<!-- 上传图片END -->
</body>
</html>
