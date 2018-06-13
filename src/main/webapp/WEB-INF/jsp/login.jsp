<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	System.out.print(basePath);
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/css/common.css">
<script type="text/javascript"
	src="<%=basePath%>resources/easyui/jquery.min.js"></script>
 <script src="<%=basePath%>resources/js/common.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/js/mainControl.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/js/PublicTools.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/easyui/easyui-lang-zh_CN.js"></script>

<!-- bootstrap start -->
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>resources/css/bootstrap/bootstrap.min.css">
<script type="text/javascript"
	src="<%=basePath%>resources/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>resources/js/bootstrap/bootbox.js"></script>
<!-- bootstrap start -->

<!--下拉框插件start-->
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap/bootstrap-select.css">
<script src="<%=basePath%>resources/js/bootstrap/bootstrap-select.js"></script>
<script src="<%=basePath%>resources/js/bootstrap/defaults-zh_CN.js"></script>
<!--下拉框插件end-->
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap/bootstrapValidator.css" />
<script src="<%=basePath%>resources/js/bootstrap/bootstrapValidator.js"></script>
<!-- bootstrap 时间控件 start -->
<link
	href="<%=basePath%>resources/datetimepicker/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" type="text/css" />
<script
	src="<%=basePath%>resources/datetimepicker/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script
	src="<%=basePath%>resources/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<!-- bootstrap 时间控件 start -->

<!-- bootstrap table start -->
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap/bootstrap-table.min.css">
<script src="<%=basePath%>resources/js/bootstrap/bootstrap-table.min.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-table-zh-CN.min.js"></script>
<!-- bootstrap table end -->
<!-- 上传图片 -->
<%-- <script src="<%=basePath%>resources/js/bootstrap/fileUpload.js"
	type="text/javascript"></script> --%>
<script src="<%=basePath%>resources/js/bootstrap/jquery.form.js"
	type="text/javascript"></script>
<script src="<%=basePath%>resources/js/bootstrap/center-loader.js"></script>
<script
	src="<%=basePath%>resources/js/bootstrap/bootstrap-treeview.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>resources/assets/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=basePath%>resources/assets/font-awesome/4.2.0/css/font-awesome.min.css" />

		<!-- text fonts -->

		<!-- ace styles -->
		<link rel="stylesheet" href="<%=basePath%>resources/assets/css/ace.min.css" />
