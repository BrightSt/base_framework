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
<script src="<%=basePath%>resources/js/bootstrap/fileUpload.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/jquery.form.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/center-loader.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-treeview.min.js"></script>

<script src="<%=basePath%>resources/js/business/UserInfoManager.js"></script>
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
			<li class="active">用户管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-right: 10px;">
				</div>
				<div class="form-group" style="margin-right: 20px;">
					用户账号: <input id="userName" class="form-control" style="width: 150px;" maxlength="25">
				</div>
				<div class="form-group" style="margin-right: 20px;">
					用户状态: <select
						id="statusId" class="form-control" name="status"
						style="width: 200px;">
						<option value="">全部</option>
						<option value="0">正常</option>
						<option value="1">冻结</option>
					</select> 
				</div>
				<div class="form-group" style="margin-right: 10px;">
		 企业名称: <select id='companyCodeId' class="form-control"
						name="companyCode" style="width: 200px;">
							<c:if test="${companys.size()>0 }">
								<option value="">--请选择--</option>
							</c:if>
							<c:forEach items="${companys }" var='company'>
								<option value='${company.code }'>${company.name}</option>
							</c:forEach>

					</select>
				</div>
				<div class="form-group" style="margin-right: 10px;">
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
				<div class="form-group" style="margin-right: 10px;">
					<a data-toggle="modal" href="<%=basePath%>userInfo/toInsertInfo.do"
						data-target="#insertModal" type="button" class="btn btn-info"><span
						class="glyphicon glyphicon-plus"></span>&nbsp;新增</a>
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

	<!-- 模态框（Modal） 修改  -->
	<div class="modal fade" id="myModalUpdateUser" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">修改用户信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateUserInfo" method="post" action=""
						class="form-horizontal">
						<input type="hidden" name="id" id="update_id" />
						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户账号:</label>
							<div class="col-sm-4">
								<input class="form-control" id="userNameId" name="userName" readonly></input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户姓名:</label>
							<div class="col-sm-4">
								<input class="form-control" id="nameId" name="name"></input>
							</div>
						</div>
						<div class="form-group">

							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>所属单位:</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="company_id" name="companyCode" readonly="readonly"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户状态:</label>
							<div class="col-sm-4">
								<select type="text" class="form-control" id="statusIdEdit" name="status">
									<option value="0">正常</option>
									<option value="1">冻结</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="updateUserInfo();">提交更改</button>
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
					<h4 class="modal-title" id="myModalUpdate">用户详情信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateUserInfo" method="post" action=""
						class="form-horizontal">
						<table cellpadding="5" align="center"
							style="border-collapse: separate; border-spacing: 10px;">

							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户账号:</td>
								<td><input class="form-control" type="text" id="morecode"
									name="code" data-options="required:true" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户名称:</td>
								<td><input class="form-control" type="text" name="name"
									id="morename" maxlength="25" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户密码:</td>
								<td><input class="form-control" type="text"
									id="morepassword" name="password" data-options="required:true"
									disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>用户类型:</td>
								<td><select class="form-control" type="text" name="type"
									id="moretype" maxlength="25" disabled></select></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>所属市:</td>
								<td><input class="form-control" type="text" id="morecity"
									name="city" data-options="required:true" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>所属县:</td>
								<td><input class="form-control" type="text" name="district"
									id="moredistrict" maxlength="25" disabled></input></td>
							</tr>
							<tr>
								<td id="dominationTypeIdTd1"><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>环保局所属级别:</td>
								<td id="dominationTypeIdTd2"><input class="form-control"
									type="text" id="dominationTypeId" name="dominationType"
									data-options="required:true" disabled></input></td>
								<td id="moreindustryTd"><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>行业别:</td>
								<td id="moreindustryTd2"><input class="form-control"
									type="text" id="moreindustry" name="industry"
									data-options="required:true" disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>负责人:</td>
								<td><input class="form-control" type="text"
									name="in_charge" id="morein_charge" maxlength="25" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>联系人电话:</td>
								<td><input class="form-control" type="text"
									id="morecontact_telephone" name="contact_telephone"
									data-options="required:true" disabled maxlength="11"></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>状态:</td>
								<td><select class="form-control" name="UI_STATUS"
									id="moreuistatus" disabled>
								</select></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>用户地址:</td>
								<td><input class="form-control" type="text"
									id="moreaddress" name="address" data-options="required:true"
									disabled></input></td>

							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>描述:</td>
								<td><input class="form-control" type="text" name="remark"
									id="moreremark" maxlength="25" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>注册日期:</td>
								<td><input class="form-control" type="text"
									name="register_time" id="moreregister_time" maxlength="25"
									disabled></input></td>
							</tr>

							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>建立日期:</td>
								<td><input class="form-control" type="text"
									name="createtime" id="morecreatetime" maxlength="25" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>更改日期:</td>
								<td><input class="form-control" type="text"
									id="moreupdatetime" name="updatetime"
									data-options="required:true" disabled></input></td>

							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>用户传真:</td>
								<td><input class="form-control" type="text" id="morefax"
									name="fax" data-options="required:true" disabled maxlength="11"></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>联系人邮箱:</td>
								<td><input class="form-control" type="text"
									name="contact_email" id="morecontact_email" maxlength="25"
									disabled></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>联系地址:</td>
								<td><input class="form-control" type="text"
									id="morecontact_address" name="contact_address"
									data-options="required:true" disabled></input></td>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>联系人名称:</td>
								<td><input class="form-control" type="text"
									name="contact_person" id="morecontact_person" maxlength="25"
									disabled></input></td>
							</tr>
							<tr>

								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>企业电话:</td>
								<td><input class="form-control" type="text"
									name="telephone_number" id="moretelephone_number"
									maxlength="11" disabled></input></td>
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

	<!-- 模态框 角色分配 start -->

	<div class="modal fade" id="roleConfModal" tabindex="-1" role="dialog"
		aria-labelledby="roleConfModal" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">用户角色配置</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" name="userid" id="userid" />
					<div id="searchTree"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary"
						onclick="insertRoleInfo();">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框 角色分配 end -->

</body>
<script type="text/javascript">
	$("#insertModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalUpdateUser").on("hide.bs.modal", function() {
		 /*  $(':input','#formupdateUserInfo')    
		   .not(':button, :submit, :reset, :hidden')    
		   .val('')    
		   .removeAttr('checked')    
		   .removeAttr('selected'); */
	});
</script>
</html>
