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

<title>My JSP '2easyLoader' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=path%>/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
</head>

<body>
	<hr />
	<hr />
	<p>使用脚本库总要加载一大堆的样式表和脚本文件，在easyui 中，除了可以使用通常的方式加载之外，还提供了使用 easyloader 加载的方式。这个组件主要是为了按需加载组件而诞生。什么情况下使用它呢？</p>
	<ol>
		<li>你觉得一次性导入 easyui 的核心 min js 和 css 太大</li>
		<li>你只用到 easyui 的其中几个组件</li>
		<li>你想使用其中的一个组件，但是你又不知道这个组件依赖了那些组件。</li>
	</ol>
	<div>如果你有以上三中情况，那么推荐你使用easyLoader。它可以帮你解决这些问题。</div>
	<p>easyloader 用来帮助我们自动加载所需的脚本文件和样式文件，这样，我们只需要在页面中引用 jquery 脚本 和 easyloader 脚本，easyloader 就可以帮助我们分析模块的依赖关系，先加载依赖项。模块加载好了会调用parse模块来解析页面。把class是easyui开头的标签都转化成
		easyui的控件。</p>
	<p>下面我们，以使用messager和dialog模块为例，使用easyloader加载所需的模块。</p>
	<p>我们的页面可以简单的仅仅写入下面的内容。注意，并不需要通常的样式表和一大堆的脚本引用。</p>
	<p>注意看！只有 jquery 的脚本和 easyloader 的脚本，完全没有一大堆的样式和其他脚本文件。</p>
	<p>load 用来使用代码来说明需要加载的模块，这是在 easyloader 中定义的一个函数，函数的第一个参数为准备加载的模块名称，第二个参数为加载成功之后的回调函数。这里用来提示已经加载成功。</p>
	<p>load 加载的模块有两种格式，即可以是一个字符串表示的单个模块，也可以是一个字符串的数组，同时加载多个模块。</p>
	<pre>
		 <span style="color: #008000;">//</span><span style="color: #008000;">name有两种，一种是string ,一种是string array,这样一次可以加载多个plugin,都是调用add方法进行添加  </span>
 <span style="color: #0000ff;">if</span> (<span style="color: #0000ff;">typeof</span> name == 'string'<span style="color: #000000;">) {
<span style="color: #000000;">    add(name);
 } <span style="color: #0000ff;">else</span><span style="color: #000000;"> {
</span>    <span style="color: #0000ff;">for</span> (<span style="color: #0000ff;">var</span> i = 0; i &lt; name.length; i++<span style="color: #000000;">) {
</span> <span style="color: #000000;">        add(name[i]);
</span> <span style="color: #000000;">    }
</span> }
	</pre>
	<p>easyloader.load 还有一个别名 using 定义在 window对象上，如下所示：</p>
	<pre>window.using = easyloader.load; </pre>
	<p>　　所以，加载的代码也可以这样写。</p>
	<div class="cnblogs_code">
<pre> using("messager", <span style="color: #0000ff;">function</span><span style="color: #000000;"> () {
</span>    alert("加载成功！"<span style="color: #000000;">);
</span> });</pre>
<p>　　加载成功之后，我们就可以在代码中使用已经加载的模块了。</p>
<p>　　页面中还使用 class 说明了一个按钮，这里使用了 <span style="color: #ff0000;">class<span style="color: #0000ff;">="easyui-linkbutton"，<span style="color: #000000;">easyloader 还可以帮助我们解析元素中的特殊类名，直接就在页面中使用过的模块。</span></span></span></p>
</div>
<p>　　easyloader 会在它所在文件夹中，寻找 plugins 子文件夹中的脚本，和 themes 文件夹中的样式表。所以需要保证文件保存在正确的位置。不过，easyloader 还提供了一个 base 属性，用来指定寻找插件和脚本的起点。</p>
	<p>相关属性的使用可查询资料</p>
	<hr />
	<hr />
	<div id="dd2">第1个对话框dialog</div>
	<button id="btnAlert" class="easyui-linkbutton">btnAlert</button>
</body>
<script type="text/javascript">
	$(function() {
		//使用easyloader加载dialog模块使用到的相关js和css样式
		easyloader.load('dialog', function() {
			/*使用JavaScript动态创建EasyUI的Dialog的步骤：
			  1、定义一个div，并给div指定一个id
			  2、使用Jquery选择器选中该div，然后调用dialog()方法就可以创建EasyUI的Dialog
			 */
			//使用自定义参数创建EasyUI的Dialog
			$('#dd2').dialog({
				title : '使用JavaScript创建的Dialog',
				width : 400,
				height : 200,
				closed : false,
				cache : false,
				modal : true
			});
		});

		easyloader.locale = "zh_CN";
		//easyloader.load 还有一个别名 using 定义在 window 对象上
		//使用easyloader加载messager模块使用到的相关js和css样式
		using("messager", function() {
			alert("第二个messager加载成功！");
			$("#btnAlert").click(function() {
				$.messager.alert('Warning', 'The warning message');
			});
		});

	});
</script>
</html>
