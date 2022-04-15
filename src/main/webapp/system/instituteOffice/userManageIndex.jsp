<%@page import="java.util.ArrayList"%>
<%@page import="cos.dao.DepartmentMapper"%>
<%@page import="cos.bean.Department"%>
<%@page import="cos.bean.DepartmentHead"%>
<%@page import="cos.dao.DepartmentHeadMapper"%>
<%@page import="cos.bean.User"%>
<%@page import="cos.dao.UserMapper"%>
<%@page import="cos.bean.Institute"%>
<%@page import="cos.dao.InstituteMapper"%>
<%@page import="cos.bean.Position"%>
<%@page import="java.util.List"%>
<%@page import="cos.dao.PositionMapper"%>
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
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
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
								User loginUser=(User)request.getSession().getAttribute("user");
								SqlSession sqlSession = MybatisUtil.openSqlSession();
								InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
								Institute ins =instituteMapper.selectByPrimaryKey(loginUser.getInstitute());
							%>
							<li class="active"><a href="#"> <span
									class="glyphicon glyphicon-user"><%=ins.getInstituteName()%>院办</span>
							</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a class="btn btn-default" href="./index.jsp">
								<span class="glyphicon glyphicon-home"></span><b>&nbsp;消息主页</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="./userManageIndex.jsp">
									<span class="glyphicon glyphicon-user"></span><b>&nbsp;院内用户管理</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" href="/cos/instituteWorkerOfStatistical">
									<span class="glyphicon glyphicon-user"></span><b>&nbsp;课程大纲工作量统计</b>
								</a>
							</li>
							<li class="dropdown">
					          <a class="btn btn-default" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
					          	<span class="glyphicon glyphicon-file"></span>
					          	<b>课程大纲管理</b>
					          	<span class="caret"></span>
					          </a>
					          <ul class="dropdown-menu">
					            <li><a class="btn btn-default" href="/cos/insArticle" >我的课程大纲</a></li>
					            <li role="separator" class="divider"></li>
					            <li><a href="/cos/insAllArticle" class="btn btn-default">学院中所有课程大纲</a></li>
					            <li><a href="/cos/waitSecondAccessArticle" class="btn btn-default">显示待复审课程大纲</a></li>
					            <li role="separator" class="divider"></li>
					            <li class="text-center"><input id="articleId" type="text" placeholder="请输入课程ID"/>
					            &nbsp;
					            <button onclick="findArticleForCourseIndex()" class="btn btn-default">搜索</button></li>
								<script>
									function findArticleForCourseIndex() {
										var id = window.document.getElementById("articleId").value;
										window.location.href='/cos/findInsArticleForCourseIndex?courseId='+id;
									}
								</script>
					          </ul>
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
							<th colspan="8" class="text-center">
								<button style="width: 360px;" type="button"
									class="btn btn-success" data-toggle="modal"
									data-target="#insertModal">
									<b>点击添加新用户</b>
								</button>
							</th>
						</tr>
						<tr>
							<th class="text-center">用户ID</th>
							<th class="text-center">用户名</th>
							<th class="text-center">联系方式</th>
							<th class="text-center">权限</th>
							<th class="text-center">状态</th>
							<th class="text-center">所属学院</th>
							<th class="text-center">职位</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<%
							UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
							
							List<User> result = userMapper.selectAll();
							List<User> users = new ArrayList<>();
							
							for(User user:result){
								if(user.getInstitute().equals(loginUser.getInstitute())){
									users.add(user);
								}
							}
							
							for (User user : users) {
						%>
						<tr>
							<td><%=user.getUserId()%></td>
							<td><%=user.getUserName()%></td>
							<td><%=user.getCellphone()%></td>
							<td><%=(user.getAuthority() == 1) ? "可编辑" : "仅查看"%></td>
							<td><%=(user.getState() == 1) ? "正常" : "锁定"%></td>
							<%
								Institute institute = instituteMapper.selectByPrimaryKey(user.getInstitute());
							%>
							<td><%=institute.getInstituteName()%></td>
							<%
								PositionMapper positionMapper = sqlSession.getMapper(PositionMapper.class);
								Position position = positionMapper.selectByPrimaryKey(user.getPosition());
								if(user.getPosition().equals(2)){
									DepartmentHeadMapper departmentHeadMapper= sqlSession.getMapper(DepartmentHeadMapper.class);
								 	List<DepartmentHead> departmentHeads = departmentHeadMapper.selectAll();
									for(DepartmentHead departmentHead : departmentHeads){
										if(departmentHead.getDepartmentHeadId().equals(user.getUserId())){
											DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
											Department department=departmentMapper.selectByPrimaryKey(departmentHead.getDepartmentId());
							%>
							<td><%=department.getDepartmentName()+"&nbsp;"+position.getPositionName()%></td>			
							<%	
										}
									}
								}else{
							%>
							<td><%=position.getPositionName()%></td>
							<%
								} 
							%>
							<td>
								<button
									onclick="window.location.href='./userManage.jsp?userId=<%=user.getUserId()%>'"
									style="font-size: 12px;" type="button" class="btn btn-primary">编辑</button>
								<button onclick="giveID('<%=user.getUserId()%>')"
									style="font-size: 12px;" type="button" class="btn btn-danger"
									data-toggle="modal" data-target="#deleteModal">删除</button>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 插入模态框 -->
		<div id="insertModal" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 style="font-weight: 600;" class="modal-title text-center">输入新用户信息</h4>
					</div>

					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td>用户ID</td>
									<td><input id="uid" type="text"></td>
								</tr>
								<tr>
									<td>用户名</td>
									<td><input id="uname" type="text"></td>
								</tr>
								<tr>
									<td>登录密码</td>
									<td><input id="pwd" type="text"></td>
								</tr>
								<tr>
									<td>联系方式</td>
									<td><input id="cell" type="text"></td>
								</tr>
								<tr>
									<td>权限</td>
									<td><select id="aut" style="width: 200px;"
										class="form-control">
											<option value="0">仅查看</option>
											<option value="1">可编辑</option>
									</select></td>
								</tr>
								<tr>
									<td>状态</td>
									<td><select id="sta" style="width: 200px;"
										class="form-control">
											<option value="0">锁定</option>
											<option value="1">正常</option>
									</select></td>
								</tr>
								<tr>
									<td>所在学院</td>
									<td><select id="ins" style="width: 200px;"
										class="form-control">
											<%
												List<Institute> institutes = instituteMapper.selectAllInstitute();
												for (Institute institute : institutes) {
													if(institute.getInstituteId().equals(loginUser.getInstitute())){
											%>
											<option value="<%=institute.getInstituteId().toString()%>">
												<%=institute.getInstituteName()%>
											</option>
											<%
													}
												}
											%>
									</select></td>
								</tr>
								<tr>
									<td>职位</td>
									<td id="p"><select id="pos" onchange="posSelect()" style="width: 200px;"
										class="form-control">
											<%
												PositionMapper positionMapper = sqlSession.getMapper(PositionMapper.class);
												List<Position> positions = positionMapper.selectAllPosition();
												for (Position position : positions) {
											%>
											<option value="<%=position.getPositionId().toString()%>">
												<%=position.getPositionName()%>
											</option>
											<%
												}
											%>
									</select></td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button onclick="insertUser()" type="button"
							class="btn btn-primary">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

		<!-- 删除模态框 -->
		<div id="deleteModal" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 style="font-weight: 600;" class="modal-title text-center">删除用户将删除用户所有信息</h4>
					</div>
					<div class="modal-body text-center">
						<button style="width: 200px" type="button"
							class="btn btn-default text-center" data-dismiss="modal">取消</button>
						<button onclick="deleteUser()" style="width: 200px" type="button"
							class="btn btn-primary text-center">删除</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

	</div>
	<!-- /.container-fluid -->

</body>
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script>
	var id;
	
	function posSelect(){
		var v=window.document.getElementById("pos").value;
		var instituteID=window.document.getElementById("ins").value;
		if(v==='2'){
			$.ajax({
				type : "POST",
				url : "/cos/findAllDepByIns",
				data : {
					instituteId:instituteID
				},
				cache : false,
				async : false,
				dataType : "json",
				success : function(msg) {
					//some code
					if (msg.condition === "500") {
						window.alert(msg.data);
					} else if (msg.condition === "200") {
						let departments = msg.data;
						console.log(departments);
						$('#p').after("<td><select id='department' style='width: 200px;' class='form-control'></select></td>");
						for(let i=0;i<departments.length;i++){
							$('#department').append("<option value="+departments[i].departmentId+">"+departments[i].departmentName+"</option>");
						}
					}
				},
				error : function(msg) {
					//some code
					console.log(msg.data);
					window.alert("系统暂时无法提供服务");
				}
			})
		}else{
			let d = $("#department");
			if(d===null){
				return;
			}else{
				$("#department").remove();
			}
		}
	}

	function giveID(uid){
		console.log(uid);
		id=uid;
	}
	
	function deleteUser() {
		window.location.href="/cos/deleteInsUser?userId="+id;
	}

	function insertUser() {
		var uid = window.document.getElementById("uid").value;
		var uname = window.document.getElementById("uname").value;
		var pwd = window.document.getElementById("pwd").value;		
		var cell = window.document.getElementById("cell").value;		
		var aut = window.document.getElementById("aut").value;		
		var sta = window.document.getElementById("sta").value;		
		var ins = window.document.getElementById("ins").value;		
		var pos = window.document.getElementById("pos").value;
		
		var dep;
		
		if(pos==='2'){
			dep = window.document.getElementById("department").value;
		}
		
		console.log(uid);
		console.log(uname);
		console.log(pwd);
		console.log(cell);
		console.log(aut);
		console.log(sta);
		console.log(ins);
		console.log(pos);
		console.log(dep);
		
		$.ajax({
			type : "POST",
			url : "/cos/addInsUser",
			data : {
				userID:uid,
				username:uname,
				password:pwd,
				cellphone:cell,
				authority:aut,
				condition:sta,
				institute:ins,
				position:pos,
				department:dep
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
					window.alert("添加新用户成功");
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