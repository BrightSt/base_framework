
$(function(){
	$('#addYearId').datetimepicker({
		startView: 'decade',  
        minView: 'decade',  
        format: 'yyyy',  
        maxViewMode: 2,  
        minViewMode:2,  
        autoclose: true 
	});
});

//上传附件
function upload(type){
	var name = $("#fileName").val();
		name += $("#updateFileName").val();
	if(name != null && name != undefined && name != ""){
		uploadEvtNew(type);
	}else{
		bootbox.alert("请先填写文件标题！");
	}
	
}

//替换附件
function update(type){
	var name = $("#updateFileName").val();
	if(name != null && name != undefined && name != ""){
		uploadEvtNew(type);
	}else{
		bootbox.alert("请先填写主题！");
	}
	
}
//下载附件
function download(type){
	var fileName = $("#updateFileInput").val();
	
	
}
//下载附件
function searchDownload(attachmentUrl){
	var rootPath = getRootPath();
	var localhostPath = getRootPath1();
	var url = localhostPath+"/filePath/"+attachmentUrl;
	 window.open(url);
}



	var rootPath = getRootPath();
		//增加保存
		function saveInfo(){
			debugger;
			var flag=true;
			//名称
	       	var title=$('#fileName').val();
	       	if(checkNullAndEmpty(title)){
	       		bootbox.alert("年度环评文件标题不能为空！");
	       		flag=false;
				return;    	
	       	}
	       	//年份
	       	var year=$('#addYearId').val();
	       	if(checkNullAndEmpty(year)){
	       		bootbox.alert("年度环评文件年份不能为空！");
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
	  				url : rootPath + "/annual/addRegs.do",
	  				async : true,
	  				data : $("#formInsertInfo").serialize(),
	  				success : function(parame) {
	  					bootbox.alert('保存成功!');
	  					$('#myModalUpdateUser').modal('hide');
	  					window.location.href='annual/toAnnualReviewPage.do';
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
