var rootPath = getRootPath();
var localhostPath = getRootPath1();
$(function (){
	debugger;
	// 检查插件是否已经安装过
	if (-1 == WebVideoCtrl.I_CheckPluginInstall()) {
		bootbox.confirm("您还未安装过插件，请点击下载，下载完后双击WebComponents.exe安装！", function(result) {
			if (result) {
				window.location.href = localhostPath+'/filePath/WebComponents.exe';
			}
		});
		return;
	}
	
	// 初始化插件参数及插入插件
	WebVideoCtrl.I_InitPlugin(500, 300, {
        iWndowType: 2,
		cbSelWnd: function (xmlDoc) {
			g_iWndIndex = $(xmlDoc).find("SelectWnd").eq(0).text();
			var szInfo = "当前选择的窗口编号：" + g_iWndIndex;
			showCBInfo(szInfo);
		}
	});
	WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");
	
	// 检查插件是否最新
	if (-1 == WebVideoCtrl.I_CheckPluginVersion()) {
		bootbox.confirm("检测到新的插件版本，请点击下载，下载完后双击WebComponents.exe安装！", function(result) {
			if (result) {
				window.location.href = localhostPath+'/filePath/WebComponents.exe';
			}
		});
		return;
	}
	// 窗口事件绑定
	$(window).bind({
		resize: function () {
			var $Restart = $("#restartDiv");
			if ($Restart.length > 0) {
				var oSize = getWindowSize();
				$Restart.css({
					width: oSize.width + "px",
					height: oSize.height + "px"
				});
			}
		}
	});

    //初始化日期时间
    var szCurTime = dateFormat(new Date(), "yyyy-MM-dd");
    $("#starttime").val(szCurTime + " 00:00:00");
    $("#endtime").val(szCurTime + " 23:59:59");
	
    
	/*$('#videoInsertForm,#videoupdateForm').bootstrapValidator({
		fields : {
			ip : {
				validators : {
					notEmpty : {
						message : 'IP地址不能为空'
					},
					regexp: {
                        regexp:  /^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$/,
                        message: 'IP地址只能包含数字及.'
                    }
				}
			},
			userName : {
				validators : {
					notEmpty : {
						message : '用户名不能为空'
					}
				}
			},
			password : {
				validators : {
					notEmpty : {
						message : '密码不能为空'
					}
				}
			},
			port:{
				validators:{
					notEmpty:{
						message:'端口号不能为空'
					},
					regexp:{
						regexp: /^\d+$ /,
						message:'端口号格式不符'
					}
				}
			},
			
		}
	});*/
	$("#addVideoInfo").click(function(){
		debugger;
		$("#systemFlag2").val(0);
		$("#videoType2").val('1');
		$.commonReq({
			async : false,
			url : rootPath + "/video/add.do",
			type : "POST",
			dataType : "json",
			data : $("#addVideoForm").serialize(),
			success : function(data) {
				debugger;
				$('.form-horizontal').loader('hide');
				// 关闭静态框
				$('#insertVideoModal').modal('hide');
				$("#insertVideoModal").find("input").val("");
				// 刷新页面
				newInfo();
				//window.location.href = rootPath + '/video/toVideoManagerPage.do'
			}
		});
	})
	$("#addInfoBtn").click(function(){
		
		debugger;
		$.commonReq({
			async : false,
			url : rootPath + "/video/add.do",
			type : "POST",
			dataType : "json",
			data : $("#videoInsertForm").serialize(),
			success : function(data) {
				$('.form-horizontal').loader('hide');
				// 关闭静态框
				$('#insertSysDataModal').modal('hide');
				$("#insertSysDataModal").find("input").val("");
				// 刷新页面
				//window.location.href = rootPath + '/video/toVideoManagerPage.do'
				newInfo();
			}
		});
	})
	
	$("#updateInfoBtn").click(function(){
		debugger;
		$.commonReq({
			async : false,
			url : rootPath + "/video/update.do",
			type : "POST",
			dataType : "json",
			data : $("#videoUpdateForm").serialize(),
			success : function(data) {
				$('.form-horizontal').loader('hide');
				// 关闭静态框
				$('#videoUpdateModal').modal('hide');
				// 刷新页面
				alert("修改成功！")
				window.location.href = rootPath + '/video/initPage.do'
				
			}
		});
	})
	checkVideoParameter();
	//checkAddOrUpdate();
	//vedioSystemLogin();
	//changeWndNum(1);
	
	clickLogin();
	newInfo();
	
})
function checkVideoParameter(){
	debugger;
	var userCode = $("#userCode").val();
	if(userCode==""||userCode==undefined){
		alert("目前尚未存入视频参数，请您输入参数并保存！");
		checkAddOrUpdate();
	}
}

function hiddenVideoDiv(){
	$("#divPlugin").hide();
}
function showVideoDiv(){
	$("#divPlugin").show();
}
function changeWndNum(iType) {
    	iType = parseInt(iType, 10);
    	WebVideoCtrl.I_ChangeWndNum(iType);
    }

