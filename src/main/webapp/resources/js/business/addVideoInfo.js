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
			companyCode : {
				validators : {
					notEmpty : {
						message : '企业不能为空'
					}
				}
			},
			pfkCode : {
				validators : {
					notEmpty : {
						message : '监控点编号不能为空'
					},
				}
			},
			addressInfo:{
				validators:{
					notEmpty:{
						message:'位置信息不能为空！'
					}
				}
			},
			useInfo : {
				validators : {
					notEmpty : {
						message : '用途信息不能为空'
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
			url : rootPath + "/video/add.do",
			async : false,
			type : "POST",
			dataType : "json",
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				if (parame.data) {
					bootbox.alert('监控点新增成功!');
					newInfo();
					$('#insertModal').modal('hide');
				} else {
					bootbox.alert('监控点新增失败!');
					$('#insertModal').modal('hide');
				}
			},
			error : function(parame) {
			}
		});
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
