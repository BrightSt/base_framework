/**
 * 企业用户管理js页面
 */
var rootPath = getRootPath();
$(function() {
	newInfo();
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
	bootbox.confirm("您确定要删除的数据吗？", function(result) {
		if (result) {
			$.commonReq({
				url : rootPath + '/roleInfo/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					if (data.data) {
						$('#dt').bootstrapTable('refresh', {
							url : rootPath + '/roleInfo/all.do'
						});
					} else {
						bootbox.alert('删除失败！');
					}

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
	if (rows.length > 1) {
		bootbox.alert("请选择一条数据进行删除！");
		return -1;
	}
	var str = "";
	if (rows != null) {
		for (var i = 0; i < rows.length; i++) {
			str += rows[i].id + ",";
		}
		str = str.substring(0, str.lastIndexOf(','));
	}
	return str;
}
function updateSearch(a, c) {
	$('#zscdupdate').html('');// 清空select
	$.ajax({
		type : "post",
		url : "<%=basePath%>loginGpsUser/updateroleSelectGps.do",
		async : false,
		data : {
			umid : a
		},
		success : function(parame) {
			var jhc = parame;
			if (jhc != null && jhc.length > 0) {
				suoding(jhc[0].UR_ID);
			} else {
				suoding(0);
			}

		},
		error : function(parame) {
		}
	});
}
function suoding(a) {
	$.ajax({
		type : "post",
		url : "/.do",
		async : false,
		success : function(parame) {
			var jhc = parame;
			for (var i = 0; i < jhc.length; i++) {
				$("#zscdupdate").append(
						"<option value='" + jhc[i].UR_ID + "'>"
								+ jhc[i].UR_NAME + "</option>");
			}
			$("#zscdupdate option[value=" + a + "]").attr("selected", true);
		},
		error : function(parame) {
		}
	});
}

function newInfo() {
	$('#dt').bootstrapTable('destroy');
	$('#dt')
			.bootstrapTable(
					{
						method : 'post',
						contentType : "application/x-www-form-urlencoded",
						url : rootPath + '/roleInfo/all.do',
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
									field : 'id',
									title : '角色编号',
									valign : 'middle'
								},
								{
									field : 'name',
									title : '角色名称',
									valign : 'middle'
								},
								{
									field : 'remark',
									title : '备注',
									valign : 'middle'
								},
								{
									field : 'createDateTime',
									title : '创建时间',
									valign : 'middle',
									formatter : function(value, data, index) {
										return fmtDate(value, "yyyy-MM-dd");
									}

								},
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" class="btn btn-success btn-xs btn-info" style="margin-right:10px;" onclick="editInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
										m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
										m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="confMenuInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-lock"></span>菜单分配</button>';
										return m;
									},
									valign : 'middle'
								} ],
						onLoadSuccess : function() {
						},
						onLoadError : function() {
						}
					});
}

function editInfo(id) {
	$("#update_id").val("").val(id);
	$.commonReq({
		url : rootPath + "/roleInfo/detailInfo.do",
		data : {
			"id" : id
		},
		success : function(data) {
			if (data.code==0) {
				$('.form-horizontal').loader('hide');
				$('#myModalUpdate').modal('show');
				var dataSucess = data.data;
				$("#updatename").val("").val(dataSucess.name);
				$("#updateremark").val("").val(dataSucess.remark);
			}
		}
	});
};

function updateRoleInfo() {
	var id = $("#update_id").val();
	$.commonReq({
		url : rootPath + "/roleInfo/update.do?id=" + id,
		async : true,
		data : $('#formupdateUserInfo').serialize(),
		beforeSend : function() {
			// 防止表单提交
			$('.form-horizontal').loader('show',
					'<img src="resources/images/loading.gif">');
		},
		success : function(parame) {
			$('.form-horizontal').loader('hide');
			if (parame.data>0) {
				bootbox.alert('角色修改成功!');
				newInfo();
				$('#myModalUpdate').modal('hide');
			} else {
				bootbox.alert('角色修改失败!');
				$('#myModalUpdate').modal('hide');
			}
		},
		error : function(parame) {
		}
	});
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		code : $("#code").val(),
		status : $("#state option:selected").val(),
		name : $("#name").val(),
	};
	return temp;
}

function addInfo() {
	$("#myModalInsert").modal("show");
}

/**
 * 角色名称防重复校验
 * 
 * @param name
 * @returns
 */
function checkName(name) {
	if (null != name && name != "") {
		$.commonReq({
			url : rootPath + "/roleInfo/countByName.do",
			data : {
				"name" : name,
				"page" : false
			},
			success : function(data) {
				$('.form-horizontal').loader('hide');
				if (!data.rows.length > 0) {
					document.getElementById("xianshi").innerHTML = "角色名已存在！";
				} else {
					document.getElementById("xianshi").innerHTML = "";
				}
			}
		});
	}
}

function submitInfo() {
	var name = document.getElementById("xianshi").innerHTML;
	if (name == "角色名已存在！") {
		bootbox.alert("请更改角色名");
		return;
	}

	$.commonReq({
		url : rootPath + "/roleInfo/add.do",
		async : true,
		data : $('#formInsertRoleInfo').serialize(),
		beforeSend : function() {
			// 防止表单提交
			$('.form-horizontal').loader('show',
					'<img src="resources/images/loading.gif">');
		},
		success : function(parame) {
			$('.form-horizontal').loader('hide');
			if (parame.data) {
				bootbox.alert('角色新增成功!');
				newInfo();
				$('#myModalInsert').modal('hide');
			} else {
				bootbox.alert('角色新增失败!');
				$('#myModalInsert').modal('hide');
			}
		},
		error : function(parame) {
		}
	});
}

function confMenuInfo(roleid) {
	var data = "";
	$.commonReq1({
		url : rootPath + "/roleMenu/menuTreeData.do",
		data : {
			"roleid" : roleid
		},
		async : false,
		success : function(result) {
			$('.form-horizontal').loader('hide');
			data = result.data;
		}
	});
	$('#searchTree').treeview({
		showCheckbox : true,
		data : data,
		onNodeChecked : nodeChecked,
		onNodeUnchecked : nodeUnchecked
	});

	$("#roleConfModal").modal("show");
	$("#roleid").val("").val(roleid);
}

function insertMenuInfo() {
	// 获取选中节点
	var checks = $('#searchTree').treeview('getChecked');
	var roleid = $("#roleid").val();

	var checkIds = "";
	// 配置用户角色
	for (var i = 0; i < checks.length; i++) {
		checkIds += checks[i].id + ",";
	}

	$.commonReq({
		url : rootPath + "/roleMenu/insertRoleMenu.do",
		data : {
			"roleid" : roleid,
			"menuids" : checkIds
		},
		success : function(result) {
			$('.form-horizontal').loader('hide');
			if (result.code==0) {
				bootbox.alert("菜单配置成功!");
			} else {
				bootbox.alert("菜单配置失败!");
			}
			$("#roleConfModal").modal("hide");
		},
		error : function() {
			bootbox.alert("菜单配置失败!");
			$("#roleConfModal").modal("hide");
		}
	});
}