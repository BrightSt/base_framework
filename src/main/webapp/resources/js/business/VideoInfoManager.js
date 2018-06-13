/**
 * 监控点管理js页面
 */
var rootPath = getRootPath();
var video;
$(function() {
	video = document.getElementById('myPlayer');
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
				url : rootPath + '/video/delete.do',
				data : {
					"id" : value
				},
				success : function(data) {
					$('#dt').bootstrapTable('refresh', {
						url : rootPath + '/video/all.do'
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
						url : rootPath + '/video/all.do',
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
		                          width:30
							 },
								{
									field : 'companyName',
									title : '所属企业名称',
									valign : 'middle',
								},
//								{
//									field : 'pfkCode',
//									title : '监控点编码',
//									valign : 'middle',
//									width:50
//								},
								{
									field : 'addressInfo',
									title : '监控点位置信息',
									valign : 'middle',
								},
								{
									field : 'useInfo',
									title : '监控用途',
									valign : 'middle',
								},
//								{
//									field : 'rtmpInfo',
//									title : 'rtmp播放通道',
//									valign : 'middle',
//									formatter : function(value, row, index) {
//										return '<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="play(\''
//										+ value
//										+ '\');"><span class="glyphicon glyphicon-play"></span>查看直播</button>';
//									},
//									width:100
//								},
								{
									field : 'hlsInfo',
									title : 'hls播放通道',
									valign : 'middle',
									formatter : function(value, row, index) {
										return '<button type="button" class="btn btn-success btn-xs" style="margin-right:10px;" onclick="play(\''
										+ value
										+ '\');"><span class="glyphicon glyphicon-play"></span>查看直播</button>';
									},
								},
//								,{
//									field:'createUserName',
//									title:'创建人',
//									valign:'middle'
//								},{
//									field:'createName',
//									title:'创建人姓名',
//									valign:'middle'
//								},
								{
									field:'createDateTime',
									title:'创建日期',
									valign:'middle',
									formatter:function(value,data,index){
					                	return fmtDate(value,"yyyy-MM-dd");
					                },
								},
								
								{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" class="btn btn-warning btn-xs " style="margin-right:10px;" onclick="detailInfo(\''
											+ row.id
											+ '\');"><span class="glyphicon glyphicon-list-alt"></span>详情</button>';
										
										m += '<button type="button" class="btn btn-info btn-xs" style="margin-right:10px;" onclick="editInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
										m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
												+ row.id
												+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
										
										return m;
									},
									valign : 'middle',
								} ],
						onLoadSuccess : function() {
						},
						onLoadError : function() {
						}
					});
}

function updateInfo() {
	var id = $("#update_id").val();
	$.commonReq({
		url : rootPath + "/video/update.do?id=" + id,
		async : true,
		data : $('#formupdateVideoInfo').serialize(),
		success : function(parame) {
			bootbox.alert('修改成功!');
			newInfo();
			$('#myModalUpdateUser').modal('hide');
		},
		error : function(parame) {
			bootbox.alert('修改失败!');
		}
	});
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		userName : $("#userName").val(),
		companyCode : $("#companyCodeId option:selected").val(),
		addressInfo : $("#qaddressInfo").val(),
		useInfo : $("#quseInfo").val(),
		type : '0',
		systemFlag:0
	};
	return temp;
}



	function editInfo(id){
		$("#update_id").val("").val(id);
		$.commonReq({
			url:rootPath+"/video/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$('#myModalUpdateUser').modal('show');
				$("#addressInfoId").val('').val(data.addressInfo);
				$("#useInfoId").val('').val(data.useInfo);
  				$("#rtmpInfoId").val('').val(data.rtmpInfo);
  				$("#hlsInfoId").val('').val(data.hlsInfo);
			}
		});
	};
	
	function detailInfo(id){
		$.commonReq({
			url:rootPath+"/video/detailInfo.do",
			data:{"id":id},
			success:function(data){
				var data = data.data;
				$('#myModalMore').modal('show');
				
				$("#moreCompanyCode").val('').val(data.companyName);
				$("#morepfkCode").val('').val(data.pfkCode);
  				$("#moreaddressInfo").val('').val(data.addressInfo);
  				$("#moreUseInfo").val('').val(data.useInfo);
  				$("#morertmpInfo").val('').val(data.rtmpInfo);
  				$("#morehlsInfo").val('').val(data.hlsInfo);
			}
		});
	};
	function play(address){
		var ui = document.getElementById('mask');
		ui.style.display=""
		 startEvent(address);
	}
	
	function closeMask(){
		var ui = document.getElementById('mask');
		ui.style.display="none"
	}
    function startEvent(value){
        video.src = value;
        var player = new EZUIPlayer('myPlayer');
        // 日志
        player.on('log', log);

        function log(str){
            var div = document.createElement('DIV');
            div.innerHTML = (new Date()).Format('yyyy-MM-dd hh:mm:ss.S') + JSON.stringify(str);
            document.body.appendChild(div);
        } 
    }
  //环保局登录变更企业
    function changeCompany(){
    	window.location.href = rootPath + '/video/initPage.do';
    }
