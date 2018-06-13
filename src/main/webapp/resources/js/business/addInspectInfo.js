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
	
	$('#inspectStartTimeId,#inspectEndTimeId').datetimepicker({
        pickerPosition: "bottom-left",
        language: "zh-CN",
        autoclose: true,
        minView: 2,
        format: "yyyy-mm-dd",
        todayHighlight: true
    });

	$('#formInsertInfo').bootstrapValidator({
		fields : {
			inspectedEnterpriseNumber : {
				validators : {
					notEmpty : {
						message : '受检单位不能为空'
					}
				}
			},
			inspectEnterpriseNumber : {
				validators : {
					notEmpty : {
						message : '检查单位不能为空'
					}
				}
			},
			inspectStartTime:{
				validators:{
					notEmpty:{
						message:'检查开始时间不能为空！'
					}
				}
			},
			inspectEndTime : {
				validators : {
					notEmpty : {
						message : '检查结束时间不能为空'
					}
				}
			},
			title : {
				validators : {
					notEmpty : {
						message : '主题不能为空'
					}
				}
			},
			content : {
				validators : {
					notEmpty : {
						message : '内容不能为空'
					}
				}
			},
			result : {
				validators : {
					notEmpty : {
						message : '结果不能为空'
					}
				}
			},
			resason : {
				validators : {
					notEmpty : {
						message : '备注不能为空'
					}
				}
			},
		}
	});
});

function submitInfo() {
	var start = $("#inspectStartTimeId").val();
	var end =$("#inspectEndTimeId").val();
	if(start>end){
		bootbox.alert('检查开始时间大于结束时间，请确认!');
		return;
	}
	$('#formInsertInfo').bootstrapValidator('validate');
	var data = $("#formInsertInfo").data('bootstrapValidator');
	if (data.isValid()) {
		$.commonReq({
			url : rootPath + "/inspection/add.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				if (parame.code == 0) {
					bootbox.alert('检查新增成功!');
					newInfo();
					$('#insertModal').modal('hide');
				} else {
					bootbox.alert('新增失败!');
					$('#insertModal').modal('hide');
				}
				$('#uploadFileName1').html('');
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

function upload(type){
	uploadEvtNew(type);
}
