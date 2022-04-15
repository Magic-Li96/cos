<%@page import="cos.bean.User"%>
<%@page import="cos.dao.UserMapper"%>
<%@page import="cos.bean.ArticleCondition"%>
<%@page import="cos.dao.ArticleConditionMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cos.bean.Article"%>
<%@page import="cos.bean.Institute"%>
<%@page import="java.util.List"%>
<%@page import="cos.dao.InstituteMapper"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="cos.util.MybatisUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="zh-CN">
<style>
.container {
	padding-top: 10px;
}
</style>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>admin</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="../lib/bootstrap/css/bootstrap.css">

</head>

<body style="background-color: rgb(150, 141, 236);">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<nav class="navbar navbar-default" role="navigation">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-ex1-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#"><b>课程大纲系统后台管理</b></a>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a class="btn btn-default" href="./index.jsp">
									<span class="glyphicon glyphicon-user"></span><b>&nbsp;主页</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="./userManageIndex.jsp">
									<span class="glyphicon glyphicon-user"></span><b>&nbsp;用户管理</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="/cos/showInstitute">
									<span class="glyphicon glyphicon-home"></span><b>&nbsp;学院管理</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="#" data-toggle="modal" data-target="#departmentModal">
									<span class="glyphicon glyphicon-th-list"></span><b>&nbsp;系及专业管理</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="#" onclick="window.location.href='/cos/showAllArticle'">
									<span class="glyphicon glyphicon-file"></span><b>&nbsp;课程大纲管理</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="#">
									<span class="glyphicon glyphicon-copy"></span><b>&nbsp;数据备份</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="#">
									<span class="glyphicon glyphicon-copy"></span><b>&nbsp;数据恢复</b>
								</a>
							</li>
							<li><a class="btn btn-default" href="/cos/loginOut"><span class="glyphicon glyphicon-off"></span><b>&nbsp;退出系统</b></a></li>
						</ul>
					</div>
					<!-- /.navbar-collapse -->
				</nav>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<table style="background-color: aliceblue;" class="table">
					<thead>
						<tr>
							<th class="text-center">课程大纲</th>
							<th class="text-center">开课学院</th>
							<th class="text-center">状态</th>
							<th class="text-center">编写教师</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody>
						<% 
						SqlSession sqlSession = MybatisUtil.openSqlSession();
						
						int page_quantity = (Integer)request.getSession().getAttribute("page_quantity");
						int current_page = (Integer)request.getSession().getAttribute("current_page");
						
						@SuppressWarnings("unchecked")
						List<Article> articles = (ArrayList<Article>)request.getSession().getAttribute("articles");
						for(Article article:articles){
						%>
							<tr>
								<%
									if(article.getContidion().equals(1)||article.getContidion().equals(2)){
								%>
								<td class="text-center"><button class="btn btn-default disabled"><%=article.getCourse()+" "+article.getArticleName()%></button></td>
								<% 
									}else{
								%>
								<td class="text-center"><button class="btn btn-default"><%=article.getCourse()+" "+article.getArticleName()%></button></td>
								<%	}
						
									InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
									Institute startInstitute = instituteMapper.selectByPrimaryKey(article.getStartInstitute());
								%>
								<td class="text-center"><%=startInstitute.getInstituteName()%></td>
								<% 
									ArticleConditionMapper articleConditionMapper =sqlSession.getMapper(ArticleConditionMapper.class);
									ArticleCondition articleCondition = articleConditionMapper.selectByPrimaryKey(article.getContidion());
								%>
								<td class="text-center"><b><%=articleCondition.getArticleConditionName()%></b></td>
								<%
									if(article.getTeacher()==null){
								%>
								<td class="text-center">未分配教师</td>								
								<%
									}else{
										UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
										User teacher = userMapper.selectByPrimaryKey(article.getTeacher());
								%>
								<td class="text-center"><%=teacher.getUserName()%></td>								
								<%
									}
								%>
								<td class="text-center">
								<%
									if(article.getContidion()>2){
								%>
									<button style="font-size: 12px" class="btn btn-primary">编辑</button>
									<button style="font-size: 12px" class="btn btn-danger">删除</button>
								<%
									}else{
								%>
									<button style="font-size: 12px" class="btn btn-primary disabled">编辑</button>
									<button style="font-size: 12px" class="btn btn-danger disabled">删除</button>
								<%
									}
								%>
								<% 
									if(article.getContidion().equals(6)){
								%>
									<button style="font-size: 12px" class="btn btn-success">下载</button>
								<%
									}else{
								%>
									<button style="font-size: 12px" class="btn btn-success disabled">下载</button>
								<%
									}
								%>
								</td>								
							</tr>
								<%
									}
								%>
						
					</tbody>
					<tfoot>
						<tr class="text-center">
							<td colspan="5">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/showAllArticle?current_page=<%=current_page%>&page_index=prior">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/showAllArticle?current_page=<%=current_page%>&page_index=<%=i%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/showAllArticle?current_page=<%=current_page%>&page_index=next">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>

		<!-- 学院系管理模态框 -->
		<div id="departmentModal" class="modal fade" tabindex="-1"
			role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 style="font-weight: 600;" class="modal-title text-center">请选择学院</h4>
					</div>
					<div class="modal-body text-center">
						<select id="insID">
							<%
								InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
								List<Institute> institutes = instituteMapper.selectAllInstitute();
								for (Institute institute : institutes) {
							%>
							<option value="<%=institute.getInstituteId()%>"><%=institute.getInstituteName()%></option>
							<%
								}
							%>
						</select>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button 
							onclick="toDepartmentManageIndex()"
							type="button" 
							class="btn btn-primary">
							确定
						</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
	</div>

</body>
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
	function toDepartmentManageIndex() {
		var insID = window.document.getElementById("insID").value;
		window.location.href = "/cos/system/admin/departmentManageIndex.jsp?insId=" + insID;
	}
</script>
</html>