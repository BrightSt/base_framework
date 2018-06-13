/**
 * 处罚管理js页面
 */
var rootPath = getRootPath();
var userType = getCookie("userType");	
var localhostPath = getRootPath1();
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
			punishNumber : {
				validators : {
					notEmpty : {
						message : '处罚文号不能为空'
					}
				}
			},
			fact : {
				validators : {
					notEmpty : {
						message : '违法事实不能为空'
					}
				}
			},
			according : {
				validators : {
					notEmpty : {
						message : '处罚依据不能为空'
					}
				}
			},
			content : {
				validators : {
					notEmpty : {
						message : '处罚内容不能为空'
					}
				}
			},
			execute : {
				validators : {
					notEmpty : {
						message : '执行情况不能为空'
					}
				}
			},
		}
	});
});
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
								}/*,{
									field:'createTime',
									title:'创建日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd");
					                }
								},{
									field:'result',
									title:'检查结果',
									valign:'middle',
									formatter:function(value,data,index){
					                	if(value == 0){
					                		return '符合'
					                	}else{
					                		return '不符合'
					                	}
					                }
								}*/,
								{
									field : 'oper',
									title : '整改操作',
									valign : 'middle',
									formatter : function(value, row, index) {
										var m = ''
										if (row.result == 1) {
											if (row.submitRectify==0) {
												
											}else {
												m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-list-alt"></span>整改报告详情</button>';
											}
										return m;
									  }
									},
									
								},{

									field : 'oper',
									title : '处罚操作',
									valign : 'middle',
									formatter : function(value, row, index) {
										var m = ''
										if (row.submitPunish == 0 && userType=="0") {
											m+='<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="reform(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-flag"></span>提交处罚报告</button>';
											
											
										
									  }else if(row.submitPunish == 1){
										  m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfoPunish(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-list-alt"></span>处罚报告详情</button>';
										  
										  if(userType == 0){
											  m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑处罚报告</button>';
										  }
										  
									  }
										return m;
									},
								}
								],
						onLoadSuccess : function() {
						},
						onLoadError : function() {
						}
					});
}

function updateRectifyInfo() {
	var id = $("#update_id").val();
	$.commonReq({
		url : rootPath + "/punishment/update.do?inspectionId=" + id,
		async : true,
		data : $('#formupdateInfo').serialize(),
		success : function(parame) {
			bootbox.alert('整改修改成功!');
			newInfo();
			$('#myModalUpdateRectify').modal('hide');
			$('#uploadFileName2').html('');
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
		$("#uploadFileId2").val('');
		$("#uploadFileName2").html('');
		$.commonReq({
			url:rootPath+"/punishment/detailInfoByInspectionId.do",
			data:{"inspectionId":id},
			success:function(data){
				var data = data.data;
				$("#editpunishNumber").val('').val(data.punishNumber)
				$("#editfact").val('').val(data.fact);
				$("#editaccording").val('').val(data.according);
				$("#editcontent").val('').val(data.content);
				$("#editexecute").val('').val(data.execute);
				$("#editpunishFileUrl").empty()
				if(data.punishFileUrl.trim() !=''){
	    			$("#uploadFileId2").val(data.punishFileUrl);
	        		var nameAry = data.punishFileUrl.split('|');
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
			debugger;
			var data = result.data;
			
			var endFlag =data.endFlag
			if(endFlag==0){
				var str = '未完成'
			}else{
				var str = '已完成'
			}
			$("#tailEndFlag").val('').val(str)
			$("#beforeStateMore").val('').val(data.beforeState)
			$("#afterStateMore").val('').val(data.afterState)
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
			$("#startTimeMore").val('').val(fmtDate(data.startTime,'yyyy-MM-dd'))
			$("#endTimeMore").val('').val(fmtDate(data.endTime,'yyyy-MM-dd'))
			$("#addressMore").val('').val(data.address)
			$("#responsiblePersonMore").val('').val(data.responsiblePerson)
			$("#responsiblePhoneMore").val('').val(data.responsiblePhone)
			$("#myModalMore").modal('show')
		}
	})
	
}

function upload(type) {
	uploadEvtNew(type)
}

function reform(inspectId) {
	$('#uploadFileId1').val('');
	$('#addexecuteId').val('');
	$('#addcontentId').val('');
	$('#addaccordingId').val('');
	$('#addpunishNumberId').val('');
	$('#addfactId').val('');
	$('#inspectId').val('').val(inspectId)
	$('#myModalSubmitReform').modal('show')
}


function submitReform() {
	
	var punishFileUrl = $("#uploadFileId1").val()
	if(null == punishFileUrl || punishFileUrl==""){
		bootbox.alert('处罚决定书不能为空！')
		return
	}
	var inspectId = $('#inspectId').val();
	$('#formSubmitReform').bootstrapValidator('validate');
	var data = $("#formSubmitReform").data('bootstrapValidator');
	if (data.isValid()) {
		$.commonReq({
			url:rootPath+"/punishment/add.do?inspectionId="+inspectId,
			data:$('#formSubmitReform').serialize(),
			success:function(){
				bootbox.alert("处罚情况提交成功！");
				newInfo()
				$('#myModalSubmitReform').modal('hide')
				$('#uploadFileName1').html('')
			}
		})
	}
}

function detailInfoPunish(id){
	$("#uploadFileId3").val('');
	$("#uploadFileName3").html('');
	$.commonReq({
		url:rootPath+"/punishment/detailInfoByInspectionId.do",
		data:{"inspectionId":id},
		success:function(result){
			var data = result.data;
			$('#punishNumberId').val('').val(data.punishNumber)
			$('#factId').val('').val(data.fact)
			$('#accordingId').val('').val(data.according)
			$('#contentId').val('').val(data.content)
			$('#executeId').val('').val(data.execute)
			if(data.punishFileUrl.trim() !=''){
    			$("#uploadFileId3").val(data.punishFileUrl);
        		var nameAry = data.punishFileUrl.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#uploadFileName3").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#uploadFileName3").html(afterFileList);
        			}
        		}
    		}
			$("#myModalMorePunish").modal('show')
		}
	})
}