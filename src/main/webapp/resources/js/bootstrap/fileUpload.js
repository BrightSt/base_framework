function uploadEvtNew(value){
	debugger;
	if(value=='1'){
		document.getElementById('file1').click();
	}else if(value=='2'){
		document.getElementById('file2').click();
	}else if(value=='3'){
		document.getElementById('file3').click();
	}else if(value=='4'){
		document.getElementById('file4').click();
	}
}


function upload_file_new(path,type) {
	debugger;
	var url=path+"upload/uploadFile.do?time="+new Date().getTime();
	var file_up;
	if(type=='1'){
		file_up = document.getElementById("file1");
	}else{
		file_up = document.getElementById("file2");
	}
	var file_path = getPath(file_up);
	var loadImgUrl=path+"/resources/images/loading.gif";
	// 判断是否是图片格式
	var file_name = file_up.value.substring(file_up.value.lastIndexOf("."),
			file_up.value.length);
	file_name = file_name.toLowerCase();
//	if ((file_name != '.jpg') && (file_name != '.gif') && (file_name != '.jpeg')
//			&& (file_name != '.png') && (file_name != '.bmp')) {
//		bootbox.alert("请选择正确的图片格式！");
//		file_up.focus();
//		// 清空file里面的值
//		if(type=='1'){
//			$("#file1").val(""); //清空
//		}else{
//			$("#file2").val(""); //清空
//		}
//		file_up.select();
//		document.selection.clear();
//	} else {
		var index;
		var options = {
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
				$('.form-horizontal').loader('hide');
				var jsonObj=eval(data);
				if(jsonObj.result=="success"){
					//上传成功替换图片
					if(type=='1'){
//						$(".btn_upload1").attr("src",jsonObj.imgPath+jsonObj.path);
						$(".imgUrl1").val(jsonObj.path);
					}else{
//						$(".btn_upload2").attr("src",jsonObj.imgPath+jsonObj.path);
						$(".imgUrl2").val(jsonObj.path);
					}
					bootbox.alert(jsonObj.message);
				}else{
					bootbox.alert(jsonObj.message);
				}
			}
		};
		if(type=='1'){
			debugger;
			$("#form1").ajaxSubmit(options);
		}else if(type=='2'){
			debugger;
			$("#form2").ajaxSubmit(options);
		}else if(type=='3'){
			$("#form3").ajaxSubmit(options);
		}else if(type=='4'){
			$("#form4").ajaxSubmit(options);
		}
		
//	}
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