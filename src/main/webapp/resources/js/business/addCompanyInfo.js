/**
 * 企业用户管理js页面
 */
var rootPath = getRootPath();
$(function() {
	var qyname = $('#subjectionId');
	qyname.selectpicker({
		noneSelectedText : '--请选择--',
		style : 'btnSelect',
		width : '200px',
		liveSearch : true,
		liveSearchPlaceholder : '请输入名称查询',
		size : 10
	});

	$('#formInsertInfo').bootstrapValidator({
		fields : {
			code : {
				validators : {
					notEmpty : {
						message : '企业编码不能为空'
					},
					regexp: {
                        regexp: /^[a-zA-Z0-9]+$/,
                        message: '企业编码只能包含数字及字母'
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
			postCode:{
				validators:{
					notEmpty:{
						message:'邮政编码不能为空'
					},
					regexp:{
						regexp:/^\d{6}$/,
						message:'请输入6位数字'
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
			}
		}
	});
});

function submitInfo() {
	$('#formInsertInfo').bootstrapValidator('validate');
	var data = $("#formInsertInfo").data('bootstrapValidator');
	var tipStr = $("#tip").html();
	if (tipStr == "企业编码已存在") {
		return;
	}
	if (data.isValid()) {
		$.commonReq({
			url : rootPath + "/companyInfo/add.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				$('.form-horizontal').loader('hide');
				if (parame.data) {
					bootbox.alert('企业新增成功!');
					newInfo();
					$('#insertModal').modal('hide');
				} else {
					bootbox.alert('企业新增失败!');
					$('#insertModal').modal('hide');
				}
			}
		});
	}
}

function checkUserName(value) {
	if (value != null && value != undefined && value != "") {
		$.commonReq({
			url : rootPath + "/userInfo/all.do",
			data : {
				"userName" : value
			},
			success : function(result) {
				$('.form-horizontal').loader('hide');
				if (result.rows.length > 0) {
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
}

function checkCode(value) {
	if (value != null && value != undefined && value != "") {
		$.commonReq({
			url : rootPath + "/companyInfo/all.do",
			data : {
				"code" : value,
				"page":false
			},
			success : function(result) {
				$('.form-horizontal').loader('hide');
				if (result.rows.length>0) {
					$('#tip').empty();
					$('#tip').append("企业编码已存在");
				} else {
					$('#tip').empty();
				}
			}
		})
	}
}
