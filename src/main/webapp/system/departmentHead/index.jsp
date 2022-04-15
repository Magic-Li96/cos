<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="cos.bean.MessageState"%>
<%@page import="cos.dao.MessageStateMapper"%>
<%@page import="cos.bean.MessageType"%>
<%@page import="cos.dao.MessageTypeMapper"%>
<%@page import="cos.bean.Message"%>
<%@page import="cos.dao.MessageMapper"%>
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

<body style="background-color: #8798fa;">
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
				<div id="myCarousel" class="carousel slide">
				    <!-- 轮播（Carousel）项目 -->
				    <div class="carousel-inner">
				        <div class="item active">
				            <img src="../img/1.jpg" alt="First slide">
				        </div>
				        <div class="item">
				            <img src="../img/2.jpg" alt="Second slide">
				        </div>
				        <div class="item">
				            <img src="../img/3.jpg" alt="Third slide">
				        </div>
				    </div>
				    <!-- 轮播（Carousel）导航 -->
				    <a class="carousel-control left" href="#myCarousel" 
				       data-slide="prev"> <span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span></a>
				    <a class="carousel-control right" href="#myCarousel" 
				       data-slide="next"><span aria-hidden="true" class="glyphicon glyphicon-chevron-left"></span></a>
				</div>
				<script type="text/javascript">
					$('#myCarousel').carousel({
	    				interval: 3000
					})
				</script>	
			</div>
		</div>
		
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<ul class="list-group">
					<% 
						MessageMapper messageMapper =sqlSession.getMapper(MessageMapper.class);
						MessageTypeMapper messageTypeMapper =sqlSession.getMapper(MessageTypeMapper.class);
					    MessageStateMapper messageStateMapper = sqlSession.getMapper(MessageStateMapper.class);
						
						List<Message> messages =messageMapper.selectAll();
						//按住键排序（按时间排序）
						Collections.sort(messages,new Comparator<Message>(){
								@Override
								public int compare(Message o1, Message o2) {
									return o2.getMessageId()-o1.getMessageId();
								}
						});
						for(Message message : messages){
							if(message.getReceiveUser().equals(user.getUserId())){
								MessageType messageType = messageTypeMapper.selectByPrimaryKey(message.getMessageType());
								MessageState messageState = messageStateMapper.selectByPrimaryKey(message.getMessageState());					
					%>
					<li class="list-group-item">
						<button onclick="showMessage('<%=message.getMessage()%>',<%=message.getMessageId()%>)" class="btn btn-default">
						<%=messageType.getMessageTypeName()%>
						</button>
						<%=message.getTime()%>
						<%=messageState.getMessageState()%>
						<a style="cursor:pointer" onclick="deleteMessage('<%=message.getMessageId()%>')">删除</a>
					</li>
					<%
							}
						}
					%>
				</ul>
			</div>
		</div>
		<script type="text/javascript">
			function showMessage(message,id) {
				window.alert(message);
				location.href="/cos/showMessage?id="+id;
			}
			function deleteMessage(msg_id){
				var url = window.location.href;
				$.ajax({
					type : "POST",
					url : "/cos/messageDelete",
					data : {
						msg_id : msg_id
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
							console.log(msg.data);
							window.alert("删除消息成功");
							window.location.replace(url);
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
	<!-- /.container-fluid -->


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


</body>

</html>