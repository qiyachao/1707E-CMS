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
<script type="text/javascript">
	function query(){
		$("#center").load("/article/articles/title="+$("[name='title']").val());
	}
</script>
</head>
<body style="text-align: center">
	<div>
		<dl>
			<dt>
				<h2 align="center">${article.title }</h2><!-- 文章标题 -->
			</dt>
			<hr>
			<dd style="text-align: right;"><!-- 按键-->
				<button class="btn btn-success" type="button"
					onclick="update(${article.id},1)">通过</button>
				<button class="btn btn-danger" type="button"
					onclick="update(${article.id},-1)">驳回</button>
				<button class="btn btn-info" type="button" onclick="back()">返回列表</button>
			</dd>
			<dd>
				<fmt:formatDate value="${article.updated }"
					pattern="yyyy-MM-dd HH:mm:ss" />
			</dd><!-- 发表时间 -->
			<dd>${article.content }</dd><!-- 文章内容 -->
		</dl>

	</div>
</body>
<script type="text/javascript">
	//修改文章审核状态
	function update(id,status){
		$.post(
			"/article/update",
			{id:id,status:status},
			function(flag){
				if(flag){
					alert("操作成功");
					$("#center").load("/article/articles");//修改成功跳列表
				
				}
			}
		)
	}
	function back(){//返回文章列表
		$("#center").load("/article/articles");
	}
</script>
</html>