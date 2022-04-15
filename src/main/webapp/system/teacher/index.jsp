<%@page import="cos.bean.MessageState"%>
<%@page import="cos.bean.MessageType"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="cos.bean.Message"%>
<%@page import="cos.dao.MessageStateMapper"%>
<%@page import="cos.dao.MessageTypeMapper"%>
<%@page import="cos.dao.MessageMapper"%>
<%@page import="cos.dao.UserMapper"%>
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
					          <a href="/cos/teacherArticle" class="btn btn-default">
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
				location.href="/cos/teaShowMessage?id="+id;
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
	

</body>

</html>