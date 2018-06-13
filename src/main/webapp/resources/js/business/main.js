/*************************************************
Function:		Main
Description:	涓婚〉闈㈢被			
*************************************************/
function Main() {
    this.m_szDeviceName = "Embedded Net DVR";
	this.m_szDeviceType = "";
	this.m_lxdMain = null;
    this._m_iTime = 0;
    this._m_iTimerID = 0;	
}

Main.prototype = {
	
	//浜嬩欢缁戝畾鍑芥暟
	_mainEventBind: function () {
		var that = this;
		$(window).bind({
			resize: function () {
				that.iframeAutoFit(); 
			}
		});
		$("#spanHelp").bind({
			click: function (e) {
				e.stopPropagation();
				if($("#softwareEdition").css("display") !== "none") {
				   $("#softwareEdition").hide();
				} else {
					$("#softwareEdition").show();
				}
			}
		});
		$("body").bind({
			click: function (e) {
				if($("#softwareEdition").css("display") !== "none") {
					$("#softwareEdition").hide();
				}			
			}
		});		
	},
	
	//鑾峰彇璁惧鍚嶇О
	_getDeviceInfo: function () {
		var that = this;
		$.ajax({
			type: "get",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			timeout: 15000,
			async: false,
			url: g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/System/deviceInfo",
			success: function(xmlDoc, textStatus, xhr) {
				that.m_szDeviceType = $(xmlDoc).find("deviceType").eq(0).text();
				$("#main_type").html($(xmlDoc).find("model").eq(0).text());
				that.m_szDeviceName = $(xmlDoc).find("deviceName").eq(0).text();
				if(that.m_szDeviceName == "") {
					that.m_szDeviceName = "Embedded Net DVR";
				}
			}
		});	
	},
	
    //涓婚〉闈㈠垵濮嬪寲鍑芥暟
	initMain: function () {
		g_oCommon.m_szUserPwdValue = $.cookie("userInfo" + g_oCommon.m_lHttpPort);
		if(g_oCommon.m_szUserPwdValue === null) {
			window.location.href="login.asp";
			return;
		}
		translator.initLanguageSelect($.cookie("language"));
		var lxd = translator.getLanguageXmlDoc("Main");
		translator.translatePage($(lxd).children("Main")[0], document);
		this.m_lxdMain = $(lxd).children("Common")[0];
		var curpage = $.cookie("page");
		if(null == curpage) {
			this.changeFrame("preview.asp", 1);
		} else {
			this.changeFrame(curpage.split("%")[0], curpage.split("%")[1]);
		}
		//浜嬩欢缁戝畾
		this._mainEventBind();
		$(window).resize();
	},
	
	//涓婚〉闈㈠姞杞芥椂锛岃幏鍙朿ookie锛岃烦杞埌鍒锋柊鍓嶇殑鐣岄潰
	changeFrame: function (src, index) {
		$("#volumeDiv").remove();
		$("#WndArrangePart").remove();
		//鍒囨崲鐣岄潰鏃跺疄鏃惰幏鍙栬澶囧悕绉�
		this._getDeviceInfo();
		if($.browser.mozilla || ($.browser.msie && parseInt($.browser.version, 10) >= 9)) {
			$("#mainFrame").html('<iframe frameborder="0" scrolling="no" id="ContentFrame" name="ContentFrame" src="' + src + '" style="width:' + 
			(document.body.clientWidth - 28) + 'px' + ';height:' + (document.body.clientHeight - 138) + 'px' + ';"></iframe>');
		} else {
			$("#ContentFrame").attr("src", src);
		}
	},
	
	//鏀瑰彉涓婚〉鑿滃崟鏍�
	changeMenu: function (index) {
		for(var i = 1; i < 5; i++) {
			if($("#iMenu" + i).hasClass("menuBackground")) {
				$("#iMenu" + i).removeClass("menuBackground");
			}
		}
		$("#iMenu" + index).addClass("menuBackground");	
	},
	
	//鏀瑰彉椤甸潰璇█
	changeFrameLanguage: function (lan) {
		$.cookie("language", lan);
		var lxd = translator.getLanguageXmlDoc("Main", lan);
		translator.translatePage($(lxd).children("Main")[0], document);
		this.m_lxdMain = $(lxd).children("Common")[0];
		var curWnd = $("#ContentFrame")[0].contentWindow;
		if(curWnd.ParamConfig !== null && curWnd.ParamConfig !== undefined) {
		    curWnd.ParamConfig.prototype.instance().changeLanguage(lan);
		} else if (curWnd.g_oLogSearch !== null && curWnd.g_oLogSearch !== undefined) {
		    curWnd.g_oLogSearch.changeLanguage(lan);
		} else if(curWnd.g_oPlaybackInstance !== null && curWnd.g_oPlaybackInstance !== undefined) {
			curWnd.g_oPlaybackInstance.changeLanguage(lan);
		} else if(curWnd.g_oPreviewInstance !== null && curWnd.g_oPreviewInstance !== undefined) {
			curWnd.g_oPreviewInstance.changeLanguage(lan);
		}
	},
	
	//iframe楂樺害鑷€傚簲
    iframeAutoFit: function () {
		try {
			if(document.body.clientWidth < 993) {
				$("#headRight").hide();	
			} else {
				$("#headRight").show();	
			}	
			$("#ContentFrame").css("height", document.body.clientHeight - 138 + "px");
			$("#ContentFrame").css("width", document.body.clientWidth - 28 + "px");
		} catch(e) {}
	},
	
	//鏄剧ず婊戝姩鎻愮ず妗�
    showTipsDiv: function (szTitle, szTips) {
		var that = this;
		if(this._m_iTime == 0) {
			$("#CurTips").show();
			$("#TipsIframe").show();
		}
		if(0 != arguments.length) {
			if(this._m_iTimerID) {
				clearTimeout(this._m_iTimerID);
				this._m_iTimerID = 0;
			}
			$("#CurTips").css("bottom", "-106px");
			if(navigator.appName == "Microsoft Internet Explorer") {
				$("#TipsIframe").css("bottom", "-106px");
			}
			this._m_iTime = 0;
			$("#CurTips").html(szTips);
		}
		if(this._m_iTime >= 20) {
			this._m_iTimerID= setTimeout(that.hideTipsDiv, 1000);
			return;
		}
		var iBottom = parseInt($("#CurTips").css("bottom").replace("px", ""), 10);
		$("#CurTips").css("bottom", (iBottom + 5) + "px");
		if(navigator.appName == "Microsoft Internet Explorer") {
			var iframeBottom = parseInt($("#TipsIframe").css("bottom").replace("px", ""), 10);
			$("#TipsIframe").css("bottom", (iframeBottom + 5) + "px");
		}
		this._m_iTime++;
		this._m_iTimerID = setTimeout(function () {
		    g_oMain.showTipsDiv();
		}, 20);
    },
	
    //闅愯棌婊戝姩鎻愮ず妗�
    hideTipsDiv: function () {
		var that = this;
		if(this._m_iTime <= 0) {
			this._m_iTime = 0;
			this._m_iTimerID = 0;
			return;
		}
		var iBottom = parseInt($("#CurTips").css("bottom").replace("px", ""), 10);
		$("#CurTips").css("bottom", (iBottom - 5) + "px");
		if(navigator.appName == "Microsoft Internet Explorer") {
			var iframeBottom = parseInt($("#TipsIframe").css("bottom").replace("px", ""), 10);
			$("#TipsIframe").css("bottom", (iframeBottom - 5) + "px");
		}
		this._m_iTime--;
		this._m_iTimerID = setTimeout(function () {
		    g_oMain.hideTipsDiv();
		},  20);
		if(this._m_iTime == 0) {
			$("#CurTips").hide();
			$("#TipsIframe").hide();
		}
    }	
}
var g_oMain = new Main();