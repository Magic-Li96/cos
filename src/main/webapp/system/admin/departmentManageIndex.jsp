<%@page import="cos.bean.Institute"%>
<%@page import="cos.dao.InstituteMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cos.bean.Subject"%>
<%@page import="cos.dao.SubjectMapper"%>
<%@page import="cos.bean.Department"%>
<%@page import="java.util.List"%>
<%@page import="cos.dao.DepartmentMapper"%>
<%@page import="cos.util.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
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
							<th colspan="4" class="text-center">
								<button style="width: 360px; font-size: 15px" type="button"
									class="btn btn-success" data-toggle="modal"
									data-target="#insertModal">
									<b>点击在学院中添加一个新系</b>
								</button>
							</th>
						</tr>
						<tr>
							<th style="font-size: 19px" class="text-center">系名称</th>
							<th style="font-size: 19px" class="text-center">操作</th>
							<th style="font-size: 19px" class="text-center">专业</th>
							<th style="font-size: 19px" class="text-center">操作</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<%
							String insId = request.getParameter("insId");
							SqlSession sqlSession=MybatisUtil.openSqlSession();							
							
							DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
							List<Department> departments = departmentMapper.selectAll();
							
							SubjectMapper subjectMapper = sqlSession.getMapper(SubjectMapper.class);
							List<Subject> subjects = subjectMapper.selectAll();
							
							for (Department department : departments) {
								if(department.getInstitute().equals(Integer.parseInt(insId))){
									
						%>
						<tr>
							<td><font style="font-size: 15px;"><%=department.getDepartmentName()%></font></td>
							<td>
								<button
									onclick="goDepID(<%=department.getDepartmentId()%>)"
									data-toggle="modal" data-target="#updateModal"
									style="font-size: 15px;" type="button" class="btn btn-primary">更改系名称</button>
								<button
									onclick="goDepID(<%=department.getDepartmentId()%>)"
									data-toggle="modal" data-target="#insertSModal"
									style="font-size: 15px;" type="button" class="btn btn-primary">添加新专业</button>
								<button
									onclick="goDepID(<%=department.getDepartmentId()%>)"
									style="font-size: 15px; width: 110px" type="button"
									class="btn btn-danger" data-toggle="modal"
									data-target="#deleteModal">删除系</button>
							</td>
							<td>
								<% 
									for(Subject subject:subjects){
										if(subject.getDepartmentId().equals(department.getDepartmentId())){
								%>
								<%=subject.getSubjectName()%>(<%=subject.getSubjectId()%>)<br><br>
								<%
										}
									} 
								%>
							</td>
							<td>
								<%
									for(Subject subject:subjects){
										if(subject.getDepartmentId().equals(department.getDepartmentId())){
								%>
									<a	href="#"
										onclick="updateSubName(<%=subject.getSubjectId()%>,<%=department.getDepartmentId()%>)" 
										style="font-size: 15px;"><b>修改专业名</b></a>
									|
									<a	href="#"
										onclick="updateSubId('<%=subject.getSubjectName()%>',<%=department.getDepartmentId()%>)" 
										style="font-size: 15px;color: green;"><b>修改专业ID</b></a>
									|
									<a 	href="#"
										onclick="delSub(<%=subject.getSubjectId()%>)" 
										style="font-size: 15px;color: red;"><b>删除专业</b></a>
									<br><br>
								<%
										}
									}
								%>								
							</td>
						</tr>
						<%		}
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
						<h4 style="font-weight: 600;" class="modal-title text-center">输入新系名称</h4>
					</div>

					<div class="modal-body text-center">
						系名：<input id="departmentName" type="text">
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button onclick="insertDepartment()" type="button"
							class="btn btn-primary">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

		<!-- 更改院名模态框 -->
		<div id="updateModal" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 style="font-weight: 600;" class="modal-title text-center">输入系名称</h4>
					</div>

					<div class="modal-body text-center">
						新系名：<input id="newDepartmentName" type="text">
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button onclick="update()" type="button" class="btn btn-primary">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>

		<!-- /.modal -->
		<!-- 添加新专业模态框 -->
		<div id="insertSModal" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 style="font-weight: 600;" class="modal-title text-center">输入新专业信息</h4>
					</div>

					<div class="modal-body text-center">
						专业ID：<input id="subjectId" type="text">
						<hr/>
						专业名：<input id="subjectName" type="text">
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button onclick="insertS()" type="button" class="btn btn-primary">提交</button>
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
						<h4 style="font-weight: 600;" class="modal-title text-center">删除系信息</h4>
					</div>
					<div class="modal-body text-center">
						<button style="width: 200px" type="button"
							class="btn btn-default text-center" data-dismiss="modal">取消</button>
						<button onclick="delDep()" style="width: 200px" type="button"
							class="btn btn-primary text-center">删除</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	
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
								sqlSession.close();
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
	
	</div><!-- /.container-fluid -->

</body>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script>
	var depId;
	
	function goDepID(id){
		depId=id;
		console.log(depId);
	}
	
	function insertDepartment() {
		var departmentName = window.document.getElementById("departmentName").value;
		if(departmentName===''){
			window.alert("新系名不可为空");
			return;
		}
		$.ajax({
			type : "POST",
			url : "/cos/addDepartment",
			data : {
				departmentName : departmentName,
				instituteId:<%=request.getParameter("insId")%>
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
					window.alert("添加新系成功");
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
	
	function insertS() {
		var subjectName = window.document.getElementById("subjectName").value;
		var subjectId = window.document.getElementById("subjectId").value;
		if(subjectName===''||subjectId===''){
			window.alert("新专业名与专业编号不可为空");
		}
		$.ajax({
			type : "POST",
			url : "/cos/addSubject",
			data : {
				subjectName : subjectName,
				subjectId : subjectId,
				departmentId : depId,
				instituteId:<%=request.getParameter("insId")%>
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
					window.alert("添加新专业成功");
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
	
	
	function update() {
		var newDepartmentName = window.document.getElementById("newDepartmentName").value;
		if(newDepartmentName===''){
			window.alert("请输入系名");
			return;
		}
		$.ajax({
			type : "POST",
			url : "/cos/updateDepartment",
			data : {
				departmentId : depId,
				newDepartmentName : newDepartmentName,
				instituteId : <%=request.getParameter("insId")%>
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
					window.alert("修改系名称成功");
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
	
	function updateSubName(subId,dId){
		var name=prompt("请输入新的专业名");	
		if(name===null){
			return;
		}else if(name===""){
			window.alert("请输入专业名！");
			return;
		}
		window.location.href="/cos/updateSubject?subjectId="+subId
				+"&instituteId="+<%=request.getParameter("insId")%>
				+"&departmentId="+dId
				+"&subjectName="+name;
	}
	
	function updateSubId(subName,dId){
		var sid=prompt("请输入新的专业编号");	
		if(sid===null){
			return;
		}else if(sid===""){
			window.alert("请输入专业编号！");
			return;
		}
		
		$.ajax({
			type : "POST",
			url : "/cos/updateSubjectByName",
			data : {
				departmentId : dId,
				subjectName:subName,
				subjectId : sid,
				instituteId : <%=request.getParameter("insId")%>
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
					window.alert("修改专业ID成功");
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
	
	function delDep(){
		window.location.href="/cos/deleteDepartment?departmentId="+depId+"&instituteId="+<%=request.getParameter("insId")%>;
	}
	
	function delSub(subId){
		var con = window.confirm("删除专业信息？");		
		if(con===true){
			window.location.href="/cos/deleteSubject?subjectId="+subId+"&instituteId="+<%=request.getParameter("insId")%>;
		}else{
			return;
		}
	}
	
	function toDepartmentManageIndex() {
		var insID = window.document.getElementById("insID").value;
		window.location.href = "/cos/system/admin/departmentManageIndex.jsp?insId=" + insID;
	}
</script>
</html>