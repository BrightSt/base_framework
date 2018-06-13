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

<script src="<%=basePath%>resources/js/business/checkInfoManager.js"></script>
<script src="<%=basePath %>resources/js/bootstrap/regulationsFileUpload.js" type="text/javascript"></script>
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
			<li class="active">环评验收管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-left: 10px;">
				  申请企业: <select id='companyCodeId' class="form-control" style="width: 200px;">
							<c:if test="${companys.size()>1 }">
								<option value="">--请选择--</option>
							</c:if>
							
							<c:forEach items="${companys }" var='company'>
								<option value='${company.code }'>${company.name}</option>
							</c:forEach>
					</select>
					
					审批结果: <select id="approveResultId" class="form-control" 
						style="width: 200px;">
						<option value="">全部</option>
						<option value=0>通过</option>
						<option value=1>拒绝</option>
					</select> 
					
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
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

	<!-- BS ： 修改********************************************************************************* -->

	<!-- 模态框（Modal） 修改  -->
	<div class="modal fade" id="myModalUpdate" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">验收信息修改</h4>
				</div>
				<div class="modal-body">
					<form id="formInsertInfoCheck" method="post" action="" class="form-horizontal">
						<input id="update_id" type="hidden"/>
						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>项目规模:</label>
							<div class="col-sm-5">
								<input name="projectArea" id="projectAreaEdit" class="form-control"></input>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>项目地点:</label>
							<div class="col-sm-5">
								<input name="projectAddress" id="projectAddressEdit" class="form-control"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>计划投资:</label>
							<div class="col-sm-5">
								<input name="investment" id="investmentEdit" class="form-control"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>污染信息：</label>
							<div class="col-sm-5">
								<textarea rows="4" cols="33" name="pollution" id="pollutionEdit"></textarea>
							</div>
						</div>

						<div class="form-group">
							<div style=" ;">
									<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
									<!-- 记录所有附件名隐藏域 -->
									<input id="uploadFileId" name ="filePath" type="hidden">
									<a style="margin-top: 5px;margin-left: 16%;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
									<span id="uploadFileName" style="color:#3c7897"></span>
							</div>
						</div>

						<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								<button type="button" class="btn btn-primary" onclick="submitCheck();">保存</button>
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
					<h4 class="modal-title" id="myModalUpdate">验收详情信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateInspectInfo" method="post" action=""
						class="form-horizontal">
						<table cellpadding="5" align="center"
							style="border-collapse: separate; border-spacing: 10px;">
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>项目规模:
								</td>
								<td>
									<input name="projectArea" id="projectAreaMore" class="form-control"></input>
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>项目地点:
								</td>
								<td>
									<input name="projectAddress" id="projectAddressMore" class="form-control"></input>
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>计划投资:
								</td>
								<td>
									<input name="investment" id="investmentMore" class="form-control"></input>
								</td>
							</tr>
							<tr>
								<td>
									<span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>污染信息:
								</td>
								<td>
									<textarea rows="4" cols="33" name="pollution" id="pollutionMore"></textarea>
								</td>
							</tr>
							
						    <tr>
								<td><span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>附件:</td>
								<td>
										<div style=" ;" id="urlDiv2" type="hidden">
											<span id="uploadFileNameMore" style="color:#3c7897"></span>
										</div>
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
		</div>
	</div>
	<!-- 详情modal end -->

<!-- 模态框（Modal）提交整改  -->
	<div class="modal fade" id="approveModel" tabindex="-1"
		role="dialog" aria-labelledby="myModalSubmitReform" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalSubmit">验收审批</h4>
				</div>
				<div class="modal-body">
				<form id="formSubmitApprove" method="post" action=""
					class="form-horizontal">
					<input type="hidden" id="envId">
					<input type="hidden" id="approveId">
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>审批结果：</label>
						<div class="col-sm-5">
							<select name="approveResult" class="form-control" id="approveResultId">
								<option value="0">通过</option>
								<option value="1">拒绝</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注：</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="33" name='approveRemark' id="approveRemarkId"></textarea>
						</div>
					</div>
					<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="submitApprove();">保存</button>
				   </div>
				</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- BS ： 修改 提交整改********************************************************************************* -->

<!-- 模态框（Modal）提交整改  -->
	<div class="modal fade" id="approveModelInfo" tabindex="-1"
		role="dialog" aria-labelledby="myModalSubmitReform" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalSubmit">环评文件审批信息</h4>
				</div>
				<div class="modal-body">
				<form id="formSubmitApprove" method="post" action=""
					class="form-horizontal">
					<input type="hidden" id="envId">
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>审批结果：</label>
						<div class="col-sm-5">
							<select name="approveResult" class="form-control" id="approveResultIdMore">
								<option value="0">通过</option>
								<option value="1">拒绝</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label"><span
							style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>备注：</label>
						<div class="col-sm-5">
							<textarea rows="6" cols="33" name='approveRemark' id="approveRemarkIdMore"></textarea>
						</div>
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
			<input id="file1" name="file1" type="file" onchange="upload_img_new('<%=basePath%>','1',$('#check_id option:selected').val())" />
		</form>
		<form id="form2" name="form2" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file2" name="file2" type="file" onchange="upload_img_new('<%=basePath%>','2',$('#check_id option:selected').val())" />
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
</script>
</html>
