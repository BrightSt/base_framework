/**
 * 企业用户管理js页面
 */
var rootPath = getRootPath();
$(function() {
	
	var qyname = $('#editSubjection');
	qyname.selectpicker({
		noneSelectedText : '--请选择--',
		style : 'btnSelect',
		width : '200px',
		liveSearch : true,
		liveSearchPlaceholder : '请输入名称查询',
		size : 10
	});
	
	newInfo();
	
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
	
	$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
	$("input[name=btSelectAll]").css("verticalAlign", "middle");

	$('#updatecreatetime,#updateupdatetime').datetimepicker({
		pickerPosition : "bottom-left",
		language : "zh-CN",
		autoclose : true,
		minView : 2,
		format : "yyyy-mm-dd",
		todayHighlight : true
	});
});

/* 删除数据 */
function delInfo(value) {
	bootbox.confirm("您确定要删除该数据吗？", function(result) {
		if (result) {
			$.commonReq({
				url : rootPath + '/companyInfo/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/companyInfo/all.do'
					});
				},
				error : function(xhr, status, e) {
					bootbox.alert('服务器请求失败');
				}
			});
		}
	});
}
/* 获取选中的值 */
function getSelectionsStr() {
	var rows = $('#dt').bootstrapTable('getSelections');
	var str = "";
	if (rows != null) {
		for (var i = 0; i < rows.length; i++) {
			str += rows[i].id + ",";
		}
		str = str.substring(0, str.lastIndexOf(','));
	}
	return str;
}
// 点击修改加载企业信息
function newInfo() {
	$('#dt').bootstrapTable('destroy');
	$('#dt')
			.bootstrapTable(
					{
						method : 'post',
						contentType : "application/x-www-form-urlencoded",
						url : rootPath + '/companyInfo/all.do',
						striped : true, // 是否显示行间隔色
						cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
						pagination : true,
						queryParamsType : '', // 默认值为 'limit' ,在默认情况下
						// 传给服务端的参数为：offset,limit,sort
						// 设置为 '' 在这种情况下传给服务器的参数为：pageSize,pageNumber
						queryParams : queryParams,
						singleSelect : false,
						pageSize: basePage.pageSize,
					    pageList: basePage.pageList,
						search : false, // 不显示 搜索框
						showColumns : false, // 不显示下拉框（选择显示的列）
						sidePagination : "server", // 服务端请求
						clickToSelect : true, // 是否启用点击选中行
						columns : [
							{
		                          field: 'Number',
		                          title: '行号',
		                          width:'1px',
		                          formatter: function (value, row, index) {
		                              return index+1;
		                          },
		                          width:50
							 },
								{
									field : 'code',
									title : '企业编码',
									valign : 'middle'
								},
								{
									field : 'name',
									title : '企业名称',
									valign : 'middle'
								},
								{
									field : 'shortName',
									title : '简称',
									valign : 'middle'
								},
								{
									field : 'englistName',
									title : '英文名',
									valign : 'middle'
								},
								{
									field : 'phone',
									title : '企业电话',
									valign : 'middle'
								},
								{
									field : 'fax',
									title : '传真',
									valign : 'middle'
								},
								{
									field : 'postCode',
									title : '邮政编码',
									valign : 'middle'
								},
								{
									field : 'address',
									title : '地址',
									valign : 'middle'
								},
								{
									field : 'email',
									title : '邮箱',
									valign : 'middle'
								},
								{
									field : 'manager',
									title : '法定代表人',
									valign : 'middle'
								},
								{
									field : 'type',
									title : '类型',
									valign : 'middle'
								},
								{
									field : 'subjection',
									title : '隶属关系',
									valign : 'middle'
								},
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" onclick="tailInfo(\''
												+ row.id
												+ '\');" class="btn btn-success btn-xs"  style="margin-right:10px;" data-toggle="" data-target="" ><span class="glyphicon glyphicon-list-alt"></span>详情</button>';
										m += '<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
										m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
										return m;
									},
									valign : 'middle'
								} ],
						onLoadSuccess : function(data) {
							debugger;
						},
						onLoadError : function(data) {
							debugger;
						}
					});
}

