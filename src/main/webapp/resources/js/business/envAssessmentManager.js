/**
 * 
 *//**
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
	  '#editinspectStartTimeId,#editinspectEndTimeId,#startTimeId,#endTimeId,#validateDateEdit').datetimepicker({
		pickerPosition : "bottom-left",
		language : "zh-CN",
		autoclose : true,
		minView : 2,
		format : "yyyy-mm-dd",
		todayHighlight : true
	});
	
	$('#formInsertInfo').bootstrapValidator({
		fields : {
			projectInfo : {
				validators : {
					notEmpty : {
						message : '项目信息不能为空'
					}
				}
			},
			envInfo : {
				validators : {
					notEmpty : {
						message : '环境信息不能为空'
					}
				}
			},
			content : {
				validators : {
					notEmpty : {
						message : '环评内容不能为空'
					}
				}
			},
			validateDate : {
				validators : {
					notEmpty : {
						message : '有效期不能为空'
					}
				}
			},
			thirdCompanyName : {
				validators : {
					notEmpty : {
						message : '委托第三方企业名称不能为空'
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
				url : rootPath + '/envAssessment/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/envAssessment/list.do'
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
						url : rootPath + '/envAssessment/list.do',
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
									field : 'applyCompanyName',
									title : '申请单位',
									valign : 'middle'
								},
								{
									field : 'thirdCompanyName',
									title : '委托第三方企业名称',
									valign : 'middle'
								},
								{
									field : 'validateDate',
									title : '有效期至',
									valign : 'middle',
									formatter:function(value){
										return fmtDate(value,"yyyy-MM-dd");
									}
								},
								{
									field:'approve',
									title:'是否审批',
									valign:'middle',
									formatter:function(value){
										if (value==0) {
											return "未审批"
										} else {
											return "已审批"
										}
									}
								},{
									field:'approveResult',
									title:'审批结果',
									valign:'middle',
									formatter:function(value,data,index){
										if(value == 0){
											return '通过'
										}else if (value == 1) {
											return '拒绝'
										}
									}
								},{
									field:'approveName',
									title:'审批人',
									valign:'middle'
								},{
									field:'createDate',
									title:'创建日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd");
					                }
								},
								{
									field : 'oper',
									title : '申请操作',
									formatter : function(value, row, index) {
										var m = ''
											m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-list-alt"></span>详情</button>';
											if(userType == '1'){
												if (row.approve == 0) {
													m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
														+ row.id
														+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
													m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
														+ row.id
														+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
												}else{
													if (row.checkSubmit==0) {
														if(row.approveResult==0){
															m += '<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="checkInfo(\''
																+ row.id
																+ '\');"><span class="glyphicon glyphicon-upload"></span>验收申请</button>';
														}else {
															m += '<button type="button" class="btn btn-link[disabled] btn-xs" style="margin-right:10px;" onclick="checkInfoForce(\''
																+ row.id
																+ '\');"><span class="glyphicon glyphicon-upload"></span>验收申请</button>';
														}
														
													}
												}
											}
										return m;
									},
									valign : 'middle'
								},{
									field:'oper',
									title:'审批操作',
									formatter:function(value,row,index){
										var m = ''
											
										if(row.approve == '1'){
											m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="approveDetail(\''+ row.approveResult+ '\',\''+row.approveRemark+'\');"><span class="glyphicon glyphicon-eye-open"></span>查看审批</button>';
										}else{
											if(userType == '0'){
												m+='<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="approve(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-ok"></span>审批</button>';
											}
										}
										return m
									}
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
		url : rootPath + "/envAssessment/update.do?id=" + id,
		async : true,
		data : $('#formUpdateInfo').serialize(),
		success : function(parame) {
			bootbox.alert('环评申请修改成功!');
			newInfo();
			$('#myModalUpdateInspect').modal('hide');
		}
	});
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		applyCompanyCode : $("#applyCompanyCodeId option:selected").val(),
		approveResult : $("#approveResultId option:selected").val(),
	};
	return temp;
}


function editInfo(id){
	$("#uploadFileId4").val('');
	$("#uploadFileName4").html("");
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/envAssessment/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$("#updateUploadFileName").empty()
				$("#projectInfoEdit").val('').val(data.projectInfo)
				$("#envInfoEdit").val('').val(data.envInfo)
				$("#contentEdit").val('').val(data.content)
				$("#validateDateEdit").val('').val(fmtDate(data.validateDate,'yyyy-MM-dd'))
				$("#thirdCompanyNameEdit").val('').val(data.thirdCompanyName)
				
        	/*	if(data.assessmentFile==''){
        			$("#downloadHref").hide();
        		}else{
        			$("#updateFileInput").val(data.assessmentFile);
            		$("#downloadHref").attr("href", localhostPath+"/filePath/"+data.assessmentFile ); 
        		} 
				*/
        		if(data.assessmentFile.trim() !=''){
        			$("#uploadFileId4").val(data.assessmentFile);
            		var nameAry = data.assessmentFile.split('|');
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
				
				$("#myModalUpdateInspect").modal('show')
			}
		});
	};
	
