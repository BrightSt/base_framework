/**
 * 
 */
var path = getRootPath();
function upload(type){
   uploadEvtNew(type);
}

function uploadEvtNew(value){
	if(value=='1'){
		document.getElementById('file1').click();
	}else{
		document.getElementById('file2').click();
	}
}

function upload_img(action,type,code) {
	var url=action;
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
	if ((file_name != '.jpg') && (file_name != '.gif') && (file_name != '.jpeg')
			&& (file_name != '.png') && (file_name != '.bmp')) {
		bootbox.alert("请选择正确的图片格式！");
		file_up.focus();
		// 清空file里面的值
		if(type=='1'){
			$("#file1").val(""); //清空
		}else{
			$("#file2").val(""); //清空
		}
		file_up.select();
		document.selection.clear();
	} else {
		var index;
		var options = {
			data:{"code":code},
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
						$(".btn_upload1").attr("src",jsonObj.imgPath+jsonObj.path);
						$(".imgUrl1").val(jsonObj.path);
					}else{
						$(".btn_upload2").attr("src",jsonObj.imgPath+jsonObj.path);
						$(".imgUrl2").val(jsonObj.path);
					}
					bootbox.alert(jsonObj.message);
				}else{
					bootbox.alert(jsonObj.message);
				}
			}
		};
		if(type=='1'){
			$("#form1").ajaxSubmit(options);
		}else{
			$("#form2").ajaxSubmit(options);
		}
		
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

function submitInfo(id){
	var imgUrl = $(".imgUrl1").val();
	if(imgUrl==null || imgUrl==undefined || imgUrl==""){
		bootbox.alert("请上传图片！");
		return;
	}
 	 $.commonReq({
		url:path+"/user/updateUserInfo.do",
		async:true,
		data:{"avatar":imgUrl,"id":id},
		beforeSend:function(){
			//防止表单提交
			$('.form-horizontal').loader('show','<img src="resources/images/loading.gif">');
		},
		success:function(parame){
			$('.form-horizontal').loader('hide');
			if(parame.data){
				bootbox.alert('头像上传成功!');
				$('#formInsertImg').modal('hide');
				location.href = path+"/user/checkLogin.do";
			}else{
				bootbox.alert('头像上传失败!');
				$('#formInsertImg').modal('hide');
			}
	    },
		error:function(parame){
		}
	});
}