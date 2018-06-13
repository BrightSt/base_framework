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
			<li class="active">管理制度</li>
		</ol>
		<span style="position: absolute; top: 10px; right: 20px;" id="time"
			class="glyphicon glyphicon-calendar"></span>
	</div>
	<div class="div-a">

		<div style="padding: 10px 10px 0 10px;">
			<div id="cond" style="margin-top: 10px;">
		<form class="form-inline" role="form">
			<div class="form-group">
			 &nbsp;&nbsp;&nbsp;&nbsp;文档类型：
		     <select class="form-control" style="width:250px;" id="searchType">
							<c:if test="${types.size()>1 }">
								<option value="">--请选择--</option>
							</c:if>
							<c:forEach items="${types }" var='type'>
								<option value='${type.number }'>${type.name}</option>
							</c:forEach>
						</select>
				 &nbsp;&nbsp;&nbsp;&nbsp;管理制度标题：
				 <input type="text" class="form-control" id="searchName" name="searchName" style="width:250px;"maxlength="30">
		      <%--
		      <select type="text" class="form-control" id="searchName" name="searchName" style="width:250px;"maxlength="30">
		     		<c:if test="${nameList.size()>1}">
	      				<option value="">--请选择--</option> 
	      			</c:if>
	      			<c:forEach items="${nameList}" var="list">
 						<option value="${list.title}">${list.title}</option>
					</c:forEach> 
		      </select> --%>
	        </div>
	        <div class="form-group" style="margin-left: 10px;">
	        	<button type="button" class="btn btn-success" onclick="searchBtn();"><span class="glyphicon glyphicon-search"></span>查询</button>
				<button type="button" class="btn btn-primary" onclick="addInfo();"><span class="glyphicon glyphicon-plus"></span>增加</button>
				<button type="button" class="btn btn-warning" onclick="updateInfo();"><span class="glyphicon glyphicon-edit"></span>修改</button>
           	 	<button type="button" class="btn btn-info" onclick="delInfo();"><span class="glyphicon glyphicon-remove"></span>删除</button>
			</div>
		</form>
	</div>
	<div class="row-fluid">
			<table id="dt" cellspacing="0" width="100%"></table>
		</div>
	</div>
</div>

