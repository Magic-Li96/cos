<%@page import="java.util.ArrayList"%>
<%@page import="cos.bean.Article"%>
<%@page import="cos.dao.ArticleMapper"%>
<%@page import="cos.bean.Course"%>
<%@page import="cos.dao.CourseMapper"%>
<%@page import="cos.bean.Institute"%>
<%@page import="java.util.List"%>
<%@page import="cos.dao.InstituteMapper"%>
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
<title>admin</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="../lib/bootstrap/css/bootstrap.css">
<!--echart-->
<script src="../lib/echarts.js"></script>
</head>

<body style="background-color: rgb(150, 141, 236);">
	<div style="background-color: white;" class="container">
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
								<a class="btn btn-default" onclick="dataBackup()">
									<span class="glyphicon glyphicon-copy"></span><b>&nbsp;数据备份</b>
								</a>
							</li>
							<li>
								<a class="btn btn-default" onclick="window.alert('请联系数据库管理员处理')">
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
			
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div id="pie" style="width: 500px;height:336px;"></div>
			</div>
			
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div id="bar" style="width: 500px;height:336px;"></div>
			</div>

			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="line" style="width: 1090px;height:336px;"></div>
			</div>
			
		</div>
		<script type="text/javascript">
		<%
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			//课程类型统计字段
			int professional_education=0;
			int liberal_education=0;
			int subject_basis=0;
			CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
			List<Course> courses = courseMapper.selectAll();
			for(Course course : courses){
				switch(course.getCourseType()){
					case 1:liberal_education++;break;
					case 2:subject_basis++;break;
					case 3:professional_education++;break;
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
				switch(article.getContidion()){
					case 1:c_1++;break;
					case 2:c_2++;break;
					case 3:c_3++;break;
					case 4:c_4++;break;
					case 5:c_5++;break;
					case 6:c_6++;break;
				}
			}
			
			//各学院每学期课程大纲统计字段
			class Ins{
				int ins_id;
				String ins_name;
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
					return ins_id+" "+ins_name+" "+
						+c_1+" "+c_2+" "+c_3+" "+c_4+" "+c_5+" "+c_6+" "+c_7+" "+c_8+" ";
				}
			}
			ArrayList<Ins> inss=new ArrayList<>();
			InstituteMapper instituteMapper=sqlSession.getMapper(InstituteMapper.class);
			List<Institute> institutes = instituteMapper.selectAllInstitute();
			for(Institute institute:institutes){
				Ins ins = new Ins();
				ins.ins_id=institute.getInstituteId();
				ins.ins_name=institute.getInstituteName();
				inss.add(ins);
			}
			
			for(Course course:courses){
				for(Ins ins: inss){
					if(course.getInstitute().equals(ins.ins_id)){
						switch (course.getPriority()){
							case 1:ins.c_1++;break;
							case 2:ins.c_2++;break;
							case 3:ins.c_3++;break;
							case 4:ins.c_4++;break;
							case 5:ins.c_5++;break;
							case 6:ins.c_6++;break;
							case 7:ins.c_7++;break;
							case 8:ins.c_8++;break;
						}
					}
				}
			}
			
			sqlSession.close();
		%>
			
		
			function pieInit() {
				// 基于准备好的dom，初始化echarts实例
				var myChart = echarts.init(document.getElementById('pie'));
				// 指定图表的配置项和数据
				var option = {
					title: {
						text: '全学校中各类型课程大纲统计',
						subtext: '兰州工业学院',
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
					text: '全学校各状态课程大纲统计',
					subtext: '兰州工业学院',
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
					text: '各学院每学期课程大纲总量统计'
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
						for(Ins ins:inss){
						%>
						'<%=ins.ins_name%>',
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
						for(Ins ins:inss){
					%>
					{
						name: '<%=ins.ins_name%>',
						type: 'line',
						stack: 'Total',
						areaStyle: {},
						emphasis: {
							focus: 'series'
						},
						data: [<%=ins.c_1%>, <%=ins.c_2%>, <%=ins.c_3%>, <%=ins.c_4%>, <%=ins.c_5%>, <%=ins.c_6%>, <%=ins.c_7%>,<%=ins.c_8%>]
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

</body>
<script src="../lib/jQuery/jquery-3.6.0.js"></script>
<script src="../lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
	function toDepartmentManageIndex() {
		var insID = window.document.getElementById("insID").value;
		window.location.href = "/cos/system/admin/departmentManageIndex.jsp?insId=" + insID;
	}
	function dataBackup() {
		window.alert('系统数据已备份');
		location.href="/cos/dataBackup";
	}
	
	//function dataRecive() {
		//window.alert('系统数据已恢复至最近备份');
		//location.href="/cos/dataRecive";
	//}
</script>
</html>