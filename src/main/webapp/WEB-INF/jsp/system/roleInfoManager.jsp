<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.print(basePath);
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/easyui/themes/color.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/common.css">
<script type="text/javascript" src="<%=basePath%>resources/easyui/jquery.min.js"></script>
<script src="<%=basePath %>resources/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/js/mainControl.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/js/PublicTools.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/easyui/easyui-lang-zh_CN.js"></script>

<!-- bootstrap start -->
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/bootstrap/bootstrap.min.css">
<script type="text/javascript" src="<%=basePath %>resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/bootstrap/bootbox.js"></script>
<!-- bootstrap start -->

<!-- bootstrap 时间控件 start -->
<link href="<%=basePath %>resources/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>resources/datetimepicker/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<!-- bootstrap 时间控件 start -->

<!-- bootstrap table start -->
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap/bootstrap-table.min.css">
<script src="<%=basePath %>resources/js/bootstrap/bootstrap-table.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap/bootstrap-table-zh-CN.min.js"></script>
<!-- bootstrap table end -->
<!-- 上传图片 -->
<script src="<%=basePath %>resources/js/bootstrap/fileUpload.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/bootstrap/jquery.form.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/bootstrap/center-loader.js"></script>
<script src="<%=basePath %>resources/js/bootstrap/bootstrap-treeview.min.js"></script>

<script src="<%=basePath %>resources/js/business/RoleInfoManager.js"></script>
<style type="text/css">
	html, body { height:100%; overflow:hidden; }
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
<div style="border-bottom: 1px solid #ccc;height: 34px;">
	<ol class="breadcrumb">
	  <li><span class="glyphicon glyphicon-home">  当前位置</span></li>
	  <li class="active">角色管理</li>
	</ol>
	<span style="position:absolute;top:10px;right:20px;" id ="time" class="glyphicon glyphicon-calendar"></span>
</div>
<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
<div id="cond" style="margin-top: 10px;">
	<form class="form-inline" role="form">
		<div class="form-group" style="margin-left: 10px;">
			角色名称:
			<input id="name" class="form-control" style="width:150px;" maxlength="25">
			<button type="button" class="btn btn-success" onclick="newInfo();"><span class="glyphicon glyphicon-search"></span>查询</button>
			<button type="button" class="btn btn-info" onclick="addInfo();"><span class="glyphicon glyphicon-plus"></span>新增</button>
		</div>
	</form>
</div>
	<div class="row-fluid">
	   <table id="dt" cellspacing="0" width="100%"></table>
  	</div>
</div>
	<!-- 上传图片div -->
		<div style="display: none;">
			<form action='${pageContext.request.contextPath}/upload/uploadIO.do?time=1212' id="form2" name="form2" method="post" enctype="multipart/form-data" style="width: 100%;">
				<input id="file" name="file" type="file"/>
				<input type="submit" value="提交">
			</form>
		</div>
		<!-- 上传图片END -->

<!-- BS ： 修改********************************************************************************* -->
<!-- 模态框 新增 开始 -->
<div class="modal fade" id="myModalInsert" tabindex="-1" role="dialog"
   aria-labelledby="myModalInsert" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalInsert1">
               	新增角色信息
            </h4>
         </div>
         <div class="modal-body">
     			<form id="formInsertRoleInfo" method="post" action="" class="form-horizontal">
     				<input type="hidden" name="id" id="update_id"/>
     				<input id="huancun" type="hidden">
			    	<table cellpadding="5" align="center" style="border-collapse:   separate;   border-spacing:   10px;">

			    		<tr>
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>角色名称:</td>
			    			<td>
			    				<input class="form-control" type="text" id="insertname" name="name" data-options="required:true" onblur="checkName(this.value);"></input>
			    				<span style="font-weight: bold;color: red;"><div id="xianshi"></div></span>
			    			</td>
			    			
			    		</tr>
			    		<tr>
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>备注:</td>
			    			<td><input class="form-control" type="text" name="remark" id="insertremark" maxlength="25"></input></td>
			    		</tr>

			    	</table>
			    	<div class="modal-footer">
			            <button type="button" class="btn btn-default"
			               data-dismiss="modal">关闭
			            </button>
			            <button type="button" class="btn btn-primary" onclick="submitInfo();">
			               	保存
			            </button>
			         </div>
			    </form>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
<!-- 模态框 新增 结束 -->
<!-- 模态框（Modal） 修改  -->
<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog"
   aria-labelledby="myModalUpdate" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalUpdate1">
               	修改角色信息
            </h4>
         </div>
         <div class="modal-body">
     			<form id="formupdateUserInfo" method="post" action="" class="form-horizontal">
     				<input type="hidden" name="id" id="update_id"/>
     				<input id="huancun" type="hidden">
			    	<table cellpadding="5" align="center" style="border-collapse:   separate;   border-spacing:   10px;">

			    		<tr>
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>角色名称:</td>
			    			<td><input class="form-control" type="text" id="updatename" name="name" data-options="required:true"></input></td>
			    			<td><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>备注:</td>
			    			<td><input class="form-control" type="text" name="remark" id="updateremark" maxlength="25"></input></td>
			    		</tr>
			    	</table>
			    	<div class="modal-footer">
			            <button type="button" class="btn btn-default"
			               data-dismiss="modal">关闭
			            </button>
			            <button type="button" class="btn btn-primary" onclick="updateRoleInfo();">
			               	提交更改
			            </button>
			         </div>
			    </form>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
<!-- BS ： 修改********************************************************************************* -->

<!-- 模态框 菜单分配 start -->

<div class="modal fade" id="roleConfModal" tabindex="-1" role="dialog"
   aria-labelledby="roleConfModal" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalUpdate">
               	角色菜单配置
            </h4>
         </div>
         <div class="modal-body">
         		<input type="hidden" name="userid" id="roleid"/>
     			<div id="searchTree"></div> 
         </div>
         <div class="modal-footer">
			            <button type="button" class="btn btn-default"
			               data-dismiss="modal">关闭
			            </button>
			            <button type="button" class="btn btn-primary" onclick="insertMenuInfo();">
			               	保存
			            </button>
			         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<!-- 模态框 菜单分配 end -->
</body>
</html>
