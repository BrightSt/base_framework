var rootPath = getRootPath();
var localhostPath = getRootPath1();
$(function (){
	debugger;
	$("#insertSysDataModal").find('input').val('');
	
	$("#insertSysDataModal").modal("show");
	
	
	$("#addInfoBtn").click(function(){
		var companyCode = $("#companyCodeId").val();
		
		// 跳转页面
		window.location.href = rootPath + '/video/selectCompany.do?companyCode='+companyCode;
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