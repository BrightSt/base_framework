/**
 * 检查管理js页面
 */
var rootPath = getRootPath();
var localhostPath = getRootPath1();
$(function() {
	newInfo();
	$("input[name=btSelectAll]").attr("style", "height:16px;width:16px;");
	$("input[name=btSelectAll]").css("verticalAlign", "middle");

	$('#inspectStartTimeId,#inspectEndTime,'+'#editstartTime,'+'#editendTime,'+
	  '#editinspectStartTimeId,#editinspectEndTimeId,#startTimeId,#endTimeId').datetimepicker({
		pickerPosition : "bottom-left",
		language : "zh-CN",
		autoclose : true,
		minView : 2,
		format : "yyyy-mm-dd",
		todayHighlight : true
	});
	
	//下拉搜素框
	var shi=$('#inspectedEnterpriseNumberId');
	shi.selectpicker({
		noneSelectedText:'--请选择--',
		style:'btnSelect',
		width:'200px',
		liveSearch:true,
		size:5
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
								},{
									field:'fileUrl',
									title:'检测报告',
									valign:'middle',
									formatter:function(value,data,index){
										var filePath = '';
										if(value != undefined && value.trim() != ''){
											var nameAry = value.split('|');
							        		for(var i=0;i<nameAry.length;i++){
							        			if(nameAry[i].trim() != ''){
							        				var idAry=nameAry[i].split('^');
							        				var fileName = idAry[1];
							        				var beforeFileList = filePath;
							        				var url =localhostPath+'/filePath/'+nameAry[i];
							        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
							        				filePath = afterFileList;
							        			}
							        		}
										}
										return filePath;
									}
								},{
									field:'endFlag',
									title:'整改进度',
									valign:'middle',
									formatter:function(value,data,index){
										if(value==1){
											return '已完成'
										}else{
											return '未完成'
										}
									}
								},
								{
									field : 'oper',
									title : '操作',
									valign : 'middle',
									formatter : function(value, row, index) {
										var m = ''
										if (row.result == 1) {
											if (row.submitRectify==0) {
												m+='<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="reform(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-flag"></span>提交整改报告</button>';
											}else {
												m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-list-alt"></span>整改报告详情</button>';
											m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑整改报告</button>';
											
//											m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
//													+ row.id
//													+ '\');"><span class="glyphicon glyphicon-remove"></span>删除整改报告</button>';
//											} TODO 如果要删除，需要同步更新inspection的submitRectify状态为未提交
											}
										return m;
									  }
									},
									
								} ],
						onLoadSuccess : function() {
						},
						onLoadError : function() {
						}
					});
}

function updateRectifyInfo() {
	var startTime = $("#editstartTime").val();
	var endTime = $("#editendTime").val();
	if(startTime>endTime){
		bootbox.alert('开始时间大于结束时间，请更正!');
		return;
	}
	var id = $("#update_id").val();
	$.commonReq({
		url : rootPath + "/rectifyReport/update.do?id=" + id,
		async : true,
		data : $('#formupdateInfo').serialize(),
		success : function(parame) {
			bootbox.alert('整改修改成功!');
			newInfo();
			$('#myModalUpdateRectify').modal('hide');
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
		$("#update_id").val("").val(id);
		$("#uploadFileId3").val('');
		$("#uploadFileId4").val('');
		$("#uploadFileName3").html('');
		$("#uploadFileName4").html('');
		$.commonReq({
			url:rootPath+"/rectifyReport/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$("#editafterState").val('').val(data.afterState)
				$("#editbeforeState").val('').val(data.beforeState)
				/*$("#editbeforeStateFileUrl").empty()
				
				$("#editbeforeStateFileUrl").append("<a href='"+localhostPath+"/filePath/"+data.beforeStateFileUrl+"' download='"+data.beforeStateFileUrl.substring(data.beforeStateFileUrl.lastIndexOf("/")+1)+"'>"+data.beforeStateFileUrl.substring(data.beforeStateFileUrl.lastIndexOf("/")+1)+"</a>");
				
				$("#editafterStateFileUrl").empty()
				$("#editafterStateFileUrl").append("<a href='"+localhostPath+"/filePath/"+data.afterStateFileUrl+"' download='"+data.afterStateFileUrl.substring(data.afterStateFileUrl.lastIndexOf("/")+1)+"'>"+data.afterStateFileUrl.substring(data.afterStateFileUrl.lastIndexOf("/")+1)+"</a>");*/
				$("#editstartTime").val('').val(fmtDate(data.startTime,'yyyy-MM-dd'))
				$("#editendTime").val('').val(fmtDate(data.endTime,'yyyy-MM-dd'))
				$("#editaddress").val('').val(data.address)
				$("#editresponsiblePerson").val('').val(data.responsiblePerson)
				$("#editresponsiblePhone").val('').val(data.responsiblePhone)
				$("#editEndFlag").val(data.endFlag)
				
				//整改前
				if(data.beforeStateFileUrl.trim() !=''){
        			$("#uploadFileId3").val(data.beforeStateFileUrl);
            		var nameAry = data.beforeStateFileUrl.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#uploadFileName3").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#uploadFileName3").html(afterFileName);
            			}
            		}
        		}
				//整改后
				if(data.afterStateFileUrl.trim() !=''){
        			$("#uploadFileId4").val(data.afterStateFileUrl);
            		var nameAry = data.afterStateFileUrl.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#uploadFileName4").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#uploadFileName4").html(afterFileName);
            			}
            		}
        		}
				$('#myModalUpdateRectify').modal('show');
			}
		});
	};
	