<script src="<%=basePath%>resources/js/business/login.js"></script>
<style>
			.login-container {
				width: 675px;
				margin: 70px auto 0;
			}
			
			#id-company-text {
				text-align: center;
			}
			
			.float {
				float: left;
			}
			
			.width-49 {
				width: 49%!important;
			}
			
			.margin-r-2 {
				margin: 0 2% 0 0;
			}
			.bootbox {
			position: absolute;
			z-index: 9999;
			top:45%;
			}
		</style>
	</head>

	<body class="login-layout">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-md-12">
						<div class="login-container">
							<div class="center">
								<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" t="1515400358820" class="icon" style="" viewBox="0 0 1024 1024" version="1.1" p-id="870" width="56" height="56">
									<path d="M417.075 516.443c0 52.608 42.648 95.256 95.256 95.256s95.256-42.648 95.256-95.256-42.648-95.256-95.256-95.256c-52.609 0-95.256 42.648-95.256 95.256z m95.256-127.185c23.415 0 45.233 6.386 63.859 17.029l160.179-274.593c-65.987-38.315-142.086-60.666-224.038-60.666s-158.583 22.351-224.57 60.666l158.583 275.657c19.157-11.175 41.507-18.093 65.987-18.093zM385.145 516.443H66.915c0 165.501 93.127 304.926 227.231 381.557l155.39-270.868c-38.315-21.818-64.391-63.327-64.391-110.689z m254.371 0c0 47.362-26.076 88.87-64.923 110.689L729.983 898c134.104-76.631 227.231-216.056 227.231-381.557H639.516z" p-id="871" fill="#478fca" />
								</svg>
								<h1>
									<!--<i class="ace-icon fa fa-leaf green"></i>-->
									
									<span class="blue">辐射源</span>
									<span class="green" id="id-text2">监督管理系统</span>
								</h1>
								<!--<h4 class="blue" id="id-company-text">&copy; 公司名称</h4>-->
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border" style="width: 375px; margin: 0 auto;">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee blue"></i>
												请输入您的信息
											</h4>

											<div class="space-6"></div>

											<form action="<%=basePath%>userInfo/login.do" method="post">
											<fieldset>
												<label class="block clearfix"> <span
													class="block input-icon input-icon-right"> <input
														type="text" class="form-control" placeholder="Username"
														name="userName" /> <i class="ace-icon fa fa-user"></i>
												</span>
												</label> <label class="block clearfix"> <span
													class="block input-icon input-icon-right"> <input
														type="password" class="form-control"
														placeholder="Password" name="password" /> <i
														class="ace-icon fa fa-lock"></i>
												</span>
												</label> <input name="type" id="type" value="1" hidden>
												<c:if test="${success==false }">
													<div class="error-mess">
														<span class="error-icon"></span><span id="error-message">${errorMsg }</span>
													</div>
												</c:if>
												<div class="space"></div>

												<div class="clearfix toolbar" style="padding: 0; border: 0; background:transparent;">
													<!-- <label class="inline"> <input type="checkbox"
														class="ace" /> <span class="lbl"> 记住</span>
													</label> -->

													<button type="submit"
														class="width-30 pull-right btn btn-sm btn-primary">
														<i class="ace-icon fa fa-key"></i> <span
															class="bigger-110">登录</span>
													</button>
													<a href="#"  data-target="#forgot-box" class="width-30 pull-left btn btn-sm btn-primary" onclick="clenaForm()">
														<i class="glyphicon glyphicon-pencil"></i> <span
															class="bigger-110">注册</span>
													</a>
												</div>

												<div class="space-4"></div>
											</fieldset>
										</form>

											<!--<div class="social-or-login center">
												<span class="bigger-110">第三方登录</span>
											</div>

											<div class="space-6"></div>

											<div class="social-login center">
												<a class="btn btn-primary">
													<i class="ace-icon fa fa-facebook"></i>
												</a>

												<a class="btn btn-info">
													<i class="ace-icon fa fa-twitter"></i>
												</a>

												<a class="btn btn-danger">
													<i class="ace-icon fa fa-google-plus"></i>
												</a>
											</div>-->
										</div>
										<!-- /.widget-main -->

										<div class="toolbar center" >
											<!--<div>
												<a href="#" data-target="#forgot-box" class="forgot-password-link">
													<i class="ace-icon fa fa-arrow-left"></i> 忘记密码
												</a>
											</div>-->

											<a href="#" data-target="#search-box" class="user-signup-link" onclick="hideSomeDiv()">
												<i class="ace-icon fa fa-arrow-left"></i>
												查看注册结果
											</a>
										</div>
									</div>
									<!-- /.widget-body -->
								</div>
								<!-- /.login-box -->

								<div id="forgot-box" class="forgot-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header red lighter bigger">
												<i class="ace-icon fa fa-key"></i>
												企业信息
											</h4>

											<div class="space-6"></div>
											<p>
												输入您的相关信息
											</p>

											<form id="companyForm">
												<input type="hidden" class="form-control"  id="companyStatus" name="status" value="0"/>
												<input type="hidden" class="form-control"  id="companyType" name="type" value="1"/>
												<fieldset>
													<label class="block width-49 float clearfix margin-r-2">
														<span class="block input-icon input-icon-right">
															<input class="form-control" placeholder="企业组织机构代码" id="companyCode" name="code" onblur="checkCode()"/>
															<i class="ace-icon fa fa-list-ol"></i>
														</span>
													</label><label class="block width-49 float clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="企业名称" id="companyName" name="name" />
															<i class="ace-icon fa fa-building"></i>
														</span>
													</label>
													<label class="block width-49 float margin-r-2 clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="法定代表人" id="CompanyManager" name="manager"/>
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label><label class="block width-49 float clearfix">
														<span class="block input-icon input-icon-right">
															<input type="tel" class="form-control" placeholder="联系电话" id="companyPhone" name="phone"/>
															<i class="ace-icon fa fa-phone-square"></i>
														</span>
													</label>
													<label class="block width-49 float clearfix margin-r-2">
														<span class="block input-icon input-icon-right">
															<select type="tel" class="form-control" id="companyLevel" name="companyLevel"/>
																<option value="1">省控企业</option>
																<option value="2">市控企业</option>
																<option value="3">区控企业</option>
															</select>
															<i class="ace-icon fa fa-caret-down"></i>
														</span>
													</label><label class="block width-49 float clearfix">
														<span class="block input-icon input-icon-right">
															<select type="text" class="form-control" placeholder="隶属关系" id="companySubjection" name="subjection">
																<option value="0">---选择上级管辖单位---</option>
																<c:forEach var="env" items="${envList}">
																<option value="${env.code }">${env.name }</option>
																</c:forEach>
															</select>
															<i class="ace-icon fa fa-paperclip"></i>
														</span>
													</label>
													
													<label class="block width-49 float clearfix margin-r-2">
														<span class="block input-icon input-icon-right">
															<input type="email" class="form-control" placeholder="邮箱" id="companyEamil" name="email"/>
															<i class="ace-icon fa fa-envelope"></i>
														</span>
													</label><label class="block width-49 float clearfix">
														<span class="block input-icon input-icon-right">
															<input type="tel" class="form-control" placeholder="传真" id="companyFax" name="fax"/>
															<i class="ace-icon fa fa-fax"></i>
														</span>
													</label>
													<label class="block width-100 float clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="企业地址" id="companyAddress" name="address"/>
															<i class="ace-icon fa fa-map-marker"></i>
														</span>
													</label>
													<label class="block width-100 float clearfix">
														<span class="block input-icon input-icon-right">
															<textarea class="form-control" placeholder="企业简介" id="companyRemark" name="remark"></textarea>
															<!--<i class="ace-icon fa fa-fax"></i>-->
														</span>
													</label>
													<!-- <div class="clearfix">
														<button type="button" class="width-35 pull-right btn btn-sm btn-danger">
															<i class="ace-icon fa fa-lightbulb-o"></i>
															<span class="bigger-110">验证</span>
														</button>
													</div> -->
												</fieldset>
											</form>
										</div>
										<!-- /.widget-main -->

										<div class="toolbar center">
											<a href="#" data-target="#login-box" class="back-to-login-link">
												<i class="ace-icon fa fa-arrow-left"></i>  &nbsp;返回首页&nbsp;  
											</a>
											<a href="#" data-target="#signup-box" class="back-to-login-link">
												&nbsp;下一步&nbsp;
												<i class="ace-icon fa fa-arrow-right"></i>
											</a>
										</div>
									</div>
									<!-- /.widget-body -->
								</div>
								<!-- /.forgot-box -->

								<div id="signup-box" class="signup-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header green lighter bigger">
												<i class="ace-icon fa fa-users green"></i>
												用户注册
											</h4>

											<div class="space-6"></div>
											<p>填写信息: </p>

											<form id="userForm">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="登录用户名" id="userName" name="userName" onblur="checkUserName()"/>
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="昵称" id="name" name="name" />
															<i class="ace-icon fa fa-heart"></i>
														</span>
													</label>
													<input type="hidden" class="form-control"  id="userStatus" name="status" value="1"/>
													<input type="hidden" class="form-control"  id="userCompanyCode" name="companyCode" value="1"/>
													<input type="hidden" class="form-control"  id="roleId"  value=""/>
													

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="密码" id="password" name="password" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="确认密码" id="password2" name="password2" onblur="checkPassword2()"/>
															<i class="ace-icon fa fa-retweet"></i>
														</span>
													</label>

													<label class="block clearfix">
														
														<span class="block input-icon input-icon-right">
															<input type="email" class="form-control" placeholder="注册结果接收邮箱" id="email" name="email" />
															<i class="ace-icon fa fa-envelope"></i>
														</span>
													</label>

													<div class="space-24"></div>

													<div class="clearfix">
														<button type="reset" class="width-30 pull-left btn btn-sm">
															<i class="ace-icon fa fa-refresh"></i>
															<span class="bigger-110">重置</span>
														</button>

														<button type="button" class="width-65 pull-right btn btn-sm btn-success" onclick="register()">
															<span class="bigger-110">注册</span>

															<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
														</button>
													</div>
												</fieldset>
											</form>
										</div>

										<div class="toolbar center">
											<a href="#" data-target="#forgot-box" class="back-to-login-link">
												<i class="ace-icon fa fa-arrow-left"></i> &nbsp;上一步
											</a>
											<a href="#" data-target="#login-box" class="back-to-login-link">
												  &nbsp;返回首页&nbsp;  
											</a>
										</div>
									</div>
									<!-- /.widget-body -->
								</div>
								<!-- /.signup-box -->
								<div id="search-box" class="signup-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header green lighter bigger">
												<i class="ace-icon fa fa-users green"></i>
												查看账号审批结果
											</h4>

											<div class="space-6"></div>
											<!-- <p>请输入登录用户名: </p> -->

											<form id="formInsertInfo" method="post" action="" class="form-horizontal">
             									 <div class="form-group">
                									<label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>请输入登录用户名：</label>
                									<div class="col-sm-6">
                										<input id="searchUserNameId"  class="form-control" maxlength="250" style="height:42px;">
                									</div>
                									<button type="button" class="btn btn-success" style="border-radius: 4px;padding: 6px 12px;font-size: 14px;" onclick="searchUser()">
														<span class="glyphicon glyphicon-search"></span>查询
													</button>
              									</div>
              									<div class="form-group" id="resultDiv" style="display:none">
                									<label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>审批结果：</label>
                									<div class="col-sm-6">
                										<input id="resultId"  class="form-control" maxlength="250" style="height:42px;">
                									</div>
                									
              									</div>
              									<div class="form-group" id="reasonDiv" style="display:none">
                									<label class="col-sm-3 control-label"><span style='color:red;font-size:20px;position:relative;top:7px;right:2px;margin-left:-7px;'></span>备注信息：</label>
                									<div class="col-sm-6">
                										<input id="reasonId" class="form-control" maxlength="250" style="height:42px;">
                									</div>
                									
              									</div>
              									
											</form>
										</div>

										<div class="toolbar center">
											
											<a href="#" data-target="#login-box" class="back-to-login-link">
												  &nbsp;返回登录页&nbsp;  
											</a>
										</div>
									</div>
									<!-- /.widget-body -->
								</div>
								<!-- /.signup-box -->
							</div>
							<!-- /.position-relative -->

							<div class="navbar-fixed-top align-right">
								<br /> &nbsp;
								<a id="btn-login-dark" href="#">Dark</a>
								&nbsp;
								<span class="blue">/</span> &nbsp;
								<a id="btn-login-blur" href="#">Blur</a>
								&nbsp;
								<span class="blue">/</span> &nbsp;
								<a id="btn-login-light" href="#">Light</a>
								&nbsp; &nbsp; &nbsp;
							</div>
						</div>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<%-- <script src="<%=basePath%>resources/assets/js/jquery.2.1.1.min.js"></script> --%>

		<!-- <![endif]-->


		<!--[if !IE]> -->
