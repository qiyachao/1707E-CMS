<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String htmlData = request.getParameter("content1") != null ? request.getParameter("content1") : "";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>KindEditor JSP</title>
<link rel="stylesheet"
	href="/resource/kindeditor/themes/default/default.css" />
<link rel="stylesheet"
	href="/resource/kindeditor/plugins/code/prettify.css" />
<script charset="utf-8"
	src="/resource/kindeditor/plugins/code/prettify.js"></script>
<script charset="utf-8" src="/resource/kindeditor/kindeditor-all.js"></script>
    
<script charset="utf-8" src="/resource/kindeditor/lang/zh-CN.js"></script>
<script src="/resource/js/jquery-3.2.1.js"></script>

<script>
	KindEditor.ready(function(K) {
		window.editor1 = K.create('textarea[name="content1"]', {
			cssPath : '/resource/kindeditor/plugins/code/prettify.css',
			uploadJson : '/resource/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '/resource/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
			}
		});
		prettyPrint();
	});
	function query() {
		alert(editor1.html())
		//alert( $("[name='content1']").attr("src"))
	}
</script>
</head>

<body>

	<form id="form1">
		<div class="form-group">
			<label for="title">文章标题:</label> <input class="form-control"
				id="title" type="text" name="title">
		</div>
		
		<div class="form-group">
			<textarea name="content1" cols="100" rows="8"
				style="width: 825px; height: 240px; visibility: hidden;"><%=htmlspecialchars(htmlData)%></textarea>
			<br />
		</div>
		
		<div class="form-group form-inline">

			所属栏目: <select class="form-control form-control-sm" id="channel" name="channelId">
				<option value="-1">请选择</option>

			</select> 所属分类: <select class="form-control form-control-sm" id="category" name="categoryId">
				<option>请选择</option>

			</select>
		</div>
		<div>
		标题图片:
		<input type="file" name="file" class="form-control form-control-sm">
		</div>
		&nbsp;
		<div>
		<button type="button" class="btn btn-success" onclick="publish()">发表文章</button>
		<button type="reset" class="btn btn-warning">重置</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	function publish(){
		//获取formData对象
		var formData = new FormData($("#form1")[0]);
		alert(editor1.html())
		//单独封装富文本编辑中的内容(hrml格式的)
		formData.set("content",editor1.html());
		$.ajax({
			type:"post",
			url:"/my/publish",
			data:formData,
			//告诉jQuery不要去处理发送的数据
			processData:false,
			//告诉jQuery不要去设置Content-Type请求头
			contentType:false,
			success:function(flag){
				if(flag){
					alert("发布成功");
					location.href="/my/index";
				}else{
					alert("发布失败,登录已过期");
				}
			}
		
		})
	}

	//栏目，分类下拉框赋值
	$(function(){
		//先查出所有栏目
		$.get(
				"/channel/channels",
				function(obj){
					for(var i in obj){
					$("#channel").append("<option value='"+obj[i].id+"'>"+obj[i].name+"</option>")
					}
			
		})
		//为栏目绑定change事件
		$("#channel").change(function(){
			//先清空栏目下的已有的值
			$("#category").empty();
			//获取栏目id值
			var channelId = $(this).val();
			//如果为-1就不查询
			if(channelId==-1){
				$("#category").html("<option>请选择</option>");
				return ;
			}
			//获取当前选中的栏目的id
			var channelId = $(this).val();
			//去查询栏目下的分类并赋值到下拉框
			$.get(
				"/category/selects",
				{channelId:channelId},
				function(list){
					$("#category").html("<option>请选择</option>");//重置第二个下拉框
					for(var i in list){
						$("#category").append("<option value='"+list[i].id+"'>"+list[i].name+"</option>")
					}
			
		})
		})
	})
	
</script>
</html>
<%!private String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}%>