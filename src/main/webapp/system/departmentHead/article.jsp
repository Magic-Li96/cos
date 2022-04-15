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
								Department department=null; 
								SqlSession sqlSession = MybatisUtil.openSqlSession();
								DepartmentHeadMapper departmentHeadMapper = sqlSession.getMapper(DepartmentHeadMapper.class);
								List<DepartmentHead> departmentHeads = departmentHeadMapper.selectAll();
								for(DepartmentHead departmentHead:departmentHeads){
									if(departmentHead.getDepartmentHeadId().equals(user.getUserId())){
										DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
										department = departmentMapper.selectByPrimaryKey(departmentHead.getDepartmentId());
									}
								}
							%>
							<li class="active"><a href="#"> <span
									class="glyphicon glyphicon-user"></span> <%=department.getDepartmentName()%>主任
							</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a class="btn btn-default" href="./index.jsp">
								<span class="glyphicon glyphicon-home"></span><b>&nbsp;消息主页</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="#" data-toggle="modal" data-target="#SubjectModal">
								<span class="glyphicon glyphicon-th-list"></span><b>&nbsp;人才培养方案</b>
								</a>
							</li>
							<li class="dropdown">
					          <a class="btn btn-default" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
					          	<span class="glyphicon glyphicon-file"></span>
					          	<b>课程大纲管理</b>
					          	<span class="caret"></span>
					          </a>
					          <ul class="dropdown-menu">
					            <li><a class="btn btn-default" href="/cos/myArticle" >我的课程大纲</a></li>
					            <li role="separator" class="divider"></li>
					            <li><a data-toggle="modal" data-target="#ReturnSubjectAllArticle"
								class="btn btn-default">选择一专业并显示其所有课程大纲</a></li>
					            <li><a data-toggle="modal" data-target="#ValidArticle"
								class="btn btn-default">选择一专业并显示其已生效课程大纲</a></li>
					            <li><a data-toggle="modal" data-target="#WaitFirstAssessArticle"
								class="btn btn-default">选择一专业并显示其待初审课程大纲</a></li>
					            <li><a data-toggle="modal" data-target="#WaitDistributionArticle"
								class="btn btn-default">选择一专业并显示其待分配课程大纲</a></li>
					            <li role="separator" class="divider"></li>
					            <li class="text-center"><input id="articleId" type="text" placeholder="请输入课程ID"/>
					            &nbsp;
					            <button onclick="findArticleForCourseIndex()" class="btn btn-default">搜索</button></li>
								<script>
									function findArticleForCourseIndex() {
										var id = window.document.getElementById("articleId").value;
										window.location.href='/cos/findArticleForCourseIndex?courseId='+id;
									}
								</script>
								</ul>
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
							<th colspan="5" class="text-center">
								<b><%=department.getDepartmentName()%>&nbsp;<%=request.getParameter("title")%>专业</b>
							</th>
						</tr>
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
						
						int page_quantity = (Integer)request.getSession().getAttribute("page_quantity");
						int current_page = (Integer)request.getSession().getAttribute("current_page");
						
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
									if(article.getContidion().equals(1)&&article.getStartInstitute().equals(article.getInstitute())){
								%>
									<button onclick="savePrimaryKey(<%=article.getCourse()%>,<%=article.getDepartment()%>,<%=article.getSubject()%>)" 
									style="font-size: 12px" class="btn btn-warning" 
									data-toggle="modal" data-target="#distributeModal">分配</button>
									
								<% 
									}else{
								%>
									<button style="font-size: 12px" class="btn btn-warning disabled">分配</button>
								<%
									}
									
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
									<button onclick="location.href='/cos/deleteArticle?src=<%=src%>'" style="font-size: 12px" class="btn btn-danger">删除</button>
								<%
									}else{
								%>
									<button style="font-size: 12px" class="btn btn-primary disabled">编辑</button>
									<button style="font-size: 12px" class="btn btn-danger disabled">删除</button>
								<%
									}
								%>
								
								<% 
									if(article.getContidion()==3){
										//HTTP请求参数中特殊字符的转义
										String src = URLEncoder.encode(article.getArticleSrc());
								%>
									<button onclick="passSuccess()" style="font-size: 12px" class="btn btn-success">审核通过</button>
									<script type="text/javascript">
										function passSuccess() {
											var r = confirm("是否通过《<%=article.getArticleName()%>》课程大纲？");
											if (r == true) {
												location.href='/cos/passSuccess?src=<%=src%>';
											} else {
												return;
											}
										}
									</script>
									<button onclick="unPassSuccess()" style="font-size: 12px" class="btn btn-success">审核不通过</button>
									<script type="text/javascript">
										function unPassSuccess() {
											var r = prompt("请输入未通过该课程大纲理由：");
											if (r != "") {
												console.log(r);
												window.alert("已将未通过审核原因发送给老师！");
												location.href='/cos/unFinallyPassSuccess?src=<%=src%>&msg='+r;
											} else {
												return;
											}
										}
									</script>
								<%
									}else{
								%>
									<button style="font-size: 12px" class="btn btn-success disabled">审核通过</button>
									<button style="font-size: 12px" class="btn btn-success disabled">审核不通过</button>
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
					<%
						if(request.getParameter("title").equals("myArticle")|request.getParameter("title").equals("search")){
						
						}else if(request.getSession().getAttribute("vaA")!=null){
							request.getSession().removeAttribute("vaA");
					%>
					<tfoot>
						<tr class="text-center">
							<td colspan="5">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/validArticle?current_page=<%=current_page%>&page_index=prior&subId=<%=request.getParameter("title")%>">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/validArticle?current_page=<%=current_page%>&page_index=<%=i%>&subId=<%=request.getParameter("title")%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/validArticle?current_page=<%=current_page%>&page_index=next&subId=<%=request.getParameter("title")%>">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
					<%
						}else if(request.getSession().getAttribute("wdA")!=null){
							request.getSession().removeAttribute("wdA");
					%>
					<tfoot>
						<tr class="text-center">
							<td colspan="5">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/waitDistributionArticle?current_page=<%=current_page%>&page_index=prior&subId=<%=request.getParameter("title")%>">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/waitDistributionArticle?current_page=<%=current_page%>&page_index=<%=i%>&subId=<%=request.getParameter("title")%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/waitDistributionArticle?current_page=<%=current_page%>&page_index=next&subId=<%=request.getParameter("title")%>">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
					<%
						}else if(request.getSession().getAttribute("wfA")!=null){
							request.getSession().removeAttribute("wfA");
					%>
					<tfoot>
						<tr class="text-center">
							<td colspan="5">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/waitFirstAssessArticle?current_page=<%=current_page%>&page_index=prior&subId=<%=request.getParameter("title")%>">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/waitFirstAssessArticle?current_page=<%=current_page%>&page_index=<%=i%>&subId=<%=request.getParameter("title")%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/waitFirstAssessArticle?current_page=<%=current_page%>&page_index=next&subId=<%=request.getParameter("title")%>">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
					<%
						}else{
					%>
					<tfoot>
						<tr class="text-center">
							<td colspan="5">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/returnSubjectAllArticle?current_page=<%=current_page%>&page_index=prior&subId=<%=request.getParameter("title")%>">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/returnSubjectAllArticle?current_page=<%=current_page%>&page_index=<%=i%>&subId=<%=request.getParameter("title")%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/returnSubjectAllArticle?current_page=<%=current_page%>&page_index=next&subId=<%=request.getParameter("title")%>">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
							<%
						}
					%>
				</table>
			</div>
		</div>
	</div>
	
	<div id="distributeModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请选择教师</h4>
				</div>
				<div class="modal-body text-center">
					<select id="userID">
						<%
							UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
							List<User> users = userMapper.selectAll();
							for(User u:users){
								if(u.getInstitute().equals(user.getInstitute())){
						%>
							<option value="<%=u.getUserId()%>"><%=u.getUserId()%>&nbsp;<%=u.getUserName()%></option>									
						<%
								}
							}
						%>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="distribute()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function distribute(){
						$.ajax({
							type : "POST",
							url : "/cos/distributeArticle",
							data : {
								course_id : cID,
								department : dep,
								subject : sub,
								teacher : document.getElementById("userID").value
							},
							cache : false,
							async : false,
							dataType : "json",
							success : function(msg) {
								//some code
								console.log(msg.data);
								if (msg.condition === "500") {
									window.alert(msg.data);
								} else if (msg.condition === "200") {
									window.alert("分配课程大纲任务成功");
									window.location.replace(msg.data);
								}
							},
							error : function(msg) {
								//some code
								console.log(msg.data);
								window.alert("系统暂时无法提供服务");
							}
						})
					}
				</script>
			</div>
		</div>
	</div>
	
	<div id="SubjectModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请选择专业</h4>
				</div>
				<div class="modal-body text-center">
					<select id="subID">
						<%	
							SubjectMapper subjectMapper = sqlSession.getMapper(SubjectMapper.class);
					 		List<Subject> subjects = subjectMapper.selectAll();
							for(Subject subject:subjects){
								if(subject.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=subject.getSubjectId()%>"><%=subject.getSubjectName()%></option>									
						<%
								}
							}
						%>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="sub_1()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function sub_1(){
						var value = document.getElementById('subID').value;
						console.log(value);
						window.location.href='/cos/showCourse?subId='+value;
					}
				</script>
			</div>
		</div>
	</div>
	
	<div id="ReturnSubjectAllArticle" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请选择专业</h4>
				</div>
				<div class="modal-body text-center">
					<select id="subID_2">
						<%	
							for(Subject subject:subjects){
								if(subject.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=subject.getSubjectId()%>"><%=subject.getSubjectName()%></option>									
						<%
								}
							}
						%>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="sub_2()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function sub_2(){
						var value = document.getElementById('subID_2').value;
						window.location.href='/cos/returnSubjectAllArticle?subId='+value;
					}
				</script>
			</div>
		</div>
	</div>
	
	<div id="ValidArticle" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请选择专业</h4>
				</div>
				<div class="modal-body text-center">
					<select id="subID_3">
						<%	
							for(Subject subject:subjects){
								if(subject.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=subject.getSubjectId()%>"><%=subject.getSubjectName()%></option>									
						<%
								}
							}
						%>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="sub_3()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function sub_3(){
						var value = document.getElementById('subID_3').value;
						window.location.href='/cos/validArticle?subId='+value;
					}
				</script>
			</div>
		</div>
	</div>
	
	<div id="WaitFirstAssessArticle" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请选择专业</h4>
				</div>
				<div class="modal-body text-center">
					<select id="subID_4">
						<%	
							for(Subject subject:subjects){
								if(subject.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=subject.getSubjectId()%>"><%=subject.getSubjectName()%></option>									
						<%
								}
							}
						%>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="sub_4()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function sub_4(){
						var value = document.getElementById('subID_4').value;
						window.location.href='/cos/waitFirstAssessArticle?subId='+value;
					}
				</script>
			</div>
		</div>
	</div>
	
	<div id="WaitDistributionArticle" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请选择专业</h4>
				</div>
				<div class="modal-body text-center">
					<select id="subID_5">
						<%	
							for(Subject subject:subjects){
								if(subject.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=subject.getSubjectId()%>"><%=subject.getSubjectName()%></option>									
						<%
								}
							}
							sqlSession.close();
						%>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="sub_5()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function sub_5(){
						var value = document.getElementById('subID_5').value;
						window.location.href='/cos/waitDistributionArticle?subId='+value;
					}
				</script>
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