function tailInfo(id) {
	$.commonReq({
				url : rootPath + "/companyInfo/detailInfo.do",
				data : {
					"id" : id
				},
				success : function(data) {
					$('.form-horizontal').loader('hide');
					$('#myModalMore').modal('show');
					var dataSucess = data.data;
					$("#morecode").val("");
					$("#morecode").val(dataSucess.code);
					$("#morename").val("");
					$("#morename").val(dataSucess.name);
					$("#moreShortName").val("");
					$("#moreShortName").val(dataSucess.shortName);
					$("#moreEnglistName").val("");
					$("#moreEnglistName").val(dataSucess.englishName);
					$("#moreAddress").val('');
					$("#moreAddress").val(dataSucess.address);
					$("#moreType").empty();
					$("#moreType").append("<option value='1'>企业单位</option>");
					$("#moreType").append("<option value='0'>环保单位</option>");
					if(dataSucess.type=='0'){
						$("#moreType option[value='0']").attr("selected",true);
					}else{
						$("#moreType option[value='1']").attr("selected",true);
					}
					$("#moreSubjection").val('');
					$("#moreSubjection").val(dataSucess.subjection);
					$("#moreFax").val('');
					$("#moreFax").val(dataSucess.fax);
					$("#morePostCode").val('');
					$("#morePostCode").val(dataSucess.postCode);
					$("#morePhone").val('');
					$("#morePhone").val(dataSucess.phone);
					$("#moreEmail").val('');
					$("#moreEmail").val(dataSucess.email);
					$("#moreManager").val('');
					$("#moreManager").val(dataSucess.manager);
					$("#moreRemark").val('');
					$("#moreRemark").val(dataSucess.remark);
				}
			});
}
function editInfo(id) {
	$('#myModalUpdateUser').modal('show');
	$("#update_id").val("").val(id);
	$.commonReq({
				url : rootPath + "/companyInfo/detailInfo.do",
				data : {
					"id" : id
				},
				success : function(data) {
					$('.form-horizontal').loader('hide');
					if (data.code==0) {
					var dataSucess = data.data;
					$("#EditCode").val("");
					$("#EditCode").val(dataSucess.code);
					$("#editName").val("");
					$("#editName").val(dataSucess.name);
					$("#editShortName").val("");
					$("#editShortName").val(dataSucess.shortName);
					$("#editEnglishName").val("");
					$("#editEnglishName").val(dataSucess.englishName);
					$("#editAddress").val('');
					$("#editAddress").val(dataSucess.address);
					$("#editType").empty();
					$("#editType").append("<option value='1'>企业单位</option>");
					$("#editType").append("<option value='0'>环保单位</option>");
					if(dataSucess.type=='0'){
						$("#editType option[value='0']").attr("selected",true);
					}else{
						$("#editType option[value='1']").attr("selected",true);
					}
					$("#editSubjection").val('');
					$("#editSubjection").val(dataSucess.subjection);
					$("#editFax").val('');
					$("#editFax").val(dataSucess.fax);
					$("#editPostCode").val('');
					$("#editPostCode").val(dataSucess.postCode);
					$("#editPhone").val('');
					$("#editPhone").val(dataSucess.phone);
					$("#editEmail").val('');
					$("#editEmail").val(dataSucess.email);
					$("#editManager").val('');
					$("#editManager").val(dataSucess.manager);
					$("#editRemark").val('');
					$("#editRemark").val(dataSucess.remark);
					}
				}
			});
};

function updateCompanyInfo() {
	$('#formInsertInfo').bootstrapValidator('validate');
	var data = $('#formInsertInfo').data('bootstrapValidator');
	if(data.isValid()){
		$.commonReq({
			url : rootPath + "/companyInfo/update.do",
			async : true,
			data : $('#formInsertInfo').serialize(),
			success : function(parame) {
				$('.form-horizontal').loader('hide');
				if (parame.data) {
					bootbox.alert('企业资料修改成功!');
					newInfo();
					$('#myModalUpdateUser').modal('hide');
				} else {
					bootbox.alert('企业资料修改失败!');
					$('#myModalUpdateUser').modal('hide');
				}
			},
			error : function(parame) {
			}
		});
	}
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		code : $("#codeId").val(),
		name : $("#nameId").val(),
	};
	return temp;
}