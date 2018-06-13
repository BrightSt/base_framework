function upload(value){
	debugger;
	if(value=='1'){
		document.getElementById('file1').click();
	}else if(value=='2'){
		document.getElementById('file2').click();
	}else if(value=='3'){
		document.getElementById('file3').click();
	}else if(value=='4'){
		document.getElementById('file4').click();
	}else if(value=='5'){
		document.getElementById('file5').click();
	}else if(value=='6'){
		document.getElementById('file6').click();
	}
}

function upload_file_new(path,type,factory_code) {
	debugger;
	var url=path+"upload/regulationsUploadFile.do?time="+new Date().getTime();
	var file_up;
	if(type=='1'){
		file_up = document.getElementById("file1");
	}else if(type=='2'){
		file_up = document.getElementById("file2");
	}else if(type=='3'){
		file_up = document.getElementById("file3");
	}else if(type=='4'){
		file_up = document.getElementById("file4");
	}else if(type=='5'){
		file_up = document.getElementById("file5");
	}else if(type=='6'){
		file_up = document.getElementById("file6");
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
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
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
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
							$("#addFileName2").html(afterFileName);
						}else if(type=='3'){
							var beforeFile = $("#addFile3").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#addFile3").val(afterFile);
							var beforeFileName = $("#addFileName3").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
							$("#addFileName3").html(afterFileName);
						}else if(type=='4'){
							var beforeFile = $("#editFile1").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#editFile1").val(afterFile);
							var beforeFileName = $("#editFileName1").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
							$("#editFileName1").html(afterFileName);
						}else if(type=='5'){
							var beforeFile = $("#editFile2").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#editFile2").val(afterFile);
							var beforeFileName = $("#editFileName2").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
							$("#editFileName2").html(afterFileName);
						}else if(type=='6'){
							var beforeFile = $("#editFile3").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#editFile3").val(afterFile);
							var beforeFileName = $("#editFileName3").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
							$("#editFileName3").html(afterFileName);
						}
					bootbox.alert(jsonObj.message);
				}else{
					bootbox.alert(jsonObj.message);
				}
			}
		};
		if(type=='1'){
			$("#form1").ajaxSubmit(options);
		}else if(type=='2'){
			$("#form2").ajaxSubmit(options);
		}else if(type=='3'){
			$("#form3").ajaxSubmit(options);
		}else if(type=='4'){
			$("#form4").ajaxSubmit(options);
		}else if(type=='5'){
			$("#form5").ajaxSubmit(options);
		}else if(type=='6'){
			$("#form6").ajaxSubmit(options);
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
function deleteFile(data){
	var rootPath = getRootPath();
	var loadImgUrl=rootPath+"/resources/images/loading.gif";
	var saveFileName = data+"^"+$("#"+data).html();
	$.commonReq({
				url : rootPath + "/upload/deleteFile.do",
				async : true,
				data :{"saveFileName":saveFileName},
				success : function(parame) {
					debugger
					bootbox.alert( "删除成功！");
				//获取删除链接的父节点的前一个节点
               	 var fileNameStr= $("#"+data).parents().prev().val();
               	 var fileNameAry = fileNameStr.split('|');
               	 for(var i=0;i<fileNameAry.length;i++){
               		 if(fileNameAry[i]==saveFileName){
               			 fileNameStr = fileNameStr.replace(saveFileName+'|','').trim();
               			fileNameStr = fileNameStr.replace(saveFileName,'').trim();
               			 if((fileNameStr).substring(0,1)=='|' ){
               				fileNameStr = fileNameStr.replace('|','').trim();
               			 }
               			if((fileNameStr).substring(fileNameStr.length-1)=='|' ){
               				fileNameStr = fileNameStr.replace('|','').trim();
               			 }
               		 }
               	 }
               	$("#"+data).parents().prev().val(fileNameStr);
               	 $("#"+data).next().html('');
               	 $("#"+data).next().remove();
               	 $("#"+data).remove();
				},
				error : function(parame) {
					bootbox.alert('删除附件失败!');
				}
			});
}