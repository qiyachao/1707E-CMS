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
function collect() {
	var text = '${article.title}';//收藏的标题
	var url = window.location.href;//收藏的地址

	$.post(
			"/collect", 
	{text : text,url : url}, 
	function(flag) {
		if (flag.code == 0) {
			alert(flag.msg);
			$("#mc").html(
					"<span style='font-size: 20px;color: red'>★(已收藏)</span>")
		} else {
			alert(flag.msg);

		}
	})

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
			<dd id="mc">
				<c:if test="${isCollect==1}">
					<span style="font-size: 20px; color: red">★ (已收藏)</span>
				</c:if>
				
				<c:if test="${isCollect!=1}">
					<span style="font-size: 20px; color: blue;"> <a
						href="javascript:collect()">☆ (未收藏)</a>
					</span>
				</c:if>

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
	
	function back(){//返回文章列表
		$("#center").load("/article/articles");
	}
</script>
</html>