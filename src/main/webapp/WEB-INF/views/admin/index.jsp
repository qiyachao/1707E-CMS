<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/resource/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/resource/css/cms.css" />
<!-- 	<link rel="stylesheet" type="text/css"
	href="/resource/open-iconic/font/css/open-iconic-bootstrap.css" /> -->
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>


<script type="text/javascript"
	src="/resource/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<div class="row" style="margin-top: 2px; min-height: 30px">
			<div class="col-md-12" style="background-color: #563d7c;">
				<img alt="" src="/resource/images/logo.jpg" class="rounded-circle" style="height: 100px;width: 160px">
					<a class="navbar-brand mr-1" href="index.html">CMS系统后台</a>

					<c:choose>
						<%-- 登录显示用户菜单 --%>
						<c:when test="${sessionScope.admin != null}">
							<div class="btn-group dropleft"
							style="float: right; padding-top: 20px">
							<button type="button" class="btn btn-secondary dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">${sessionScope.admin.username}</button>
							<div class="dropdown-menu">
								<ul class="nav" style="left: -88px">
									<li class="nav-item"><a class="nav-link"
										href="/passport/login">注销</a></li>
								</ul>
							</div>
						</div>
						</c:when>
						<c:otherwise>
							<%-- 未登录显示登录注册链接 --%>
							<li class="nav-item"><a class="nav-link"
								href="/passport/reg">注册</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/passport/login">登录</a></li>
						</c:otherwise>
					</c:choose>
				</ul>


			</div>
		</div>
		<div class="row" style="padding-top: 3px; min-height: 500px">
			<div class="col-md-2">
				<ul class="nav flex-column" style="font-size: 30px">
					<li class="nav-item"><a class="nav-link"
						href="/admin/index"><span class="oi oi-monitor">&nbsp;后台首页</a></li>
					<li class="nav-item"><a class="nav-link" href="#" data="/user/users">用户管理</a></li>
					<li class="nav-item"><a class="nav-link" href="#" data="/article/articles">文章管理</a></li>
					<li class="nav-item"><a class="nav-link" href="#">友情链接</a></li>
					<li class="nav-item"><a class="nav-link" href="#">分类管理</a></li>
					<li class="nav-item"><a class="nav-link" href="#">系统设置</a></li>
				</ul>
			</div>
			<div class="col-md-10 min_h_500 split" id="center" style="border-left: 1px solid #000">
			<img alt="" src="/resource/images/01.jpg" class="rounded-circle" style="height: 500px;width: 800px;">
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){//文档就绪函数
		$(".nav-link").click(function(){//获取所有按键给一个点击事件
			var li = $("ul li a");
			//先移除所有的list-group-item-info样式
			li.removeClass("list-group-item-danger");
			//为左侧菜单添加动态点击样式 
			$(this).addClass("list-group-item-danger");
			 //获取点击URL
			var url=$(this).attr("data");//获取到该事件的data值
			$("#center").load(url);//把获取的内容放到中间内容区
		})
	})
	
</script>
</html>