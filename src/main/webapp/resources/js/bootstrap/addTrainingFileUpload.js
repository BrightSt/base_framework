function upload(value){
	debugger;
	if(value=='1'){
		document.getElementById('file1').click();
	}else if(value=='3'){
		document.getElementById('file3').click();
	}else{
		document.getElementById('file2').click();
	}
}

function upload_img_new(path,type,factory_code) {
	debugger;
	var url=path+"upload/regulationsUploadFile.do?time="+new Date().getTime();
	var file_up;
	if(type=='1'){
		file_up = document.getElementById("file1");
	}else if(type=='3'){
		file_up = document.getElementById("file3");
	}else{
		file_up = document.getElementById("file2");
	}
	var file_path = getPath(file_up);
	var loadImgUrl=path+"/resources/images/loading.gif";
	// 判断是否是图片格式
	var file_name = file_up.value.substring(file_up.value.lastIndexOf("."),
			file_up.value.length);
	file_name = file_name.toLowerCase();
	
		var index;
		var options = {
			data:{"factory_code":factory_code},
			url : url,
			type : "POST",// 提交方式
			dataType : "json",// 数据类型
	    	beforeSend:function(){
	    		 $('.form-horizontal').loader('show',"<img src='"+loadImgUrl+"'>");
	        },
			error : function(data, status, e) {
				$('.form-horizontal').loader('hide');
				bootbox.alert("服务器请求失败！");
			},
			success : function(data) {
				debugger;
				$('.form-horizontal').loader('hide');
				/*if(typeof(document.form2) != undefined){
					document.form2.reset();
				}*/
				var jsonObj=eval(data);
				if(jsonObj.result=="success"){
					 
					 if(type=='1'){
							var beforeFile = $("#addFile1").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#addFile1").val(afterFile);
							var beforeFileName = $("#addFileName1").html();
							var afterFileName = '<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+','+'addFile1'+');" style="color:#ff000096;"> 删除</a>';
							$("#addFileName1").html(afterFileName);
						}else if(type=='2'){
							var beforeFile = $("#addFile2").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#addFile2").val(afterFile);
							var beforeFileName = $("#addFileName2").html();
							var afterFileName = '<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+','+'addFile2'+');" style="color:#ff000096;"> 删除</a>';
							$("#addFileName2").html(afterFileName);
						}else{
							var beforeFile = $("#addFile3").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#addFile3").val(afterFile);
							var beforeFileName = $("#addFileName3").html();
							var afterFileName = '<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+','+'addFile3'+');" style="color:#ff000096;"> 删除</a>';
							$("#addFileName3").html(afterFileName);
						}
					bootbox.alert(jsonObj.message);
				}else{
					bootbox.alert(jsonObj.message);
				}
			}
		};
		if(type=='1'){
			$("#form1").ajaxSubmit(options);
		}else if(type=='3'){
			$("#form3").ajaxSubmit(options);
		}else{
			$("#form2").ajaxSubmit(options);
		}
		
	
}

function getPath(obj) {
	if (obj) {
		if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
			obj.select();
			return document.selection.createRange().text;
		} else if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
			if (obj.files) {
				return window.URL.createObjectURL(obj.files[0]);
			}
			return obj.value;
		}
		return obj.value;
	}
}

//删除附件
function deleteFile(data,id){
	debugger;
	var rootPath = getRootPath();
	var loadImgUrl=rootPath+"/resources/images/loading.gif";
	var saveFileName = data+"^"+$("#"+data).html();
	$.commonReq({
				url : rootPath + "/upload/deleteFile.do",
				async : true,
				data :{"saveFileName":saveFileName},
				success : function(parame) {
					bootbox.alert( "删除成功！");
               	 /*var fileNameStr= $('#uploadFileId').val();
               	 var fileNameAry = fileNameStr.split('|');
               	 for(var i=0;i<fileNameAry.length;i++){
               		 if(fileNameAry[i]==saveFileName){
               			 fileNameStr = fileNameStr.replace(saveFileName,' ');
               		 }
               	 }*/
               	 $(id).val("");
               	 $("#"+data).next().html('');
               	 $("#"+data).next().remove();
               	 $("#"+data).remove();
				},
				error : function(parame) {
					bootbox.alert('删除附件失败!');
				}
			});
}