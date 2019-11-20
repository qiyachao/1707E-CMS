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
	//文档就绪函数，下拉框回显
	$(function(){
		$("#status").val('${article.status}');
	})
	function query(){
		$("#center").load("/article/articles?title="+$("[name='title']").val()+"&status="+$("[name='status']").val());
	}
</script>
</head>
<body>
	<div style="text-align: center;">
		<div class="form-group form-inline">
			<label for="title"> 标题:</label> <input id="title" type="text"
				class="form-control form-control-sm" name="title"
				value="${article.title }">&nbsp; 
			<select class="form-control form-control-sm" name="status" id="status">
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
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${articles}" var="a" varStatus="i">
					<tr>
						<td>${(info.pageNum-1) * info.pageSize+i.index+1 }</td>
						<td>${a.title }</td>
						<td>${a.user.username }</td>
						<td><c:if test="${a.hot==0 }">
								<button type="button" class="btn btn-info"
									onclick="update(this,${a.id})">否</button>
							</c:if> <c:if test="${a.hot==1 }">
								<button type="button" class="btn btn-success"
									onclick="update(this,${a.id})">是</button>
							</c:if></td>
						<td>${a.channel.name }</td>
						<td>${a.category.name }</td>
						<td><fmt:formatDate value="${a.updated }"
								pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
						<td><c:if test="${a.deleted==0 }">
								<button type="button" class="btn btn-warning"
									onclick="del(this,${a.id})">正常</button>
							</c:if> <c:if test="${a.deleted==1 }">
								<button type="button" class="btn btn-danger"
									onclick="del(this,${a.id})">已删除</button>
							</c:if></td>		
								
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
		$("#center").load("/article/article?id="+id);
	}
	//删除文章
	function del(obj,id){
		 //0:正常 1:停用
		  //更改当前状态 如果当前状态为正常,则改为停用.如果是停用则改为正常
		var deleted =$(obj).text()=="正常"?"1":"0";
		$.post(
		"/article/update",
		{id:id,deleted:deleted},
		function(flag){
			if(flag){
				$(obj).text(deleted==1?"已删除":"正常")//先改变按钮内容
				$(obj).attr("class",deleted=="0"?"btn btn-warning":"btn btn-danger")//改变按钮颜色
			}else{
				alert("操作失败")
			}
		}
		)
	}
	//修改状态
	function update(obj,id){
		 //0:正常 1:停用
		  //更改当前状态 如果当前状态为正常,则改为停用.如果是停用则改为正常
		var hot =$(obj).text()=="否"?"1":"0";
		$.post(
		"/article/update",
		{id:id,hot:hot},
		function(flag){
			if(flag){
				$(obj).text(hot==1?"是":"否")//先改变按钮内容
				$(obj).attr("class",hot=="0"?"btn btn-info":"btn btn-success")//改变按钮颜色
			}else{
				alert("操作失败")
			}
		}
		)
	}
	//分页点击事件
	function goPage(page){
		var url = "/admin/article/articles?page="+page+"&title="+$("[name='title']").val()+"&status="+$("[name='status']").val();
		$("#center").load(url);
	}
	</script>
</body>
</html>