function checkAddOrUpdate(){
	
	debugger;
	var userCode = $("#userCode").val();
	if(userCode==""||userCode==undefined){
		$("#insertSysDataModal").find('input').val('');
		$("#systemFlag").val(1);
		$("#insertSysDataModal").modal("show");
		
	}
}

function vedioSystemLogin(){
	$.commonReq({
		async : false,
		url : rootPath + "/video/videoSystemLogin.do",
		type : "POST",
		dataType : "json",
		data : '',
		success : function(data) {
			debugger;
			$('.form-horizontal').loader('hide');
			// 关闭静态框
			$('#insertSysDataModal').modal('hide');
			$("#insertSysDataModal").find("input").val("");
			/*// 刷新页面
			window.location.replace(rootPath + '/video/toVideoManagerPage.do')*/
			newInfo();
		}
	});
}
//点击修改加载企业信息
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
									field : 'channel',
									title : '通道号',
									valign : 'middle'
								},
								{
									field : 'videoName',
									title : '监控点名称',
									valign : 'middle'
								},
								{
									field : 'addressInfo',
									title : '监控点地址',
									valign : 'middle'
								},
								{
									field : 'useInfo',
									title : '用途',
									valign : 'middle'
								}
								,{
									field : 'oper',
									title : '操作',
									formatter : function(value, row, index) {
										var m = '<button type="button" onclick="clickStartRealPlay(\''
												+ row.channel
												+ '\');" class="btn btn-success btn-xs"  style="margin-right:10px;" data-toggle="" data-target="" ><span class="glyphicon glyphicon-film"></span> 播放</button>';
										m += '<button type="button" onclick="updateVideoInfo(\''
											+ row.id
											+ '\');" class="btn btn-default btn-xs"  style="margin-right:10px;" data-toggle="" data-target="" ><span class="glyphicon glyphicon-edit"></span> 修改</button>';
										m += '<button type="button" class="btn btn-danger btn-xs" style="margin-right:10px;" onclick="delInfo(\''
											+ row.id
											+ '\');"><span class="glyphicon glyphicon-remove"></span>删除</button>';
										return m;
									},
									valign : 'middle'
								}],
						onLoadSuccess : function() {
						},
						onLoadError : function() {
						}
					});
}
function queryParams(params) {
	var temp = {
		pageSize : params.pageSize,
		pageNumber : params.pageNumber,
		systemFlag : 0,
		userName : $("#userName").val(),
		companyCode : $("#companyCodeId option:selected").val(),
		addressInfo : $("#qaddressInfo").val(),
		useInfo : $("#quseInfo").val(),
		type:'1'
	};
	return temp;
}
//修改
function updateVideoInfo(id){
	
	$.commonReq({
		async : false,
		url : rootPath + "/video/detailInfo.do",
		type : "POST",
		dataType : "json",
		data : {"id":id},
		success : function(data) {
			
			debugger;
			var data = data.data;
			$('.form-horizontal').loader('hide');
			$("#updateVideoModal2").find("input").val("");
			$("updateId").val(data.id);
			$("#updateSystemFlag").val(data.systemFlag);
			$("#updateVideoType").val(data.type);
			$("#updateChannels").val(data.channel);
			$("#updateVideoName").val(data.videoName);
			$("#updateAddressInfo").val(data.addressInfo);
			$('#updateUseInfo').val(data.useInfo);
			$("#updateId").val(data.id);
			$('#updateVideoModal2').modal('show');
		}
	});
}
function saveUpdateInfo(){
	debugger;
	$.commonReq({
		async : false,
		url : rootPath + "/video/update.do",
		type : "POST",
		dataType : "json",
		data : $("#updateVideoForm").serialize(),
		success : function(data) {
			$('.form-horizontal').loader('hide');
			$('#updateVideoModal2').modal('hide');
			newInfo();
		}
	});
}


