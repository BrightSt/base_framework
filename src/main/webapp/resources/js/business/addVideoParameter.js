var rootPath = getRootPath();
var localhostPath = getRootPath1();
$(function (){
	debugger;
	$("#insertSysDataModal").find('input').val('');
	
	$("#insertSysDataModal").modal("show");
	
	
$("#addInfoBtn").click(function(){
		
		debugger;
		$.commonReq({
			async : false,
			url : rootPath + "/video/add.do",
			type : "POST",
			dataType : "json",
			data : $("#videoInsertForm").serialize(),
			success : function(data) {
				
				// 跳转页面
				window.location.href = rootPath + '/video/initPage.do'
			}
		});
	})
});

function typeChange(){
	var type = $("#type").val();
	$("#insertSysDataModal").find('input').val('');
	$("#systemFlag").val(1);
	if(type=="0"){
		$("#addip,#addport,#adduserName,#addpassWord").hide();
	}else{
		$("#addip,#addport,#adduserName,#addpassWord").show();
	}
}