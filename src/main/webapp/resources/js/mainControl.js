/*此文件用于控制整个菜单的异步交互然后返回内容使用html*/
jQuery.MainPageJs={
	ajaxSysnMainMenu:function(address,changeParentCss,chageChildCss){
	   	
		$("li[id ^='parent']").removeClass("active");
		$("li[id ^='parent']").removeClass("open");
		$("li[class='active']").removeClass("active");
		$("#"+changeParentCss).addClass("active open");
		$("#"+chageChildCss).addClass("active");			
		document.getElementById("mainiframe").src=address;
	},
	relaoddategrid:function(username,statrinfo){
   	    $('#tt').datagrid('load',{url:'<%=basePath%>loginGpsUser/initUpdateUserInfoGps.do',UserName:username,StateInfo:statrinfo});
    },
    addUserInfo:function(){
//    	bootbox.confirm("您需要先添加角色信息吗？",function(result){
//    		
//   			if(result){
//   				window.location.href="rolemenuGps/rolemenuInitGps.do?usertz=0";
//   			}else{
//   				$('#myModal').modal('show');
//   			}
//
//    	});
    	
    	$('#insertUI_USERNAME').val("");
    	$('#insertUI_PASSWORD').val("");
    	$('#insertuiname').val("");
    	$('#insertuiemail').val("");
    	$('#insertuiphone').val("");
		$("#insertuistatus").empty();
		$('#insertuistatus').append("<option value='0'>激活</option>");
        $('#insertuistatus').append("<option value='1'>冻结</option>");
        $('#insertuigender').empty();
        $('#insertuigender').append("<option value='0'>男</option>");
        $('#insertuigender').append("<option value='1'>女</option>");
        $("#insertuicompanycode option:first").prop("selected", 'selected');
        document.getElementById("uodateSelectbuMen").options[0].selected = true;
        
		$('#zscd').html('');//清空select
	   	$.ajax({
			type:"post",
			url:"loginGpsUser/initUserRoleInfoGps.do",
			async:true,
			success:function(parame){
				var jhc = parame;
				for(var i=0;i<jhc.length;i++){
					$("#zscd").append("<option value='"+jhc[i].UR_ID+"'>"+jhc[i].UR_NAME+"</option>");
				}
				$('#myModal').modal('show');
		    },
			error:function(parame){
			}
		});
   	 
    },
    submitUserInfo:function(){
    	var urid = $('#zscd').val();
    	var insertusername = $('#insertUI_USERNAME').val();
    	var insertpassword = $('#insertUI_PASSWORD').val();
    	var insertuiphone  = $('#insertuiphone').val();
    	var insertuiname = $('#insertuiname').val();
    	var insertuiemail = $('#insertuiemail').val();
    	var uinameu = document.getElementById("xianshi").innerHTML;
    	if(uinameu=="用户名已存在!"){
    		bootbox.alert('请更改用户名');
    		return;
    	}
    	if(insertusername == "" || insertusername == null){
    		bootbox.alert('用户名不能为空!');
    		return;
    	}
    	if(insertpassword == "" || insertpassword == null){
    		bootbox.alert('用户密码不能为空!');
    		return;
    	}
    	
    	if(insertuiname == "" || insertuiname == null){
    		bootbox.alert('姓名不能为空!');
    		return;
    	}
    	
    	if(insertuiemail != null && insertuiemail != ""){
    		if(!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(insertuiemail))){
    			bootbox.alert('电子邮箱格式错误!');
        		return;
        	}
    	}
    	
    	if(insertuiphone != null && insertuiphone != ""){
    		if(!(/^1[3|4|5|7|8]\d{9}$/.test(insertuiphone))){ 
        		bootbox.alert('手机号码格式有误!');
        		return;
            }
    	}
    	if(insertpassword.length>16||insertpassword.length<6){
    		bootbox.alert('密码长度在6-16之间!');
    		return;
    	}
	   	 $.ajax({
				type:"post",
				url:"loginGpsUser/addUserInfoGps.do?urid="+urid,
				async:true,
				data:$('#form').serialize(),
				beforeSend:function(){
					//防止表单提交
					$('.form-horizontal').loader('show','<img src="image/loading1.gif">');
				},
				success:function(parame){
					$('.form-horizontal').loader('hide');
					if(parame>0){
						bootbox.alert('用户添加成功!');
						newInfo();
						$('#myModal').modal('hide');
					}else{
						bootbox.alert('用户添加失败!');
						$('#myModal').modal('hide');
					}
			    },
				error:function(parame){
				}
			});
    },
    deleteUserInfo:function(){
    	
    	var selectRow = $('#dt').bootstrapTable('getSelections');
    	var uiidinfo="";
    	for(var i = 0;i<selectRow.length;i++){
    		uiidinfo += selectRow[i].uiid+",";
    	}
    	
    	if(uiidinfo==""){
    		bootbox.alert('请选择要删除的数据!');
    		return;
    	}
    	
    	bootbox.confirm("您确定要删除吗？",function(result){
    		
   			if(result){
   				$.ajax({
					type:"post",
					url:"loginGpsUser/deleteUserInfoGps.do",
					async:true,
					data:{
						uiid:uiidinfo
					},
					success:function(parame){
						if(parame==0){
							bootbox.alert("用户删除成功!");
							newInfo();
						}else if(parame==-1){
							bootbox.alert("删除失败,选择的用户存在审核关系!");
							newInfo();
						}else{
							bootbox.alert("用户删除失败!");
						}
				    },
					error:function(parame){
						
					}
				});
   			}

    	});
    	
    },
    initUpdateUserForm:function(a){
    	
    	$.ajax({
			type:"post",
			url:"<%=basePath%>loginUser/searchUserManger.do",
			async:true,
			data:{
				uiid:a
			},
			success:function(parame){
				$('#updateUserInfo').dialog('open');
				
		    },
			error:function(parame){
			}
		});
//    	$('#updateUserInfo').form('load',{url:'<%=basePath%>loginUser/initUpdateUserInfo.do',uiid:a});
//    	$('#updateUserInfo').form('load','<%=basePath%>loginUser/initUpdateUserInfo.do');
    	
    },
    updateUserInfo:function(addressCur){
    	var urid = $('#zscdupdate').val();
    	var updateusername = $('#updateusername').val();
    	var updatepassword = $('#updatepassword').val();
    	var updateuiname = $('#updateuiname').val();
    	var updateuiphone = $('#updateuiphone').val();
    	var updateemail = $('#updateemail').val();
    	var yuanGongSelect=$("#update_UI_DEPARTMEN").val();
    	//部门信息
    	var buMenValue=$("#update_UI_DICODE").val();
    	//员工信息
    	var yuanGongValue=$("#employeeInUpdateSelect").val();
    	//所属企业
    	var qiYeValue=$("#updatecompanycode").val();
    	var uinameu = document.getElementById("xianshiupdate").innerHTML;
    	if(uinameu=="用户名已存在!"){
    		bootbox.alert('请更改用户名');
    		return;
    	}
    	if(updateusername == null || updateusername == ""){
    		bootbox.alert('用户名不能为空!');
    		return;
    	}
    	if(updatepassword == null || updatepassword == ""){
    		bootbox.alert('用户密码不能为空!');
    		return;
    	}
    	if(updateuiname == null || updateuiname == ""){
    		bootbox.alert('姓名不能为空!');
    		return;
    	}
    	
    	if(updateemail != null && updateemail != ""){
    		if(!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(updateemail))){
        		bootbox.alert('电子邮箱格式错误!');
        		return;
        	}
    	}
    	
    	if(updateuiphone != null && updateuiphone != ""){
    		if(!(/^1[3|4|5|7|8]\d{9}$/.test(updateuiphone))){ 
        		bootbox.alert('手机号码格式有误!');
        		return;
            }
    	}
    	if(updatepassword.length>16||updatepassword.length<6){
    		bootbox.alert('密码长度在6-16之间!');
    		return;
    	}
    	if(yuanGongSelect==0){
    		if(yuanGongValue=="" || yuanGongValue==null){
    			bootbox.alert("请选择员工信息！");
    			return;
    		}
    	}else{
    		if(qiYeValue==""){
    			bootbox.alert("请选择所属企业！");
    			return;
    		}
    	}
    	 $.ajax({
				type:"post",
				url:"loginGpsUser/updateUserInfoGps.do?urid="+urid,
				async:true,
				data:$('#formupdateUserInfo').serialize(),
				beforeSend:function(){
					//防止表单提交
					$('.form-horizontal').loader('show','<img src="image/loading1.gif">');
				},
				success:function(parame){
					$('.form-horizontal').loader('hide');
					if(parame==0){
						bootbox.alert('用户修改成功!');
						newInfo();
						$('#myModalUpdate').modal('hide');
					}else{
						bootbox.alert('用户修改失败!');
						$('#myModalUpdate').modal('hide');
					}
			    },
				error:function(parame){
				}
			});
    }
	
};

