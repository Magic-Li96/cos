<%@page import="java.util.ArrayList"%>
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
							<% 
								SubjectMapper subjectMapper = sqlSession.getMapper(SubjectMapper.class);
								Subject subject = subjectMapper.selectByPrimaryKey(Integer.parseInt(request.getParameter("subId")));
							%>
							<th style="font-size: 21px;font-family: STKaiti;" colspan="8" class="text-center">专业：<%=subject.getSubjectId()%>-<%=subject.getSubjectName()%></th>
						</tr>
						<tr>
							<th colspan="8" class="text-center">
								<button data-toggle="modal" data-target="#insertModal" 
								style="font-size: 15px;width: 300px" class="btn btn-success">
									<b>添加新课程</b>
								</button>
								<button data-toggle="modal" data-target="#BatchInsertModal" 
								style="font-size: 15px;width: 360px" class="btn btn-success">
									<b>批量导入课程信息(人才培养方案导入)</b>
								</button>
								<button onclick="delAllCourse()" style="font-size: 15px;width: 360px" class="btn btn-success">
									<b>删除该专业所有课程信息</b>
								</button>
							</th>
						</tr>
						<tr>
							<th class="text-center">课程编号</th>
							<th class="text-center">课程名</th>
							<th class="text-center">开课学院</th>
							<th class="text-center">优先级</th>
							<th class="text-center">所占学分</th>
							<th class="text-center">课时</th>
							<th class="text-center">课程类型</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<% 
							int page_quantity = (Integer)request.getSession().getAttribute("page_quantity");
							int current_page = (Integer)request.getSession().getAttribute("current_page");	
						
							ArrayList<Course> courses =(ArrayList<Course>)session.getAttribute("result");
							//CourseUtil.sortCourse(courses);//优先级排序
							for(Course course:courses){
						%>
						<tr>
							<td><%=course.getCourseId()%></td>
							<td><%=course.getCourseName()%></td>
							<% 
								InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
								Institute institute = instituteMapper.selectByPrimaryKey(course.getStartInstitute());
							%>
							<td><%=institute.getInstituteName()%></td>
							<td><%=course.getPriority()%></td>
							<td><%=course.getCredit()%></td>
							<td><%=course.getAllClassHours()%></td>
							<%
								CourseTypeMapper courseTypeMapper = sqlSession.getMapper(CourseTypeMapper.class);
								CourseType courseType = courseTypeMapper.selectByPrimaryKey(course.getCourseType());
							%>
							<td><%=courseType.getCourseTypeName()%></td>
							<td>
								<button onclick="updateCourse(<%=course.getCourseId()%>,<%=course.getDepartment()%>,<%=course.getSubject()%>)" style="font-size: 12px" class="btn btn-primary">编辑</button>
								<button onclick="deleteCourse(<%=course.getCourseId()%>,<%=course.getDepartment()%>,<%=course.getSubject()%>)" style="font-size: 12px" class="btn btn-danger">删除</button>
							</td>
						</tr>
						<% 
							}
						%>
					</tbody>
					<tfoot>
						<tr class="text-center">
							<td colspan="8">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/showCourse?current_page=<%=current_page%>&page_index=prior&subId=<%=subject.getSubjectId()%>">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/showCourse?current_page=<%=current_page%>&page_index=<%=i%>&subId=<%=subject.getSubjectId()%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/showCourse?current_page=<%=current_page%>&page_index=next&subId=<%=subject.getSubjectId()%>">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
	<div id="insertModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">添加新课程</h4>
				</div>
				<div class="modal-body">
					<table class="table">
						<tbody>
							<tr>
								<td>课程编号：</td>
								<td><input id="courseId" type="text"></td>
							</tr>
							<tr>
								<td>课程名：</td>
								<td><input id="courseName" type="text"></td>
							</tr>
							<tr>
								<td>开课学院：</td>
								<td>
									<select id="startInstitute">
										<%
											InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
												List<Institute> institutes = instituteMapper.selectAllInstitute();
											for(Institute institute:institutes){
										%>
											<option value="<%=institute.getInstituteId()%>"><%=institute.getInstituteName()%></option>
										<%
											} 
										%>
									</select>
								</td>
							</tr>
							<tr>
								<td>优先级：</td>
								<td>
									<select id="priority">
										<option value="1">1</option>									
										<option value="2">2</option>									
										<option value="3">3</option>									
										<option value="4">4</option>									
										<option value="5">5</option>									
										<option value="6">6</option>									
										<option value="7">7</option>									
										<option value="8">8</option>									
										<option value="9">9</option>									
										<option value="10">10</option>									
										<option value="11">11</option>									
									</select>
								</td>
							</tr>
							<tr>
								<td>总学时：</td>
								<td><input id="allClassHours" type="text"></td>
							</tr>
							<tr>
								<td>学分：</td>
								<td><input id="credit" type="text"></td>
							</tr>
							<tr>
								<td>课程类型：</td>
								<td>
									<select id="courseType">
										<% 
											CourseTypeMapper courseTypeMapper = sqlSession.getMapper(CourseTypeMapper.class);
											List<CourseType> courseTypes = courseTypeMapper.selectAll();
											for(CourseType courseType : courseTypes){
										%>
										<option value="<%=courseType.getCourseTypeId()%>"><%=courseType.getCourseTypeName()%></option>				
										<% 
											}
										%>					
									</select>
								</td>
							</tr>
							
						</tbody>											
						
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					<button onclick="courseInsert()"
						type="button" class="btn btn-primary">确定</button>
				</div>
				<script type="text/javascript">
					function courseInsert(){
						var course_id = document.getElementById('courseId').value;
						var department = '<%=department.getDepartmentId()%>';
						var subject = '<%=request.getParameter("subId")%>';
						var courseName = document.getElementById('courseName').value;
						var institute = '<%=user.getInstitute()%>';
						var startInstitute = document.getElementById('startInstitute').value;
						var priority = document.getElementById('priority').value;
						var allClassHours = document.getElementById('allClassHours').value;
						var credit = document.getElementById('credit').value;						
						var courseType = document.getElementById('courseType').value;
						
						if(course_id===""||courseName===""||courseName===""||credit===""){
							window.alert("请填写完整信息");
							return;
						}
						
						console.log(course_id);
						console.log(department);
						console.log(subject);
						console.log(courseName);
						console.log(institute);
						console.log(startInstitute);
						console.log(priority);
						console.log(allClassHours);
						console.log(credit);
						console.log(courseType);
						
						$.ajax({
							type : "POST",
							url : "/cos/insertCourse",
							data : {
								course_id : course_id,
								department : department,
								subject : subject,
								courseName : courseName,
								institute : institute,
								startInstitute : startInstitute,
								priority : priority,
								allClassHours : allClassHours,
								credit : credit,
								courseType : courseType
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
									window.alert("添加课程成功");
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
	
	<div id="BatchInsertModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 style="font-weight: 600;" class="modal-title text-center">请上传当前专业的人才培养方案</h4>
				</div>
				<form id="form" action="/cos/courseMessageBatchInsertModel" method="post" enctype="multipart/form-data">
					<div class="modal-body">
						选择一个文件:<input id="file" type="file" name="file"/>
						文件名：专业编号+专业名&nbsp;
						<a href="../img/example.png">文件形式示例</a>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
						<button onclick="uploadFile()" type="button" class="btn btn-primary">确定</button>
					</div>
				</form>
				<script type="text/javascript">
					function uploadFile() {
						
						var file = document.getElementById("file").value;
					
						if(file === ""){
							window.alert("请选择文件");
							return;
						}else{
							var strs = file.split('\\');							
							var subject_ID = strs[strs.length-1].split('-')[0];
							if(subject_ID == <%=request.getParameter("subId")%>){
								document.getElementById("form").submit();
								window.alert("人才培养方案上传成功");
							}else{
								window.alert("请选择当前专业的人才培养方案");
							}
						}
						
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
					 		List<Subject> subjects = subjectMapper.selectAll();
							for(Subject sub:subjects){
								if(sub.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=sub.getSubjectId()%>"><%=sub.getSubjectName()%></option>									
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
							for(Subject sub:subjects){
								if(sub.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=sub.getSubjectId()%>"><%=sub.getSubjectName()%></option>									
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
							for(Subject sub:subjects){
								if(sub.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=sub.getSubjectId()%>"><%=sub.getSubjectName()%></option>									
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
							for(Subject sub:subjects){
								if(sub.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=sub.getSubjectId()%>"><%=sub.getSubjectName()%></option>									
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
							for(Subject sub:subjects){
								if(sub.getDepartmentId().equals(department.getDepartmentId())){
						%>
							<option value="<%=sub.getSubjectId()%>"><%=sub.getSubjectName()%></option>									
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


</body>
<script type="text/javascript">
	function updateCourse(c,d,s){
		window.location.href="./courseUpdate.jsp?courseId="+c+"&department="+d+"&subject="+s;
	}
</script>
<script type="text/javascript">
	function delAllCourse() {
		window.alert("清除课程信息成功");
		window.location.href="/cos/deleteAllCourse?subId="+<%=subject.getSubjectId()%>;
	}
</script>
<script type="text/javascript">
	function deleteCourse(c,d,s) {
		$.ajax({
			type : "POST",
			url : "/cos/deleteCourse",
			data : {
				courseId : c+"",
				department :d+"",
				subject :s+""
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
					window.alert("删除课程信息成功");
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
</html>