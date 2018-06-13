/**
 * 企业用户管理js页面
 */
var rootPath = getRootPath();
$(function() {

	var qyname = $('#company_id');
	qyname.selectpicker({
		noneSelectedText : '--请选择--',
		style : 'btnSelect',
		width : '200px',
		liveSearch : true,
		liveSearchPlaceholder : '请输入名称查询',
		size : 10
	});

	$('#company_code').selectpicker({
		  noneSelectedText : '--请选择--',
		  style : 'btnSelect',
		  liveSearch : true,
		  liveSearchPlaceholder : '请输入企业名称查询',
		  size : 10
		});
	
	$('#formInsertInfo').bootstrapValidator({
		fields : {
			userName : {
				validators : {
					notEmpty : {
						message : '用户名不能为空'
					}
				}
			},
			password : {
				validators : {
					notEmpty : {
						message : '密码不能为空'
					},
					stringLength:{
						min:6,
						max:18,
						message:'密码长度必须在6到18位之间'
					},
					regexg:{
						regexg:/^[a-zA-Z0-9]+$/,
						message:'密码只能包含数字与字母'
					}
					
				}
			},
			passwordConf:{
				validators:{
					notEmpty:{
						message:'确认密码不能为空！'
					}
				}
			},
			companyId : {
				validators : {
					notEmpty : {
						message : '所属企业不能为空'
					}
				}
			},
		}
	});
});

function submitInfo() {
	$('#formInsertInfo').bootstrapValidator('validate');
	var data = $("#formInsertInfo").data('bootstrapValidator');
	var tipStr = $("#tip").html();
	if (tipStr == "账号已存在！") {
		return;
	}
	if (data.isValid()) {
		$.commonReq({
			url : rootPath + "/userInfo/add.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				if (parame.data) {
					bootbox.alert('用户新增成功!');
					newInfo();
					$('#insertModal').modal('hide');
				} else {
					bootbox.alert('用户新增失败!');
					$('#insertModal').modal('hide');
				}
			},
			error : function(parame) {
			}
		});
	}
}

function checkUserName(value) {
	if (value != null && value != undefined && value != "") {
		$.commonReq({
			url : rootPath + "/userInfo/dataCheck.do",
			data : {
				"userName" : value
			},
			success : function(result) {
				$('.form-horizontal').loader('hide');
				if (result.data > 0) {
					$('#tip').empty();
					$('#tip').append("用户名已存在！");
				} else {
					$('#tip').empty();
				}
			}
		})
	}
}
/**
 * 校验两次密码是否一致
 * @param value
 * @returns
 */
function checkPassword(value){
	var password = $("#passwordId").val();
	if(value!=password){
		alert("两次输入密码不一致！请确认");
		$("#passwordIdConf").val('');
		return;
	}
	
}
/**
 * 根据用户选择的类型加载相应的企业
 * 
 * @param value
 * @returns
 */
function updateCompanys(value) {
	$.commonReq({
		url : rootPath + "/companyInfo/all.do",
		data : {
			"type" : value,
			"isPage" : false
		},
		success : function(result) {
			var rows = result.rows;
			var companySelect = $("#company_id");
			if (rows.length > 0) {
				companySelect.empty();
				companySelect.append("<option value=''>--请选择--</option>");
				for (var i = 0; i < rows.length; i++) {
					companySelect.append("<option value='" + rows[i].number
							+ "'>" + rows[i].name + "</option>");
				}
			} else {
				companySelect.empty();
				companySelect.append("<option value=''>未查询到数据</option>");
			}
		}
	})
}
