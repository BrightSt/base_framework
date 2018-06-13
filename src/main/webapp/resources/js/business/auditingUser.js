var rootPath = getRootPath();

$(function(){
		newInfo();
  		$("input[name=btSelectAll]").attr("style","height:16px;width:16px;");
    	$("input[name=btSelectAll]").css("verticalAlign","middle");
  	});
  	
  	
  	
  	function newInfo(){
  		debugger
  		$('#dt').bootstrapTable('destroy');
  		$('#dt').bootstrapTable({
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			url: rootPath + '/companyInfo/all.do',
		    striped: true,      //是否显示行间隔色
		    cache: false,      //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
		    pagination: true,
		    queryParamsType:'', //默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
		                        // 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber
		    queryParams:queryParams,
		    singleSelect: false,
		    pageSize: 10,
		    pageList: [10, 20,30],
		    search: false, //不显示 搜索框
		    showColumns: false, //不显示下拉框（选择显示的列）
		    sidePagination: "server", //服务端请求
		    clickToSelect: true,    //是否启用点击选中行
		    columns: [
		   {
		    	field: 'name',
		        title: '企业名称',
                valign:'middle'
		    }, {
		    	field: 'code',
		        title: '企业编码',
                valign:'middle'
		    },{
		    	field: 'manager',
		        title: '法定代表人',
                valign:'middle'
		    },{
		    	field: 'phone',
		        title: '企业电话',
                valign:'middle'
		    }/*,{
		    	field: 'registerTimeStr',
		        title: '申请时间',
                valign:'middle'
		    }*/,{
		    	field: '',
		        title: '企业详细资料展示',
                valign:'middle',
                formatter:function(value,data,index){
            		var str = '<button type="button" class="btn btn-default btn-xs" onclick="tailInfo(\''+data.id+'\');">详情</button>';
                	str += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success btn-xs" onclick="auditingPass(\''+data.id+'\');">通过</button>';
                	str += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-warning btn-xs" onclick="auditingNG(\''+data.id+'\');">驳回</button>'; 
                	return str;
            	}
		    }
		    ],
		    onLoadSuccess:function(){},
		    onLoadError: function () {
		    }
		});
  	}
  	
  	
  	function queryParams(params){
  		var temp = {
  			pageSize:params.pageSize,
  			pageNumber:params.pageNumber,
  			status:0,
  			code:$("#codeId").val(),
  			name:$("#nameId").val()
  		};
  		
  		return temp;
  	}
  //审核通过	
  function auditingPass(id){
	  debugger;
	  $("#myModal3").modal('hide');
		if(id==''||id==undefined){
    		id=$("#tailInfoId").val();
    	}
		$.commonReq({
			url:rootPath + '/userInfo/auditingPass.do',
			data:{"id":id},
			success : function(parame) {
				debugger;
				
				 bootbox.confirm(parame.data+",请您给该用户分配权限角色？", function(result) {
						if (result) {
							$.commonReq({
					    		url : rootPath + "/companyInfo/findUserIdByCompanyId.do",
					    		data : {
					    			"id" : id
					    		},
					    		success : function(result) {
					    			debugger;
					    			confRoleInfo(result.data);
					    		}
					    	});
							
						}
				 });
				 
			}
			
	    });
	   	
	       
   }
	//审核未通过
	function auditingNG(id){
		debugger
		$("#myModal3").modal('hide');
		if(id==''||id==undefined){
    		id=$("#tailInfoId").val();
    	}
		$("#hideId").val(id);
		$("#myModal").modal('show');
  		
   }
	//隐藏弹出框
    function hideModal(){
    	debugger
    	var id = $("#hideId").val();
    	var reason = $("#reason").val();
    	if(reason==''){
  		  	bootbox.alert('请在说明栏里填写审核未通过原因！');
  		  	return;
  		 }
    	$('#myModal').modal('hide');
    	$.commonReq({
    		url:rootPath + '/userInfo/auditingNG.do',
			data:{"id":id,
				"reason":reason
				},
			success : function(result) {
				debugger;
				 window.location.href=rootPath + '/userInfo/auditingUser.do';
                 bootbox.alert( result.msg);
			}
			
	    });
    	
    }
  	
	
  //查看详情
  
      function tailInfo(id){
    	  debugger
        $("#insertEnterpriseForm3").find("input").val("");
        $("#insertEnterpriseForm3").find("input").attr("readonly","readonly");
        
        $.commonReq({
			url :rootPath + '/companyInfo/detailInfo.do',
			data:{"id":id},
			success : function(result) {
				debugger
				var ui = result.data;
            	$("#tailInfoId").val(ui.id);
             	$("#name").val(ui.name+"");
             	$("#code").val(ui.code+"");
        		$("#inCharge").val(ui.inCharge+"");
        		$("#remark").val(ui.remark+"");
        		$("#address").val(ui.address+"");
           		$("#phone").val(ui.phone);
           		$("#fax").val(ui.fax+"");
           		$("#companyLevel").val(ui.companyLevelName);
           		
           		$("#subjection").val(ui.subjectionName);
           		$("#email").val(ui.email);
           		$("#manager").val(ui.manager);
           		$('#myModal3').modal({
					keyboard: true,
					width:800,
 				});
			}
		})
      	
      }
  	
  	 /*获取选中的值*/
    function getSelectionsStr(){
    	var rows = $('#dt').bootstrapTable('getSelections');
    	var str="";
    		if(rows!=null){
    			for(var i=0;i<rows.length;i++){
    				str+=(rows[i].id+"")+",";
    			}
    			str=str.substring(0,str.lastIndexOf(','));
    		}
    	return str;
    }
  	 
    /*验证是否为空*/
    function checkNullAndEmpty(value){
    	if(value==null || value.trim()==''){
    		return true;
    	}else{
    		return false;
    	}
    }
  	//判断字符串是否为数字
    function checkNumber(value){
    	var re = /^[0-9]+.?[0-9]*$/; 
     	if(null==value||''==value) {
     		return false;
     	}else if(!re.test(value)){
     		return true;
     	}else{
     		return false;
     	}
     }
  	
    /*时间格式转化*/  
    function dateFormat(value){
    	if(value!=null){
              var date = new Date(value);
      		var seperator1 = "-";
      		//年
	        	var year = date.getFullYear();
	        	//月
	            var month = date.getMonth() + 1;
	            //日
	            var strDate = date.getDate();
		        if (month >= 1 && month <= 9) {
		            month = "0" + month;
		        }
		        if (strDate >= 0 && strDate <= 9) {
		            strDate = "0" + strDate;
		        }
		        var currentdate = year + seperator1 + month + seperator1 + strDate;
		        return currentdate; 
          }else{
             return "";
          }
    }  
    //分配权限
    function confRoleInfo(userid) {
    	debugger;
    	var data = "";
    	$.commonReq1({
    		url : rootPath + "/userRole/roleTree.do",
    		data : {
    			"id" : userid
    		},
    		async : false,
    		success : function(result) {
    			data = result.data;
    		}
    	});
    	$('#searchTree').treeview({
    		showCheckbox : true,
    		data : data,
    		onNodeChecked : nodeChecked,
    		onNodeUnchecked : nodeUnchecked
    	});

    	$("#roleConfModal").modal("show");
    	$("#userid").val("").val(userid);
    }
    function insertRoleInfo() {
    	debugger;
    	// 获取选中节点
    	var checks = $('#searchTree').treeview('getChecked');
    	var userid = $("#userid").val();

    	var checkIds = "";
    	// 配置用户角色
    	for (var i = 0; i < checks.length; i++) {
    		checkIds += checks[i].id + ",";
    	}

    	$.commonReq({
    		url : rootPath + "/userRole/insertRole.do",
    		data : {
    			"userId" : userid,
    			"roleIdsStr" : checkIds
    		},
    		success : function(result) {
    			bootbox.alert("角色配置成功!");
    			$("#roleConfModal").modal("hide");
    			window.location.href=rootPath + '/userInfo/auditingUser.do';
    		},
    		error : function() {
    			bootbox.alert("角色配置失败!");
    			$("#roleConfModal").modal("hide");
    		}
    	});
    }
    
  