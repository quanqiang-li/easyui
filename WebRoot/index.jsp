<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<body>
	<ul>
		<li><a target="_blank" href="userController/getUser">CRUD 应用</a></li>
		<li><a target="_blank" href="baseController/parser">parser</a></li>
		<li><a target="_blank" href="baseController/easyLoader">easyLoader</a></li>
		<li><a target="_blank" href="baseController/toolTip">toolTip</a></li>
		<li><a target="_blank" href="datagridController/table2grid">table2grid</a></li>
		<li><a target="_blank" href="layout/layout">layout</a></li>
	</ul>
	
</body>
</html>
