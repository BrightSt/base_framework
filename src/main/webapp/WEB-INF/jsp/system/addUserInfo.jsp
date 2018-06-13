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
<script src="<%=basePath%>resources/js/business/addUserInfo.js"></script>

</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">新增用户信息</h4>
	</div>
	<div class="modal-body">
		<form id="formInsertInfo" method="post" action=""
			class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户账号:</label>
				<div class="col-sm-4">
					<input class="form-control" name="userName"
						onblur="checkUserName(this.value)"></input> <span id="tip"
						style='color: red;'></span>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户姓名:</label>
				<div class="col-sm-4">
					<input class="form-control" name="name"></input> <span id="tip"
						style='color: red;'></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户密码:</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="passwordId"
						name="password"></input>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>确认密码:</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="passwordIdConf"
						name="passwordConf" onblur="checkPassword(this.value);"></input>
				</div>
			</div>
			<div class="form-group">

				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>所属单位:</label>
				<div class="col-sm-4">
					<select type="text" class="form-control" id="company_code" name="companyCode" style="width:100%;">
						<c:if test="${companys.size()>0}">
							<option value="">--请选择--</option>
						</c:if>
						<c:forEach var="company" items="${companys}">
							<option value="${company.code }">${company.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-4 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户状态:</label>
				<div class="col-sm-4">
					<select type="text" class="form-control" id="statusId"
						name="status">
						<option value="0">正常</option>
						<option value="1">冻结</option>
					</select>
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
