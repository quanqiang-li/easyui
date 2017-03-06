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
	<table id="dg" style="width:100%;height:auto;border:1px solid #ccc;" >
	<thead>
            <tr>
                <th data-options="field:'itemid'">itemid</th>
                <th data-options="field:'productid'">productid</th>
                <th data-options="field:'listprice',align:'right'">listprice</th>
                <th data-options="field:'attr1'">attr1</th>
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
        (function($){
            function pagerFilter(data){
                if ($.isArray(data)){    // is array
                    data = {
                        total: data.length,
                        rows: data
                    }
                }
                var target = this;
                var dg = $(target);
                var state = dg.data('datagrid');
                var opts = dg.datagrid('options');
                if (!state.allRows){
                    state.allRows = (data.rows);
                }
                if (!opts.remoteSort && opts.sortName){
                    var names = opts.sortName.split(',');
                    var orders = opts.sortOrder.split(',');
                    state.allRows.sort(function(r1,r2){
                        var r = 0;
                        for(var i=0; i<names.length; i++){
                            var sn = names[i];
                            var so = orders[i];
                            var col = $(target).datagrid('getColumnOption', sn);
                            var sortFunc = col.sorter || function(a,b){
                                return a==b ? 0 : (a>b?1:-1);
                            };
                            r = sortFunc(r1[sn], r2[sn]) * (so=='asc'?1:-1);
                            if (r != 0){
                                return r;
                            }
                        }
                        return r;
                    });
                }
                var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
                var end = start + parseInt(opts.pageSize);
                data.rows = state.allRows.slice(start, end);
                return data;
            }
 
            var loadDataMethod = $.fn.datagrid.methods.loadData;
            var deleteRowMethod = $.fn.datagrid.methods.deleteRow;
            $.extend($.fn.datagrid.methods, {
                clientPaging: function(jq){
                    return jq.each(function(){
                        var dg = $(this);
                        var state = dg.data('datagrid');
                        var opts = state.options;
                        opts.loadFilter = pagerFilter;
                        var onBeforeLoad = opts.onBeforeLoad;
                        opts.onBeforeLoad = function(param){
                            state.allRows = null;
                            return onBeforeLoad.call(this, param);
                        }
                        var pager = dg.datagrid('getPager');
                        pager.pagination({
                            onSelectPage:function(pageNum, pageSize){
                                opts.pageNumber = pageNum;
                                opts.pageSize = pageSize;
                                pager.pagination('refresh',{
                                    pageNumber:pageNum,
                                    pageSize:pageSize
                                });
                                dg.datagrid('loadData',state.allRows);
                            }
                        });
                        $(this).datagrid('loadData', state.data);
                        if (opts.url){
                            $(this).datagrid('reload');
                        }
                    });
                },
                loadData: function(jq, data){
                    jq.each(function(){
                        $(this).data('datagrid').allRows = null;
                    });
                    return loadDataMethod.call($.fn.datagrid.methods, jq, data);
                },
                deleteRow: function(jq, index){
                    return jq.each(function(){
                        var row = $(this).datagrid('getRows')[index];
                        deleteRowMethod.call($.fn.datagrid.methods, $(this), index);
                        var state = $(this).data('datagrid');
                        if (state.options.loadFilter == pagerFilter){
                            for(var i=0; i<state.allRows.length; i++){
                                if (state.allRows[i] == row){
                                    state.allRows.splice(i,1);
                                    break;
                                }
                            }
                            $(this).datagrid('loadData', state.allRows);
                        }
                    });
                },
                getAllRows: function(jq){
                    return jq.data('datagrid').allRows;
                }
            })
        })(jQuery);
 
        /*
        function getData(){
            var rows = [];
            for(var i=1; i<=800; i++){
                var amount = Math.floor(Math.random()*1000);
                var price = Math.floor(Math.random()*1000);
                rows.push({
                    inv: 'Inv No '+i,
                    date: $.fn.datebox.defaults.formatter(new Date()),
                    name: 'Name '+i,
                    amount: amount,
                    price: price,
                    cost: amount*price,
                    note: 'Note '+i
                });
            }
            return rows;
        }
        */
        $(function(){
        	//原始的数据项，可以改为ajax
            //$('#dg').datagrid({data:getData()}).datagrid('clientPaging');
        	//修改后的数据项，post请求得到数据之后客户端分页
            $('#dg').datagrid({rownumbers:true,
                singleSelect:true,
                autoRowHeight:false,
                pagination:true,
                pageSize:10,fit:true}).datagrid('clientPaging');
        });
    </script>
</html>
