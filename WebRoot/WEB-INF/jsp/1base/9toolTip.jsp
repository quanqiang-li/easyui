<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP '9toolTip.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css">
<script type="text/javascript" src="<%=path%>/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
</head>

<body>
	<div>内容提示</div>
	<a id="dd" href="javascript:void(0)">Click here</a>
</body>

<script type="text/javascript">
	$('#dd')
			.tooltip(
					{
						position : 'right',
						content : '<span style="color:#fff">This is the tooltip message.</span>',
						onShow : function() {
							$(this).tooltip('tip').css({
								backgroundColor : '#666',
								borderColor : '#666'
							});
						}
					});
</script>
</html>