<!-- BS ： 修改********************************************************************************* -->
<!-- 模态框（Modal） 修改  -->
<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog" 
   aria-labelledby="myModalUpdate2" aria-hidden="true" style="overflow-y:scroll">
   <div class="modal-dialog">
      <div class="modal-content" style="width:800px;height:95%;margin-left: -20%;margin-top:-25%; overflow:scroll;">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalUpdate3">
               	管理制度管理
            </h4>
         </div>
          <div class="modal-body">
          	<input type="hidden" name="id" id="updateId"/>
       		<aside class="side-right" id='third_side_right'>
					<!--- 文本类型--->
					<div class="form-group" style="margin-left: 10px;">
						<span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>文档分类：
						<select class="form-control" style="width:750px;" id="updateType">
							<c:if test="${types.size()>1 }">
								<option value="">--请选择--</option>
							</c:if>
							<c:forEach items="${types }" var='type'>
								<option value='${type.number }'>${type.name}</option>
							</c:forEach>
						</select>
					</div>
					<!--- 标题 --->
					<div class="form-group" style="margin-left: 10px;">
						<span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>标题：
						<input type="text" class="form-control" style="width:750px;" id="updateName" placeholder='标题...' maxlength="250">
					</div>
					<!--- 输入框 --->
					<div class="form-group" style="margin-left: 10px;">
						文本内容：
						<script type="text/plain" id="myEditor" style="width:750px;"></script>
					</div>
					<!--- 输入框 --->
				</aside>
				<!-- <div class="form-group" style="margin-left: 10px;">
					<span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'>*</span>关键字:
					<input class="form-control" type="text" id="updateTitle" placeholder="请输入通知公告关键字" name="title" data-options="required:true" >
					
				</div> -->
				<div class="form-group" style="margin-left: 10px;">
					
					<div style=" ;" id="urlDiv">
						点击按钮添加附件:&nbsp;&nbsp;&nbsp;&nbsp;
						<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
						<!-- 记录所有附件名隐藏域 -->
						<input id="uploadFileId" type="hidden">
						<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default" id="urlSuperA"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
						<span id="uploadFileName" style="color:#3c7897"></span>
					</div>
					<div style=" ;" id="urlDiv2" type="hidden">
						点击查看附件:&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="uploadFileName2" style="color:#3c7897"></span>
					</div>
				</div>
               		
            <div class="modal-footer">
			      <button type="button" class="btn btn-default" 
			           data-dismiss="modal">关闭
			      </button>
			      <button type="button" class="btn btn-primary" onclick="saveUpdateInfo()" id="saveUpdateBtn">
			              	保存
			      </button>
			</div>
		</form>
    	</div>
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
	//下拉搜素框
	/* var shi=$('#searchName');
	shi.selectpicker({
		noneSelectedText:'--请选择--',
		style:'btnSelect',
		width:'250px',
		liveSearch:true,
		liveSearchPlaceholder:'请输入管理制度标题查询',
		size:5
	}); */
	
	 	searchBtn();
  		$("input[name=btSelectAll]").attr("style","height:16px;width:16px;");
    	$("input[name=btSelectAll]").css("verticalAlign","middle");
  	});
  	
  	
  	
  	function searchBtn(){
  		
  		var localhostPath = getRootPath1();
  		$('#dt').bootstrapTable('destroy');
  		$('#dt').bootstrapTable({
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			url:'<%=basePath%>regulatory/findAllRegs.do',
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
		    	field:'',
		    	checkbox:true,
		    	valign: "middle"},
            {
		    	field:'id',
		    	visible:false
		    },{
		    	field: 'typeStr',
		        title: '管理制度类型',
                valign:'middle'
		    },{
		    	field: 'title',
		        title: '管理制度标题',
                valign:'middle'
		    },
		    {
		    	field: '',
		        title: '文本内容',
                valign:'middle',
                formatter:function(value,data,index){
                	var body = data.bodyText;
                	if(body!=''&&body.length>20){
                		body = body.substring(0,20)+'......'+'<a  onclick="searchRegulations(\''+data.id+'\');" type="button"  >[详情]</a>';
                	}
                	return body;
            	}
		    },{
		    	field: 'createTimeStr',
		        title: '上传时间',
                valign:'middle'
		    } ,{
		    	field: 'userName',
		        title: '上传单位',
                valign:'middle'
		    },{
		    	field: '',
		        title: '操作',
                valign:'middle',
                formatter:function(value,data,index){
                	var str = '<button  onclick="searchRegulations(\''+data.id+'\');" type="button"  class="btn btn-info btn-xs" style="margin-right:10px;">查看详情</button>';
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
  			title:$('#searchName').val(),
  			type:$('#searchType option:selected').val()
  		};
  		$("#searchTitle").val('');
  		return temp;
  	}
 //增加通知公告
 function addInfo(){
	 
	 window.location.href="<%=basePath%>regulatory/toAdd.do"
 }
//删除
function delInfo(){
	var ids = getSelectionsStr();
		if(ids==""){
			bootbox.alert('请选择你要删除的数据！');
		}else{
			bootbox.confirm("您确定要删除该数据吗？",function(result){
   			if(result){
   				$.commonReq({
	  				url : rootPath + "/regulatory/deleteRegs.do",
	  				async : true,
	  				data : {"ids":ids},
	  				success : function(parame) {
	  					bootbox.alert( "删除成功！");
                   	 	window.location.href='<%=basePath%>regulatory/toRegulatoryRegimePage.do';
	  				},
	  				error : function(parame) {
	  					bootbox.alert('服务器请求失败!');
	  				}
	  			});
   				
   			}
	       });
   }
}
	
 //修改通知公告
 	function updateInfo(){
 		$('#saveUpdateBtn').show();
 		$('#urlDiv2').hide();
 		$('#urlDiv').show();
 		var rootPath = getRootPath();
 		var localhostPath = getRootPath1();
 		var id = getSelectionsStr()+"";
      	if(id==''){
      		bootbox.alert('请选择要编辑的行！');
      		return;
      	}else{
      		if(id.indexOf(',')!=-1){
      			bootbox.alert('只能选中一行');
      			return;
      		}
      	}
        $("#formUpdatesInfo").find("input").val("");
        $('#myModalAdd').modal('hide');
        $("#uploadFileName").html('');
        $("#uploadFileId").val('');
       // $("#uploadFileId").val(id);
        $.commonReq({
				url : rootPath + "/regulatory/selectById.do",
				async : true,
				data : {"id":id},
				success : function(parame) {
						debugger;
                		var obj = parame.data;
                		$("#updateId").val(obj.id);
                		$("#updateName").val(obj.title);
                		$("#updateType").val(obj.type);
                		//向编辑器中填充文本
                		um.setContent(obj.body);
                		if(obj.fileUrl==''){
                			$("#downloadHref").hide();
                		}else{
                			$("#updateFileInput").val(obj.fileUrl);
                    		$("#downloadHref").attr("href", localhostPath+"/filePath/"+obj.fileUrl ); 
                		} 
                		
                		if(obj.fileUrl.trim() !=''){
                			$("#uploadFileId").val(obj.fileUrl);
                    		var nameAry = obj.fileUrl.split('|');
                    		for(var i=0;i<nameAry.length;i++){
                    			if(nameAry[i].trim()!=''){
                    				var idAry=nameAry[i].split('^');
                    				var id = idAry[0];
                    				var fileName = idAry[1];
                    				var beforeFileName = $("#uploadFileName").html();
        							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
        												+'<span id='+id+'>'+fileName+'</span>'
        												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
        							$("#uploadFileName").html(afterFileName);
                    			}
                    		}
                		}
                   		$('#myModalUpdate').modal('show');
				},
				error : function(parame) {
					bootbox.alert('服务器请求失败!');
				}
			});
  	} 
  	function saveUpdateInfo(){
  		var flag = true;
  		var id = $("#updateId").val();
  		var body=um.getContent();
		//无样式文本
		var bodyText=um.getContentTxt()+'';
		var flag = true;
		//检查通知公告名称
       	var name=$('#updateName').val();
       	if(checkNullAndEmpty(name)){
       		bootbox.alert("管理制度标题不能为空！");
       		flag=false;
			return;    	
       	}
        //检查通知公告名称
       	var type=$('#updateType option:selected').val();
       	if(checkNullAndEmpty(type)){
       		bootbox.alert("文档类型不能为空！");
       		flag=false;
			return;    	
       	}
      //附件
       	if($("#uploadFileId").val()!=undefined){
       		var fileUrl = $("#uploadFileId").val();
       	}else{
       		var fileUrl = '';
       	}
  		
  		if(flag){
  			 $.commonReq({
 				url : rootPath + "/regulatory/updateRegulatoryRegime.do",
 				async : true,
 				data:{
                	"id":id,
                	"body":body,
                	"title":name,
                	"fileUrl":fileUrl,
                	"bodyText":bodyText,
                	"type":type
                },
 				success : function(data) {
                        $('#myModalAdd').modal('hide');
                        $('#myModalUpdate').modal('hide');
                        $('#dt').bootstrapTable('refresh', {url:rootPath + '/regulatory/findAllRegs.do'});
                        bootbox.alert("修改成功！");
                },
                error:function(xhr,status,e){
                    //服务器响应失败时的处理函数
                   bootbox.alert('服务器请求失败！');
                }
            });
  		}
  	}
	
	function searchRegulations(id){
		var localhostPath = getRootPath1();
		$("#formUpdatesInfo").find("input").val("");
        $('#myModalAdd').modal('hide');
        $("#uploadFileName2").html('');
        $("#uploadFileId").val('');
        $('#urlDiv').hide();
        $.commonReq({
			url : rootPath + '/regulatory/selectById.do',
			data : {
				"id" : id
			},
			success : function(data) {
                     		var obj = data.data;
                    		$("#updateId").val(obj.id);
                    		$("#updateName").val(obj.title);
                    		$("#updateType").val(obj.type);
                    		//向编辑器中填充文本
                    		um.setContent(obj.body);
                    		var afterName = '';
                    		if(obj.fileUrl !=''){
                    			var nameAry = obj.fileUrl.split('|');
                        		for(var i=0;i<nameAry.length;i++){
                        			if(nameAry[i].trim() != ''){
                        				var idAry=nameAry[i].split('^');
                        				var fileName = idAry[1];
                        				var beforeFileList = $("#uploadFileName2").html();
                        				var url =localhostPath+'/filePath/'+nameAry[i];
                        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
                        				$("#uploadFileName2").html(afterFileList);
                        			}
                        		}
                        		$('#urlDiv2').show();
                    		}
                    		
                    		$('#saveUpdateBtn').hide();
                       		$('#myModalUpdate').modal('show');
			}
		});
        
  	} 
	
	
  	
  	 /*获取选中的值*/
    function getSelectionsStr(){
    	var rows = $('#dt').bootstrapTable('getSelections');
    	var str="";
    		if(rows!=null){
    			for(var i=0;i<rows.length;i++){
    				str+=(rows[i].id+"")+",";
    			}
    			str=str.substring(0,str.lastIndexOf(','));
    		}
    	return str;
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
  	
    /*时间格式转化*/  
    function dataFormat(value){
    	if(value!=null){
              var date = new Date(value);
      		var seperator1 = "-";
      		//年
	        	var year = date.getFullYear();
	        	//月
	            var month = date.getMonth() + 1;
	            //日
	            var strDate = date.getDate();
		        if (month >= 1 && month <= 9) {
		            month = "0" + month;
		        }
		        if (strDate >= 0 && strDate <= 9) {
		            strDate = "0" + strDate;
		        }
		        var currentdate = year + seperator1 + month + seperator1 + strDate;
		        return currentdate; 
          }else{
             return "";
          }
    }  
  </script>
  <script type="text/javascript">
	//加载DOM之后处理页面高度
	function get_dom(e){
		return document.getElementById(e);
	}
	function set_height(){
		var pc_height=window.innerHeight;
		pc_height=pc_height-132;
		
		get_dom('third_side_right').style.height='20%;'
		
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
</html>
