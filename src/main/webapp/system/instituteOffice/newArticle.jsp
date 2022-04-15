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


</head>

<script type="text/javascript">
	var courseTargetIndex=1;
	var c_targetIndex=1;
	var experimentIndex=1;
</script>
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
								SqlSession sqlSession = MybatisUtil.openSqlSession();
								InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
								Institute institute =instituteMapper.selectByPrimaryKey(user.getInstitute());
							%>
							<li class="active"><a href="#"> <span
									class="glyphicon glyphicon-user"><%=institute.getInstituteName()%>院办</span>
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
				<%
					Integer courseId =Integer.parseInt(request.getParameter("courseId"));
					Integer departmentId =Integer.parseInt(request.getParameter("departmentId"));
					Integer subjectId = Integer.parseInt(request.getParameter("subjectId"));
					CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
					Course course = courseMapper.selectByPrimaryKey(courseId, departmentId, subjectId);
				%>
				<table style="background-color: aliceblue;" class="table">
					<thead>
						<tr>
							<th style="font-family: STKaiti;font-size: 23px" class="text-center" colspan="2"><%=course.getCourseName()%>&nbsp;课程大纲</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">一.基本信息</td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">课程编码：</td>
							<td><input value="<%=course.getCourseId()%>" disabled="disabled"/></td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">课程类型：</td>
							<td>
								<select id="course_type">
									<option>通识教育</option>
									<option>学科基础</option>
									<option>专业教育</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">学时：</td>
							<td><input id="class_hour" value="<%=course.getAllClassHours()%>" disabled="disabled"/></td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">学分：</td>
							<td><input id="credit" value="<%=course.getCredit()%>" disabled="disabled"></td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">先修课程：</td>
							<td>
								<select id="pir_course">
									<% 
										List<Course> courses = courseMapper.selectAll();
										for(Course c : courses){
											if(c.getSubject().equals(subjectId)&&c.getPriority()<course.getPriority()){
									%>
										<option><%=c.getCourseName()%></option>
									<%
											}
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">后续：</td>
							<td>
								<select id="after_course">
									<% 
										for(Course c : courses){
											if(c.getSubject().equals(subjectId)&&c.getPriority() > course.getPriority()){
									%>
										<option><%=c.getCourseName()%></option>
									<%
											}
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">适用专业：</td>
							<%
								SubjectMapper subjectMapper = sqlSession.getMapper(SubjectMapper.class); 
								Subject sub = subjectMapper.selectByPrimaryKey(course.getSubject());
							%>
							<td>
								<input id="subject_name" value="<%=sub.getSubjectName()%>" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td style="font-size: 15px;font-weight: 500">开课单位：</td>
							<%
								Institute ins = instituteMapper.selectByPrimaryKey(course.getInstitute());
							%>
							<td><input id="start_ins_name" value="<%=ins.getInstituteName()%>" disabled="disabled"/></td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">二.课程性质与任务</td>
						</tr>
						<tr>
							<td>课程性质:</td>
							<td><textarea id="c_x" rows="3" cols="50" style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<td>课程任务:</td>
							<td><textarea id="c_t" rows="3" cols="50" style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">三.课程目标</td>
						</tr>
						<tr>
							<td colspan="2">学生通过本课程学习应达到如下目标：</td>
						</tr>
						<tr>
							<td>（一）知识与技能目标:</td>
							<td><textarea id="target_1" rows="3" cols="50" style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<td>（二）思政育人目标:</td>
							<td><textarea id="target_2" rows="3" cols="50" style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">四.课程目标对毕业要求的支撑关系</td>
						</tr>
						<tr id="c_1">
							<td colspan="2">
								毕业要求：
								<textarea name="r_g" rows="2" cols="30" style="resize: none;"></textarea> 
								毕业要求指标点：
								<textarea name="r_i" rows="2" cols="30" style="resize: none;"></textarea>
								课程目标：
								<input name="courseTarget" type="text"/>
								<button id="addnewCTItem" onclick="addnewCTItem()">
									+ 点击添加新项
								</button>
							</td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">五、课程教学内容、教学要求及学时分配</td>
						</tr>
						<tr>
							<td>章节标题:</td>
							<td><input name="partTitle" type="text"/></td>
						</tr>
						<tr>
							<td>教学内容:</td>
							<td><textarea name="courseContent" style="resize: none;" rows="3" cols="60"></textarea></td>
						</tr>
						<tr>
							<td>教学要求:</td>
							<td><textarea name="courseRequire" style="resize: none;" rows="3" cols="60"></textarea></td>
						</tr>
						<tr>
							<td>教学重点:</td>
							<td><input name="courseImportent" type="text"/></td>
						</tr>
						<tr>
							<td>教学难点:</td>
							<td><input name="course_n" type="text"/></td>
						</tr>
						<tr id="t_1">
							<td>对应课程目标:</td>
							<td>
								<input name="d_t" type="text"/>&nbsp;
								<button id="addC_target" onclick="addC_target()">点击添加新项</button>
							</td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">六、实验考核要求及成绩评定</td>
						</tr>
						<tr>
							<td>描述:</td>
							<td><textarea id="c_a" style="resize: none;" rows="2" cols="50"></textarea></td>
						</tr>
						<tr id="e_1">
							<td colspan="2">
							考核项目：<input name="exam_item" type="text"/>
							分值：<input name="score" type="text"/>
							考核要求：<textarea name="exam_require" style="resize: none;" rows="2" cols="45"></textarea>
							<button id="addExperiment" onclick="addExperiment()">+ 点击添加新项</button>
							</td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">七、课程考核及成绩评定</td>
						</tr>
						<tr>
							<td>过程考核占比:</td>
							<td>
								<select id="process_precent">
									<%
										for(int i=0;i<=100;i++){
									%>
									<option><%=i%>%</option>
									<%											
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td>过程考核要求:</td>
							<td><textarea id="process_require" style="resize: none;" rows="2" cols="60"></textarea></td>
						</tr>
						<tr>
							<td>期末考试占比:</td>
							<td>
								<select id="exam_precent">
									<%
										for(int i=0;i<=100;i++){
									%>
									<option><%=i%>%</option>
									<%											
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td>期末考试要求:</td>
							<td><textarea id="exam_require" style="resize: none;" rows="2" cols="60"></textarea></td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">八、建议教材和参考资料</td>
						</tr>
						<tr>
							<td>建议教材:</td>
							<td><textarea id="jyjc" style="resize: none;" rows="3" cols="60"></textarea></td>
						</tr>
						<tr>
							<td>参考资料:</td>
							<td><textarea id="ckzl" style="resize: none;" rows="3" cols="60"></textarea></td>
						</tr>
						<tr>
							<td style="font-family: STKaiti;font-size: 20px;font-weight: 600" colspan="2">九、其他说明</td>
						</tr>
						<tr>
							<td colspan="2"><textarea id="another_introduction" style="resize: none;" rows="3" cols="96"></textarea></td>
						</tr>
					</tbody>
					<tfoot class="text-center">
						<tr>
							<td colspan="2">
								<button onclick="location.href='/cos/insArticle'" class="btn btn-default">返回我的课程大纲界面</button>
								<button onclick="article_sub()" class="btn btn-success">提交新的课程大纲</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		function addnewCTItem(){
			$('#c_'+courseTargetIndex).after('<tr id="c_'+(++courseTargetIndex)+'"><td colspan="2">毕业要求：<textarea name="r_g" rows="2" cols="30" style="resize: none;"></textarea> &nbsp;毕业要求指标点： <textarea name="r_i" rows="2" cols="30" style="resize: none;"></textarea>&nbsp;课程目标： <input name="courseTarget" type="text"/>&nbsp;<button id="addnewCTItem" onclick="addnewCTItem()">+ 点击添加新项</button></td></tr>');
			$('#addnewCTItem').remove();
		}
		function addC_target(){
			$('#t_'+c_targetIndex).after('<tr><td style="background-color: gray;" colspan="2"></td></tr><tr><td>章节标题:</td><td><input name="partTitle" type="text"/></td></tr><tr><td>教学内容:</td><td><textarea name="courseContent" style="resize: none;" rows="3" cols="60"></textarea></td></tr><tr><td>教学要求:</td><td><textarea name="courseRequire" style="resize: none;" rows="3" cols="60"></textarea></td></tr><tr><td>教学重点:</td><td><input name="courseImportent" type="text"/></td></tr><tr><td>教学难点:</td><td><input name="course_n" type="text"/></td></tr><tr id="t_'+(++c_targetIndex)+'"><td>对应课程目标:</td><td><input name="d_t" type="text"/>&nbsp;<button id="addC_target" onclick="addC_target()">+ 点击添加新项</button></td></tr>');
			$('#addC_target').remove();
		}
		function addExperiment(){
			$('#e_'+experimentIndex).after('<tr id="e_'+(++experimentIndex)+'"><td colspan="2">考核项目：<input name="exam_item" type="text"/>&nbsp;分值：<input name="score" type="text"/>&nbsp;考核要求：<textarea name="exam_require" style="resize: none;" rows="2" cols="45"></textarea>&nbsp;<button id="addExperiment" onclick="addExperiment()">+ 点击添加新项</button></td></tr>');
			$('#addExperiment').remove();
		}
		function article_sub() {
			var courseId=<%=course.getCourseId()%>;
			var departmentId=<%=departmentId%>;
			var subjectId=<%=subjectId%>;
			
			var course_type=window.document.getElementById("course_type").value;
			var class_hour=window.document.getElementById("class_hour").value;
			var credit=window.document.getElementById("credit").value;
			var pir_course=window.document.getElementById("pir_course").value;
			var after_course=window.document.getElementById("after_course").value;
			var subject_name=window.document.getElementById("subject_name").value;
			var start_ins_name=window.document.getElementById("start_ins_name").value;
			var c_x=window.document.getElementById("c_x").value;
			var c_t=window.document.getElementById("c_t").value;
			var t_1=window.document.getElementById("target_1").value;
			var t_2=window.document.getElementById("target_2").value;
			
			var r_gs=window.document.getElementsByName("r_g");
			var array_1=[];
			for (let index = 0; index < r_gs.length; index++) {
				array_1.push(r_gs[index].value);
			}
			
			var r_is=window.document.getElementsByName("r_i");
			var array_2=[];
			for (let index = 0; index < r_is.length; index++) {
				array_2.push(r_is[index].value);
			}
			
			var courseTargets=window.document.getElementsByName("courseTarget");
			var array_3=[];
			for (let index = 0; index < courseTargets.length; index++) {
				array_3.push(courseTargets[index].value);
			}
			
			var partTitles=window.document.getElementsByName("partTitle");
			var array_4=[];
			for (let index = 0; index < partTitles.length; index++) {
				array_4.push(partTitles[index].value);
			}

			var courseContents=window.document.getElementsByName("courseContent");
			var array_5=[];
			for (let index = 0; index < courseContents.length; index++) {
				array_5.push(courseContents[index].value);
			}
			
			var courseRequires=window.document.getElementsByName("courseRequire");
			var array_6=[];
			for (let index = 0; index < courseRequires.length; index++) {
				array_6.push(courseRequires[index].value);
			}

			var courseImportents=window.document.getElementsByName("courseImportent");
			var array_7=[];
			for (let index = 0; index < courseImportents.length; index++) {
				array_7.push(courseImportents[index].value);
			}

			var course_ns=window.document.getElementsByName("course_n");
			var array_8=[];
			for (let index = 0; index < course_ns.length; index++) {
				array_8.push(course_ns[index].value);
			}

			var d_ts=window.document.getElementsByName("d_t");
			var array_9=[];
			for (let index = 0; index < d_ts.length; index++) {
				array_9.push(d_ts[index].value);
			}

			var c_a=window.document.getElementById("c_a").value;

			var exam_items=window.document.getElementsByName("exam_item");
			var array_10=[];
			for (let index = 0; index < exam_items.length; index++) {
				array_10.push(exam_items[index].value);
			}

			var scores=window.document.getElementsByName("score");
			var array_11=[];
			for (let index = 0; index < scores.length; index++) {
				array_11.push(scores[index].value);
			}

			var exam_requires=window.document.getElementsByName("exam_require");
			var array_12=[];
			for (let index = 0; index < exam_requires.length; index++) {
				array_12.push(exam_requires[index].value);
			}

			var process_precent=window.document.getElementById("process_precent").value;
			var process_require=window.document.getElementById("process_require").value;
			var exam_precent=window.document.getElementById("exam_precent").value;
			var exam_require=window.document.getElementById("exam_require").value;
			var jyjc=window.document.getElementById("jyjc").value;
			var ckzl=window.document.getElementById("ckzl").value;
			var another_introduction=window.document.getElementById("another_introduction").value;


			console.log(course_type);
			console.log(class_hour);
			console.log(credit);
			console.log(pir_course);
			console.log(after_course);
			console.log(subject_name);
			console.log(start_ins_name);
			console.log(c_x);
			console.log(c_t);
			console.log(t_1);
			console.log(t_2);
			console.log(array_1);
			console.log(array_2);
			console.log(array_3);
			console.log(array_4);
			console.log(array_5);
			console.log(array_6);
			console.log(array_7);
			console.log(array_8);
			console.log(array_9);
			console.log(c_a);
			console.log(array_10);
			console.log(array_11);
			console.log(array_12);
			console.log(process_precent);
			console.log(process_require);
			console.log(exam_precent);
			console.log(exam_require);
			console.log(jyjc);
			console.log(ckzl);
			console.log(another_introduction);
			
			$.ajax({
				type : "POST",
				url : "/cos/insTeaArticleGeneration",
				data : {
					courseId : courseId,
					departmentId : departmentId,
					subjectId : subjectId,
					course_type : course_type,
					class_hour : class_hour,
					credit : credit,
					pir_course : pir_course,
					after_course : after_course,
					subject_name : subject_name,
					start_ins_name : start_ins_name,
					c_x : c_x,
					c_t : c_t,
					t_1 : t_1,
					t_2 : t_2,
					array_1 : array_1,
					array_2 : array_2,
					array_3 : array_3,
					array_4 : array_4,
					array_5 : array_5,
					array_6 : array_6,
					array_7 : array_7,
					array_8 : array_8,
					array_9 : array_9,
					c_a : c_a,
					array_10 : array_10,
					array_11 : array_11,
					array_12 : array_12,
					process_precent : process_precent,
					process_require : process_require,
					exam_precent : exam_precent,
					exam_require : exam_require,
					jyjc : jyjc,
					ckzl : ckzl,
					another_introduction : another_introduction
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
						window.alert("课程大纲文件上传成功");
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
	
	
</body>

</html>