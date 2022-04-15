<%@page import="cos.bean.Institute"%>
<%@page import="cos.dao.InstituteMapper"%>
<%@page import="cos.bean.User"%>
<%@page import="cos.dao.UserMapper"%>
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

td {
	width: 100px;
	height: 50px;
	font-weight: 600;
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
				<div class="panel panel-default">
					<div class="panel-heading text-center">
						<h3 class="panel-title">
							<b>修改用户信息</b>
						</h3>
					</div>
					<div class="panel-body">
						<table class="table">
							<%
								String userId = request.getParameter("userId");
								SqlSession sqlSession = MybatisUtil.openSqlSession();
								UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
								User user = userMapper.selectByPrimaryKey(userId);
							%>
							<tbody class="text-center">
								<tr>
									<td>用户ID</td>
									<td><input id="uid" type="text"
										value="<%=user.getUserId()%>"></td>
								</tr>
								<tr>
									<td>用户名</td>
									<td><input id="uname" type="text"
										value="<%=user.getUserName()%>"></td>
								</tr>
								<tr>
									<td>密码</td>
									<td><input id="pwd" type="text"
										value="<%=user.getPassword()%>"></td>
								</tr>
								<tr>
									<td>联系方式</td>
									<td><input id=cell type="text"
										value="<%=user.getCellphone()%>"></td>
								</tr>

								<tr>
									<td>所在学院</td>
									<td><b> <select id="ins" class="form-control">
												<%
													InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
													List<Institute> institutes = instituteMapper.selectAllInstitute();
													for (Institute institute : institutes) {
														if (institute.getInstituteId().equals(user.getInstitute())) {
												%>
												<option selected="selected"
													value="<%=institute.getInstituteId().toString()%>">
													<%=institute.getInstituteName()%>
												</option>
												<%
														} else {
												%>
												<option value="<%=institute.getInstituteId().toString()%>">
													<%=institute.getInstituteName()%>
												</option>
												<%
														}
													}
												%>
										</select>

									</b></td>
								</tr>
								<tr id="p">
									<td>职位</td>
									<td><b> <select onchange="posSelect()" id="pos" class="form-control">
												<%
													PositionMapper positionMapper = sqlSession.getMapper(PositionMapper.class);
													List<Position> positions = positionMapper.selectAllPosition();
													for (Position position : positions) {
														if (position.getPositionId().equals(user.getPosition())) {
												%>
												<option selected="selected"
													value="<%=position.getPositionId()%>">
													<%=position.getPositionName()%>
												</option>

												<%
													} else {
												%>
												<option value="<%=position.getPositionId()%>">
													<%=position.getPositionName()%>
												</option>
												<%
													}
													}
													sqlSession.close();
												%>
										</select>
									</b></td>
								</tr>
								<tr>
									<td>状态</td>
									<td><b> <select id="sta" class="form-control">
												<%
													int value = user.getPosition();
													if (value == 1) {
												%>
												<option selected="selected" value="1">正常</option>
												<option value="0">锁定</option>
												<%
													} else {
												%>
												<option value="1">正常</option>
												<option selected="selected" value="0">锁定</option>
												<%
													}
												%>
										</select>
									</b></td>
								</tr>
								<tr>
									<td>权限</td>
									<td><b> <select id="aut" class="form-control">
												<% 
													int valueAut = user.getAuthority();
													if(valueAut==1){
												%>
												<option selected="selected" value="1">可编辑</option>
												<option value="0">仅查看</option>
												<%
													}else{
												%>
												<option value="1">可编辑</option>
												<option selected="selected" value="0">仅查看</option>
												<% 
													}
												%>
										</select>
									</b></td>
								</tr>
								<tr>
									<td>
										<button onclick="window.location.href='./userManageIndex.jsp'"
											type="button" class="btn btn-primary">返回</button>
									</td>
									<td>
										<button onclick="update()" type="button"
											class="btn btn-success">提交修改信息</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
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
						<button onclick="toDepartmentManageIndex()" type="button"
							class="btn btn-primary">确定</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->

</body>
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
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
						$('#p').after("<tr id='d'><td>请选择教学系</td><td><select id='department' style='width: 200px;' class='form-control'></select></td></tr>");
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
			let d = $("#d");
			if(d===null){
				return;
			}else{
				$("#d").remove();
			}
		}
	}

	function update() {
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
			url : "/cos/updateUser",
			data : {
				userID : uid,
				username : uname,
				password : pwd,
				cellphone : cell,
				authority : aut,
				condition : sta,
				institute : ins,
				position : pos,
				department : dep
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
					window.alert("修改用户信息成功");
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

	function toDepartmentManageIndex() {
		var insID = window.document.getElementById("insID").value;
		window.location.href = "/cos/system/admin/departmentManageIndex.jsp?insId="
				+ insID;
	}
</script>
</html>