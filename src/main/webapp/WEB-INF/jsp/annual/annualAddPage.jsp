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
<script src="<%=basePath%>resources/js/business/annualAdd.js"></script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4 class="modal-title" id="myModalInsert1">新增评估文件</h4>
	</div>
	<div class="modal-body">
		<form id="formInsertInfo" method="post" action="" class="form-horizontal">
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>文件标题：</label>
                <div class="col-sm-6">
                	<input id="fileName" name="fileName" class="form-control" maxlength="250">
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>年份：</label>
                <div class="col-sm-6">
					<input id="addYearId" name="year" class="form-control" maxlength="25" >
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>内容简述：</label>
                <div class="col-sm-6">
                	<textarea rows="5" cols="6" id="resume" name="resume" style="width:418px;" maxlength="250"></textarea>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>备注：</label>
                <div class="col-sm-6">
                	<input type="text" class="form-control" id="remarks" name="remarks" maxlength="250">
                	</input>
                </div>
               </div> 
                <div class="form-group">
                <label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>附件：</label>
                <div class="col-sm-6">
                	<input  name="attachmentUrl" class="imgUrl imgUrl1" type="hidden"  value="" id="uploadFileInput">
						<!-- 记录所有附件名隐藏域 -->
						<input id="uploadFileId" type="hidden" name="fileUrl">
						<a style="margin-top: 5px;" onclick="upload('1');" type="button"  class="btn btn-default"><span class="glyphicon glyphicon-upload"></span>&nbsp;添加附件</a>
						<span id="uploadFileName" style="color:#3c7897"></span>
                </div>
              </div>
            </form>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" onclick="saveInfo();">保存</button>
		</div>
	</div>
	<!-- 模态框 新增 结束 -->
	<!-- 上传图片div -->
	<div style="display: none;">
		<form id="form1" name="form1" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file1" name="file1" type="file" onchange="upload_img_new('<%=basePath%>','1',$('#check_id option:selected').val())" />
		</form>
		<form id="form2" name="form2" method="post" enctype="multipart/form-data" style="width: 100%;">
			<input id="file2" name="file2" type="file" onchange="upload_img_new('<%=basePath%>','2',$('#check_id option:selected').val())" />
		</form>
	</div>
</body>
</html>