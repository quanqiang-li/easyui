<%@ page import="org.apache.log4j.Logger"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>出错了</title>
<style>
/*404页面开始*/
.mobdec {
	width: 700px;
	height: 325px;
	margin: 0 auto;
	background: url(<%=path%>/images/gf2.png) no-repeat;
}

.mobdex {
	width: 350px;
	height: 180px;
	float: right;
	padding-top: 130px;
}

.mobdex ul li {
	list-style: none;
	line-height: 30px;
}

.mobdex-size {
	font-weight: bold;
	font-size: 14px;
}

.mo-bedu {
	font-size: 14px;
}

.mo-bedp {
	padding-left: 30px;
}

.mo-bedk {
	display: block;
	height: 30px;
	margin-top: 10px;
}

.mo-bedk li a {
	width: 70px;
	height: 25px;
	float: left;
	background: #e8fcff;
	margin-left: 10px;
	text-align: center;
	line-height: 25px;
	border: 1px solid #b5dcf1;
	border-radius: 5px 5px 5px 5px;
	color: #4b90b4;
}
/*404页面结束*/
</style>

</head>

<body>
	<div class="mobdec">
		<div class="mobdex">
			<ul>
				<li class="mo-bedu">非常抱歉，并没有找到您需要的页面。最可能的原因是：</li>
				<li class="mo-bedp">●&nbsp;地址栏的地址可能是错误的。</li>
				<li class="mo-bedp">●&nbsp;您的点击链接不存在或者更新中。</li>
				<li class="mobdex-size">请点击下面链接回到首页或者刷新此页面：</li>
				<ul class="mo-bedk">
					<li><a href="<%=basePath%>">回到首页</a></li>
					<li><a href="javascript:history.go(-1);">刷新页面</a></li>
				</ul>
			</ul>
		</div>
	</div>
	<div style="display: none;">
		<%
		//如果是从web.xml跳转过来的exception不为null，如果直接请求此页面exception是null
		     
			if (null != exception) {
				try {
					//全部内容先写到内存，然后分别从两个输出流再输出到页面和文件
					ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
					PrintStream printStream = new PrintStream(byteArrayOutputStream);
		
					printStream.println();
					printStream.println("用户信息");
					printStream.println("账号：" + request.getSession().getAttribute("userName"));
					printStream.println("访问的路径: " + request.getAttribute("javax.servlet.forward.request_uri"));
					printStream.println();
		
					printStream.println("异常信息");
					printStream.println(exception.getClass() + " : " + exception.getMessage());
					printStream.println();
		
					Enumeration<String> e = request.getParameterNames();
					if (e.hasMoreElements()) {
						printStream.println("请求中的Parameter包括：");
						while (e.hasMoreElements()) {
							String key = e.nextElement();
							printStream.println(key + "=" + request.getParameter(key));
						}
						printStream.println();
					}
		
					printStream.println("堆栈信息");
					exception.printStackTrace(printStream);
					printStream.println();
		
					out.print(byteArrayOutputStream); //输出到网页
					/*用log替代
					File dir = new File(request.getRealPath("/errorLog"));
					if (!dir.exists()) {
					    dir.mkdir();
					}
					String timeStamp = new SimpleDateFormat("yyyyMMddhhmmssS").format(new Date());
					FileOutputStream fileOutputStream = new FileOutputStream(new File(dir.getAbsolutePath() + File.separatorChar + "error-" + timeStamp + ".txt"));
					new PrintStream(fileOutputStream).print(byteArrayOutputStream); //写到文件
					 */
					Logger log = Logger.getLogger(this.getClass());
					log.error(byteArrayOutputStream);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}else{
				out.println("exception无信息");
			}
		%>
	</div>
</body>
</html>