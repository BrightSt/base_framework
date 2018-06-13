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
	<!-- 上传照片新 -->
	<script src="<%=basePath %>resources/js/bootstrap/regulationsFileUpload.js" type="text/javascript"></script>
	<script src="<%=basePath %>resources/js/business/regulationsAdd.js"></script>
	<script src="<%=basePath %>resources/js/common.js"></script>
	<!--上传照片end -->
	<!--富文本框start  -->
        <link rel="stylesheet" href="resources/css/styles/icon.css"/>
		<!-- Ueditor编辑器CSS -->
		<link href="resources/css/styles/umeditor.min.css" type="text/css" rel="stylesheet">
		
  		<script type="text/javascript" src="resources/js/cookie_util.js"></script>
		<script type="text/javascript" src="resources/js/const.js"></script>	 
  		<script type="text/javascript" src="resources/js/edit.js"></script>
  		
	<!--富文本框end  -->
	
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
			<li><span class="glyphicon glyphicon-home">当前位置</span></li>
			<li class="active">通知公告管理</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div class="modal-body" style="overflow:scroll;height:100%;>
	<div style="padding: 10px 10px;" class="table_main"><!--liuxiaowei-->
		<aside class="side-right" id='third_side_right'>
					<!--- 标题 --->
					<div class="form-group" style="margin-left: 10px;">
						<span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>主题：
						<input type="text" class="form-control" style="width:750px; ;" id="addTitle" placeholder='主题...' maxlength="250">
					</div>
					<!--- 输入框 --->
					<div class="form-group" style="margin-left: 10px; ;" >
						<span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>文本内容：
						<script type="text/plain" id="myEditor" style="width:750px; ;"></script>
					</div>
					<!--- 输入框 --->
				</aside>
				<div class="form-group" style="margin-left: 10px;  ;">
					<span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>发布来源:
					<select type="text" class="form-control" id="createName" name="createName" style="width:17%;">
						<c:if test="${createName.size()>0}">
							<option value="">--请选择--</option>
						</c:if>
						<c:forEach var="cn" items="${createName}">
							<option value="${cn.number }">${cn.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group" style="margin-left: 10px; ;">
					
					<div style=" ;">
						点击按钮添加附件:&nbsp;&nbsp;&nbsp;&nbsp;
						<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
						<!-- 记录所有附件名隐藏域 -->
						<input id="uploadFileId" type="hidden">
						<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
						<span id="uploadFileName" style="color:#3c7897"></span>
					</div>
				</div>
				<!-- class="modal-footer" -->
				<div  style="margin-left:25%;">
			      <button type="button" class="btn btn-default" onclick="reback()">取消 </button>
			      <button type="button" class="btn btn-primary" onclick="saveInfo()">保存</button>
				</div>
		</div>
</div>
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
	//加载DOM之后处理页面高度
	function get_dom(e){
		return document.getElementById(e);
	}
	function set_height(){
		var pc_height=window.innerHeight;
		pc_height=pc_height-132;
		
		get_dom('third_side_right').style.height=20%;
		
	}
	function myEditorWidth(){
		var dom=get_dom('third_side_right');
		var style=dom.currentStyle||window.getComputedStyle(dom, null);
		get_dom('myEditor').style.width=style.width;
	}
	set_height();
	//改变窗口大小时调整页面尺寸
	window.onresize=function(){
		set_height();
		var width=$('#third_side_right').width()-35;
		$('.edui-container,.edui-editor-body').width(width);
		$('#myEditor').width(width-20);
	};
  </script> 
		<!-- Ueditor编辑器JS -->
		<script type="text/javascript" charset="utf-8" src="resources/js/ue/umeditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="resources/js/ue/umeditor.min.js"></script>
		<script type="text/javascript" src="resources/js/ue/lang/zh-cn.js"></script>
		
		<script type="text/javascript">
			//重写JS原生alert函数
				window.alert=function(e){
					$('#can').load('./alert/alert_error.html',function(){
						$('#error_info').text(' '+e);
						$('.opacity_bg').show();
						$('#can .close, #can .cancel')
						.click(function(){
							$('#can').empty();
							$('.opacity_bg').hide();
						});
					});
				}
			//实例化Ueditor编辑器
			var um = UM.getEditor('myEditor');
			//um.setContent("ABC");
		</script>
		<script type="text/javascript">
		var rootPath = getRootPath();
			//增加保存
			function saveInfo(){
				//无样式文本
				var bodyText=um.getContentTxt()+'';
				var flag = true;
				//检查通知公告名称
		       	var title=$('#addTitle').val();
		       	if(checkNullAndEmpty(title)){
		       		bootbox.alert("通知公告主题不能为空！");
		       		flag=false;
					return;    	
		       	}
		     //检查关键字
		       	var body=um.getContent();
		       	if(checkNullAndEmpty(body)){
		       		bootbox.alert("文本内容不能为空！");
		       		flag=false;
					return;    	
		       	}
		       	var createName = $("#createName").val();
		       	if(checkNullAndEmpty(createName)){
		       		bootbox.alert("发布来源不能为空！");
		       		flag=false;
					return;    	
		       	}
		       	//附件
		       	var url = $("#uploadFileId").val();
		       	if(url!=undefined){
		       		var fileUrl = url;
		       	}else{
		       		var fileUrl = '';
		       	}
		  		
		  		if(flag){
		  			$.commonReq({
		  				url : rootPath + "/notice/addRegs.do",
		  				async : true,
		  				data : {
		                	"body":body,
		                	"title":title,
		                	"fileUrl":fileUrl,
		                	"bodyText":bodyText,
		                	"createName":createName
		                },
		  				success : function(parame) {
		  					bootbox.alert('保存成功!');
		  					$('#myModalUpdateUser').modal('hide');
		  					window.location.href='<%=basePath%>notice/toNoticeInfoPage.do';
		  				},
		  				error : function(parame) {
		  					bootbox.alert('保存失败!');
		  				}
		  			});
		  			
		  		}
			}
		
			//取消编辑，返回
			function reback(){
				window.location.href='<%=basePath%>notice/toNoticeInfoPage.do';
			}
			
			
			
			
			 /*验证是否为空*/
		    function checkNullAndEmpty(value){
		    	if(value==null || value.trim()==''){
		    		return true;
		    	}else{
		    		return false;
		    	}
		    }
		  	//判断字符串是否为数字
		    function checkNumber(value){
		    	var re = /^[0-9]+.?[0-9]*$/; 
		     	if(null==value||''==value) {
		     		return false;
		     	}else if(!re.test(value)){
		     		return true;
		     	}else{
		     		return false;
		     	}
		     }
		</script>
</html>