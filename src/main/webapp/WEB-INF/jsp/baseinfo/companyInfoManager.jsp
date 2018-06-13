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
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-table.min.js"></script>
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

<script src="<%=basePath%>resources/js/business/companyInfoManager.js"></script>
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
			<li class="active">企业资料管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-left: 10px;">
					企业编码: <input id="codeId" class="form-control" style="width: 150px;"
						maxlength="25"> 企业名称: <input id='nameId'
						class="form-control" name="companyCode" style="width: 200px;">
					</input>
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
					<a data-toggle="modal"
						href="<%=basePath%>companyInfo/toInsertInfo.do"
						data-target="#insertModal" type="button" class="btn btn-info"><span
						class="glyphicon glyphicon-plus"></span>&nbsp;新增</a>
				</div>
			</form>
		</div>
		<!-- 增加弹框 -->
		<div class="modal fade" id="insertModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog" style="margin-left: 20%;">
				<div class="modal-content" style="width: 900px;"></div>
			</div>
		</div>
		<!-- 增加弹框 End -->
		<div class="row-fluid">
			<table id="dt" cellspacing="0" width="100%"></table>
		</div>
	</div>
	<!-- 上传图片div -->
	<div style="display: none;">
		<form
			action='${pageContext.request.contextPath}/upload/uploadIO.do?time=1212'
			id="form2" name="form2" method="post" enctype="multipart/form-data"
			style="width: 100%;">
			<input id="file" name="file" type="file" /> <input type="submit"
				value="提交">
		</form>
	</div>
	<!-- 上传图片END -->

	<!-- BS ： 修改********************************************************************************* -->

	<!-- 模态框（Modal） 修改start  -->
	<div class="modal fade" id="myModalUpdateUser" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog" style="width: 900px; margin-left: 20%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">修改企业信息</h4>
				</div>
				<div class="modal-body">
					<span style="font-size: 20px; padding-left: 45%;">基本信息</span><br />
					<form id="formInsertInfo" method="post" action=""
						class="form-horizontal">
						<input name="id" id="update_id" hidden>
						<div class="form-group" style="margin-top: 20px;">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业编码</label>
							<div class="col-sm-3">
								<input class="form-control" id="EditCode" name="code"
									onblur="checkCode(this.value)" readonly></input> <span id="tip"
									style='color: red;'></span>
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业名称：</label>
							<div class="col-sm-3">
								<input class="form-control" id="editName" name="name"></input>
							</div>

						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">简称</label>
							<div class="col-sm-3">
								<input class="form-control" id="editShortName" name="shortName"></input>
							</div>

							<label class="col-sm-2 control-label">英文名：</label>
							<div class="col-sm-3">
								<input class="form-control" id="editEnglishName"
									name="englishName"></input>
							</div>

						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>地址:</label>
							<div class="col-sm-8">
								<input class="form-control" name="address" id="editAddress">
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 20px;">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>类型：</label>
							<div class="col-sm-3">
								<select type="text" class="form-control" id="editType"
									name="type">
									<option value="1">企业单位</option>
									<option value="0">环保单位</option>
								</select>
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>隶属关系：</label>
							<div class="col-sm-3">
								<select type="text" class="form-control" name="subjection"
									id="editSubjection">
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
								<input class="form-control" id="editFax" name="fax"></input>
							</div>
						</div>
						<span style="font-size: 20px; padding-left: 45%;">联系方式</span>
						<div class="form-group" style="margin-top: 20px;">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>邮政编码:</label>
							<div class="col-sm-3">
								<input class="form-control" id="editPostCode" name="postCode"></input>
							</div>
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业电话：</label>
							<div class="col-sm-3">
								<input class="form-control" id="editPhone" name="phone"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>邮箱:</label>
							<div class="col-sm-3">
								<input class="form-control" id="editEmail" name="email"></input>
							</div>

							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>法定代表人:</label>
							<div class="col-sm-3">
								<input class="form-control" name="manager" id="editManager">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注:</label>
							<div class="col-sm-8">
								<textarea class="form-control" id="editRemark" name="remark"
									rows="5" cols="80">
          						</textarea>
							</div>
						</div>
					</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary"
							onclick="updateCompanyInfo();">提交更改</button>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- BS ： 修改end********************************************************************************* -->

	<!-- 详情modal start -->
	<div class="modal fade" id="myModalMore" tabindex="-1" role="dialog"
		aria-labelledby="myModalMore" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">企业详情信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateUserInfo" method="post" action=""
						class="form-horizontal">
						<table cellpadding="5" align="center"
							style="border-collapse: separate; border-spacing: 10px;">

							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业编码:</td>
								<td><input class="form-control" type="text" id="morecode"
									name="code" data-options="required:true" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>企业名称:</td>
								<td><input class="form-control" type="text" name="name"
									id="morename" maxlength="25" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>简称:</td>
								<td><input class="form-control" type="text"
									id="moreShortName" name="password" data-options="required:true"
									disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>英文名:</td>
								<td><input class="form-control" type="text" name="type"
									id="moreEnglistName" maxlength="25" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>地址:</td>
								<td><input class="form-control" type="text"
									id="moreAddress" name="city" data-options="required:true"
									disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>类型:</td>
								<td><select class="form-control" type="text" name="type"
									id="moreType" maxlength="25" disabled></select></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>隶属关系:</td>
								<td><input class="form-control" type="text"
									id="moreSubjection" name="subjection"
									data-options="required:true" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>传真:</td>
								<td><input class="form-control" type="text" id="moreFax"
									name="fax" data-options="required:true" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>邮政编码:</td>
								<td><input class="form-control" type="text" name="postCode"
									id="morePostCode" maxlength="25" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>企业电话:</td>
								<td><input class="form-control" type="text" id="morePhone"
									name="phone" data-options="required:true" disabled
									maxlength="11"></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>邮箱:</td>
								<td><input class="form-control" name="email" id="moreEmail"
									disabled> </input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>法定代表人:</td>
								<td><input class="form-control" type="text"
									id="moreManager" name="manager" data-options="required:true"
									disabled></input></td>

							</tr>
							<tr>
								<td>备注:</td>
								<td colspan="3"><textarea class="form-control"
										id="moreRemark" name="remark" rows="5" cols="50" disabled>
                				</textarea></td>
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
</body>
<script type="text/javascript">
	$("#insertModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalUpdateUser").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
</script>
</html>
