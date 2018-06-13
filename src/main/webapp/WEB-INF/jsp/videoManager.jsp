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
	
<script src="https://open.ys7.com/sdk/js/1.3/ezuikit.js"></script>

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

<script src="<%=basePath%>resources/js/business/VideoInfoManager.js"></script>
<style type="text/css">
html, body {
	height: 100%;
	overflow: hidden;
}

body {
	margin: 0;
	background: url(resources/images/body.jpg) repeat;
}

.row-fluid thead {
	background: url(resources/images/toolbarbg.png) repeat-x #f3f3f3;/*liuxiaowei*/
}
.table_main {
	box-shadow: 0px 0px 4px 1px rgba(0, 0, 0, 0.1);
	-webkit-border-radius: 3px;
	background: #FFF;
	margin: 10px;
	overflow-y: auto;
}
</style>
<script type="text/javascript">
			$(document).ready(function() {
				$(window).resize(function() {
					var table_height = $(window).height();
					$(".table_main").height(table_height - 74); 
				});
				$(window).resize();
			});
</script>
</head>

<body>
	<div style="border-bottom: 1px solid #ccc; height: 34px;">
		<ol class="breadcrumb">
			<li><span class="glyphicon glyphicon-home"> 当前位置</span></li>
			<li class="active">监控点管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding: 10px 10px;" class="table_main">
		<div id="cond" style="margin-top: 10px;">
			<form class="form-inline" role="form">
				<div class="form-group" style="margin-right: 10px;">
		 所属企业名称: <select id='companyCodeId' class="form-control"
						name="companyCode" style="width: 200px;">
							<c:if test="${companys.size()>1 }">
								<option value="">--请选择--</option>
							</c:if>
							<c:forEach items="${companys }" var='company'>
								<option value='${company.code }'>${company.name}</option>
							</c:forEach>

					</select>
				</div>
				<button type="button" class="btn btn-warning" onclick="changeCompany();">
						<span class="glyphicon glyphicon-share"></span>更换企业
				</button>
				<div class="form-group" style="margin-right: 20px;">
					监控点位置信息: <input id="qaddressInfo" class="form-control" style="width: 150px;" maxlength="25">
				</div>
				<div class="form-group" style="margin-right: 20px;">
					监控用途: <input id="quseInfo" class="form-control" style="width: 150px;" maxlength="25">
				</div>
				<div class="form-group" style="margin-right: 10px;">
					<button type="button" class="btn btn-success" onclick="newInfo();">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
				<div class="form-group" style="margin-right: 10px;">
					<a data-toggle="modal" href="<%=basePath%>video/toInsertInfo.do"
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
					<h4 class="modal-title" id="myModalUpdate">修改监控点信息</h4>
				</div>
				<div class="modal-body">
					<form id="formupdateVideoInfo" method="post" action=""
						class="form-horizontal">
						<input type="hidden" name="id" id="update_id" />
						<div class="form-group">
							<label class="col-sm-3 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控点位置信息：</label>
							<div class="col-sm-8">
								<input class="form-control" id="addressInfoId" name="addressInfo"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控用途：</label>
							<div class="col-sm-8">
								<input class="form-control" id="useInfoId" name="useInfo"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>rtmp播放路径</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="rtmpInfoId" name="rtmpInfo"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label"><span
								style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>hls播放路径</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="hlsInfoId" name="hlsInfo"/>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								onclick="updateInfo();">提交更改</button>
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
					<h4 class="modal-title" id="myModalUpdate">监控点详情信息</h4>
				</div>
				<div class="modal-body">
					<form id="formUserInfo" method="post" action=""
						class="form-horizontal">
						<table cellpadding="5" align="center"
							style="border-collapse: separate; border-spacing: 10px;">
							<tr>
								<td><span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>所属企业名称:</td>
								<td><input class="form-control" type="text" id="moreCompanyCode" style="width:430px;"></input></td>
							</tr>
							<tr>
								<td><span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控点编码:</td>
								<td><input class="form-control" type="text" id="morepfkCode" style="width:430px;"></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控位置信息:</td>
								<td><input class="form-control" type="text" id="moreaddressInfo" style="width:430px;"></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'>*</span>监控用途信息:</td>
								<td><input class="form-control" type="text" name="useInfo" id="moreUseInfo" style="width:430px;"></input></td>
							</tr>
							<tr>
								<td><span style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>rtmp播放路径:</td>
								<td><input class="form-control" type="text" id="morertmpInfo" style="width:430px;"></input></td>
							</tr>
							<tr>
								<td><span
									style='color: red; font-size: 20px; position: relative; top: 7px; right: 2px; margin-left: -7px;'></span>hls播放路径:</td>
								<td><input class="form-control" type="text" name="district" id="morehlsInfo" style="width:430px;"></input></td>
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

	<style>
	 #mask {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        z-index: 15000;
        text-align: center;
      }
      .video3 {
    	/* margin-top: 100px; */
      }
      .coverClose {
		    position: absolute;
		    top: 8px;
		    right: 5px;
		    height: 43px;
		    width: 43px;
		    background: url(./resources/images/coverClose-9746a051d0.png) no-repeat;
		    cursor: pointer;
		}
	</style>
	<div id="mask" style="display: none;">
		<div style="background: url('<%=basePath%>resources/images/sp-1.gif') no-repeat center 10% #000000; background-size:260px; width:730px; margin:-360px 0 0 -360px; position:absolute; left:50%; top:50%;border:5px solid #5bc0de52; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;"><textarea id="url" placeholder="直播地址" hidden></textarea>
		<video id="myPlayer" class="video3" width="720px" poster="" controls playsInline webkit-playsinline autoplay>
		</video></div>
		<div class="coverClose" title="退出播放" onclick="closeMask()"></div>
	</div>
<!-- <div id="mask" style="display: none;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalUpdate">监控直播</h4>
		</div>
		<div class="modal-content" style="">
			
			<textarea id="url" placeholder="直播地址" hidden></textarea>
			<video id="myPlayer" poster="" controls playsInline webkit-playsinline autoplay>
			</video>
		</div>
</div> -->

	<!-- 弹出test end  -->


</body>
<script type="text/javascript">
	$("#insertModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#videoPlayModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	$("#myModalUpdateUser").on("hide.bs.modal", function() {
	});
</script>
</html>
