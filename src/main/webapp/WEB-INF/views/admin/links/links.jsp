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
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function add(){
		$("#center").load("/admin/links/add");
	}
</script>
</head>
<body>
	<div style="text-align: center;">
		<button class="btn  btn-info" onclick="add()">添加链接</button>
		<table class="table table-hover  table-bordered">
			<thead class="thead-dark">
				<tr>
					<th>序号</th>
					<th>链接名称</th>
					<th>url</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${info.list}" var="l">
					<tr>
						<td>${l.id}</td>
						<td>${l.text}</td>
						<td>${l.url }</td>
						<td><fmt:formatDate value="${l.created }"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><a href="${l.url }">浏览</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/common/pages.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	//分页点击事件
	function goPage(page) {
		var url = "/admin/links/links?page=" + page;
		$("#center").load(url);
	}
</script>
</html>