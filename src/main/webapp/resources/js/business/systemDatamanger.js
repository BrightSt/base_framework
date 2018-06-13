var rootPath = getRootPath();
$(function() {
	$("#insertSysDataModal").on("hidden.bs.modal", function() {
		$(this).removeData("bs.modal");
	});
	// 查询数据字典类型
	$.commonReq({
		url : rootPath + "/systemData/findAllRemarks.do",
		async : true,
		success : function(data) {
			$('.form-horizontal').loader('hide');
			var str = '<option value="">  ---请选择备注--- </option>';
			var data = data.data;
			if(data!=null && data!=undefined && data.length>0){
				for (var i = 0; i < data.length; i++) {
					str += '<option value="' + data[i].code + '">' + data[i].remark
							+ '</option>';
				}
				$("#viewRemark").empty();
				$("#viewRemark").append(str);
			}
		}
	});
	initTable();
	// 当点击查询按钮的时候执行
	$("#search").click(function() {
		initTable();
		$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
		$("input[name=btSelectAll]").css("verticalAlign", "middle");
	});
	function initTable() {
		$('#dt').bootstrapTable('destroy');
		$('#dt')
				.bootstrapTable(
						{
							method : 'post',
							contentType : "application/x-www-form-urlencoded",
							url : rootPath + "/systemData/findAll.do",
							striped : true,// 隔行变色
							pagination : true,
							singleSelect : false,
							queryParamsType : '',
							queryParams : queryParams,// 带参数查询
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
										field : 'id',
										title : '',
										visible : false,
										valign : 'middle'
									},
									{
										field : 'code',
										title : '字典代号',
										valign : 'middle'
									},
									{
										field : 'number',
										title : '数据编码',
										valign : 'middle'
									},
									{
										field : 'name',
										title : '数据名称',
										valign : 'middle'
									},
									{
										field : 'remark',
										title : '字典类型备注',
										valign : 'middle'
									},
									{
										field : 'createtime',
										title : '创建时间',
										formatter : function(value, data, index) {
											return fmtDate(value,
													"yyyy-MM-dd HH:mm:ss");
										},
										valign : 'middle'
									},
									{
										field : 'oper',
										title : '操作',
										formatter : function(value, row, index) {
											var m = '<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="updateSysDataInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
											m += '<button type="button" class="btn btn-danger btn-xs " style="margin-right:10px;" onclick="delSysDataInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-lock"></span>删除</button>';
											return m;
										},
										valign : 'middle'
									} ],
							onLoadSuccess : function() {
							},
							onLoadError : function() {
								bootbox.alert("数据加载失败！");
							}
						});
	}
	$(function() {
		$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
		$("input[name=btSelectAll]").css("verticalAlign", "middle");
	});

	function queryParams(params) {
		var name = $('#viewName').val();
		var remark = $('#viewRemark option:selected').val();
		var temp = {
			pageSize : params.pageSize,
			pageNumber : params.pageNumber,
			name : name,
			code : remark
		};
		return temp;
	}

	// 保存操作
	$('#save').click(function() {
		var flag = true;
		// 数据字典类型名称
		var code = $("#remark").val();
		if (checkNullAndEmpty(code)) {
			bootbox.alert("数据字典类型不能为空！");
			flag = false;
			return;
		}

		// 数据名称
		var name = $("#sddName").val();
		if (checkNullAndEmpty(name)) {
			bootbox.alert("数据名称不能为空！");
			flag = false;
			return;
		}
		var remark = $("#remark").find("option:selected").text();
		if (flag) {
			// 数据名称防重复
			$.commonReq({
				url : rootPath + "/systemData/findAll.do",
				data : {
					"code" : code,
					"name" : name,
					"page" : false
				},
				success : function(data) {
					$('.form-horizontal').loader('hide');
					if (data.total > 0) {
						bootbox.alert("名称重复！");
					} else {
						$.commonReq({
							async : false,
							url : rootPath + "/systemData/insertData.do",
							type : "POST",
							dataType : "json",
							data : {
								"code" : code,
								"remark" : remark,
								"name" : name
							},
							success : function(data) {
								$('.form-horizontal').loader('hide');
								// 关闭静态框
								$('#insertSysDataModal').modal('hide');
								$("#insertSysDataModal").find("input").val("");
								// 刷新页面
								$("#dt").bootstrapTable('refresh', {
									url : rootPath + '/systemData/findAll.do'
								});
							}
						});
					}
				}
			})
		}
	});

	// 保存操作
	$('#updateSysInfoBtn').click(function() {
		var flag = true;
		// 数据名称
		var updateName = $("#updateName").val();
		if (checkNullAndEmpty(updateName)) {
			bootbox.alert("数据名称不能为空！");
			flag = false;
			return;
		}
		if (flag) {
			$.commonReq({
				async : false,
				url : rootPath + "/systemData/updataData.do",
				type : "POST",
				dataType : "json",
				data : $('#updateSysInfoForm').serialize(),
				success : function(data) {
					$('.form-horizontal').loader('hide');
					// 关闭静态框
					$('#updateSysDataModal').modal('hide');
					// 刷新页面
					$("#dt").bootstrapTable('refresh', {
						url : rootPath + '/systemData/findAll.do'
					});
				}
			});
		}
	});
});

function updateSysDataInfo(value) {
	$.commonReq({
		async : false,
		url : rootPath + "/systemData/toUpdateSysData.do",
		type : "POST",
		data : {
			id : value
		},
		success : function(data) {
			$('.form-horizontal').loader('hide');
			if (data.code == 0) {
				$('#updateSysDataModal').find(":input").val("");
				var data = data.data;
				$("#updateId").val(data.id + "");
				$("#updateNumber").val(data.number + "");
				$("#updateName").val(data.name + "");
				$("#updateCode").val(data.code + "");
				$("#updateRemark").val(data.remark + "");
				$('#updateSysDataModal').modal('show');
			} else {
				var data = data.data;
				bootbox.alert(data.error);
			}
		}
	});
}

// 增加数据
function addSysDataInfo() {

	$('#updateSysDataModal').modal('hide');
	$.commonReq({
		type : "post",
		url : rootPath + "/systemData/findAllRemarks.do",
		async : true,
		dateType : "json",
		success : function(data) {
			$('.form-horizontal').loader('hide');
			var str = '<option value="">-请选择-</option>';
			if (data.code == 0) {
				var data = data.data;
				for (var i = 0; i < data.length; i++) {
					str += '<option value="' + data[i].code + '">'
							+ data[i].remark + '</option>';
				}
				$("#remark").empty();
				$("#remark").append(str);
				$("#insertSysDataModal").modal('show');
			}
		},
		error : function() {
		}
	});
}

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
// 删除方法
function delSysDataInfo(value) {
	bootbox.confirm("您确定要删除此数据吗？", function(result) {
		if (result) {
			$.commonReq({
				async : false,
				url : rootPath + "/systemData/deleteData.do",
				data : {
					id : value
				},
				success : function(data) {
					$('.form-horizontal').loader('hide');
					// 刷新页面
					$("#dt").bootstrapTable('refresh', {
						url : rootPath + '/systemData/findAll.do'
					});
				}
			});
		}
	});
}
/* 验证是否为空 */
function checkNullAndEmpty(value) {
	if (value == null || value.trim() == '') {
		return true;
	} else {
		return false;
	}
}