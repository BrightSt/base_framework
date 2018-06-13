/*****************************************************
Copyright 2007-2011 Hikvision Digital Technology Co., Ltd.   
FileName: Translator.js
Description: 缈昏瘧鍣ㄧ浉鍏�
Author: wuyang
Date: 2012.1.5
*****************************************************/

function Translator()
{
	debugger;
	this.szCurLanguage = null; // 鍘焟_szLanguage
	this.languages = new Array();
	var that = this;
	$.ajax({
		url: "../xml/Languages.xml",
		type: "get",
		async: false,
		dataType: "xml",
		error: function(xml) {
			//alert('Error loading XML document' + xml); // 鍙兘鏂囦欢缂栫爜閿欒锛屾垨XML涓嶆爣鍑�
		},
		success: function(xml) {
			$(xml).find("Language").each(function(i) {
				that.languages.push({
					value: $(this).children("value").text(), 
					name: $(this).children("name").text(),
					isDefault: $(this).is("[default='true']")
				});
			});
		}
	});
	
	/*************************************************
	Function:		initLanguageSelect
	Description:	鍒濆鍖�$("LanguageSelect")锛岄噸缃畉his.szCurLanguage
	Input:			szLanguage: 閫変腑璇█鐨勬爣鍑嗙缉鍐�
	Output:			鏃�
	return:			鏃�
	*************************************************/
	this.initLanguageSelect = function(szLanguage) {
		var that = this;
		if ($("#LanguageSelect option").length === 0) {
			var szOptions = "";
			$.each(this.languages, function(i) {
				szOptions += "<option value ='"+ this.value + "'>" + this.name + "</option>";
				if (this.isDefault === true) {
					that.szCurLanguage = this.value;
				}
			});
			$(szOptions).appendTo("#LanguageSelect");
		}
		if (szLanguage !== undefined && szLanguage !== null && szLanguage !== "") {
			$.each(this.languages, function(i) {
			    if (this.value === szLanguage) {
				    that.szCurLanguage = this.value;
			    }
		    });
		}
		else if(szLanguage === null)
		{
			this.szCurLanguage = "en";  //绯荤粺璇█鏃犳硶鍖归厤鍒版椂榛樿鏄剧ず鑻辨枃
		}
		$.cookie('language', this.szCurLanguage);
		setTimeout(function() { $('#LanguageSelect').val(that.szCurLanguage); }, 10); // IE6闇€寤惰繜璁剧疆
		return this.szCurLanguage;
	}

	/*************************************************
	Function:		appendLanguageXmlDoc
	Description:	灏唋xd鍚堝苟鑷砽xdObj锛岃繑鍥炲悎骞跺悗鐨刲xd
	Input:			lxdObj: 寰呭悎骞剁殑lxd
					lxd: 鐢ㄤ簬鍚堝苟鐨刲xd锛屼笉琚敼鍙�
	Output:			lxdObj: 鍚堝苟鍚庣殑lxd鍚岃繑鍥炲€�
	return:			鍚堝苟鍚庣殑lxd
	*************************************************/
	this.appendLanguageXmlDoc = function(lxdObj, lxd) {
		if (lxdObj === null && lxd !== null) {
			return (this.s_lastLanguageXmlDoc = lxd);
		} else if (lxdObj !== null && lxd === null) {
			return (this.s_lastLanguageXmlDoc = lxdObj);
		} else if (lxdObj === null && lxd === null) {
			return (this.s_lastLanguageXmlDoc = null);
		} else {
			return (this.s_lastLanguageXmlDoc = $(lxdObj).append($(lxd.cloneNode(true)).children())[0]);
		}
	}
	
	/*************************************************
	Function:		getLanguageXmlDoc
	Description:	鏍规嵁鎸囧畾璇█鏍囩ず绗﹀拰XML鍚嶇О锛岃幏鍙朙anguageXmlDoc锛屽鎸囧畾szLanguage鍒欓噸缃畉his.szCurLanguage
	Input:			szXmls: (String)XML鍚嶇О锛屼笉鍚悗缂€鍚嶏紱鎴�(Array)XML鍚嶇О鍙婂叾瀛愬瓩鑺傜偣缁勬垚鐨勬暟缁�
					szLanguage: 璇█鏍囩ず绗︼紝鍗虫枃浠跺す鍚嶏紙鍙渷鐣ワ紝榛樿this.szCurLanguage锛�
	Output:			鏃�
	return:			鎸囧畾璇█鐨凩anguageXmlDoc
	*************************************************/
	this.getLanguageXmlDoc = function(szXmls, szLanguage, bMergeCommon) {
		if (szLanguage !== undefined) {
			this.szCurLanguage = szLanguage;
		}
		if (typeof szXmls === "string") {
			szXmls = [szXmls];
		}
		$.each(szXmls, function(i, szXml) {
			szXmls[i] = szXml.replace(/^(\d)/, "_$1");
		});
		var lxd = $.ajax({
			url: "../xml/" + this.szCurLanguage + "/" + szXmls[0] + ".xml",
			type: "get",
			async: false,
			cache: true,
			dataType: "xml",
			error: function(xml, textStatus, errorThrown) {
				//alert("Error loading XML document" + xml); // 鍙兘鏂囦欢缂栫爜閿欒锛屾垨XML涓嶆爣鍑�
			}
		}).responseXML;
		var lxdCommon = undefined;
		$.each(szXmls, function(i, szXml) {
			if (i === 1) {
				lxdCommon = $(lxd).children("Common")[0];
			}
			lxd = $(lxd).children(szXml)[0];
		});
		if (lxdCommon !== undefined && bMergeCommon !== false) {
			//this.appendLanguageXmlDoc(lxd, lxdCommon);
			$(lxd).append($(lxdCommon).children());
		}
		return (this.s_lastLanguageXmlDoc = lxd);
	}
	
	/*************************************************
	Function:		translateElements
	Description:	缈昏瘧鎸囧畾鏂囨。鐨勬煇绫绘爣绛�
	Input:			languageXmlDoc: 閫氳繃getLanguageXmlDoc鑾峰彇鐨凩anguageXmlDoc
					doc: 鎸囧畾鏂囨。
					szTag: 鏍囩绫诲瀷
					szProp: 灞炴€х被鍨�
					szKey: 鐢ㄤ簬缈昏瘧鐨勯敭锛屽"id"銆�"name"銆�"class"锛岄粯璁�"name"
	Output:			鏃�
	return:			鏃�
	*************************************************/
	this.translateElements = function(languageXmlDoc, doc, szTag, szProp, szKey)
	{
		if (szKey === undefined) {
			szKey = "name";
		}
		$(doc).find(szTag).each(function(i) {
			//var szTranslated = $(languageXmlDoc).children("Page").find($(this).attr("name")).eq(0).text();
			var szTranslated = $(languageXmlDoc).find($(this).attr(szKey)).eq(0).text(); // 杩欓噷鍙繘涓€姝ヤ紭鍖�, wuyang
			if (szTranslated !== "") {
				if (szTag === "label" || szTag === "a") {
					szTranslated = szTranslated.replace(/ /g,"&nbsp;");
				}
				switch (szProp) {
					case "innerHTML":
						$(this).html(szTranslated);
						break;
					case "innerText":
						$(this).text(szTranslated);
						break;
					case "value":
						$(this).val(szTranslated);
						break;
					default:
						$(this).attr(szProp, szTranslated);
						break;
				}
			}
		});
	}
	
	/*************************************************
	Function:		translatePage
	Description:	缈昏瘧鎸囧畾鏂囨。
	Input:			languageXmlDoc: 閫氳繃getLanguageXmlDoc鑾峰彇鐨凩anguageXmlDoc
					doc: 鎸囧畾鏂囨。
					szKey: 鐢ㄤ簬缈昏瘧鐨勯敭锛屽"id"銆�"name"銆�"class"锛岄粯璁�"name"
	Output:			鏃�
	return:			鏃�
	*************************************************/
	this.translatePage = function(languageXmlDoc, doc, szKey) {
		if (doc === undefined) {
			doc = document;
		}
		if (szKey === undefined) {
			szKey = "name";
		}
		// 杩欓噷鍙繘涓€姝ヤ紭鍖栵紝wuyang
		this.translateElements(languageXmlDoc, doc, "input", "value", szKey);
		this.translateElements(languageXmlDoc, doc, "label", "innerHTML", szKey);
		this.translateElements(languageXmlDoc, doc, "img", "title", szKey);
		this.translateElements(languageXmlDoc, doc, "option", "innerText", szKey);
		this.translateElements(languageXmlDoc, doc, "a", "innerHTML", szKey);
		var that = this;
		if (translateTailor.bEnable) {
			setTimeout(function() {
//				translateTailor.clearXmlFiles("D:/xml", ["Login", "Main", "Preview", "Playback", "Download", "Log", "ParamConfig", 
//					"LocalConfig", "System", "Network", "VideoAudio", "VideoSettings", "Security", "Events", "Storage"], that.szCurLanguage);
				
//				translateTailor.sewXmlFiles("D:/xml", ["Login"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "Preview"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "Playback"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "Download"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "Log"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "LocalConfig"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "System"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "Network"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "VideoAudio"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "VideoSettings"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "Security"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "Events"], that.szCurLanguage, doc, szKey);
//				translateTailor.sewXmlFiles("D:/xml", ["Main", "ParamConfig", "Storage"], that.szCurLanguage, doc, szKey);
			}, 10);
		}
	}
	
	/*************************************************
	Function:		translateNode
	Description:	缈昏瘧鎸囧畾鑺傜偣
	Input:			languageXmlDoc: 閫氳繃getLanguageXmlDoc鑾峰彇鐨凩anguageXmlDoc
					nodeName: XML涓殑鑺傜偣鍚�
	Output:			鏃�
	return:			缈昏瘧缁撴灉
	*************************************************/
	this.translateNode = function(languageXmlDoc, nodeName)
	{
		return $(languageXmlDoc).find(nodeName).text();
	}
}

