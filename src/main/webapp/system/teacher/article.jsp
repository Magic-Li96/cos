<%@page import="java.net.URLEncoder"%>
<%@page import="cos.dao.UserMapper"%>
<%@page import="cos.bean.ArticleCondition"%>
<%@page import="cos.dao.ArticleConditionMapper"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cos.bean.Article"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="cos.dao.CourseMapper"%>
<%@page import="cos.bean.Course"%>
<%@page import="cos.dao.CourseTypeMapper"%>
<%@page import="cos.bean.CourseType"%>
<%@page import="cos.dao.InstituteMapper"%>
<%@page import="cos.bean.Institute"%>
<%@page import="cos.bean.Subject"%>
<%@page import="cos.dao.SubjectMapper"%>
<%@page import="cos.dao.DepartmentMapper"%>
<%@page import="cos.bean.Department"%>
<%@page import="java.util.List"%>
<%@page import="cos.dao.DepartmentHeadMapper"%>
<%@page import="cos.bean.DepartmentHead"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="cos.util.MybatisUtil"%>
<%@page import="cos.bean.User"%>
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
<title>课程大纲信息管理系统</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="../lib/bootstrap/css/bootstrap.css">
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="/cos/pageoffice.js" id="po_js_main"></script>

<script type="text/javascript">
	var cID;
	var dep;
	var sub;
	function savePrimaryKey(c,d,s) {
		cID=c;
		dep=d;
		sub=s;
		console.log(cID);
		console.log(dep);
		console.log(sub);
	}
</script>
</head>

<body style="background-color: rgb(150, 141, 236);">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<nav class="navbar navbar-default" role="navigation">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a style="font-size: 20px;" class="navbar-brand" href="#"><b>课程大纲信息管理系统</b></a>
					</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav navbar-left">
							<% 
								User user=(User)request.getSession().getAttribute("user");
								SqlSession sqlSession = MybatisUtil.openSqlSession();
							%>
							<li class="active"><a href="#"> <span
									class="glyphicon glyphicon-user"></span> <%=user.getUserName()%>老师
							</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a class="btn btn-default" href="./index.jsp">
								<span class="glyphicon glyphicon-home"></span><b>&nbsp;消息主页</b>
								</a>
							</li>
							<li class="dropdown">
					          <a class="btn btn-default" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
					          	<span class="glyphicon glyphicon-file"></span>
					          	<b>我的课程大纲</b>
					          </a>
					        </li>
							<li><a class="btn btn-default" href="./userMange.html"><span
									class="glyphicon glyphicon-pushpin"></span><b>&nbsp;修改个人信息</b></a></li>
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
										//HTTP请求参数中特殊字符的转义
										String src = URLEncoder.encode(article.getArticleSrc());
								%>
								<td class="text-center">
									<button onclick="openArticle('<%=src%>')" class="btn btn-default"><%=article.getCourse()+" "+article.getArticleName()%>
									</button>
								</td>
								<%
									}
								%>
								<% 
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
									if(article.getContidion().equals(2)){
								%>
									<button onclick="newArticle(<%=article.getCourse()%>,<%=article.getDepartment()%>,<%=article.getSubject()%>)" style="font-size: 12px" class="btn btn-primary">新建</button>
								<%
									}else{
								%>
									<button style="font-size: 12px" class="btn btn-primary disabled">新建</button>
								<%
									}
									if(article.getContidion()>2){
										//HTTP请求参数中特殊字符的转义
										String src = URLEncoder.encode(article.getArticleSrc());
								%>
									<button onclick="editArticle('<%=src%>')" style="font-size: 12px" class="btn btn-primary">编辑</button>
									<button onclick="location.href='/cos/deleteTeacherArticle?src=<%=src%>'" style="font-size: 12px" class="btn btn-danger">删除</button>
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
										String src = URLEncoder.encode(article.getArticleSrc());
								%>
									<button onclick="download('<%=src%>')" style="font-size: 12px" class="btn btn-success">下载</button>
									<script type="text/javascript">
										function download(str) {
											location.href="/cos/articleFileDownload?src="+str;
										}
									</script>
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
				</table>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		function newArticle(cou,dep,sub) {
			location.href="./newArticle.jsp?courseId="+cou+"&departmentId="+dep+"&subjectId="+sub;
		}
		function openArticle(url) {
			POBrowser.openWindowModeless('/cos/checkArticle?src='+url,'width=1200px;height=800px;');
		}
		function editArticle(url) {
			POBrowser.openWindowModeless('/cos/editArticle?src='+url,'width=1200px;height=800px;');
		}
	</script>
	

</body>

</html>