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

<title>My JSP '1parser.jsp' starting page</title>

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
	<hr />
	<hr />
	<div id="wrapper">
		<script type="text/javascript">
			function doZoom(size) {
				var zoom = document.all ? document.all['entry'] : document
						.getElementById('entry');
				zoom.style.fontSize = size + 'px';
			}
		</script>
		<div id="content">
			<!-- menu -->
			<div id="map">
				<div class="font">
					<a href="javascript:doZoom(12)">小</a> <a href="javascript:doZoom(13)">中</a> <a href="javascript:doZoom(18)">大</a>
				</div>
			</div>
			<!-- end: menu -->
			<div class="entry_box_s">
				<div class="entry_title_box">
					<!-- 分类图标 -->
					<div class="ico"></div>
					<!-- end: 分类图标 -->
					<div class="entry_title">jQuery EasyUI parser 的使用场景</div>
				</div>
				<!-- end: entry_title_box -->
				<div class="entry">
					<div id="entry">
						<p>
							parser，故名意思，就是解析器的意思，$.parser.parse()解析整个页面，$.parser.parse("#cc")解析指定元素的子元素;别看他只有那么几行代码，jQuery Easyui 能够根据class就能正常渲染页面全靠它了。一般情况下，我们并用不到解析器，本文主要讨论一下，什么情况下会用到它，如何使用。<br />
							<span id="more-216"></span>
						</p>
						<h4 id="自动调用parser：">自动调用parser：</h4>
						<p>我们之所以在页面中，只要书写相应的class，Easyui就能成功渲染页面，这是因为解析器在默认情况下，会在文档装载完成的时候($(document).ready)被调用一次，而且是渲染整个页面。</p>
						<h4 id="手动调用parser：">手动调用parser：</h4>
						<p>有些童鞋反映，当页面装载完后，如果用javascript生成的DOM中包含了Easyui支持控件的class，比如说，用javascript生成了以下代码：</p>
						<pre class="brush: html; gutter: true; first-line: 1; highlight: []; html-script: false">
&lt;div class=&quot;easyui-accordion&quot; id=&quot;tt&quot;&gt;
        &lt;div title=&quot;title1&quot;&gt;1&lt;/div&gt;
	&lt;div title=&quot;title2&quot;&gt;2&lt;/div&gt;
&lt;/div&gt;
</pre>
						<p>虽然页面上有这样的DOM了，但是没有被渲染为Easyui的accordion插件，原因很简单，Easyui并不会一直监听页面，所以不会主动渲染，这时候就需要手工调用Easyui的parser进行解析了。不过手工调用需要注意以下几点：</p>
						<h5 id="(1) 解析目标为指定DOM的所有子孙元素，不包含这个DOM自身：">(1) 解析目标为指定DOM的所有子孙元素，不包含这个DOM自身：</h5>
						<p>比如上面代码生成的HTML，id="tt"是我们想要的手风琴DIV，像下面代码去手工解析的话是得不到你想要的结果的：</p>
						<pre class="brush: javascript; gutter: true; first-line: 1; highlight: []; html-script: false">
$.parser.parse($(&#039;#tt&#039;));
</pre>
						<p>道理很简单，parser只渲染tt的子孙元素，并不包括tt自身，而它的子孙元素并不包含任何Easyui支持的控件class，所以这个地方就得不到你想要的手风琴效果了，应该这样写：</p>
						<pre class="brush: javascript; gutter: true; first-line: 1; highlight: []; html-script: false">
$.parser.parse($(&#039;#tt&#039;).parent());
</pre>
						<p>渲染tt的父节点的所有子孙元素就可以了，个人觉得通过jQuery的parent()方法是最安全不过的了，不管你的javascript输出了什么DOM，直接渲染其父节点就可以保证页面能被正确解析。</p>
						<h5 id="(2) 某些组件无法多次解析同一个DOM元素：">(2) 某些组件无法多次解析同一个DOM元素(新版已经修复)：</h5>
						<p>如果页面上本身就有tt元素：</p>
						<pre class="brush: html; gutter: true; first-line: 1; highlight: []; html-script: false">
&lt;div class=&quot;easyui-accordion&quot; id=&quot;tt&quot;&gt;
&lt;/div&gt;
</pre>
						<p>页面装载完，你通过脚本向tt元素append两个子DIV，然后解析：</p>
						<pre class="brush: javascript; gutter: true; first-line: 1; highlight: []; html-script: false">
$(&#039;#tt&#039;).append(&#039;&lt;div title=&quot;title1&quot;&gt;1&lt;/div&gt;&lt;div title=&quot;title2&quot;&gt;2&lt;/div&gt;&#039;)
$.parser.parse($(&#039;#tt&#039;).parent());
</pre>
						<p>不要以为你会得到一个满意的accordion，你什么也得不到，因为页面初始化的时候parser就主动渲染过tt元素，这时候tt已经被parser重构，你再到脚本中append，得到的DOM结构，其实并不是你预想的结果了，所以要避免这种用法。</p>
						<div class="clear"></div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<hr />
	<hr />
	<div>
		<div class="easyui-accordion" id="t1">
			<div title="title1">1</div>
			<div title="title2">2</div>
		</div>
	</div>
	<div>
		<div class="easyui-accordion" id="t2"></div>
	</div>
</body>
<script type="text/javascript">
	//1.关闭自动解析
	$.parser.auto = false;
	//2.动态设置t2元素
	$('#t2').append('<div title="title3">3</div><div title="title4">4</div>');
	//3.手动解析t2元素
	$.parser.parse($('#t2').parent());
	//4.当解析器完成解析动作的时候触发 只有自动解析的才触发，手动的不会触发
	$.parser.onComplete = function() {
		alert("解析完毕");
	}
	//5.最终结果只有t2组件成功解析
</script>
</html>
