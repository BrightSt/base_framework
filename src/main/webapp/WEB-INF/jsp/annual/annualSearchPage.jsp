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

<script src="<%=basePath %>resources/js/bootstrap/annualFileUpload.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/business/annualUpdate.js"></script>
<script src="<%=basePath %>resources/js/business/annualSearchPage.js"></script>
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
			<li class="active">历年评估文件查询</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
					
				<div class="form-group" style="margin-left: 10px;">
					公司名称:
					<select type="text" class="form-control" id="searchUserName" name="searchName" style="width:250px;"maxlength="30">
		     			<c:if test="${nameList.size()>1}">
	      					<option value="">--请选择--</option> 
	      				</c:if>
	      				<c:forEach items="${nameList}" var="list">
 							<option value="${list.code}">${list.name}</option>
						</c:forEach> 
		      		</select>
					&nbsp;&nbsp; 报告标题: <input id="headNameId" class="form-control" style="width: 150px;" maxlength="25"> 
					&nbsp;&nbsp; 报告年份：<input id="headYearId" name="year" class="form-control" style="width: 150px;" >
				</div>
				<div class="form-group" style="margin-left: 10px;">
					<button type="button" class="btn btn-success" onclick="searchBtn();"><span class="glyphicon glyphicon-search"></span>查询</button>
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
	<div class="modal fade" id="myModalUpdate" tabindex="-1"
		role="dialog" aria-labelledby="myModalUpdate" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog" style="margin-left: 20%;">
			<div class="modal-content" style="width:900px;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalUpdate">修改评估文件</h4>
				</div>
				<div class="modal-body">
		<form id="formUpdateInfo" method="post" action="" class="form-horizontal">
              <input id="updateId" type="hidden" name="id">
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>文件标题：</label>
                <div class="col-sm-6">
                	<input id="updateFileName" name="fileName" class="form-control" maxlength="25">
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>年份：</label>
                <div class="col-sm-6">
					<input id="updateYearId" name="year" class="form-control" maxlength="25" >
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>内容简述：</label>
                <div class="col-sm-6">
                	<textarea rows="5" cols="6" id="updateResume" name="resume" style="width:418px;"></textarea>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>备注：</label>
                <div class="col-sm-6">
                	<input type="text" class="form-control" id="updateRemarks" name="remarks" >
                	</input>
                </div>
               </div> 
                <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>附件：</label>
                <div class="col-sm-6">
                	<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
						<!-- 记录所有附件名隐藏域 -->
						<input id="uploadFileId" type="hidden">
						<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
						<span id="uploadFileName" style="color:#3c7897"></span>
                </div>
              </div>
            </form>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" onclick="saveUpdateInfo();">保存</button>
		</div>
		<!-- /.modal -->
	</div>
	</div>
	</div>
	</div>
	<!-- BS ： 修改********************************************************************************* -->

<!-- BS:自行利用********************************************************************start -->


	<!-- 详情modal start -->
	<div class="modal fade" id="myModalSearch" tabindex="-1"
		role="dialog" aria-labelledby="myModalSearch" aria-hidden="true"
		style="overflow-y: scroll">
		<div class="modal-dialog" style="margin-left: 20%;">
			<div class="modal-content" style="width:900px;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalSearch">评估文件详情</h4>
				</div>
				<div class="modal-body">
		<form id="formUpdateInfo" method="post" action="" class="form-horizontal">
               <input id="searchId" type="hidden" name="id">
               <input id="status" type="hidden" name="status">
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>文件标题:</label>
                <div class="col-sm-6">
                	<input id="searchFileName" name="fileName" class="form-control" maxlength="50" readonly="true">
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>年份:</label>
                <div class="col-sm-6">
					<input id="searchYearId" name="year" class="form-control" maxlength="25"  readonly="true">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>内容简述:</label>
                <div class="col-sm-6">
                	<textarea rows="5" cols="6" id="searchResume" name="resume" style="width:418px;" readonly="true"></textarea>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>备注:</label>
                <div class="col-sm-6">
                	<input type="text" class="form-control" id="searchRemarks" name="remarks" readonly="true">
                	</input>
                </div>
               </div> 
                <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>附件:</label>
                <div class="col-sm-6">
                	<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
						<!-- 记录所有附件名隐藏域 -->
						<input id="uploadFileId" type="hidden">
						<span id="searchUploadFileName" style="color:#3c7897"></span>
                </div>
              </div>
            </form>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" id="submitBtn" class="btn btn-primary" onclick="submitInfo();">提交</button>
		</div>
		<!-- /.modal -->
	</div>
	</div>
	</div>
	</div>
	<!-- 详情modal end -->

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
	$("#myModalUpdateRadiationSource").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalSelfUser").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
</script>
</html>