<%-- 		<script type="text/javascript">
			window.jQuery || document.write("<script src='<%=basePath%>resources/assets/js/jquery.min.js'>" + "<" + "/script>");
		</script> --%>

		<!-- <![endif]-->

		<!--[if IE]>
<%-- <script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script> --%>
<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='<%=basePath%>resources/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
		</script>

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
				$(document).on('click', '.toolbar a[data-target]', function(e) {
					e.preventDefault();
					var target = $(this).data('target');
					$('.widget-box.visible').removeClass('visible'); //hide others
					$(target).addClass('visible'); //show target
				});
			});

			//you don't need this, just used for changing background
			jQuery(function($) {
				$('#btn-login-dark').on('click', function(e) {
					$('body').attr('class', 'login-layout');
					$('#id-text2').attr('class', 'white');
					$('#id-company-text').attr('class', 'blue');

					e.preventDefault();
				});
				$('#btn-login-light').on('click', function(e) {
					$('body').attr('class', 'login-layout light-login');
					$('#id-text2').attr('class', 'grey');
					$('#id-company-text').attr('class', 'blue');

					e.preventDefault();
				});
				$('#btn-login-blur').on('click', function(e) {
					$('body').attr('class', 'login-layout blur-login');
					$('#id-text2').attr('class', 'white');
					$('#id-company-text').attr('class', 'light-blue');

					e.preventDefault();
				});

			});
		</script>
		
<h5 class="blue" id="id-company-text" style="position: fixed; bottom: 0; text-align: center; left: 50%; width: 230px; margin-left:-115px;">&copy; 江苏小桥流水科技股份有限公司</h5>
	</body>

</html>