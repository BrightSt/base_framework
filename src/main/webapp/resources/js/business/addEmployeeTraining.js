/**
 * 增加放射源管理js页面
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
	$('#addQualificationStart').datetimepicker({
		pickerPosition : "bottom-left",
		language : "zh-CN",
		autoclose : true,
		minView : 2,
		format : "yyyy-mm-dd",
		todayHighlight : true
	});
	$('#formInsertInfo').bootstrapValidator({
		fields : {
			name : {
				validators : {
					notEmpty : {
						message : '人员姓名不能为空'
					}
				}
			},
			age : {
				validators : {
					notEmpty : {
						message : '年龄不能为空'
					}
			
				}
			},
			cardNo : {
				validators : {
					notEmpty : {
						message : '身份证号不能为空'
					},
					regexp: {
                        regexp: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
                        message: '身份证号格式不正确'
                    }
				}
			},
			qualificationStart : {
				validators : {
					notEmpty : {
						message : '资格证起始时间不能为空'
					}
				}
			},
			qualificationLong : {
				validators : {
					notEmpty : {
						message : '资格证有效时长不能为空'
					}
				}
			},
			/*qualificationNo:{
				validators:{
					notEmpty:{
						message:'资格证编号不能为空！'
					}
				}
			},*/
		}
	});
});

function submitInfo() {
	$('#formInsertInfo').bootstrapValidator('validate');
	var data = $("#formInsertInfo").data('bootstrapValidator');
	if (data.isValid()) {
		$.commonReq({
			url : rootPath + "/employeeTraining/add.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				bootbox.alert('从业人员信息新增成功!');
				newInfo();
				$('#insertModal').modal('hide');
				$("#addFileName1").html('');
				$("#addFileName2").html('');
				$("#addFileName3").html('');
			}
		});
	}
}
function isCardNo() 
{ 
	debugger;
	var card = $("#addCardNo").val();
// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X 
var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; 
if(reg.test(card) === false) 
{ 
alert("身份证输入不合法"); 
return false; 
} 
}
