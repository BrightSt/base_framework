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
<script src="<%=basePath%>resources/js/business/addCompanyInfo.js"></script>

</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">新增企业信息</h4>
	</div>

	<div class="modal-body">
		<span style="font-size: 20px; padding-left: 45%;">基本信息</span><br />
		<form id="formInsertInfo" method="post" action=""
			class="form-horizontal">
			<div class="form-group" style="margin-top: 20px;">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业编码</label>
				<div class="col-sm-3">
					<input class="form-control" id="codeId" name="code"
						onblur="checkCode(this.value)"></input> <span id="tip"
						style='color: red;'></span>
				</div>
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业名称：</label>
				<div class="col-sm-3">
					<input class="form-control" id="nameId" name="name"></input>
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">简称</label>
				<div class="col-sm-3">
					<input class="form-control" id="shortNameId" name="shortName"></input>
				</div>

				<label class="col-sm-2 control-label">英文名：</label>
				<div class="col-sm-3">
					<input class="form-control" id="englishNameId" name="englishName"></input>
				</div>

			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>地址:</label>
				<div class="col-sm-8">
					<input class="form-control" name="address" id="addressId">
				</div>


			</div>
			<div class="form-group" style="margin-bottom: 20px;">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>类型：</label>
				<div class="col-sm-3">
					<select type="text" class="form-control" id="typeId" name="type">
						<option value="1">企业单位</option>
						<option value="0">环保单位</option>
					</select>
				</div>

				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>隶属关系：</label>
				<div class="col-sm-3">
					<select type="text" class="form-control" name="subjection"
						id="subjectionId">
						<option value="0">无</option>
						<c:forEach var="env" items="${envList}">
							<option value="${env.code }">${env.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-group" style="margin-bottom: 20px;">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>传真:</label>
				<div class="col-sm-3">
					<input class="form-control" id="faxId" name="fax"></input>
				</div>
			</div>
			<span style="font-size: 20px; padding-left: 45%;">联系方式</span><br />
			<div class="form-group" style="margin-top: 20px;">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>邮政编码:</label>
				<div class="col-sm-3">
					<input class="form-control" id="postCodeId" name="postCode"></input>
				</div>
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业电话：</label>
				<div class="col-sm-3">
					<input class="form-control" id="phoneId" name="phone"></input>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>邮箱:</label>
				<div class="col-sm-3">
					<input class="form-control" id="emailId" name="email"></input>
				</div>

				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>法定代表人:</label>
				<div class="col-sm-3">
					<input class="form-control" name="manager" id="managerId">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注:</label>
				<div class="col-sm-8">
					<textarea class="form-control" name="remark" rows="5" cols="80">
                	</textarea>
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
</body>
</html>
