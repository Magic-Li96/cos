<%@page import="cos.bean.Course"%>
<%@page import="cos.dao.CourseMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cos.bean.Article"%>
<%@page import="cos.dao.ArticleMapper"%>
<%@page import="cos.bean.Institute"%>
<%@page import="cos.dao.InstituteMapper"%>
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

<!--echart-->
<script src="../lib/echarts.js"></script>

</head>

<body style="background-color: rgb(220, 218, 245);">
	<div  style="background-color: white;" class="container">
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
								InstituteMapper instituteMapper=sqlSession.getMapper(InstituteMapper.class);
								Institute institute = instituteMapper.selectByPrimaryKey(user.getInstitute());
							%>
							<li class="active"><a href="#"> <span
									class="glyphicon glyphicon-user"></span><%=institute.getInstituteName()%>
							</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a class="btn btn-default" href="./index.jsp">
								<span class="glyphicon glyphicon-home"></span><b>&nbsp;主页</b>
								</a>
							</li>
							<li class="dropdown">
					          <a class="btn btn-default" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
					          	<span class="glyphicon glyphicon-file"></span>
					          	<b>课程大纲管理</b>
					          	<span class="caret"></span>
					          </a>
					          <ul class="dropdown-menu">
					            <li><a href="/cos/insAllArticleForLeader" class="btn btn-default">学院中所有课程大纲</a></li>
					            <li><a href="/cos/waitFinallAccessArticle" class="btn btn-default">显示待终审课程大纲</a></li>
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
							<li><a class="btn btn-default" href="/cos/loginOut"><span class="glyphicon glyphicon-off"></span><b>&nbsp;退出系统</b></a></li>
						</ul>
					</div>
					<!-- /.navbar-collapse -->
				</nav>
			</div>
		</div>
		
		<div class="row">
			
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div id="pie" style="width: 500px;height:333px;"></div>
			</div>
			
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div id="bar" style="width: 500px;height:333px;"></div>
			</div>

			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div  id="line" style="width: 1090px;height:333px;"></div>
			</div>
			
		</div>
		<script type="text/javascript">
			
			<%
				//课程类型统计字段
				int professional_education=0;
				int liberal_education=0;
				int subject_basis=0;
				CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
				List<Course> courses = courseMapper.selectAll();
				for(Course course : courses){
					if(course.getInstitute().equals(institute.getInstituteId())){
						switch(course.getCourseType()){
							case 1:liberal_education++;break;
							case 2:subject_basis++;break;
							case 3:professional_education++;break;
						}
					}
				}
				
				//课程大纲状态统计字段
				int c_1=0;
				int c_2=0;
				int c_3=0;
				int c_4=0;
				int c_5=0;
				int c_6=0;
				ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
				List<Article> articles = articleMapper.selectAll();
				for(Article article : articles){
					if(article.getInstitute().equals(institute.getInstituteId())){
						switch(article.getContidion()){
							case 1:c_1++;break;
							case 2:c_2++;break;
							case 3:c_3++;break;
							case 4:c_4++;break;
							case 5:c_5++;break;
							case 6:c_6++;break;
						}
					}
				}
				
				//各专业每学期课程大纲统计字段
				class Sub{
					int sub_id;
					String sub_name;
					//课程大纲状态统计字段
					int c_1=0;
					int c_2=0;
					int c_3=0;
					int c_4=0;
					int c_5=0;
					int c_6=0;
					int c_7=0;
					int c_8=0;
					public String toString(){
						return sub_id+" "+sub_name+" "+
							+c_1+" "+c_2+" "+c_3+" "+c_4+" "+c_5+" "+c_6+" "+c_7+" "+c_8+" ";
					}
				}
				ArrayList<Sub> subs=new ArrayList<>();
				SubjectMapper subjectMapper = sqlSession.getMapper(SubjectMapper.class);
				List<Subject> subjects = subjectMapper.selectAll();
				DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
				List<Department> departments = departmentMapper.selectAll();
				for(Department department:departments){
					if(department.getInstitute().equals(institute.getInstituteId())){
						for(Subject subject: subjects){
							if(subject.getDepartmentId().equals(department.getDepartmentId())){
								Sub sub =new Sub();
								sub.sub_id=subject.getSubjectId();
								sub.sub_name=subject.getSubjectName();
								subs.add(sub);
							}
						}
					}
				}
				for(Course course:courses){
					if(course.getInstitute().equals(institute.getInstituteId())){
						for(Sub sub: subs){
							if(course.getSubject().equals(sub.sub_id)){
								switch (course.getPriority()){
									case 1:sub.c_1++;break;
									case 2:sub.c_2++;break;
									case 3:sub.c_3++;break;
									case 4:sub.c_4++;break;
									case 5:sub.c_5++;break;
									case 6:sub.c_6++;break;
									case 7:sub.c_7++;break;
									case 8:sub.c_8++;break;
								}
							}
						}
					}
				}
			%>
		
			function pieInit() {
				// 基于准备好的dom，初始化echarts实例
				var myChart = echarts.init(document.getElementById('pie'));
				// 指定图表的配置项和数据
				var option = {
					title: {
						text: '学院中各类型课程大纲统计',
						subtext: '计算机与人工智能学院',
						left: 'center'
					},
					toolbox: {
						feature: {
						saveAsImage: {}
						}
					},
					tooltip: {
						trigger: 'item'
					},
					legend: {
						orient: 'vertical',
						left: 'left',
					},
					series: [
					{
						name: 'Access From',
						type: 'pie',
						radius: '50%',
						data: [
							{ value: <%=liberal_education%>,name: '通识教育' },
							{ value: <%=subject_basis%>, name: '学科基础' },
							{ value: <%=professional_education%>, name: '专业教育' },
						],
						emphasis: {
							itemStyle: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						},
					}
					]
				};
	       	 	// 使用刚指定的配置项和数据显示图表。
	        	myChart.setOption(option);
			}
			
			function barInit(params) {
				var chartDom = document.getElementById('bar');
				var myChart = echarts.init(chartDom);
				var option;

				option = {
				title: {
					text: '学院中各状态课程大纲统计',
					subtext: '计算机与人工智能学院',
					left: 'center'
				},
				toolbox: {
					feature: {
					saveAsImage: {}
					}
				},
				xAxis: {
					type: 'category',
					data: ['未分配', '未编写', '待初审', '待复审', '待终审', '生效中'],
					axisLabel: {
					show: true,
					textStyle: {
						color: '#000000', //更改坐标轴文字颜色
						fontSize: 14 //更改坐标轴文字大小
					}
					},
					axisLine: {
					lineStyle: {
						color: '#000000' //更改坐标轴颜色
					}
					}
				},
				yAxis: {
					type: 'value'
				},
				series: [
					{
					data: [<%=c_1%>, <%=c_2%>, <%=c_3%>, <%=c_4%>, <%=c_5%>,<%=c_6%>],
					type: 'bar'
					}
				]
				};
				myChart.setOption(option);
			}
			
			function lineInit() {
				var chartDom = document.getElementById('line');
				var myChart = echarts.init(chartDom);
				var option = {
				title: {
					text: '各专业每学期课程大纲总量统计'
				},
				tooltip: {
					trigger: 'axis',
					axisPointer: {
					type: 'cross',
					label: {
						backgroundColor: '#6a7985'
					}
					}
				},
				legend: {
					data: [
						<%
							for(Sub sub:subs){
						%>
							'<%=sub.sub_name%>',
						<%
							}
						%>
						]
				},
				toolbox: {
					feature: {
					saveAsImage: {}
					}
				},
				grid: {
					left: '3%',
					right: '4%',
					bottom: '3%',
					containLabel: true
				},
				xAxis: [
					{
					type: 'category',
					boundaryGap: false,
					data: ['第一学期', '第二学期', '第三学期', '第四学期', '第五学期', '第六学期','第七学期','第八学期']
					}
				],
				yAxis: [
					{
					type: 'value'
					}
				],
				series: [
					<%
						for(Sub sub:subs){
					%>
						{
							name: '<%=sub.sub_name%>',
							type: 'line',
							stack: 'Total',
							areaStyle: {},
							emphasis: {
								focus: 'series'
							},
							data: [<%=sub.c_1%>, <%=sub.c_2%>, <%=sub.c_3%>, <%=sub.c_4%>, <%=sub.c_5%>, <%=sub.c_6%>, <%=sub.c_7%>,<%=sub.c_8%>]
						},
					<%		
						}
					%>
				]
				};
				myChart.setOption(option);
			}

			window.onload=function(){
				pieInit();
				barInit();
				lineInit();
			}


			
    	</script>
		
		
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