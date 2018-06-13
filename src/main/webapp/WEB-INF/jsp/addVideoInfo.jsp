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
<script src="<%=basePath%>resources/js/business/addVideoInfo.js"></script>

</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">新增监控点信息</h4>
	</div>
	<div class="modal-body">
		<form id="formInsertInfo" method="post" action=""
			class="form-horizontal">
			<!-- 0代表萤石云 -->
			<input type="hidden" name="type" id="videoType" value="0">
			<input type="hidden" name="systemFlag" id="systemFlag" value="0">  
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>所属单位</label>
				<div class="col-sm-8">
					<select type="text" class="form-control" id="company_code" name="companyCode" style="width:100%;">
						<c:if test="${companys.size()>1}">
							<option value="">--请选择--</option>
						</c:if>
						<c:forEach var="company" items="${companys}">
							<option value="${company.code }">${company.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控点编码</label>
				<div class="col-sm-8">
					<input class="form-control" name="pfkCode"></input> <span id="tip"
						style='color: red;'></span>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控位置信息</label>
				<div class="col-sm-8">
					<input class="form-control" name="addressInfo"></input> <span id="tip"
						style='color: red;'></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控用途信息</label>
				<div class="col-sm-8">
					<input class="form-control" name="useInfo"></input> <span id="tip"
						style='color: red;'></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>rtmp播放路径</label>
				<div class="col-sm-8">
					<input class="form-control" name="rtmpInfo"></input> <span id="tip"
						style='color: red;'></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><span
					style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>hls播放路径</label>
				<div class="col-sm-8">
					<input class="form-control" name="hlsInfo"></input> <span id="tip"
						style='color: red;'></span>
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
