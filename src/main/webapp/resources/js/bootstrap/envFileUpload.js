function uploadEvtNew1(value){
	if(value=='1'){
		document.getElementById('file1').click();
	}else if(value=='3'){
		document.getElementById('file3').click();
	}else{
		document.getElementById('file2').click();
	}
}

function upload_file(path,type,factory_code) {
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
					//上传成功替换图片
					/*if(type=='1'){
						$(".btn_upload1").attr("src",jsonObj.imgPath+jsonObj.path);
						$(".imgUrl1").val(jsonObj.path);
					}else{
						$(".btn_upload2").attr("src",jsonObj.imgPath+jsonObj.path);
						$(".imgUrl2").val(jsonObj.path);
					}*/
					 //上传附件显示附件名称连接用
					 if(type=='3'){
							$(".btn_upload1").attr("src",jsonObj.imgPath+jsonObj.path);
							var beforeFile = $("#uploadFileId3").val();
							var afterFile = '';
							if(beforeFile==''||beforeFile=='1'){
								afterFile = jsonObj.saveFileName;
							}else{
								afterFile = beforeFile+"|"+jsonObj.saveFileName;
							}
							$("#uploadFileId3").val(afterFile);
							var beforeFileName = $("#updateUploadFileName3").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
							+'<span id='+jsonObj.dateId+'>'+jsonObj.fileName+'</span>'
							+'<a  onclick="deleteFile('+jsonObj.dateId+');" style="color:#ff000096;"> 删除</a>';
							$("#updateUploadFileName3").html(afterFileName);
						}else{
							$(".btn_upload2").attr("src",jsonObj.imgPath+jsonObj.fileName);
							$(".imgUrl2").val(jsonObj.fileName);
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
function deleteFile(data){
	debugger;
	var rootPath = getRootPath();
	var loadImgUrl=rootPath+"/resources/images/loading.gif";
	var saveFileName = data+"^"+$("#"+data).html();
	$.commonReq({
				url : rootPath + "/upload/deleteFile.do",
				async : true,
				data :{"saveFileName":saveFileName},
				success : function(parame) {
					
               	 var fileNameStr= $('#uploadFileId3').val();
               	 var fileNameAry = fileNameStr.split('|');
               	 for(var i=0;i<fileNameAry.length;i++){
               		 if(fileNameAry[i]==saveFileName){
               			 fileNameStr = fileNameStr.replace(saveFileName,' ');
               		 }
               	 }
               	 $('#uploadFileId3').val(fileNameStr);
               	 $("#"+data).next().html('');
               	 $("#"+data).next().remove();
               	 $("#"+data).remove();
               	 bootbox.alert( "删除成功！");
				},
				error : function(parame) {
					bootbox.alert('删除附件失败!');
				}
			});
}