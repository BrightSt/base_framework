/**
 * 企业角色管理js页面
 */
var rootPath = getRootPath();
$(function(){
  		newInfo();
  		$("input[name=btSelectAll]").attr("style","height:16px;width:16px;");
    	$("input[name=btSelectAll]").css("verticalAlign","middle");
    	
    	$('#updatecreatetime,#updateupdatetime').datetimepicker({
            pickerPosition: "bottom-left",
            language: "zh-CN",
            autoclose: true,
            minView: 2,
            format: "yyyy-mm-dd",
            todayHighlight: true
        });
  	});

	  /*删除数据*/
	function delInfo(value){
		bootbox.confirm("您确定要删除该条记录吗？",function(result){
   			if(result){
   				$.commonReq({
   					url:rootPath+'/menuInfo/delete.do',
   					data:{"id":value},
   					success: function(data) {
   						$('.form-horizontal').loader('hide');
                    	$('#dt').bootstrapTable('refresh', {url:rootPath+'/menuInfo/all.do'});
                    }
   				});
   			}
        });
	}
  	function newInfo(){
  		$('#dt').bootstrapTable('destroy');
  		$('#dt').bootstrapTable({
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			url:rootPath+'/menuInfo/all.do',
		    striped: true,      //是否显示行间隔色
		    cache: false,      //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
		    pagination: true,
		    queryParamsType:'', //默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
		                        // 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber
		    queryParams:queryParams,
		    singleSelect: false,
		    pageSize: basePage.pageSize,
		    pageList: basePage.pageList,
		    search: false, //不显示 搜索框
		    showColumns: false, //不显示下拉框（选择显示的列）
		    sidePagination: "server", //服务端请求
		    clickToSelect: true,    //是否启用点击选中行
		    columns: [
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
		        field: 'id',
		        title: '菜单编号',
                valign:'middle'
		    },{
		    	field: 'menuName',
		        title: '菜单名称',
                valign:'middle'
		    }, {
		        field: 'url',
		        title: '菜单路径',
                valign:'middle'
		    },{
		    	field: 'remark',
		        title: '备注',
                valign:'middle'
		    },{
		    	field: 'typeName',
		        title: '菜单类型',
                valign:'middle'
		    }
//		    ,{
//		    	field: 'createid',
//		        title: '创建人',
//                valign:'middle'
//		    }
		    ,{
		    	field:'oper',
		    	title:'操作',
		    	formatter:function(value,row,index){
                   	var m = '<button type="button" class="btn btn-success btn-xs btn-info" style="margin-right:10px;" onclick="editInfo(\''+row.id+'\');"><span class="glyphicon glyphicon-edit"></span>编辑</button>';
                    m += '<button type="button" class="btn btn-warning btn-xs" style="margin-right:10px;" onclick="delInfo(\''+row.id+'\');"><span class="glyphicon glyphicon-remove"></span>删除</button>'; 
                   	return m; 
		    	},
                valign:'middle'
		    }
		    ],
		    onLoadSuccess:function(){
		    },
		    onLoadError: function () {
		    }
		});
  	}
  	
  	function editInfo(id){
  		$("#update_id").val("").val(id);
  		$.commonReq({
  			url:rootPath+"/menuInfo/detailInfo.do",
  			data:{"id":Number(id)},
  			success:function(data){
  				$('.form-horizontal').loader('hide');
  				if(data.code==0){
  					$('.form-horizontal').loader('hide');
  					$('#myModalUpdate').modal('show');
  	  				var dataSucess = data.data;
  	  				$("#updateMenuName").val("").val(dataSucess.menuName);
  	  				$("#updateturl").val("").val(dataSucess.url);
  	  				$("#updateRemark").val("").val(dataSucess.remark);
  	  				$("#updateImage").val("").val(dataSucess.image);
  	  				$("#updatetype").empty();
  	  				$("#updatetype").append("<option value='0'>主菜单</option>");
  	  				$("#updatetype").append("<option value='1'>子菜单</option>");
  	  				if(dataSucess.type=="0"){
  						$("#updatetype option[value='0']").attr("selected",true);
  					}else if(dataSucess.type=="1"){
  						$("#updatetype option[value='1']").attr("selected",true);
  					}
  	  				
  	  				if(dataSucess.type=="0"){
  	  					// 主菜单
	  	  				jQuery("#cdkz_update").fadeOut();
	  	  				jQuery("#cdkz_update").fadeOut("slow");
	  	  				jQuery("#cdkz_update").fadeOut(1000);
	  	  				$('#zscd_update').html('');
  	  				}else{
  	  					debugger
	  	  				$('#zscd_update').html('');//清空select
	  	  				jQuery("#cdkz_update").fadeIn();
	  	  				jQuery("#cdkz_update").fadeIn("slow");
	  	  				jQuery("#cdkz_update").fadeIn(1000);
	  	  				$.commonReq({
		  	      			url:rootPath+"/menuInfo/all.do",
		  	      			data:{"type":0,"page":false},
		  	      			async: false,
		  	      			success:function(parame){
		  	      				$('.form-horizontal').loader('hide');
		  	      				var jhc = parame.rows;
		  	      				for(var i=0;i<jhc.length;i++){
		  	          				$('#zscd_update').append("<option value='"+jhc[i].id+"'>"+jhc[i].menuName+"</option>");
		  	      				}
		  	      				
		  	      			$("#zscd_update option[value='"+dataSucess.detialIndex+"']").attr("selected",true);
		  	      		    },
		  	      			error:function(parame){
		  	      			}
	  	  				});
  	  				}
  	  				$("#updatemenuIndex").val("").val(dataSucess.menuIndex);
  				}
  			}
  		});
  	};
  	
  	function updateMenuInfo(){
  		var id = $("#update_id").val();
	   	 $.commonReq({
				url:rootPath+"/menuInfo/update.do",
				async:true,
				data:$('#formupdateMenuInfo').serialize(),
				success:function(parame){
					$('.form-horizontal').loader('hide');
					if(parame.code==0){
						bootbox.alert('菜单修改成功!');
						newInfo();
						$('#myModalUpdate').modal('hide');
					}else{
						bootbox.alert('菜单修改失败!');
						$('#myModalUpdate').modal('hide');
					}
			    },
				error:function(parame){
				}
			});
  	}
  	function queryParams(params){
  		var temp = {
  			pageSize:params.pageSize,
  			pageNumber:params.pageNumber,
  			menuName:$("#menuName").val(),
  			type:$("#type option:selected").val(),
  		};
  		return temp;
  	}
  	
  	function addmenuInfo(){
  		if($('#inserttype').val()=="1"){
			$('#zscd').html('');//清空select
			jQuery("#cdkz").fadeIn();
			jQuery("#cdkz").fadeIn("slow");
			jQuery("#cdkz").fadeIn(1000);
			$.commonReq({
    			url:rootPath+"/menuInfo/all.do",
    			data:{"type":0,"page":false},
    			success:function(parame){
    				$('.form-horizontal').loader('hide');
    				var jhc = parame.rows;
    				for(var i=0;i<jhc.length;i++){
        				$('#zscd').append("<option value='"+jhc[i].id+"'>"+jhc[i].menuName+"</option>");
    				}
    		    },
    			error:function(parame){
    			}
    		});
		}else{
			jQuery("#cdkz").fadeOut();
			jQuery("#cdkz").fadeOut("slow");
			jQuery("#cdkz").fadeOut(1000);
			$('#zscd').html('');
		}
  	}
  	function updatemenuInfo(){
  		if($('#updatetype').val()=="1"){
  			$('#zscd_update').html('');//清空select
  			jQuery("#cdkz_update").fadeIn();
  			jQuery("#cdkz_update").fadeIn("slow");
  			jQuery("#cdkz_update").fadeIn(1000);
  			$.commonReq({
  				url:rootPath+"/menu/selectMenuList.do",
  				data:{"type":0,"pageSize":99999},
  				success:function(parame){
  					$('.form-horizontal').loader('hide');
  					var jhc = parame.rows;
  					for(var i=0;i<jhc.length;i++){
  						$('#zscd_update').append("<option value='"+jhc[i].id+"'>"+jhc[i].menuName+"</option>");
  					}
  				},
  				error:function(parame){
  				}
  			});
  		}else{
  			jQuery("#cdkz_update").fadeOut();
  			jQuery("#cdkz_update").fadeOut("slow");
  			jQuery("#cdkz_update").fadeOut(1000);
  			$('#zscd_update').html('');
  		}
  		
  		
  	}
  	
  	function addInfo(){
  		$("#myModalInsert").modal("show");
  		$("#insertMenuName").val("");
  		$("#inserturl").val("");
  		$("#insertRemark").val("");
  		$("#inserttype").empty();
  		$("#inserttype").append("<option value='0'>主菜单</option>")
  		$("#inserttype").append("<option value='1'>子菜单</option>")
  		$("#zscd").empty();
  		$("#insertmenuIndex").val("");
  		$("#insertImage").val("");
  	}
  	function submitMenuInfo(){
  		
  		var menuName = $("#insertMenuName").val();
  		var url = $("#inserturl").val();
  		var type = $("#inserttype").val();
  		
  		if(menuName == null || menuName == ''){
  			bootbox.alert("菜单名称不能为空！");
  			return;
  		}
  		if((url == null || url=='')&&(type==1)){
  			bootbox.alert("菜单路径不能为空！");
  			return;
  		}
  		if(type==null || type==''){
  			bootbox.alert("菜单类型不能为空！");
  			return;
  		}
  		
  		$.commonReq({
  			url:rootPath+"/menuInfo/add.do",
  			data:$("#formInsertUserInfo").serialize(),
  			success: function(data){
				$('.form-horizontal').loader('hide');
				if(data.data){
					bootbox.alert('菜单新增成功!');
					newInfo();
					$('#myModalInsert').modal('hide');
				}else{
					bootbox.alert("菜单新增失败！");
					$('#myModalInsert').modal('hide');
				}
  				
  			},
  			error:function(){
  				
  			}
  		});
  	}