Translator.prototype = {
	constructor: Translator,
	s_lastLanguageXmlDoc: null,
	translateNodeByLastLxd: function(nodeName) { // 妯℃嫙鍘焔etNodeValude
		if (this.s_lastLanguageXmlDoc === null) {
			return;
		}
		return translator.translateNode(this.s_lastLanguageXmlDoc, nodeName);
	}
}

/*************************************************
Function:		TransStack
Description:	缈昏瘧鍥炶皟鍫嗘爤绫�
Input:			鏃�
Output:			鏃�
return:			鏃�
*************************************************/
function TransStack()
{
	var _cbTransStack = [];

	this.clear = function() {
		_cbTransStack = [];
	}

	this.push = function(cbFun, bSync) {
		if (bSync === true) {
			cbFun();
		}
		_cbTransStack.push(cbFun);
	}
	
	this.translate = function() {
		$.each(_cbTransStack, function(i, cbTrans) {
			cbTrans();
		});
	}
}

/*************************************************
Function:		TranslateTailor
Description:	缈昏瘧瀛楃涓叉墍鍦ㄦ爣绛剧被鍨嬪拰闄愬埗闀垮害鐨勮嚜鍔ㄥ寲
Input:			鏃�
Output:			鏃�
return:			鏃�
*************************************************/
function TranslateTailor()
{
	this.bEnable = false;
	try {
		var _fso = null;//new ActiveXObject("Scripting.FileSystemObject");
		//this.bEnable = true;
	} catch (e) { }
	
	this.clearXmlFiles = function(szPath, szXmls, szLanguage) {
		if (!this.bEnable) {
			return;
		}
		if (typeof szXmls === "string") {
			szXmls = [szXmls];
		}
		$.each(szXmls, function(i, szXml) {
			_clearPage(szPath + "/" + szLanguage + "/" + szXml + ".xml", szLanguage);
		});
	}
	
	function _clearPage(szXmlPath, szLanguage) {
		var szXmlDoc = _readFile(szXmlPath);
		var lxd = g_oCommon.parseXmlFromStr(szXmlDoc);
		
		$.each($(lxd).find("*"), function(i, elem) {
			$(elem).removeAttr("tag").removeAttr("length");
		})

		_writeFile(lxd.xml, szXmlPath);
	}
	
	this.sewXmlFiles = function(szPath, szXmls, szLanguage, doc, szKey) {
		if (!this.bEnable) {
			return;
		}
		if (typeof szXmls === "string") {
			szXmls = [szXmls];
		}
		$.each(szXmls, function(i, szXml) {
			_measurePage(szPath + "/" + szLanguage + "/" + szXml + ".xml", szLanguage, doc, szKey);
		});
	}
	
	function _measureElements(languageXmlDoc, doc, szTag, szKey)
	{
		if (szKey === undefined) {
			szKey = "name";
		}
		$(doc).find(szTag).each(function(i) {
			if ($(languageXmlDoc).find($(this).attr(szKey)).length !== 0) {
				var elemXmlDoc = $(languageXmlDoc).find($(this).attr(szKey))[0];
				var szElemTag = $(elemXmlDoc).attr("tag");
				if (szElemTag === undefined) {
					szElemTag = "";
				}
				if (-1 === szElemTag.indexOf(szTag + ";")) {
					$(elemXmlDoc).attr("tag", szElemTag + szTag + ";");
				}
				var szElemLength = $(elemXmlDoc).attr("length");
				switch (szTag) {
					case "option":
						var iWidth = $(this).parent("select").eq(0).width();
						break;
					case "a":
						if ($(this).parent().get(0).tagName === "LI") {
							iWidth = 9999; // 鍚勯厤缃〉闈㈢殑a鏍囩
							break;
						}
					case "label":
//						var parent = $(this).parent().get(0);
//						if (parent !== null && (parent.tagName === "DIV" || parent.tagName === "SPAN" || parent.tagName === "TD" || parent.tagName === "TH")) {
//							var iParentWidth = $(this).parent().eq(0).width();
//							var iWidth = $(this).width();
//							iWidth = (iWidth !== iParentWidth) ? iParentWidth : 9999; // iWidth === iParentWidth鏃惰涓烘湭璁炬渶澶у搴︼紝鏆傛湭鎯冲埌鏇村ソ鐨勬柟娉�
//						} else {
//							var iWidth = 9999;
//						}
//						break;

						var iWidth = 9999;
						var $ancestor = $(this);
						var $ancestor2 = null; // 绁栬妭鐐逛腑$ancestor鐨刢hild
						while ($ancestor.length !== 0) {
							if ($ancestor.css("display") === "block" || $ancestor.css("display") === "inline-block" || $ancestor.css("display") === "table-cell") {
								iWidth = $ancestor.width();
								break;
							}
							$ancestor2 = $ancestor;
							$ancestor = $ancestor.parent();
						}
						if ($ancestor2 !== null && $ancestor2.css("text-align") === "left") {
							var ancestor2Next = $ancestor2.next().get(0);
							if (ancestor2Next === undefined) {
								iWidth = $ancestor.position().left + $ancestor.width() - $ancestor2.position().left;
							} else if (ancestor2Next !== undefined && $(ancestor2Next).position().top <= $ancestor2.position().top + $ancestor2.height()) {
								iWidth = Math.abs($ancestor2.position().left - $(ancestor2Next).position().left); // 杩欓噷涓轰粈涔堟湁鏃舵槸璐熸暟锛燂紵
							}
						}
						break;

					default: // "input"銆�"img"
						var iWidth = $(this).width();
						break;
				}

				if (iWidth > 0 && (szElemLength === undefined || szElemLength === "0" || szElemLength > iWidth)) {
					$(elemXmlDoc).attr("length", iWidth);
				}
			}
		});
	}
	
	function _measurePage(szXmlPath, szLanguage, doc, szKey) {		
		if (doc === undefined) {
			doc = document;
		}
		if (szKey === undefined) {
			szKey = "name";
		}
		
		var szXmlDoc = _readFile(szXmlPath);
		var lxd = g_oCommon.parseXmlFromStr(szXmlDoc);

		_measureElements(lxd, doc, "input", szKey);
		_measureElements(lxd, doc, "label", szKey);
		_measureElements(lxd, doc, "img", szKey);
		_measureElements(lxd, doc, "option", szKey);
		_measureElements(lxd, doc, "a", szKey);
		
		_writeFile(lxd.xml, szXmlPath);
	}
	
	function _readFile(szPath) {
		var szContent = "";
		try {
			var reader = _fso.OpenTextFile(szPath, 1, false, 0);
			while (!reader.AtEndofStream) {
				szContent += reader.readline();
				szContent += "\n";
			}
			reader.close();
		} catch(e) { }
		return szContent;
	}
	
	function _writeFile(szContent, szPath){
		try {
		   var writer = _fso.CreateTextFile(szPath, true);
		   writer.WriteLine(szContent);
		   writer.Close();
		} catch (e) { }
	}
}

var translateTailor = new TranslateTailor();

var translator = new Translator();