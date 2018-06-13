<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
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
<!--判空验证  -->
<link rel="stylesheet" href="<%=basePath%>resources/css/bootstrap/bootstrapValidator.css" />
<script src="<%=basePath%>resources/js/bootstrap/bootstrapValidator.js"></script> 
<!-- 视频 -->
<script src="<%=basePath %>resources/js/business/selectCompany.js"></script>

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
<body >
	<div style="border-bottom: 1px solid #ccc;height: 34px;">
		<ol class="breadcrumb">
		  <li><span class="glyphicon glyphicon-home">  当前位置</span></li>
		  <li class="active">配置视频参数</li>
		</ol>
		<span style="position:absolute;top:10px;right:20px;" id ="time" class="glyphicon glyphicon-calendar"></span>
	</div>
	<!-- 增加弹框 -->
  	<div  class="modal fade" id="insertSysDataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   		<div  class="modal-dialog">
      		<div class="modal-content" style="width:500px;">
      			<form id="videoInsertForm" class="form-horizontal">
      			
    				<div style="margin:0 auto;width: 100%">
    					<div class="modal-header">
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">选择要查看的企业</h4>
      					</div>
      					  
					<div style="margin-top: 20px;">
      			   		<div class="form-group">
      							<label  class="col-sm-3 control-label">所属企业名称:</label> 
      						<div class="col-sm-7">
                    			<select id='companyCodeId' class="form-control" name="companyCode" style="width: 280px;">
									<c:if test="${companys.size()>1 }">
										<option value="">--请选择--</option>
									</c:if>
									<c:forEach items="${companys }" var='company'>
										<option value='${company.code }'>${company.name}</option>
									</c:forEach>
								</select>
                    		</div>
              			</div>
             		</div>  
    				<div style="text-align: center;margin-bottom: 30px;">
    					<a id="addInfoBtn" type="button" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;保存</a>
       					<!-- <a type="button" data-dismiss="modal" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; 取消</a> -->
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