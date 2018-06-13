
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
	
	var qyname = $('#companyCodeId');
	qyname.selectpicker({
		noneSelectedText : '--请选择--',
		style : 'btnSelect',
		width : '200px',
		liveSearch : true,
		liveSearchPlaceholder : '请输入名称查询',
		size : 10
	});
	

	$('#formupdateInfo').bootstrapValidator({
		fields : {
			name : {
				validators : {
					notEmpty : {
						message : '人员姓名不能为空'
					}
				}
			},
			age : {
				validators : {
					notEmpty : {
						message : '年龄不能为空'
					}
			
				}
			},
			cardNo : {
				validators : {
					notEmpty : {
						message : '身份证号不能为空'
					},
					regexp: {
                        regexp: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
                        message: '身份证号格式不正确'
                    }
				}
			},
			qualificationStart : {
				validators : {
					notEmpty : {
						message : '资格证起始时间不能为空'
					}
				}
			},
			qualificationLong : {
				validators : {
					notEmpty : {
						message : '资格证有效时长不能为空'
					}
				}
			}
		}
	});
	
});

/* 删除数据 */
function delInfo(value) {
	bootbox.confirm("您确定要删除该数据吗？", function(result) {
		if (result) {
			$.commonReq({
				url : rootPath + '/employeeTraining/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/employeeTraining/all.do'
					});
				}
			});
		}
	});
}

function newInfo() {
	$('#dt').bootstrapTable('destroy');
	$('#dt').bootstrapTable(
					{
						method : 'post',
						contentType : "application/x-www-form-urlencoded",
						url : rootPath + '/employeeTraining/all.do',
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
									field:'',
									checkbox:true,
									valign: "middle"
								},{
									field:'id',
									visible:false
								},{
									field : 'name',
									title : '姓名',
									valign : 'middle'
								},{
									field : 'gender',
									title : '性别',
									valign : 'middle',
									formatter:function(value){
										if (value == "0") {
											return '男'
										} else {
											return '女'
										}
									}
								}
								,{
									field : 'age',
									title : '年龄',
									valign : 'middle'
								},
								{
									field : 'cardNo',
									title : '身份证号',
									valign : 'middle'
								},
								{
									field : 'qualificationNo',
									title : '资格证编号',
									valign : 'middle'
								},{
									field : 'qualificationStartStr',
									title : '资格证有效起始时间',
									valign : 'middle'
								},
								{
									field : 'qualificationLong',
									title : '资格证有效时长',
									valign : 'middle'
								},
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''+ row.id+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
										m += '<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="tailInfo(\''+ row.id+ '\');"><span class="glyphicon glyphicon-search"></span>详情</button>';
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

function updateInfo() {
	$('#formupdateInfo').bootstrapValidator('validate');
	var data = $("#formupdateInfo").data('bootstrapValidator');
	var id = $("#update_id").val();
	if (data.isValid()) {
		$.commonReq({
			url : rootPath + "/employeeTraining/update.do?id=" + id,
			async : true,
			data : $('#formupdateInfo').serialize(),
			success : function(parame) {
				bootbox.alert('从业人员信息修改成功!');
				newInfo();
				$('#myModalUpdateEmployeeTraining').modal('hide');
			},
			error : function(parame) {
				bootbox.alert('从业人员信息修改失败!');
			}
		});
	}
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		name : $("#nameId").val()
		
	};
	return temp;
}

//详情
function tailInfo(id){
	var localhostPath = getRootPath1();
	$("#update_id").val("").val(id);
	$("#tailFile1").val('');
	$("#tailFileName1").html('');
	$("#tailFile2").val('');
	$("#tailFileName2").html('');
	$("#tailFile3").val('');
	$("#tailFileName3").html('');
	$.commonReq({
		url:rootPath+"/employeeTraining/detailInfo.do",
		data:{"id":id},
		success:function(data){
			$('.form-horizontal').loader('hide');
			var data = data.data
			$("#tailName").val('').val(data.name)
			$("#tailGender").val('').val(data.gender)
			$("#tailAge").val('').val(data.age)
			$("#tailCardNo").val('').val(data.cardNo)
			$("#tailQualificationStart").val('').val(data.qualificationStartStr)
			$("#tailQualificationLong").val('').val(data.qualificationLong)
			$("#tailQualificationNo").val('').val(data.qualificationNo)
			$('#tailGrantOrganize').val('').val(data.grantOrganize)
			if(data.attendanceRecord.trim() !=''){
				$("#tailFile1").val(data.attendanceRecord);
        		var nameAry = data.attendanceRecord.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#tailFileName1").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#tailFileName1").html(afterFileList);
        			}
        		}
			}
			if(data.materials.trim() !=''){
				$("#tailFile2").val(data.materials);
        		var nameAry = data.materials.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#tailFileName2").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#tailFileName2").html(afterFileList);
        			}
        		}
			}
			if(data.examineMaterials.trim() !=''){
				$("#tailFile3").val(data.examineMaterials);
        		var nameAry = data.examineMaterials.split('|');
        		for(var i=0;i<nameAry.length;i++){
        			if(nameAry[i].trim() != ''){
        				var idAry=nameAry[i].split('^');
        				var fileName = idAry[1];
        				var beforeFileList = $("#tailFileName3").html();
        				var url =localhostPath+'/filePath/'+nameAry[i];
        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
        				$("#tailFileName3").html(afterFileList);
        			}
        		}
			}
			$("#myModalTailEmployeeTraining").modal('show')
		}
	});
};

function editInfo(id){
	$("#editFile3").val('');
	$("#editFileName3").html('');
	$("#editFile2").val('');
	$("#editFileName2").html('');
	$("#editFile1").val('');
	$("#editFileName1").html('');
		var localhostPath = getRootPath1();
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/employeeTraining/detailInfo.do",
			data:{"id":id},
			success:function(data){
				$('.form-horizontal').loader('hide');
				var data = data.data
				$("#editName").val('').val(data.name)
				$("#editGender").val('').val(data.gender)
				$("#editAge").val('').val(data.age)
				$("#editCardNo").val('').val(data.cardNo)
				$("#editQualificationStart").val('').val(data.qualificationStartStr)
				$("#editQualificationLong").val('').val(data.qualificationLong)
				$("#editQualificationNo").val('').val(data.qualificationNo)
				$('#editGrantOrganize').val('').val(data.grantOrganize)
				if(data.attendanceRecord.trim() !=''){
					$("#editFile1").val(data.attendanceRecord);
            		var nameAry = data.attendanceRecord.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#editFileName1").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#editFileName1").html(afterFileName);
            			}
            		}
				}
				if(data.materials.trim() !=''){
					$("#editFile2").val(data.materials);
            		var nameAry = data.materials.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#editFileName2").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#editFileName2").html(afterFileName);
            			}
            		}
				}
				if(data.examineMaterials.trim() !=''){
					$("#editFile3").val(data.examineMaterials);
            		var nameAry = data.examineMaterials.split('|');
            		for(var i=0;i<nameAry.length;i++){
            			if(nameAry[i].trim()!=''){
            				var idAry=nameAry[i].split('^');
            				var id = idAry[0];
            				var fileName = idAry[1];
            				var beforeFileName = $("#editFileName3").html();
							var afterFileName = beforeFileName+"&nbsp;&nbsp;&nbsp;"
												+'<span id='+id+'>'+fileName+'</span>'
												+'<a  onclick="deleteFile('+id+');" style="color:#ff000096;"> 删除</a>';
							$("#editFileName3").html(afterFileName);
            			}
            		}
				}
				$("#myModalUpdateEmployeeTraining").modal('show')
			}
		});
};

