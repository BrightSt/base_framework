/**
 * 企业用户管理js页面
 */
var rootPath = getRootPath();
$(function() {

	$('#companyForm,#userForm').bootstrapValidator({
		fields : {
			code : {
				validators : {
					notEmpty : {
						message : '企业组织机构代码不能为空'
					}
					
				}
			},
			name : {
				validators : {
					notEmpty : {
						message : '企业名称不能为空'
					}
				}
			},
			address : {
				validators : {
					notEmpty : {
						message : '地址不能为空'
					}
				}
			},
			fax:{
				validators:{
					notEmpty:{
						message:'传真不能为空'
					},
					phone:{
						country: 'CN',
						message:'传真格式不符'
					}
				}
			},
			phone:{
				validators:{
					notEmpty:{
						message:'企业电话不能为空'
					},
					phone:{
						country: 'CN',
						message:'企业电话格式不符'
					}
				}
			},
			
			email:{
				validators:{
					notEmpty:{
						message:'邮箱不能为空'
					},
					emailAddress:{
						message:'邮箱格式不正确'
					}
				}
			},
			manager:{
				validators:{
					notEmpty:{
						message:'法定代表人不能为空'
					}
				}
			},
			userName:{
				validators:{
					notEmpty:{
						message:'用户名不能为空'
					}
				}
			},
			password:{
				validators:{
					notEmpty:{
						message:'密码不能为空'
					}
				}
			},
			password2:{
				validators:{
					notEmpty:{
						message:'请再次确认密码'
					}
				}
			}
		}
	});
});



function checkUserName() {
	var value = $("#userName").val();
	if (value != null && value != undefined && value != "") {
		$.commonReq({
			url : rootPath + "/userInfo/checkUserName.do",
			data : {
				"userName" : value
			},
			success : function(result) {
				if (result.rows.length > 0) {
					
					$('#userName').val('');
					bootbox.alert("用户名已存在！");
				}
			}
		})
	}
}

/**
 * 根据用户选择的类型加载相应的企业
 * 
 * @param value
 * @returns
 *//*
function updateCompanys(value) {
	$.commonReq({
		url : rootPath + "/companyInfo/all.do",
		data : {
			"type" : value,
			"page" : false
		},
		success : function(result) {
			$('.form-horizontal').loader('hide');
			var rows = result.rows;
			var subjectionId = $("#subjectionId");
			if (rows.length > 0) {
				subjectionId.empty();
				subjectionId.append("<option value=''>--请选择--</option>");
				for (var i = 0; i < rows.length; i++) {
					subjectionId.append("<option value='" + rows[i].number
							+ "'>" + rows[i].name + "</option>");
				}
			} else {
				subjectionId.empty();
				subjectionId.append("<option value=''>未查询到数据</option>");
			}
		}
	})
}*/

function checkCode() {
	$("#userStatus").val("1");
	var companyCode = $("#companyCode").val();
	if (companyCode != null && companyCode != undefined && companyCode != "") {
		$.commonReq({
			url : rootPath + "/companyInfo/checkCode.do",
			data : {
				"code" : companyCode,
				"page":false,
				status:1
			},
			success : function(result) {
				if (result.rows.length>0) {
					bootbox.alert("企业已在系统留档，请您点击下一步注册登录账号！");
					$("#userStatus").val("0");
					$("#companyForm").find('input').attr("readonly","readonly");
					
				} 
			}
		})
	}
}
//注册企业
function register(){
	var userStatus = $("#userStatus").val();
	$("#companyStatus").val('0');
	$("#companyType").val('1');
	var companyCode = $("#companyCode").val();
	var roleId = "";
	$("#userCompanyCode").val(companyCode);
	//如果企业未注册过
	if (userStatus=="1") {
		$.commonReq({
			url : rootPath + "/companyInfo/registerComapnyAdd.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#companyForm').serialize(),
			success : function(parame) {
				/*$('.form-horizontal').loader('hide');*/
				$.commonReq({
					url : rootPath + "/userInfo/registerUserAdd.do",
					async : false,
					type : "POST",
					dataType : "json",
					data : $('#userForm').serialize(),
					success : function(parame) {
						$('.form-horizontal').loader('hide');
						bootbox.confirm("注册成功，请留意邮箱及时获取审核结果！", function(result) {
							if (result) {
								window.location.href = rootPath + "/userInfo/login.do"
							}
						})
						
					}
				});
			}
		});
	}else{
		//企业已存在
		$.commonReq({
			url : rootPath + "/userInfo/getUserRole.do",
			async:false,
			type:"POST",
			dataType:"json",
			data:{"companyCode":companyCode},
			success:function(parame){
				var treeData = parame.data;
				roleId =treeData.roleid;
				$.commonReq({
					url : rootPath + "/userInfo/registerUserAdd.do",
					async : false,
					type : "POST",
					dataType : "json",
					data : $('#userForm').serialize(),
					success : function(parame) {
						var userName = $('#userName').val();
						$.commonReq({
							url : rootPath + "/userInfo/setUserRole.do",
							async : false,
							type : "POST",
							dataType : "json",
							data : {"userName":userName,
									"roleId":roleId
								},
							success : function(parame) {
								bootbox.confirm("注册成功，现在就去登录吗？", function(result) {
									if (result) {
										window.location.href=rootPath+'/userInfo/login.do'
									}
								})
							}
						});
						
					}
				});
			}
		});
		
	}
}

function checkPassword2(){
	var password = $("#password").val();
	var password2 = $("#password2").val();
	if(password != password2){
		alert("两次输入密码不一致，请重新输入！");
		$("#password2").val('');
	}
}

/*function getUserRole(companyCode){
	debugger;
	$.commonReq({
		url : rootPath + "/userInfo/getUserRole.do",
		async:false,
		type:"POST",
		dataType:"json",
		data:{"companyCode":companyCode},
		success:function(parame){
			debugger
			var mi = parame.data;
			$("#roleId").var(mi.roleId);
		}
	});
}*/
function clenaForm(){
	$("#companyForm").find('input').val('');
	$("#userForm").find('input').val('');
	
}

function searchUser(){
	$("#resultDiv").hide();
	$("#reasonDiv").hide();
	$("#resultId").val('');
	$("#reasonId").val('');
	var value = $("#searchUserNameId").val();
	if (value != null && value != undefined && value != "") {
		$.commonReq({
			url : rootPath + "/userInfo/checkUserName.do",
			data : {
				"userName" : value
			},
			success : function(result) {
				if (result.rows.length > 0) {
					var user = result.rows[0];
					if(user.status=="1"){
						$("#resultDiv").show();
						$("#resultId").val("待审批");
					}else if(user.status=="0"){
						$("#resultDiv").show();
						$("#resultId").val("审请已通过");
					}else if(user.status=="2"){
						$("#resultDiv").show();
						$("#resultId").val("申请被驳回");
						$("#reasonDiv").show();
						$("#reasonId").val(user.reason);
					}
					
				}
			}
		})
	}
}
//进入检查结果查询页面隐藏某些div
function hideSomeDiv(){
	$("#resultDiv").hide();
	$("#reasonDiv").hide();
}