/**
 * 新增文件审批管理js页面
 */

//上传附件
function upload(type){
	uploadEvtNew(type);
}
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
	
	$('#validateDateId').datetimepicker({
        pickerPosition: "bottom-left",
        language: "zh-CN",
        autoclose: true,
        minView: 2,
        format: "yyyy-mm-dd",
        todayHighlight: true
    });

	$('#formInsertInfo').bootstrapValidator({
		fields : {
			projectInfo : {
				validators : {
					notEmpty : {
						message : '项目信息不能为空'
					}
				}
			},
			envInfo : {
				validators : {
					notEmpty : {
						message : '环境信息不能为空'
					}
				}
			},
			content:{
				validators:{
					notEmpty:{
						message:'环评内容不能为空！'
					}
				}
			},
			validateDate : {
				validators : {
					notEmpty : {
						message : '有效期不能为空'
					}
				}
			},
			thirdCompanyName : {
				validators : {
					notEmpty : {
						message : '委托第三方企业名称不能为空'
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
		var filePath = $("#uploadFileId").val();
		$.commonReq({
			url : rootPath + "/envAssessment/add.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				$('#uploadFileName1').html('');
				bootbox.alert('环评文件提交成功!');
				newInfo();
				$('#insertModal').modal('hide');
				
			},
			error : function(parame) {
			}
		});
	}
}


function upload(type){
	debugger;
	uploadEvtNew(type);
}
