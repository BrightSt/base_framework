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
	bootbox.confirm("您确定要删除该数据吗？", function(result) {
		if (result) {
			$.commonReq({
				url : rootPath + '/userInfo/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/userInfo/all.do'
					});
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
// 点击修改加载员工信息
function newInfo() {
	$('#dt').bootstrapTable('destroy');
	$('#dt')
			.bootstrapTable(
					{
						method : 'post',
						contentType : "application/x-www-form-urlencoded",
						url : rootPath + '/userInfo/all.do',
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
									field : 'userName',
									title : '用户账号',
									valign : 'middle'
								},
								{
									field : 'name',
									title : '用户姓名',
									valign : 'middle'
								},
								{
									field : 'companyCode',
									title : '所属单位编号',
									valign : 'middle'
								},
								{
									field : 'companyName',
									title : '所属单位名称',
									valign : 'middle'
								},/*{
									field:'createUserName',
									title:'创建人',
									valign:'middle'
								},{
									field:'createName',
									title:'创建人姓名',
									valign:'middle'
								},*/{
									field:'createDateTime',
									title:'创建日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd");
					                }
								},
								{
									field : 'statusName',
									title : '用户状态',
									valign : 'middle'
								},
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
										m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
										m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="confRoleInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-lock"></span>角色分配</button>';
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

function updateUserInfo() {
	// 校验不能为空的字段
	var name = $("#nameId").val().trim();// 用户名称
	if (name == "") {
		bootbox.alert("用户姓名不能为空！");
		return;
	}
	var id = $("#update_id").val();
	$.commonReq({
		url : rootPath + "/userInfo/update.do?id=" + id,
		async : true,
		data : $('#formupdateUserInfo').serialize(),
		success : function(parame) {
			bootbox.alert('用户修改成功!');
			newInfo();
			$('#myModalUpdateUser').modal('hide');
		},
		error : function(parame) {
			bootbox.alert('用户修改失败!');
		}
	});
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		userName : $("#userName").val(),
		companyCode : $("#companyCodeId option:selected").val(),
		status : $("#statusId option:selected").val(),
	};
	return temp;
}

function confRoleInfo(userid) {
	var data = "";
	$.commonReq1({
		url : rootPath + "/userRole/roleTree.do",
		data : {
			"id" : userid
		},
		async : false,
		success : function(result) {
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
	$("#userid").val("").val(userid);
}

function insertRoleInfo() {
	// 获取选中节点
	var checks = $('#searchTree').treeview('getChecked');
	var userid = $("#userid").val();

	var checkIds = "";
	// 配置用户角色
	for (var i = 0; i < checks.length; i++) {
		checkIds += checks[i].id + ",";
	}

	$.commonReq({
		url : rootPath + "/userRole/insertRole.do",
		data : {
			"userId" : userid,
			"roleIdsStr" : checkIds
		},
		success : function(result) {
			bootbox.alert("角色配置成功!");
			$("#roleConfModal").modal("hide");
		},
		error : function() {
			bootbox.alert("角色配置失败!");
			$("#roleConfModal").modal("hide");
		}
	});
}

function editInfo(id){
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/userInfo/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$('#myModalUpdateUser').modal('show');
				$("#userNameId").val('').val(data.userName);
				$("#nameId").val('').val(data.name);
  				$("#company_id").val('').val(data.companyName)
  				$("#statusIdEdit option").attr("selected", false);
  				$("#statusIdEdit").empty()
  				$("#statusIdEdit").append("<option value='0'>正常</option> <option value='1'>冻结</option>")
  				$("#statusIdEdit option[value='"+data.status+"']").attr("selected",true);
			}
		});
	};