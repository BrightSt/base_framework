/**
 * 检查管理js页面
 */
var rootPath = getRootPath();
var localhostPath = getRootPath1();
var userType = getCookie("userType")
$(function() {
	newInfo();
	$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
	$("input[name=btSelectAll]").css("verticalAlign", "middle");

	$('#inspectStartTimeId,#inspectEndTime,'+
	  '#editinspectStartTimeId,#editinspectEndTimeId,#startTimeId,#endTimeId').datetimepicker({
		pickerPosition : "bottom-left",
		language : "zh-CN",
		autoclose : true,
		minView : 2,
		format : "yyyy-mm-dd",
		todayHighlight : true
	});
	
	$('#formSubmitReform').bootstrapValidator({
		fields : {
			beforeState : {
				validators : {
					notEmpty : {
						message : '整改前情况不能为空'
					}
				}
			},
			afterState : {
				validators : {
					notEmpty : {
						message : '整改后情况不能为空'
					}
				}
			},
			startTimeId : {
				validators : {
					notEmpty : {
						message : '开始时间不能为空'
					}
				}
			},
			endTimeId : {
				validators : {
					notEmpty : {
						message : '结束时间不能为空'
					}
				}
			},
			address : {
				validators : {
					notEmpty : {
						message : '地点不能为空'
					}
				}
			},
			responsiblePerson : {
				validators : {
					notEmpty : {
						message : '联系人不能为空'
					}
				}
			},
			responsiblePhone : {
				validators : {
					notEmpty : {
						message : '联系电话不能为空'
					},
					phone:{
						country:'CN',
						message:'联系电话不能为空'
					}
				}
			},
		}
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
									field : 'inspectedEnterpriseName',
									title : '受检单位',
									valign : 'middle'
								},
								{
									field : 'inspectEnterpriseName',
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
								},/*{
									field:'fileUrl',
									title:'检测报告',
									valign:'middle',
									formatter:function(value,data,index){
										return "<a href='"+localhostPath+"/filePath/"+value+"' download='"+value.substring(value.lastIndexOf("/")+1)+"'>"+value.substring(value.lastIndexOf("/")+1)+"</a>";
									}
								},{
									field:'createTime',
									title:'创建日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd");
					                }
								}*/
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = ''
											if(userType == '0'){
												m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
											m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
											}
											m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-list-alt"></span>详情</button>';
										
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
	var start = $("#editinspectStartTimeId").val();
	var end =$("#editinspectEndTimeId").val();
	if(start>end){
		bootbox.alert('检查开始时间大于结束时间，请确认!');
		return;
	}
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
		inspectedEnterpriseNumber : $("#inspectedEnterpriseNumberId option:selected").val(),
		result : $("#resultId option:selected").val(),
	};
	return temp;
}


function editInfo(id){
	$("#uploadFileName2").html('');
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/inspection/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$('#myModalUpdateInspect').modal('show');
				$("#editinspectedEnterpriseNumber").val('').val(data.inspectedEnterpriseName);
				$("#editinspectEnterpriseNumberId").val('').val(data.inspectEnterpriseName);
				$("#editinspectStartTimeId").val('').val(fmtDate(data.inspectStartTime,'yyyy-MM-dd'));
				$("#editinspectEndTimeId").val('').val(fmtDate(data.inspectEndTime,"yyyy-MM-dd"));
				$("#editTitle").val('').val(data.title);
				$("#editcontent").val('').val(data.content);
				$("#editresultId").val('').val(data.result);
				$("#editresason").val('').val(data.reason);
				//$("#fileUrlId").val('').val(data.fileUrl);
				if(data.fileUrl.trim() !=''){
        			$("#uploadFileId2").val(data.fileUrl);
            		var nameAry = data.fileUrl.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#uploadFileName2").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#uploadFileName2").html(afterFileName);
            			}
            		}
        		}
  				$("#statusId option[value='"+data.status+"']").attr("selected",true);
			}
		});
	};
	
function detailInfo(id) {
	$("#uploadFileName3").html('');
	var localhostPath = getRootPath1();
	$.commonReq({
		url:rootPath+"/inspection/detailInfo.do",
		data:{"id":id},
		success:function(result){
			var data = result.data;
			$("#searchInspectedEnterpriseNumberId").val('').val(data.inspectedEnterpriseName)
			$("#inspectEnterpriseNumberId").val('').val(data.inspectEnterpriseName)
			$("#inspectStartTimeIdMore").val('').val(fmtDate(data.inspectStartTime,'yyyy-MM-dd'))
			$("#inspectEndTime").val('').val(fmtDate(data.inspectEndTime,"yyyy-MM-dd"))
			$("#titleId").val('').val(data.title)
			$("#contentId").val('').val(data.content)
			$("#resultId option[value='"+data.result+"']").attr('selected',true)
			$("#reasonId").val('').val(data.reason)
			/*$("#fileUrl").empty()
			$("#fileUrl").append("<a href='"+localhostPath+"/filePath/"+data.fileUrl+"' download='"+data.fileUrl.substring(data.fileUrl.lastIndexOf("/")+1)+"'>"+data.fileUrl.substring(data.fileUrl.lastIndexOf("/")+1)+"</a>");*/
			if(data.fileUrl.trim() !=''){
    			$("#uploadFileId3").val(data.fileUrl);
        		var nameAry = data.fileUrl.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim()!=''){
        				var idAry=nameAry[i].split('^');
        				var id = idAry[0];
        				var fileName = idAry[1];
        				var beforeFileList = $("#uploadFileName3").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileName =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
						$("#uploadFileName3").html(afterFileName);
        			}
        		}
    		}
			$("#myModalMore").modal('show')
		}
	})
	
}

function upload(type) {
	uploadEvtNew(type)
}
