<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/index_work.css" />
<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resource/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/resource/css/cms.css" />
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>

</head>
<body>
	<div style="text-align: center;">
		<div class="form-group form-inline">
			<label for="title"> 标题:</label> <input id="title" type="text"
				class="form-control form-control-sm" name="title"
				value="${article.title }">&nbsp; <select
				class="form-control form-control-sm" name="status" id="status">
				<option value="1">已审核</option>
				<option value="0">待审核</option>
				<option value="-1">驳回</option>
				<option value="">全部</option>
			</select>&nbsp;
			<button type="button" class="btn btn-success btn-sm"
				onclick="query()">查询</button>
		</div>
		<table class="table table-hover  table-bordered">
			<thead class="thead-light">
				<tr>
					<th>序号</th>
					<th>文章标题</th>
					<th>作者</th>
					<th>是否热门</th>
					<th>所属栏目</th>
					<th>所属分类</th>
					<th>更新时间</th>
					<th>是否删除</th>
					<th>审核状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${info.list}" var="a" varStatus="i">
					<tr>
						<td>${(info.pageNum-1) * info.pageSize+i.index+1 }</td>
						<td>${a.title }</td>
						<td>${a.user.username }</td>
						<td>"${a.hot==0?"否":"是" }"</td>
						<td>${a.channel.name }</td>
						<td>${a.category.name }</td>
						<td><fmt:formatDate value="${a.updated }"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>${a.deleted==0?"正常":"已被管理删除" }</td>
						<td>${a.status==0?"待审":a.status==1?"已审":"驳回" }</td>
						<td>
							<button type="button" class="btn btn-primary"
								onclick="detail(${a.id})">详情</button>
						</td>
					</tr>

				</c:forEach>
			</tbody>

		</table>
		<div>
			<jsp:include page="/WEB-INF/views/common/pages.jsp"></jsp:include>
		</div>

	</div>
	<script type="text/javascript">
	
	//文章详情
	function detail(id){
		$("#center").load("/my/article?id="+id);
	}
	
	//分页点击事件
	function goPage(page) {
			var url = "/my/selectByUser?page=" + page 
			$("#center").load(url);
		}
	</script>
</body>
</html>