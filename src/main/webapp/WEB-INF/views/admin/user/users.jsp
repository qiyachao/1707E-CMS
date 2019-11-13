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
	function query(){
		//在中间区域加载用户页面
		$("#center").load("/users?usernmae="+$("[name='username']").val());
	}
</script>
</head>
<body>
<div style="text-align: center;">
	<div class="form-group form-inline">
		用户名:<input type="text" name="username" class="form-control"
			value="${user.username }">&nbsp;
		<button type="button" class="btn btn-success btn-sm" onclick="query()">查询</button>
	</div>
	<table class="table table-hover  table-bordered">
		<thead class="thead-dark">
			<tr>
				<th>序号</th>
				<th>用户名</th>
				<th>昵称</th>
				<th>性别</th>
				<th>生日</th>
				<th>注册时间</th>
				<th>更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${users}" var="u" varStatus="i">
				<tr>
					<td>${(info.pageNum-1)*info.pageSize+i.index+1}</td>
					<td>${u.username }</td>
					<td>${u.nickname }</td>
					<td>${u.gender==0?"男":"女" }</td>
					<td><fmt:formatDate value="${u.birthday }"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${u.created }"
							pattern="yyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${u.updated }"
							pattern="yyy-MM-dd HH:mm:ss" /></td>
					<td><c:if test="${u.locked==0 }">
							<button type="button" class="btn btn-success" onclick="update(this,${u.id})">正常</button>
						</c:if> <c:if test="${u.locked==1 }">
							<button type="button" class="btn btn-danger" onclick="update(this,${u.id})">停用</button>
						</c:if></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/common/pages.jsp"></jsp:include>
</div>
</body>
<script type="text/javascript">
	function update(obj,id){
		 //0:正常 1:停用
		  //更改当前状态 如果当前状态为正常,则改为停用.如果是停用则改为正常
		var locked =$(obj).text()=="正常"?"1":"0";
		$.post(
		"/update",
		{id:id,locked:locked},
		function(flag){
			if(flag){
				$(obj).text(locked==1?"禁用":"正常")//先改变按钮内容
				$(obj).attr("class",locked=="0"?"btn btn-success":"btn btn-danger")//改变按钮颜色
			}else{
				alert("操作失败")
			}
		}
		)
	}
	//分页点击事件
	$(function(){
		$(".page-link").click(function(){
			var url = $(this).attr("data");
			$("#center").load(url);
		})
	})
</script>
</html>