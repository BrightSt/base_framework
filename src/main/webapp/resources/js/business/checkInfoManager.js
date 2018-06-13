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

});

/* 删除数据 */
function delInfo(value,assessmentId) {
	bootbox.confirm("您确定要删除该数据吗？", function(result) {
		if (result) {
			$.commonReq({
				url : rootPath + '/checkInfo/delete.do',
				data : {
					"id" : value,
					"assessmentId":assessmentId
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/checkInfo/list.do'
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
						url : rootPath + '/checkInfo/list.do',
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
									field : 'companyName',
									title : '申请企业名称',
									valign : 'middle'
								},
								{
									field : 'projectArea',
									title : '项目规模',
									valign : 'middle'
								},
								{
									field : 'projectAddress',
									title : '项目地点',
									valign : 'middle'
								},
								{
									field : 'investment',
									title : '计划投资',
									valign : 'middle'
								},
								{
									field : 'createDate',
									title : '申请日期',
									valign : 'middle',
									formatter:function(value){
										return fmtDate(value,"yyyy-MM-dd");
									}
								},
								{
									field : 'approve',
									title : '是否审批',
									valign : 'middle',
									formatter:function(value){
										if (value == 0) {
											return '未审批'
										} else {
											return '已审批'
										}
									}
								},
								{
									field : 'approveResult',
									title : '审批结果',
									valign : 'middle',
									formatter:function(value){
										if (value == 0) {
											return '通过'
										} if (value == 1) {
											return '拒绝'
										} else {
											return ''
										}
									}
								},
								{
									field : 'approveName',
									title : '审批人',
									valign : 'middle'
								},
								{
									field : 'oper',
									title : '申请操作',
									formatter : function(value, row, index) {
										var m = ''
										 m += '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-list-alt"></span>详情</button>';
										if (row.approve == 0) {
											if(userType == '1'){
												m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
													+ row.id
													+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
												m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''+ row.id+ '\',\''+row.assessmentId+'\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
											}
										} 
										return m;
									},
									valign : 'middle'
								},
								{
									field : 'oper',
									title : '审批操作',
									formatter : function(value, row, index) {
										var m = ''
											if (row.approve == 0) {
												if(userType== '0'){
													m += '<button type="button" class="btn btn-success btn-xs " style="margin-right:10px;" onclick="approve(\''+ row.id+ '\',\''+row.assessmentId+'\');"><span class="glyphicon glyphicon-ok"></span>审批</button>';
												}
											} else {
												m+='<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="approveDetail(\''+ row.approveResult+ '\',\''+row.approveRemark+'\');"><span class="glyphicon glyphicon-eye-open"></span>查看审批</button>';;
											}
											
										return m;
									},
									valign : 'middle'
								},
								],
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
		approveResult : $("#approveResultId option:selected").val(),
	};
	return temp;
}


function editInfo(id){
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/checkInfo/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;

				$("#projectAreaEdit").val('').val(data.projectArea);
				$("#projectAddressEdit").val('').val(data.projectAddress);
				$("#investmentEdit").val('').val(data.investment);
				$("#pollutionEdit").val('').val(data.pollution);
				
				if(data.filePath==''){
        			$("#downloadHref").hide();
        		}else{
        			$("#updateFileInput").val(data.filePath);
            		$("#downloadHref").attr("href", localhostPath+"/filePath/"+data.filePath ); 
        		} 
				$("#uploadFileName").empty()
        		if(data.filePath.trim() !=''){
        			$("#uploadFileId").val(data.filePath);
            		var nameAry = data.filePath.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#uploadFileName").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#uploadFileName").html(afterFileName);
            			}
            		}
        		}
			
        		$("#myModalUpdate").modal('show')
			
			}
		});
	};
	
function detailInfo(id) {
	$.commonReq({
		url:rootPath+"/checkInfo/detailInfo.do",
		data:{"id":id},
		success:function(result){
			var data = result.data;
			$("#projectAreaMore").val('').val(data.projectArea).attr("disabled",true);
			$("#projectAddressMore").val('').val(data.projectAddress).attr("disabled",true);
			$("#investmentMore").val('').val(data.investment).attr("disabled",true);
			$("#pollutionMore").val('').val(data.pollution).attr("disabled",true);
			
			$("#uploadFileNameMore").empty()
    		var afterName = '';
    		if(data.filePath !=''){
    			var nameAry = data.filePath.split('|');
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

function upload() {
	uploadEvtNew(1)
}

function submitCheck(){
	var id = $("#update_id").val();
	$.commonReq({
		url:rootPath+"/checkInfo/update.do?id="+id,
		data:$("#formInsertInfoCheck").serialize(),
		success:function(result){
			bootbox.alert('修改成功')
			newInfo();
			$("#myModalUpdate").modal('hide')
		}
		
	})
}


function approve(id,assessmentId){
	$("#approveModel").modal('show')
	$("#approveRemarkId").val("");
	$("#envId").val(assessmentId)
	$("#approveId").val(id)
}

function submitApprove(){
	var id = $("#approveId").val()
	var assessmentId = $("#envId").val()
	var approveRemarkId = $("#approveRemarkId").val()
	if(approveRemarkId==''||approveRemarkId==null){
		bootbox.alert('请在备注栏填写审批意见')
		return
	}
	$.commonReq({
		url:rootPath+"/envAssessment/update.do?id="+assessmentId,
		data:{"checkSubmit":1},
		success:function(result){
			$.commonReq({
				url:rootPath+"/checkInfo/updateApprove.do?id="+id,
				data:$('#formSubmitApprove').serialize(),
				success:function(result){
					bootbox.alert('审批完成')
					newInfo()
					$("#approveModel").modal('hide')
				}
			})
		}
	})
	
}


function approveDetail(approveResult,approveRemark) {
	$("#approveModelInfo").modal('show')
	$("#approveResultIdMore").val(approveResult);
	$("#approveResultIdMore").attr("disabled",true);
	$("#approveRemarkIdMore").val('').val(approveRemark)
	$("#approveRemarkIdMore").attr("disabled",true);
}