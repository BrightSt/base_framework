/**
 * 企业用户管理js页面
 */
var rootPath = getRootPath();
$(function() {
	newInfo();
	$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
	$("input[name=btSelectAll]").css("verticalAlign", "middle");

});

// 点击修改加载员工信息
function newInfo() {
	$('#dt').bootstrapTable('destroy');
	$('#dt')
			.bootstrapTable(
					{
						method : 'post',
						contentType : "application/x-www-form-urlencoded",
						url : rootPath + '/operationRecord/list.do',
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
									title : '操作账号',
									valign : 'middle'
								},
								{
									field : 'methodName',
									title : '方法名称',
									valign : 'middle'
								},
								{
									field : 'method',
									title : '方法',
									valign : 'middle'
								},
								{
									field : 'result',
									title : '处理结果',
									valign : 'middle',
									formatter:function(value,row,index){
										
										if(value==0){
											return "成功";
										}else{
											return "失败";
										}
									}
								},{
									field:'msg',
									title:'响应信息',
									valign:'middle'
								},{
									field:'oprDateTime',
									title:'操作日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd HH:mm:ss");
					                }
								},
								
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="detailInfo(\''
												+ row.parameter
												+ '\');"><span class="glyphicon glyphicon-edit"></span>参数详情</button>';
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

function detailInfo(parameter) {
	$('#myModalMore').modal('show');
	$('#parameterId').val('').val(parameter);

}

function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		userName : $("#userName").val()
	};
	return temp;
}
