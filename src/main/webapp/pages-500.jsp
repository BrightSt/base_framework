<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.print(basePath);
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<!-- Mirrored from condorthemes.com/cleanzone/pages-500.html by HTTrack Website Copier/3.x [XR&CO'2013], Mon, 31 Mar 2014 14:37:32 GMT -->
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="shortcut icon" href="<%=basePath %>resources/images/favicon.png">

	<title>后台异常页面</title>

	<!-- Bootstrap core CSS -->
	<link href="<%=basePath%>resources/cleanzone/js/bootstrap/dist/css/bootstrap.css" rel="stylesheet">

	<link rel="stylesheet" href="<%=basePath%>resources/cleanzone/fonts/font-awesome-4/css/font-awesome.min.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	  <script src="../../assets/js/html5shiv.js"></script>
	  <script src="../../assets/js/respond.min.js"></script>
	<![endif]-->

	<!-- Custom styles for this template -->
	<link href="<%=basePath%>resources/cleanzone/css/style.css" rel="stylesheet" />	

</head>

<body class="texture">

<div id="cl-wrapper" class="error-container">
	<div class="page-error">
		<h1 class="number text-center">500</h1>
		<h2 class="description text-center">不要担心, 遇到一点小问题!</h2>
		<h3 class="text-center"> 我们正在努力解决, 请稍后再试.</h3>
		<h4 class="text-center" style="color:#FFF;">想要返回 <a href="<%=basePath%>user/checkLogin.do">首页</a>?</h4>
	</div>
	<div class="text-center copy">&copy; 2017 <a href="#">江苏小桥流水科技股份有限公司</a></div>

	
</div>

<script src="<%=basePath%>resources/cleanzone/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/cleanzone/js/behaviour/general.js"></script>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
  <script src="<%=basePath%>resources/cleanzone/js/behaviour/voice-commands.js"></script>
  <script src="<%=basePath%>resources/cleanzone/js/bootstrap/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/cleanzone/js/jquery.flot/jquery.flot.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/cleanzone/js/jquery.flot/jquery.flot.pie.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/cleanzone/js/jquery.flot/jquery.flot.resize.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/cleanzone/js/jquery.flot/jquery.flot.labels.js"></script>
</body>

<!-- Mirrored from condorthemes.com/cleanzone/pages-500.html by HTTrack Website Copier/3.x [XR&CO'2013], Mon, 31 Mar 2014 14:37:32 GMT -->
</html>
