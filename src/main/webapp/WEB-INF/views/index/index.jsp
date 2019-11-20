<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.ex{
		white-space: nowrap;/*不换行*/
		overflow: hidden;/*超出范围隐藏*/
		text-overflow: ellipsis;/*超出用省略号*/
	}

</style>
<title>cms系统</title>
<body>
	<!-- top -->
	<div>
		<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	</div>
	<div class="container ">
		<div class="row">
			<!-- 左侧栏目菜单 -->
			<div class="col-md-2" style="margin-top: 5px;">
				<div class="list-group">
					<ul class="list-group text-center">
						<!--遍历栏目 -->
						<li
							class="list-group-item cms-list-group-item-action ${article.channelId==null?"cms-list-group-item-active":"" }"><a
							href="/" class="channel">热点</a></li>
						

						<c:forEach items="${channels}" var="c">
							<li
								class="list-group-item cms-list-group-item-action ${article.channelId==c.id?"cms-list-group-item-active":"" }"><a
								href="/?channelId=${c.id }" class="channel"> ${c.name } </a></li>

						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- 中间文章内容 -->
			<div class="col-md-7 split min_h_500">

				<c:if test="${article.channelId==null }">
					<!-- 轮播图 -->
					<div>
						<div id="carouselExampleCaptions" class="carousel slide"
							data-ride="carousel">
							<ol class="carousel-indicators">
								<li data-target="#carouselExampleCaptions" data-slide-to="0"
									class="active"></li>
								<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
								<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
							</ol>
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img src="/pic/1.jpg" class="d-block w-100" alt="...">
									<div class="carousel-caption d-none d-md-block">
										<h5>图片一</h5>
										<p></p>
									</div>
								</div>
								<div class="carousel-item">
									<img src="/pic/2.jpg" class="d-block w-100" alt="...">
									<div class="carousel-caption d-none d-md-block">
										<h5>图片二</h5>
										<p></p>
									</div>
								</div>
								<div class="carousel-item">
									<img src="/pic/3.jpg" class="d-block w-100" alt="...">
									<div class="carousel-caption d-none d-md-block">
										<h5>图片三</h5>
										<p></p>
									</div>
								</div>
							</div>

							<a class="carousel-control-prev" href="#carouselExampleCaptions"
								role="button" data-slide="prev"> <span
								class="carousel-control-prev-icon" aria-hidden="true"></span> <span
								class="sr-only">Previous</span>
							</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
								role="button" data-slide="next"> <span
								class="carousel-control-next-icon" aria-hidden="true"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>

					</div>
					<!-- 热点文章 -->
					<div>
						<hr>
						<c:forEach items="${info.list}" var="h">
							<div class="media">
								<img src="/pic/${h.picture }" class="mr-3" alt="..."
									style="height: 101px; width: 156px">
								<div class="media-body">
									<h3>
										<strong><a href="/article?id=${h.id }"
											target="_blank">${h.title }</a></strong>
									</h3>
									<p style="margin-top: 10px">
										${h.user.username}
										<fmt:formatDate value="${h.updated }"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</p>
								</div>
							</div>
							<hr>
						</c:forEach>
						<jsp:include page="/WEB-INF/views/common/pages.jsp"></jsp:include>
					</div>

				</c:if>
				<!-- 栏目不为空时。显示栏目下分类及分类文章 -->
				<c:if test="${article.channelId!=null }">
					<div>
						<!-- 分类 -->
						<div>
							<ul class="nav">
								<li class="nav-item"><a
									class="nav-link cms-list-group-item-action ${article.categoryId==null?"
									cms-list-group-item-active":"" }" href="/?channelId=${article.channelId}">全部</a>
								</li>
								<c:forEach items="${categorys }" var="c">
									<li class="nav-item"><a
										class="nav-link cms-list-group-item-action ${article.categoryId==c.id?"
										cms-list-group-item-active":"" }" href="/?channelId=${article.channelId}&categoryId=${c.id}">${c.name }</a>
									</li>
								</c:forEach>

							</ul>
						</div>
						<!-- 分类文章 -->
						<div>
						<hr>
						<c:forEach items="${info.list}" var="h">
							<div class="media">
								<img src="/pic/${h.picture }" class="mr-3" alt="..."
									style="height: 101px; width: 156px">
								<div class="media-body">
									<h3>
										<strong><a href="/article?id=${h.id }"
											target="_blank">${h.title }</a></strong>
									</h3>
									<p style="margin-top: 10px">
										${h.user.username}
										<fmt:formatDate value="${h.updated }"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</p>
								</div>
							</div>
							<hr>
						</c:forEach>
						<jsp:include page="/WEB-INF/views/common/pages.jsp"></jsp:include>
					</div>
						
						
						
						
					</div>

				</c:if>

			</div>
			<!-- 右侧栏目 -->
			<div class="col-md-3 split min_h_500" style="margin-top: 5px;">
			<!-- 最新文章 -->
			<div class="col-md-3 split min_h_500">
				<!-- 最近发布的5篇文章 -->
				<div class="card" style="width: 18rem;">
					<div class="card-header">最新文章</div>
					<div class="card-body">
						<c:forEach items="${lastInfo.list}" var="a">
							<p class="ex"> 
								<a href="/article?id=${a.id }" target="_blank" title="${a.title }">${a.title }</a>

							</p>
						</c:forEach>
					</div>
				</div>
			
			
			<div>
					<div class="card" style="width: 18rem; margin-top: 5px;">
						<img src="/pic/4.jpg" class="card-img-top" alt="..." style="height: 100px;width: 150px;">
						<div class="card-body">
							<h5 class="card-title">企鹅要飞？？</h5>
							<p class="card-text">小小的企鹅拥有一颗飞翔的心？？？但是你这翅膀是认真的吗？？麻烦翅膀再长大些吧.</p>
							<a href="#" class="btn btn-primary">查看详情</a>
						</div>
					</div>

					<div class="card" style="width: 18rem; margin-top: 5px;">
						<div class="card-header">图片集</div>
						<div class="card-body">
							<div id="carouselExampleSlidesOnly" class="carousel slide"
								data-ride="carousel">
								<!-- 轮播图 -->
								<div class="carousel-inner">
									<div class="carousel-item active">
										<img src="/pic/7.jpg" class="d-block w-100" alt="..." style="height: 200px;width: 300px;">
									</div>
									<div class="carousel-item">
										<img src="/pic/5.jpg" class="d-block w-100" alt="..." style="height: 200px;width: 300px;">
									</div>
									<div class="carousel-item">
										<img src="/pic/6.jpg" class="d-block w-100" alt="..." style="height: 200px;width: 300px;">
									</div>
								</div>
							</div>

						</div>
					</div>
					<!-- 友情链接 -->
					<div class="card" style="width: 18rem; margin-top: 5px;">
						<div class="card-header">友情链接</div>
						<div class="card-body">
						<a href="https://v4.bootcss.com/docs/4.3/getting-started/introduction/">Bootstarp</a> &nbsp;&nbsp;
						<a href="https://www.csdn.net/">CSDN</a>&nbsp;&nbsp;
						<a href="https://www.toutiao.com/">今日头条</a>&nbsp;&nbsp;
						<a href="https://www.taobao.com/">淘宝网</a>&nbsp;&nbsp;
						<a href="https://landing.zhaopin.com/register?utm_source=baidupcpz&utm_medium=cpt&utm_provider=partner&sid=121113803&site=null">智联招聘</a>&nbsp;&nbsp;
						<a href="https://www.xin.com/beijing/?channel=a49b117c44837d110753e751863f53">优信二手车</a>
						</div>
					</div>


				</div>
			
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	<script type="text/javascript">
		function goPage(page) {
			var url = "/?page=" + page
			location = url;
		}
	</script>
</body>
</html>