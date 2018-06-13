/*此文件用于控制整个菜单的异步交互然后返回内容使用html*/
jQuery.PublicToolsJs={
	getJsonFromBackJson:function(parame,sign){//获取后台jso转过来的json数据进行处理变成同实体类属性一致的json对象，只针对后台实体类属性是大写的方法;sign:0说明是一个json对象其他json对象数组
		 var backJsonArray = new Array();
		 var count=0;
		 for(var i=0;i<parame.length;i++){
				    var obj=parame[i];
				    var backJsonObject="{";
				    for(var name in obj){
				    	var newName=name.toUpperCase();
				    	var jsonzhi = obj[name];
				    	if(jsonzhi==null || jsonzhi=="null" || jsonzhi==""){
				    		jsonzhi = "";
				    	}
				    	backJsonObject+="\""+newName+"\""+":"+"\""+jsonzhi+"\",";
				    }  
				    backJsonObject=backJsonObject.substring(0,(backJsonObject.lastIndexOf(',')));
				    backJsonObject+="}";
				    backJsonArray[count] = JSON.parse(backJsonObject);
					count++;
		 }
		 if(sign==0){
			 return backJsonArray[0];
		 }else{
			 return backJsonArray;
		 }
	}
};
window.onload= function getNowFormatDate() {
	var date = new Date();
	this.year = date.getFullYear();
	this.month = date.getMonth() + 1;
	this.date = date.getDate();
	this.day = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六")[date.getDay()];
	this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
	this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
	this.second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
	var currentTime = " "+this.year + "年" + this.month + "月" + this.date + "日" + this.day;
	$("#time").html(currentTime);
	return currentTime;
}; 
//时间格式化
	function fmtDate(dtData, fmt){
	    if(null==dtData || ''==dtData || typeof(dtData)=='undefined'){
	        return '';
	    }
	    var dt=new Date(new Number(dtData));
	    if (/(y+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(dt.getFullYear()+"").substr(4-RegExp.$1.length));
	    }
	    if (/(M+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(new Number(dt.getMonth())+1):(("00"+(new Number(dt.getMonth())+1)).substr((""+ (new Number(dt.getMonth())+1)).length)));
	    }
	    if (/(d+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(dt.getDate()):(("00"+dt.getDate()).substr((""+ dt.getDate()).length)));
	    }
	    if (/(H+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(dt.getHours()):(("00"+dt.getHours()).substr((""+ dt.getHours()).length)));
	    }
	    if (/(m+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(dt.getMinutes()):(("00"+dt.getMinutes()).substr((""+ dt.getMinutes()).length)));
	    }
	    if (/(s+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(dt.getSeconds()):(("00"+dt.getSeconds()).substr((""+ dt.getSeconds()).length)));
	    }
	    if (/(q+)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(Math.floor((this.getMonth() + 3) / 3)):(("00"+Math.floor((this.getMonth() + 3) / 3)).substr((""+ Math.floor((this.getMonth() + 3) / 3)).length)));
	    }
	    if (/(S)/.test(fmt)){
	        fmt = fmt.replace(RegExp.$1,(RegExp.$1.length==1)?(dt.getMilliseconds()):(("00"+dt.getMilliseconds()).substr((""+ dt.getMilliseconds()).length)));
	    }
	    return fmt;
	}
	