function detailInfo(id) {
	$.commonReq({
		url:rootPath+"/envAssessment/detailInfo.do",
		data:{"id":id},
		success:function(result){
			var data = result.data;
			$("#uploadFileNameMore").empty().attr("disabled",true)
			$("#projectInfoMore").val('').val(data.projectInfo).attr("disabled",true)
			$("#envInfoMore").val('').val(data.envInfo).attr("disabled",true)
			$("#contentMore").val('').val(data.content).attr("disabled",true)
			$("#validateDateMore").val('').val(fmtDate(data.validateDate,"yyyy-MM-dd")).attr("disabled",true)
			$("#thirdCompanyNameMore").val('').val(data.thirdCompanyName).attr("disabled",true)
    		var afterName = '';
    		if(data.assessmentFile !=''){
    			var nameAry = data.assessmentFile.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#uploadFileNameMore").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#uploadFileNameMore").html(afterFileList);
        			}
        		}
        		$('#urlDiv2').show();
    		}
    		
			$("#myModalMore").modal('show')
		}
	})
	
}

function upload(type) {
	uploadEvtNew(type)
}

function approve(id){
	$("#approveModel").modal('show')
	$("#approveRemarkId").val("");
	$("#envId").val(id)
}
function submitApprove(){
	var id = $("#envId").val()
	var approveRemarkId = $("#approveRemarkId").val()
	if(approveRemarkId==''||approveRemarkId==null){
		bootbox.alert('请在备注栏填写审批意见')
		return
	}
	$.commonReq({
		url:rootPath+"/envAssessment/updateApprove.do?id="+id,
		data:$('#formSubmitApprove').serialize(),
		success:function(result){
			bootbox.alert('审批完成')
			newInfo()
			$("#approveModel").modal('hide')
		}
	})
}
function submitCheck(){
	var assessmentId = $("#assessmentId").val()
	$.commonReq({
		url:rootPath+"/checkInfo/add.do?assessmentId="+assessmentId,
		data:$('#formInsertInfoCheck').serialize(),
		success:function(result){
			bootbox.alert('验收提交成功')
			newInfo()
			$("#checkModal").modal('hide')
		}
	})
}

function approveDetail(approveResult,approveRemark) {
	$("#approveModelInfo").modal('show')
	/*$("#approveResultIdMore option[value='"+approveResult+"']").attr("selected",true)*/
	$("#approveResultIdMore").val(approveResult);
	$("#approveResultIdMore").attr("disabled",true);
	$("#approveRemarkIdMore").val('').val(approveRemark)
	$("#approveRemarkIdMore").attr("disabled",true);
}
  
function checkInfo(assessmentId){
	$('#checkModal').modal('show')
	$("#assessmentId").val(assessmentId)
}

function checkInfoForce() {
	bootbox.alert("环评申请被拒绝，不可验收申请！")
}
