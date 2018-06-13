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
	<script src="<%=basePath %>resources/js/business/regulationsUpdate.js"></script>
	<script src="<%=basePath %>resources/js/common.js"></script>
	<!--上传照片end -->
	
<style type="text/css">
html, body {
	height: 100%;
	overflow: hidden;
}

body {
	margin: 0;
}

#dt tr {
	height: 40px;
}

#dt td {
	vertical-align: middle;
}

#dt input[type=checkBox] {
	height: 16px;
	width: 16px;
	vertical-align: middle;
}

.row-fluid thead {
	background-color: #f5f5f5;
}

.div-a {
	float: left;
	width: 100%;
	border: 0px solid #000;
	height: 100%;
	overflow: hidden;
}
#insertEnterpriseForm3 tr{height: 40px;}
</style>
</head>

<body>
	<div style="border-bottom: 1px solid #ccc; height: 34px;">
		<ol class="breadcrumb">
			<li><span class="glyphicon glyphicon-home">当前位置</span></li>
			<li class="active">管理制度查询</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div class="row-fluid">
			<table id="dt" cellspacing="0" width="100%"></table>
		</div>
	</div>
<script type="text/javascript">
var rootPath = getRootPath();
//下拉框悬停显示选择项
$('#viewShen').width(150);
$('#viewShen').hover(function(){
	$(this).attr('title',$(this).find(':selected').text());
});
$('#viewShi').width(150);
$('#viewShi').hover(function(){
	$(this).attr('title',$(this).find(':selected').text());
});
$('#viewXian').width(150);
$('#viewXian').hover(function(){
	$(this).attr('title',$(this).find(':selected').text());
});
//搜索
var showHideIcon=$('.showHideIcon span');
var buttonGroupHead=$('.buttonGroupHead');
var buttonBool=true;
showHideIcon.click(function(){//显示隐藏效果
   if(buttonBool)
	   {
	     buttonGroupHead.animate({
	    	 top:'-75px'
	     },500);
	     showHideIcon.removeClass('glyphicon-circle-arrow-up').addClass('glyphicon-circle-arrow-down');
	   }
   else{
	   buttonGroupHead.animate({
	    	 top:'0'
	     },500);
	   showHideIcon.removeClass('glyphicon-circle-arrow-down').addClass('glyphicon-circle-arrow-up'); 
   }
   buttonBool=!buttonBool;
});

   
$(function(){
	/* //下拉搜素框
	var shi=$('#searchName');
	shi.selectpicker({
		noneSelectedText:'--请选择--',
		style:'btnSelect',
		width:'250px',
		liveSearch:true,
		liveSearchPlaceholder:'请输入法规名称查询',
		size:5
	}); */
	
	 	searchBtn();
  		/* $("input[name=btSelectAll]").attr("style","height:16px;width:16px;");
    	$("input[name=btSelectAll]").css("verticalAlign","middle"); */
  	});
  	
  	
  	
  	function searchBtn(){
  		debugger;
  		var localhostPath = getRootPath1();
  		$('#dt').bootstrapTable('destroy');
  		$('#dt').bootstrapTable({
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			url:'<%=basePath%>regulatory/total.do',
		    striped: true,      //是否显示行间隔色
		    cache: false,      //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
		    pagination: true,
		    queryParamsType:'', //默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
		                        // 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber
		    queryParams:queryParams,
		    singleSelect: false,
		    pageSize: basePage.pageSize,
		    pageList: basePage.pageList,
		    search: false, //不显示 搜索框
		    showColumns: false, //不显示下拉框（选择显示的列）
		    sidePagination: "server", //服务端请求
		    clickToSelect: true,    //是否启用点击选中行
		    columns: [
		    	{
                    field: 'Number',
                    title: '行号',
                    width:'1px',
                    formatter: function (value, row, index) {
                        return index+1;
                    },
                    width:50
				 },
            {
		    	field:'id',
		    	visible:false
		    },{
		    	field: 'userNameStr',
		        title: '企业名称',
                valign:'middle'
		    },{
		    	field: 'uploadNumber',
		        title: '已上传制度文档数',
                valign:'middle'
		    },{
		    	field: '',
		        title: '详情',
                valign:'middle',
                formatter:function(value,data,index){
                	var str = '<button style="margin-top: 5px;" onclick="searchRegulations(\''+data.userName+'\');" type="button" class="btn btn-info btn-xs" style="margin-right:10px;">查看详情</button>';
                	return str;
            	}
		    }  
		    ],
		    onLoadSuccess:function(){},
		    onLoadError: function () {
		    }
		});
  	}
  	
  	
  	function queryParams(params){
  		var temp = {
  			pageSize:params.pageSize,
  			pageNumber:params.pageNumber,
  			userCode:$('#searchName option:selected').val(),
  			type:$('#searchType option:selected').val()
  		};
  		$("#searchTitle").val('');
  		return temp;
  	}
 	
  	function searchRegulations(userName){
  		 window.location.href="<%=basePath%>/regulatory/toSearchPage.do?userCode="+userName;
  		 
  	}
  	</script>	
</html>
