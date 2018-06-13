$(function(){
	 	searchBtn();
  		$("input[name=btSelectAll]").attr("style","height:16px;width:16px;");
    	$("input[name=btSelectAll]").css("verticalAlign","middle");
    	$('#headYearId').datetimepicker({
    		startView: 'decade',  
            minView: 'decade',  
            format: 'yyyy',  
            maxViewMode: 2,  
            minViewMode:2,  
            autoclose: true 
    	});
    	$('#updateYearId').datetimepicker({
    		startView: 'decade',  
            minView: 'decade',  
            format: 'yyyy',  
            maxViewMode: 2,  
            minViewMode:2,  
            autoclose: true 
    	});
});
  	
  	
  	
  	function searchBtn(){
  		var localhostPath = getRootPath1();
  		var rootPath = getRootPath();
  		$('#dt').bootstrapTable('destroy');
  		$('#dt').bootstrapTable({
			method: 'post',
			contentType: "application/x-www-form-urlencoded",
			url:rootPath+'/annual/findAll.do',
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
		    	field:'',
		    	checkbox:true,
		    	valign: "middle"},
            {
		    	field:'id',
		    	visible:false
		    },{
		    	field: 'userName',
		        title: '公司名称',
                valign:'middle'
		    },{
		    	field: 'fileName',
		        title: '文件标题',
                valign:'middle'
		    },
		    {
		    	field: 'year',
		        title: '年份',
                valign:'middle'
		    },{
		    	field: 'uploadTime',
		        title: '上传时间',
                valign:'middle'
		    },{
		    	field: 'resume',
		        title: '内容简述',
                valign:'middle'
		    },{
		    	field: 'remarks',
		        title: '备注',
                valign:'middle'
		    },{
		    	field: 'status',
		        title: '是否提交',
                valign:'middle',
                formatter:function(value,data,index){
                	if(data.status==0){
                		return '未提交';
                	}else{
                		return '已提交';
                	}
                }
		    },{
		    	field: '',
		        title: '操作',
                valign:'middle',
                formatter:function(value,data,index){
                	var str = '<button  onclick="searchRegulations(\''+data.id+'\');" type="button"  type="button"  class="btn btn-info btn-xs" style="margin-right:10px;"><span class="glyphicon glyphicon-search"></span>查看详情</button>';
                	if(data.status==0){
                		str += '<button type="button" type="button"  class="btn btn-success btn-xs" style="margin-right:10px;" onclick="submitInfo(\''+data.id+'\');"><span class="glyphicon glyphicon-upload"></span>提交</button>'
                	}
                	
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
  			fileName:$('#headNameId').val(),
  			year:$('#headYearId').val()
  		};
  		$("#headNameId").val('');
  		$('#headYearId').val('');
  		return temp;
  	}
 //增加通知公告
 function addInfo(){
	 
	 window.location.href="<%=basePath%>regulatory/toAdd.do"
 }
//删除
function delInfo(){
	rootPath = getRootPath();
	var id = getSelectionsStr();
	if(id==''){
  		bootbox.alert('请选择要编辑的行！');
  		return;
  	}else{
  		if(id.indexOf(',')!=-1){
  			bootbox.alert('只能选中一行');
  			return;
  		}
  	}
	 $.commonReq({
			url : rootPath + "/annual/selectById.do",
			async : true,
			data : {"id":id},
			success : function(obj) {
				if(obj.data.status==1){
					bootbox.alert('该文件已提交审核，无法对其操作!');
					return;
				}			
   				$.commonReq({
	  				url : rootPath + "/annual/deleteRegs.do",
	  				async : true,
	  				data : {"ids":id},
	  				success : function(parame) {
	  					bootbox.alert( "删除成功！");
                   	 	window.location.href=rootPath+'/annual/toAnnualReviewPage.do';
	  				},
	  				error : function(parame) {
	  					bootbox.alert('服务器请求失败!');
	  				}
	  			});
			}
	       });
}
	
 //修改通知公告
 	function updateInfo(){
 		$('#saveUpdateBtn').show();
 		$('#urlDiv2').hide();
 		$('#urlDiv').show();
 		var rootPath = getRootPath();
 		var localhostPath = getRootPath1();
 		var id = getSelectionsStr()+"";
      	if(id==''){
      		bootbox.alert('请选择要编辑的行！');
      		return;
      	}else{
      		if(id.indexOf(',')!=-1){
      			bootbox.alert('只能选中一行');
      			return;
      		}
      	}
        $("#formUpdatesInfo").find("input").val("");
        $('#myModalAdd').modal('hide');
        $("#uploadFileName").html('');
        $("#uploadFileId").val('');
        //$("#uploadFileId").val(id);
        $.commonReq({
				url : rootPath + "/annual/selectById.do",
				async : true,
				data : {"id":id},
				success : function(parame) {
					if(parame.data.status==1){
						bootbox.alert('该文件已提交审核，无法对其操作!');
						return;
					}
                		var obj = parame.data;
                		$("#updateId").val(obj.id);
                		$("#updateFileName").val(obj.fileName);
                		$("#updateYearId").val(obj.year);
                		$("#updateResume").val(obj.resume);
                		$("#updateRemarks").val(obj.remarks);
                		if(obj.fileUrl==''){
                			$("#downloadHref").hide();
                		}else{
                			$("#uploadFileInput").val(obj.fileUrl);
                    		$("#downloadHref").attr("href", localhostPath+"/filePath/"+obj.fileUrl ); 
                		} 
                		
                		if(obj.fileUrl != null && obj.fileUrl.trim() !=''){
                			$("#uploadFileId").val(obj.fileUrl);
                    		var nameAry = obj.fileUrl.split('|');
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
                   		$('#myModalUpdate').modal('show');
				},
				error : function(parame) {
					bootbox.alert('服务器请求失败!');
				}
			});
  	} 
  	function saveUpdateInfo(){
  		var flag = true;
  		//检查标题
       	var name=$('#updateFileName').val();
       	if(checkNullAndEmpty(name)){
       		bootbox.alert("环评文件标题不能为空！");
       		flag=false;
			return;    	
       	}
     //检查年份
       	var year = $("#updateYearId").val();
       	if(checkNullAndEmpty(year)){
       		bootbox.alert("年份不能为空！");
       		flag=false;
			return;    	
       	} 
       	var rootPath = getRootPath();
  		
  		if(flag){
  			 $.commonReq({
 				url : rootPath + "/annual/updateAnnualRevice.do",
 				async : true,
 				data:$("#formUpdateInfo").serialize(),
 				success : function(data) {
                        $('#myModalAdd').modal('hide');
                        $('#myModalUpdate').modal('hide');
                        $('#dt').bootstrapTable('refresh', {url:rootPath + '/annual/findAll.do'});
                        bootbox.alert("修改成功！");
                },
                error:function(xhr,status,e){
                    //服务器响应失败时的处理函数
                   bootbox.alert('服务器请求失败！');
                }
            });
  		}
  	}
	
	function searchRegulations(id){
		debugger;
		var localhostPath = getRootPath1();
		var rootPath = getRootPath();
		$("#formUpdatesInfo").find("input").val("");
		$("#submitBtn").show();
        $('#myModalUpdate').modal('hide');
        $("#searchUploadFileName").html('');
        $("#uploadFileId").val('');
        $('#urlDiv').hide();
        $.commonReq({
			url : rootPath + '/annual/selectById.do',
			data : {
				"id" : id
			},
			success : function(data) {
				debugger;
                     		var obj = data.data;
                     		$("#searchId").val(obj.id);
                     		if(obj.status==1){
                     			$("#submitBtn").hide();
                     		}
                    		$("#searchFileName").val(obj.fileName);
                    		$("#searchYearId").val(obj.year);
                    		$("#searchResume").val(obj.resume);
                    		$("#searchRemarks").val(obj.remarks);
                    		var afterName = '';
                    		if(obj.fileUrl !='' && obj.fileUrl != null){
                    			var nameAry = obj.fileUrl.split('|');
                        		for(var i=0;i<nameAry.length;i++){
                        			if(nameAry[i].trim() != ''){
                        				var idAry=nameAry[i].split('^');
                        				var fileName = idAry[1];
                        				var beforeFileList = $("#searchUploadFileName").html();
                        				var url =localhostPath+'/filePath/'+nameAry[i];
                        				var afterFileList =beforeFileList+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href='+url+' target=_blank>'+fileName+'</a>';
                        				$("#searchUploadFileName").html(afterFileList);
                        			}
                        		}
                        		//$('#urlDiv2').show();
                    		}
                    		
                       		$('#myModalSearch').modal('show');
			}
		});
        
  	} 
	
	//提交
	function submitInfo(id){
		debugger;
		var rootPath = getRootPath();
		
		if(id=='' || id==undefined){
			id = $("#searchId").val();
		}
		
		if(id==""){
			bootbox.alert('请选择你要提交的数据！');
		}else{
			bootbox.confirm("提交后您将无法对该文件进行修改或删除操作,确定要提交该数据吗？",function(result){
   			if(result){
   				$.commonReq({
				url : rootPath + "/annual/sumbitAnnualReview.do",
				async : true,
				data:{"id":id},
				success : function(data) {
                    $('#myModalAdd').modal('hide');
                    $('#myModalUpdate').modal('hide');
                    $('#dt').bootstrapTable('refresh', {url:rootPath + '/annual/findAll.do'});
                    bootbox.alert("提交成功！");
                    $('#myModalSearch').modal('hide');
				},
				error:function(xhr,status,e){
                //服务器响应失败时的处理函数
					bootbox.alert('服务器请求失败！');
				}
   				});
   			}
   			});
   		}		
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
    function dataFormat(value){
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
