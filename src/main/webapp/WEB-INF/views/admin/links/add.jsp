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
	function save(){
		$.post(
			"admin/links/add",
			$("#form1").serialize(),
			function(flag){
				if(flag.code==0){
					alert(flag.msg);
					$("#center").load("/admin/links/selects");
				}else{
					alert(flag.msg);
				}
			}
		)
	}
</script>
</head>
<body>
	<div>
	<form action="" id="form1">
	<div class="from-group">
	<label for="text">链接名称:</label>
	<input class="form-control" type="text" name="text" id="text">
	</div>
	<div class="from-group">
	<label for="text">链接url:</label>
	<input class="form-control" type="text" name="url" id="url">
	</div>
	<div class="from-group">
		<button type="button" class="btn btn-success" onclick="save()">保存</button>
		<button class="btn btn-info" type="reset">重置</button>
	</div>
	</form>
	</div>
</html>