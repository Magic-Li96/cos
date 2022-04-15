package cos.servlet.institute;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Article;
import cos.bean.Institute;
import cos.bean.article.CourseContent;
import cos.bean.article.CourseTarget;
import cos.bean.article.Experiment;
import cos.dao.ArticleMapper;
import cos.dao.InstituteMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class TeacherArticleGeneration
 */
@WebServlet("/insTeaArticleGeneration")
public class InsTeaArticleGeneration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String courseId = request.getParameter("courseId");
			String departmentId = request.getParameter("departmentId");
			String subjectId=request.getParameter("subjectId");
			
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
			Article article = articleMapper.selectByPrimaryKey(Integer.parseInt(courseId), Integer.parseInt(departmentId),Integer.parseInt(subjectId));
			Institute institute = instituteMapper.selectByPrimaryKey(article.getInstitute());
			
			
			Map<String,Object> dataMap = new HashMap<String, Object>();
			dataMap.put("courseName","《"+article.getArticleName()+"》");
			dataMap.put("courseId", courseId);
			dataMap.put("courseType", request.getParameter("course_type"));
			dataMap.put("courseHours", request.getParameter("class_hour"));
			dataMap.put("credit",request.getParameter("credit"));
			dataMap.put("priorCourse", request.getParameter("pir_course"));
			dataMap.put("nextCourse", request.getParameter("after_course"));
			dataMap.put("department", request.getParameter("subject_name"));
			dataMap.put("institute", request.getParameter("start_ins_name"));
			dataMap.put("courseQuality", request.getParameter("c_x"));
			dataMap.put("courseTask", request.getParameter("c_t"));
			dataMap.put("knowledgeTarget", request.getParameter("t_1"));
	        dataMap.put("politicsTarget", request.getParameter("t_2"));
	        String[] array_1 = request.getParameterValues("array_1[]");
	        String[] array_2 = request.getParameterValues("array_2[]");
	        String[] array_3 = request.getParameterValues("array_3[]");
	        List<CourseTarget> courseTargets = new ArrayList<CourseTarget>();  
	        for (int i = 0; i < array_1.length; i++) {
				CourseTarget courseTarget = new CourseTarget();
				courseTarget.setRequire(array_1[i]);
				courseTarget.setIndex(array_2[i]);
				courseTarget.setTarget(array_3[i]);
				courseTargets.add(courseTarget);
			}
	        dataMap.put("courseTargets", courseTargets);

	        String[] array_4 = request.getParameterValues("array_4[]");
	        String[] array_5 = request.getParameterValues("array_5[]");
	        String[] array_6 = request.getParameterValues("array_6[]");
	        String[] array_7 = request.getParameterValues("array_7[]");
	        String[] array_8 = request.getParameterValues("array_8[]");
	        String[] array_9 = request.getParameterValues("array_9[]");
	        List<CourseContent> courseContents = new ArrayList<CourseContent>();
	        for (int i = 0; i < array_9.length; i++) {
				CourseContent courseContent = new CourseContent();
				courseContent.setPartTitle(array_4[i]);
		        courseContent.setPartContent(array_5[i]);
		        courseContent.setRequire(array_6[i]);
		        courseContent.setEmphasis(array_7[i]);
		        courseContent.setDifficulty(array_8[i]);
		        courseContent.setTarget(array_9[i]);
		        courseContents.add(courseContent);
			}
	        dataMap.put("courseContents", courseContents);
	        
	        dataMap.put("description", request.getParameter("c_a"));
	        
	        String[] array_10 = request.getParameterValues("array_10[]");
	        String[] array_11 = request.getParameterValues("array_11[]");
	        String[] array_12 = request.getParameterValues("array_12[]");
	        List<Experiment> experiments = new ArrayList<Experiment>();
	        for (int i = 0; i < array_12.length; i++) {
	        	Experiment experiment = new Experiment();
	            experiment.setItem(array_10[i]);
	            experiment.setScore(array_11[i]);
	            experiment.setRequire(array_12[i]);
	            experiments.add(experiment);
			}
	        dataMap.put("experiments", experiments);
	        
	        dataMap.put("processPercent", request.getParameter("process_precent"));
	        dataMap.put("processRequire", request.getParameter("process_require"));
	        dataMap.put("examPercent", request.getParameter("exam_precent"));
	        dataMap.put("examRequire", request.getParameter("exam_require"));
	        dataMap.put("adviceBook", request.getParameter("jyjc"));
	        dataMap.put("referenceData", request.getParameter("ckzl"));
	        dataMap.put("anotherIntroduce", request.getParameter("another_introduction"));
	        dataMap.put("teacher", article.getTeacher());
	        dataMap.put("departmentHead", "departmentHead");
	        dataMap.put("dean", "张");
	        
			//存储路径
			String savePath = request.getServletContext().getRealPath("/article/");
			//文件持久化保存
			new cos.util.ArticleGeneration().generation(article.getCourse()+
					article.getArticleName()+
					"("+institute.getInstituteName()+
					article.getSubject()+
					"专业)",savePath,dataMap);
			//数据库信息更新
			article.setContidion(3);
			article.setArticleSrc(
				savePath+
				article.getCourse()+
				article.getArticleName()+
				"("+institute.getInstituteName()+
				article.getSubject()+
				"专业)"+
				".doc"
			);
			articleMapper.updateByPrimaryKey(article);
			sqlSession.commit();
			sqlSession.close();
			
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("/cos/insArticle",200));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
