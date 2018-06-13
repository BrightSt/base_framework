<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<script type="text/javascript" src="<%=basePath%>resources/easyui/jquery.min.js"></script>
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
<script src="<%=basePath%>resources/js/common.js"></script>
<script src="<%=basePath %>resources/js/business/systemDatamanger.js"></script>
<style type="text/css">
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
		  <li class="active">数据字典管理</li>
		</ol>
		<span style="position:absolute;top:10px;right:20px;" id ="time" class="glyphicon glyphicon-calendar"></span>
	</div>
	<div style="padding:10px 10px 0 10px;">
	<form class="form-inline" role="form">
	<input type="hidden"  name="remark" id="remark1"/>
		<div class="form-group">
	      	数据名称：
	      <input type="text" class="form-control"  id="viewName" style="width:150px;" maxlength="25">
	      &nbsp;
	      	字典备注：
	     <select   class="form-control"  style="width:150px"  id="viewRemark" ></select>
	      &nbsp;&nbsp;
          <button type="button" class="btn btn-success" id="search"><span class="glyphicon glyphicon-search"></span>&nbsp;查找</button>
          <a onclick="addSysDataInfo()" type="button" class="btn btn-warning" ><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>
	   </div>
	</form>
	<div style="margin-top: 10px;" class='rowFlow'>
	   <table id="dt" class="table table-condensed" cellspacing="0" width="100%"></table>
  	</div>
  </div>
  	<!-- 增加弹框 -->
  	<div  class="modal fade" id="insertSysDataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   		<div  class="modal-dialog">
      		<div class="modal-content" style="width:500px;">
      			<form id="addSysDataInfo" class="form-horizontal">
    				<input type="hidden" value="" name="remark" id="remark1" />
    				<div style="margin:0 auto;width: 90%">
    				<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title">增加数据字典信息</h4>
      				</div>
             		 <div class="form-group" style="margin-top: 20px">
      					<label  class="col-sm-3 control-label">字典类型备注:</label>
      					<div class="col-sm-7">
      						<select class="form-control" id="remark" name="remark"  style="width: 248px">
      						<option value="">-请选择-</option>
      						<c:if test="${data!=null }">
      							<c:forEach var="list" items="${data}">
      								<option value="${list.code}" >${list.remark}</option>
      							</c:forEach>
      						</c:if>
				    		</select>
                    	</div>
             	 </div>
            	 <div style="margin-top: 20px;">
      			    <div class="form-group">
      					<label  class="col-sm-3 control-label">数据名称:</label>
      					<div class="col-sm-7">
                    		<input class="form-control" name="name" id="sddName" maxlength="25px"></input>
                    	</div>
              		</div>
             </div>
    	</div>
    	<div style="text-align: center;margin-bottom: 30px;">
    	<a id="save" type="button" class="btn btn-success" ><span class="glyphicon glyphicon-ok"></span>&nbsp;保存</a>
        <a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 取消</a>
    	</div>
   </form>
      		</div>
   		</div>
	</div>
	
	
	<!-- 修改弹框 -->
  	<div  class="modal fade" id="updateSysDataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   		<div  class="modal-dialog">
      		<div class="modal-content" style="width:500px;" id="updateSysDataModalDiv">
      			<form id="updateSysInfoForm" class="form-horizontal">
      			
    				<div style="margin:0 auto;width: 90%">
    					<div class="modal-header">
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        				<h4 class="modal-title">修改字典信息</h4>
      					</div>
      						<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">数据编号:</label>
      							<div class="col-sm-7">
                    				<input class="form-control" value="" name="number" id="updateNumber" readonly="readonly"></input>
                    				<input style="display: none;" name="id" id="updateId"/>
                    			</div>
              				</div>
             		</div>
             		<div style="margin-top: 20px;">
      			   		<div class="form-group">
      						<label  class="col-sm-3 control-label">字典代码:</label>
      						<div class="col-sm-7">
                    			<input class="form-control" value="" name="code" id="updateCode" readonly="readonly"></input>
                    		</div>
              			</div>
             		</div>
             		<div style="margin-top: 20px;">
      			   		<div class="form-group">
      						 <div class="col-xs-3"  style="text-align: right">
					    		<span style='color:red;font-size:20px;position:relative;top:7px;right:2px'>*</span><label class="control-label rowTxt " for="title" >数据名称:</label>
						</div>	
      					<div class="col-sm-7">
                    		<input class="form-control" value="" name="name" id="updateName" maxlength="25px"></input>
                    	</div>
              			</div>
             		</div>
             				<div style="margin-top: 20px;">
      			   				<div class="form-group">
      								<label  class="col-sm-3 control-label">字典备注:</label>
      								<div class="col-sm-7">
                    					<input class="form-control" value="" name="remark"  id="updateRemark" readonly="readonly"></input>
                    				</div>
              					</div>
              				</div>
    				</div>
    					<div style="text-align: center;margin-bottom: 30px;">
    					<a id="updateSysInfoBtn" type="button" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;保存</a>
       					 <a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 取消</a>
    				</div>
  				 </form>
      		</div>
   		</div>
	</div>
</body>
<script type="text/javascript">
$("#insertSysDataModal").on("hidden.bs.modal", function() {
	$(this).removeData("bs.modal");  
});
$("#updateSysDataModal").on("hidden.bs.modal", function() {
	$(this).removeData("bs.modal");  
});
</script>
</html>