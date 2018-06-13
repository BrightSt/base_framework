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
		}
	});
});

function submitInfo() {
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
function upload(type){
	uploadEvtNew(type);
}
