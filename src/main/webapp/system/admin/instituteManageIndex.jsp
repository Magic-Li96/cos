<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="cos.dao.InstituteMapper"%>
<%@page import="cos.bean.Institute"%>
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
							<th colspan="2" class="text-center">
								<button style="width: 360px; font-size: 15px" type="button"
									class="btn btn-success" data-toggle="modal"
									data-target="#insertModal">
									<b>点击添加新学院</b>
								</button>
							</th>
						</tr>
						<tr>
							<th style="font-size: 19px" class="text-center">学院名称</th>
							<th style="font-size: 19px" class="text-center">操作</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<%
							SqlSession sqlSession = MybatisUtil.openSqlSession();
							
							int page_quantity = (Integer)request.getSession().getAttribute("page_quantity");
							int current_page = (Integer)request.getSession().getAttribute("current_page");
							List<Institute> institutes = (List<Institute>)request.getSession().getAttribute("institutes");
							
							for (Institute institute : institutes) {
						%>
						<tr>
							<td><font style="font-size: 15px;"><%=institute.getInstituteName()%></font></td>
							<td>
								<button
									onclick="goInsID(<%=institute.getInstituteId().toString()%>)"
									data-toggle="modal" data-target="#updateModal"
									style="font-size: 15px;" type="button" class="btn btn-primary">学院更名</button>
								<button
									onclick="window.location.href='./departmentManageIndex.jsp?insId=<%=institute.getInstituteId()%>'"
									style="font-size: 15px;" type="button" class="btn btn-success">学院系及专业管理</button>
								<button 
									onclick="goInsID(<%=institute.getInstituteId().toString()%>)"
									style="font-size: 15px;" type="button"
									class="btn btn-danger" data-toggle="modal"
									data-target="#deleteModal">删除学院</button>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
					<tfoot>
						<tr class="text-center">
							<td colspan="3">
								<nav>
								  <ul class="pagination">
								    <li><a href="/cos/showInstitute?current_page=<%=current_page%>&page_index=prior">&laquo;</a></li>
								    <% 
								    	for(int i=0;i < page_quantity;i++){
								    %>
								    <li><a href="/cos/showInstitute?current_page=<%=current_page%>&page_index=<%=i%>"><%=i+1%></a></li>
								    <%
								    	}
								    %>
								    <li><a href="/cos/showInstitute?current_page=<%=current_page%>&page_index=next">&raquo;</a></li>
								  </ul>
								</nav>
							</td>
						</tr>
					</tfoot>
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
						<h4 style="font-weight: 600;" class="modal-title text-center">输入新学院名称</h4>
					</div>

					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td>学院名</td>
									<td><input id="instituteName" type="text"></td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button onclick="insertInstitute()" type="button"
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
						<h4 style="font-weight: 600;" class="modal-title text-center">输入新名称</h4>
					</div>

					<div class="modal-body">
						<table class="table">
							<tbody>
								<tr>
									<td>学院新名称</td>
									<td><input id="newInstituteName" type="text"></td>
								</tr>
							</tbody>
						</table>
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


		<!-- 删除模态框 -->
		<div id="deleteModal" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 style="font-weight: 600;" class="modal-title text-center">删除院信息</h4>
					</div>
					<div class="modal-body text-center">
						<button style="width: 200px" type="button"
							class="btn btn-default text-center" data-dismiss="modal">取消</button>
						<button onclick="delIns()" style="width: 200px" type="button"
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
								institutes = instituteMapper.selectAllInstitute();
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
	</div>
	<!-- /.container-fluid -->

</body>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script>
	function insertInstitute() {
		var instituteName = window.document.getElementById("instituteName").value;
		if(instituteName===''){
			window.alert("新院名不可为空");
		}
		$.ajax({
			type : "POST",
			url : "/cos/addInstitute",
			data : {
				insName : instituteName,
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
					window.alert("添加新学院成功");
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
	
	var insId;
	
	function goInsID(id){
		insId=id;
		console.log(insId);
	}
	
	function update() {
		var newInstituteName = window.document.getElementById("newInstituteName").value;
		if(newInstituteName===''){
			window.alert("请输入学院名");
		}
		$.ajax({
			type : "POST",
			url : "/cos/updateInstitute",
			data : {
				insID : insId,
				newName : newInstituteName
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
					window.alert("修改学院名称成功");
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
	
	function delIns(){
		window.location.href="/cos/deleteInstitute?insID="+insId;
	}
	
	function toDepartmentManageIndex() {
		var insID = window.document.getElementById("insID").value;
		window.location.href = "/cos/system/admin/departmentManageIndex.jsp?insId=" + insID;
	}
</script>
</html>