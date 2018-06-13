/**
 * 检查管理js页面
 */
var rootPath = getRootPath();
var localhostPath = getRootPath1();
$(function() {
	newInfo();
	$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
	$("input[name=btSelectAll]").css("verticalAlign", "middle");

	$('#inspectStartTimeId,#inspectEndTime,#editinspectStartTimeId,#editinspectEndTimeId').datetimepicker({
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
				url : rootPath + '/inspection/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/inspection/all.do'
					});
				}
			});
		}
	});
}
// 点击修改加载信息
function newInfo() {
	$('#dt').bootstrapTable('destroy');
	$('#dt').bootstrapTable(
					{
						method : 'post',
						contentType : "application/x-www-form-urlencoded",
						url : rootPath + '/inspection/all.do',
						striped : true, // 是否显示行间隔色
						cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
						pagination : true,
						queryParamsType : '', // 默认值为 'limit' ,在默认情况下
												// 传给服务端的参数为：offset,limit,sort
						// 设置为 '' 在这种情况下传给服务器的参数为：pageSize,pageNumber
						queryParams : queryParams,
						singleSelect : false,
						pageSize : 10,
						pageList : [ 10, 20, 30 ],
						search : false, // 不显示 搜索框
						showColumns : false, // 不显示下拉框（选择显示的列）
						sidePagination : "server", // 服务端请求
						clickToSelect : true, // 是否启用点击选中行
						columns : [
								{
									field : 'inspectedEnterpriseNumber',
									title : '受检单位',
									valign : 'middle'
								},
								{
									field : 'inspectEnterpriseNumber',
									title : '检查单位',
									valign : 'middle'
								},
								{
									field : 'inspectStartTime',
									title : '检查开始时间',
									valign : 'middle',
									formatter:function(value){
										return fmtDate(value,"yyyy-MM-dd");
									}
								},
								{
									field : 'inspectEndTime',
									title : '检查结束时间',
									valign : 'middle',
									formatter:function(value){
										return fmtDate(value,"yyyy-MM-dd")
									}
								},{
									field:'title',
									title:'主题',
									valign:'middle'
								},{
									field:'fileUrl',
									title:'检测报告',
									valign:'middle',
									formatter:function(value,data,index){
										return "<a href='"+localhostPath+"/file/"+value+"' download='"+value.substring(value.lastIndexOf("/")+1)+"'>"+value.substring(value.lastIndexOf("/")+1)+"</a>";
									}
								},{
									field:'createTime',
									title:'创建日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd");
					                }
								},
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										
										var m = ''
											m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-list-alt"></span>详情</button>';
										m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
										m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
									
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

function updateInspectInfo() {
	var id = $("#update_id").val();
	$.commonReq({
		url : rootPath + "/inspection/update.do?id=" + id,
		async : true,
		data : $('#formupdateInfo').serialize(),
		success : function(parame) {
			bootbox.alert('检查修改成功!');
			newInfo();
			$('#myModalUpdateInspect').modal('hide');
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


function editInfo(id){
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/inspection/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$('#myModalUpdateInspect').modal('show');
				$("#editinspectedEnterpriseNumber").val('').val(data.inspectedEnterpriseNumber);
				$("#editinspectEnterpriseNumberId").val('').val(data.inspectEnterpriseNumber);
				$("#editinspectStartTimeId").val('').val(fmtDate(data.inspectStartTime,'yyyy-MM-dd'));
				$("#editinspectEndTimeId").val('').val(fmtDate(data.inspectEndTime,"yyyy-MM-dd"));
				$("#editTitle").val('').val(data.title);
				$("#editcontent").val('').val(data.content);
				$("#editresultId").val('').val(data.result);
				$("#editresason").val('').val(data.resason);
				$("#fileUrlId").val('').val(data.fileUrl);
  				$("#statusId option[value='"+data.status+"']").attr("selected",true);
			}
		});
	};
	
function detailInfo(id) {
	$.commonReq({
		url:rootPath+"/inspection/detailInfo.do",
		data:{"id":id},
		success:function(result){
			var data = result.data;
			$("#inspectedEnterpriseNumberId").val('').val(data.inspectedEnterpriseNumber)
			$("#inspectEnterpriseNumberId").val('').val(data.inspectEnterpriseNumber)
			$("#inspectStartTimeId").val('').val(fmtDate(data.inspectStartTime,'yyyy-MM-dd'))
			$("#inspectEndTime").val('').val(fmtDate(data.inspectEndTime,"yyyy-MM-dd"))
			$("#titleId").val('').val(data.title)
			$("#contentId").val('').val(data.content)
			$("#resultId option[value='"+data.result+"']").attr('selected',true)
			$("#reasonId").val('').val(data.reason)
			$("#fileUrl").empty()
			$("#fileUrl").append("<a href='"+localhostPath+"/file/"+data.fileUrl+"' download='"+data.fileUrl.substring(data.fileUrl.lastIndexOf("/")+1)+"'>"+data.fileUrl.substring(data.fileUrl.lastIndexOf("/")+1)+"</a>");
			$("#myModalMore").modal('show')
		}
	})
	
}

function upload() {
	uploadEvtNew(1)
}