//开始预览
function clickStartRealPlay(channel) {
	var ip = $("#ip").val();
	var port = $("#port").val();
	var userName = $("#userName").val();
	var passWord = $("#passWord").val();
	window.open(rootPath + '/video/toVideoManagerNew.do?channel='+channel+'&ip='+ip+'&port='+port+'&userName='+userName+'&passWord='+passWord);
}
//显示回调信息
function showCBInfo(szInfo) {
	szInfo = "<div>" + dateFormat(new Date(), "yyyy-MM-dd hh:mm:ss") + " " + szInfo + "</div>";
	//$("#cbinfo").html(szInfo + $("#cbinfo").html());
}
//格式化时间
function dateFormat(oDate, fmt) {
	var o = {
		"M+": oDate.getMonth() + 1, //月份
		"d+": oDate.getDate(), //日
		"h+": oDate.getHours(), //小时
		"m+": oDate.getMinutes(), //分
		"s+": oDate.getSeconds(), //秒
		"q+": Math.floor((oDate.getMonth() + 3) / 3), //季度
		"S": oDate.getMilliseconds()//毫秒
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (oDate.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}
//登录
function clickLogin() {
	debugger;
	var szIP = $("#ip").val(),
		szPort = $("#port").val(),
		szUsername = $("#userName").val(),
		szPassword = $("#passWord").val();

	if ("" == szIP || "" == szPort) {
		return;
	}

	var iRet = WebVideoCtrl.I_Login(szIP, 1, szPort, szUsername, szPassword, {
		success: function (xmlDoc) {
			$("#loginIp").prepend("<option value='" + szIP + "'>" + szIP + "</option>");
			setTimeout(function () {
				$("#loginIp").val(szIP);
				getChannelInfo();
				hiddenVideoDiv();
				alert(szIP + " 登录成功！");
			}, 10);
		},
		error: function () {
			//showOPInfo(szIP + " 登录失败！");
			alert(szIP + " 登录失败，请保存正确的视频后台登录参数！");
			$("#videoUpdateModal").modal('show');
		}
	});

	if (-1 == iRet) {
		//showOPInfo(szIP + " 已登录过！");
		alert(szIP + " 已登录过！");
	}
}
function closePage(){
	debugger;
	//退出
	clickLogout()
}
//退出
function clickLogout() {
	var szIP = $("#ip").val(),
		szInfo = "";

	if (szIP == "") {
		return;
	}

	var iRet = WebVideoCtrl.I_Logout(szIP);
	if (0 == iRet) {
		szInfo = "退出成功！";
	} else {
		szInfo = "退出失败！";
	}
	console.log(szInfo);
}
//增加监控点
function addVideoInfo(){
	$("#addVideoForm").find('input').val('');
	$("#systemFlag").val(0);
	$("#videoType").val('1');
	$("#insertVideoModal").modal("show");
}
// 获取通道
function getChannelInfo() {
	debugger;
	var szIP = $("#loginIp").val(),
		oSel = $("#channels").empty(),
		oSel2 = $("#updateChannels").empty(),
		nAnalogChannel = 0;
	if ("" == szIP) {
		return;
	}

	// 模拟通道
	WebVideoCtrl.I_GetAnalogChannelInfo(szIP, {
		async: false,
		success: function (xmlDoc) {
			var oChannels = $(xmlDoc).find("VideoInputChannel");
			nAnalogChannel = oChannels.length;

			$.each(oChannels, function (i) {
				var id = parseInt($(this).find("id").eq(0).text(), 10),
					name = $(this).find("name").eq(0).text();
				if ("" == name) {
					name = "Camera " + (id < 9 ? "0" + id : id);
				}
				oSel.append("<option value='" + id + "' bZero='false'>" + name + "</option>");
				oSel2.append("<option value='" + id + "' bZero='false'>" + name + "</option>");
			});
			
			
		},
		error: function () {
			showOPInfo(szIP + " 获取模拟通道失败！");
		}
	});
	// 数字通道
	WebVideoCtrl.I_GetDigitalChannelInfo(szIP, {
		
		async: false,
		success: function (xmlDoc) {
			debugger;
			var oChannels = $(xmlDoc).find("InputProxyChannelStatus");

			$.each(oChannels, function (i) {
				var id = parseInt($(this).find("id").eq(0).text(), 10),
					name = $(this).find("name").eq(0).text(),
					online = $(this).find("online").eq(0).text();
				if ("false" == online) {// 过滤禁用的数字通道
					return true;
				}
				if ("" == name) {
					name = "IPCamera " + ((id - nAnalogChannel) < 9 ? "0" + (id - nAnalogChannel) : (id - nAnalogChannel));
				}
				oSel.append("<option value='" + id + "' bZero='false'>" + name + "</option>");
				oSel2.append("<option value='" + id + "' bZero='false'>" + name + "</option>");
			});
		},
		error: function () {
			showOPInfo(szIP + " 获取数字通道失败！");
		}
	});
	// 零通道
	WebVideoCtrl.I_GetZeroChannelInfo(szIP, {
		async: false,
		success: function (xmlDoc) {
			var oChannels = $(xmlDoc).find("ZeroVideoChannel");
			
			$.each(oChannels, function (i) {
				var id = parseInt($(this).find("id").eq(0).text(), 10),
					name = $(this).find("name").eq(0).text();
				if ("" == name) {
					name = "Zero Channel " + (id < 9 ? "0" + id : id);
				}
				if ("true" == $(this).find("enabled").eq(0).text()) {// 过滤禁用的零通道
					oSel.append("<option value='" + id + "' bZero='true'>" + name + "</option>");
					oSel2.append("<option value='" + id + "' bZero='true'>" + name + "</option>");
				}
			});
		},
		error: function () {
		}
	});
}
//环保局登录变更企业
function changeCompany(){
	window.location.href = rootPath + '/video/initPage.do';
}
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