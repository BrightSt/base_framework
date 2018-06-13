
jQuery.commonReq = function(user_options) {
	$.ajax({
		type : user_options.type || "POST",
		url : user_options.url,
		data : user_options.data,
		dataType : user_options.dataType || "json",
		async : user_options.async || true,
		beforeSend : function() {
			// 防止表单提交
			$('.form-horizontal').loader('show',
					'<img src="resources/images/loading.gif">');
		},
		success : function(res) {
			$('.form-horizontal').loader('hide');
			if (res.code == 0) {
				user_options.success(res);
			} else {
				// 失败处理
				bootbox.alert(res.msg);
			}
		},
		error : function(err) {
			$('.form-horizontal').loader('hide');
			if (undefined != user_options.error) {
				user_options.error();
			}
		}
	})
}

jQuery.extend({
	commonReq1 : (function() {
		var default_options = {
			"type" : "post",
			"timeout" : "60000",
			beforeSend : function() {
				// 防止表单提交
				$('.form-horizontal').loader('show',
						'<img src="resources/images/loading.gif">');
			},
			"success" : function(data) {
				$('.form-horizontal').loader('hide');
			},
			"error" : function(request, textStatus, errorThrown) {
				alert("后台请求失败！");
			}
		};
		return function(user_options) {
			var options = {};
			$.extend(options, default_options, user_options);
			$.ajax(options);
		};
	})()
});

// js获取项目根路径，如： http://localhost:8080/
function getRootPath() {
	// 获取当前网址
	var curWwwPath = window.document.location.href;
	// 获取主机地址之后的目录
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	// 获取主机地址
	var localhostPaht = curWwwPath.substring(0, pos);
	// 获取带"/"的项目名
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);
	return (localhostPaht + projectName);
}

function getRootPath1() {
	// 获取当前网址
	var curWwwPath = window.document.location.href;
	// 获取主机地址之后的目录
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	// 获取主机地址
	var localhostPaht = curWwwPath.substring(0, pos);

	return localhostPaht;
}

// 节点选中问题start
var nodeCheckedSilent = false;
function nodeChecked(event, node) {
	if (nodeCheckedSilent) {
		return;
	}
	nodeCheckedSilent = true;
	checkAllParent(node);
	checkAllSon(node);
	nodeCheckedSilent = false;
}

var nodeUncheckedSilent = false;
function nodeUnchecked(event, node) {
	if (nodeUncheckedSilent)
		return;
	nodeUncheckedSilent = true;
	uncheckAllParent(node);
	uncheckAllSon(node);
	nodeUncheckedSilent = false;
}

// 选中全部父节点
function checkAllParent(node) {
	$('#searchTree').treeview('checkNode', node.nodeId, {
		silent : true
	});
	var parentNode = $('#searchTree').treeview('getParent', node.nodeId);
	if (!("nodeId" in parentNode)) {
		return;
	} else {
		checkAllParent(parentNode);
	}
}

/**
 * treeview节点选中需要的方法 start
 */
// 取消全部父节点
function uncheckAllParent(node) {
	$('#searchTree').treeview('uncheckNode', node.nodeId, {
		silent : true
	});
	var siblings = $('#searchTree').treeview('getSiblings', node.nodeId);
	var parentNode = $('#searchTree').treeview('getParent', node.nodeId);
	if (!("nodeId" in parentNode)) {
		return;
	}
	var isAllUnchecked = true; // 是否全部没选中
	for ( var i in siblings) {
		if (siblings[i].state.checked) {
			isAllUnchecked = false;
			break;
		}
	}
	if (isAllUnchecked) {
		uncheckAllParent(parentNode);
	}

}

// 级联选中所有子节点
function checkAllSon(node) {
	$('#searchTree').treeview('checkNode', node.nodeId, {
		silent : true
	});
	if (node.nodes != null && node.nodes.length > 0) {
		for ( var i in node.nodes) {
			checkAllSon(node.nodes[i]);
		}
	}
}
// 级联取消所有子节点
function uncheckAllSon(node) {
	$('#searchTree').treeview('uncheckNode', node.nodeId, {
		silent : true
	});
	if (node.nodes != null && node.nodes.length > 0) {
		for ( var i in node.nodes) {
			uncheckAllSon(node.nodes[i]);
		}
	}
}

/**
 * 从cookie中获取用户信息 name参数为
 * 
 * @returns
 */
function getCookie(name) {
	var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

// 分页公共配置
var basePage = {
		pageSize:15,
		pageList:[ 15, 30, 45 ]
}