function detailInfo(id) {
	$("#uploadFileId5").val('');
	$("#uploadFileId6").val('');
	$("#uploadFileName5").html('');
	$("#uploadFileName6").html('');
	$.commonReq({
		url:rootPath+"/rectifyReport/detailInfo.do",
		data:{"id":id},
		success:function(result){
			var data = result.data;
			$("#beforeStateMore").val('').val(data.beforeState)
			$("#afterStateMore").val('').val(data.afterState)
			/*$("#beforeStateFileUrlMore").empty()
			$("#beforeStateFileUrlMore").append("<a href='"+localhostPath+"/filePath/"+data.beforeStateFileUrl+"' download='"+data.beforeStateFileUrl.substring(data.beforeStateFileUrl.lastIndexOf("/")+1)+"'>"+data.beforeStateFileUrl.substring(data.beforeStateFileUrl.lastIndexOf("/")+1)+"</a>");
			
			$("#afterStateFileUrlMore").empty()
			$("#afterStateFileUrlMore").append("<a href='"+localhostPath+"/filePath/"+data.afterStateFileUrl+"' download='"+data.afterStateFileUrl.substring(data.afterStateFileUrl.lastIndexOf("/")+1)+"'>"+data.afterStateFileUrl.substring(data.afterStateFileUrl.lastIndexOf("/")+1)+"</a>");*/
			$("#startTimeMore").val('').val(fmtDate(data.startTime,'yyyy-MM-dd'))
			$("#endTimeMore").val('').val(fmtDate(data.endTime,'yyyy-MM-dd'))
			$("#addressMore").val('').val(data.address)
			$("#responsiblePersonMore").val('').val(data.responsiblePerson)
			$("#responsiblePhoneMore").val('').val(data.responsiblePhone)
			var flag = "";
			if(data.endFlag == 1){
				flag = "已完成"
			}else{
				flag = "未完成"
			}
			$("#detailEndFlag").val('').val(flag)
			//整改前
			if(data.beforeStateFileUrl.trim() !=''){
    			$("#uploadFileId5").val(data.beforeStateFileUrl);
        		var nameAry = data.beforeStateFileUrl.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#uploadFileName5").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#uploadFileName5").html(afterFileList);
        			}
        		}
    		}
			//整改后
			if(data.afterStateFileUrl.trim() !=''){
    			$("#uploadFileId6").val(data.afterStateFileUrl);
        		var nameAry = data.afterStateFileUrl.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#uploadFileName6").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#uploadFileName6").html(afterFileList);
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

function reform(inspectId) {
	$('#inspectId').val('').val(inspectId)
	$('#myModalSubmitReform').modal('show')
}


function submitReform() {
	var startTime = $("#startTimeId").val();
	var endTime = $("#endTimeId").val();
	if(startTime>endTime){
		bootbox.alert('开始时间大于结束时间，请更正!');
		return;
	}
	var inspectId = $('#inspectId').val();
	$('#formupdateInfo').bootstrapValidator('validate');
	var data = $("#formupdateInfo").data('bootstrapValidator');
	if (data.isValid()) {
		$.commonReq({
			url:rootPath+"/rectifyReport/add.do?inspectionId="+inspectId,
			data:$('#formSubmitReform').serialize(),
			success:function(){
				bootbox.alert("整改情况提交成功！");
				newInfo()
				$('#myModalSubmitReform').modal('hide')
			}
		})
	}
	
}