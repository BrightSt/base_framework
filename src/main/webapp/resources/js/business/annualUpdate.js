//上传附件
function upload(type){
	debugger;
	var name = $("#updateFileName").val();
	if(name != null && name != undefined && name != ""){
		uploadEvtNew(type);
	}else{
		bootbox.alert("请先填写标题！");
	}
	
}

//替换附件
function update(type){
	var name = $("#updateName").val();
	if(name != null && name != undefined && name != ""){
		uploadEvtNew(type);
	}else{
		bootbox.alert("请先填写标题！");
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
	