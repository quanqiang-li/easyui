<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'table2grid.jsp' starting page</title>

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
	<table id="dg" style="width:700px;height:auto;border:1px solid #ccc;">
	<thead>
            <tr style="visibility: hidden;">
                <th data-options="field:'itemid'"></th>
                <th data-options="field:'productid'"></th>
                <th data-options="field:'listprice',align:'right'"></th>
                <th data-options="field:'attr1'"></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>EST-1</td><td>FI-SW-01</td><td>36.50</td><td>Large</td>
            </tr>
            <tr>
                <td>EST-10</td><td>K9-DL-01</td><td>18.50</td><td>Spotted Adult Female</td>
            </tr>
            <tr>
                <td>EST-11</td><td>RP-SN-01</td><td>28.50</td><td>Venomless</td>
            </tr>
            <tr>
                <td>EST-12</td><td>RP-SN-01</td><td>26.50</td><td>Rattleless</td>
            </tr>
            <tr>
                <td>EST-13</td><td>RP-LI-02</td><td>35.50</td><td>Green Adult</td>
            </tr>
        </tbody>
    </table>
</body>
<script type="text/javascript">
$('#dg').datagrid();
</script>
</html>
