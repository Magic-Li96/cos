package cos.servlet.departmentHead.courseManage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Article;
import cos.bean.Course;
import cos.dao.ArticleMapper;
import cos.dao.CourseMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class InsertCourse
 */
@WebServlet("/insertCourse")
public class InsertCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String course_Id = request.getParameter("course_id");
			String department = request.getParameter("department");
			String subject = request.getParameter("subject");
			String courseName = request.getParameter("courseName");
			String institute = request.getParameter("institute");
			String startInstitute = request.getParameter("startInstitute");
			String priority = request.getParameter("priority");
			String allClassHours = request.getParameter("allClassHours");
			String credit = request.getParameter("credit");
			String courseType= request.getParameter("courseType");

			SqlSession sqlSession = MybatisUtil.openSqlSession();
			CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
			
			Course course =courseMapper.selectByPrimaryKey(Integer.parseInt(course_Id), Integer.parseInt(department), Integer.parseInt(subject));
			if (course!=null) {
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("课程信息重复", 500));
				sqlSession.close();
				return;
			}else {
				course=new Course();
				course.setCourseId(Integer.parseInt(course_Id));
				course.setDepartment(Integer.parseInt(department));
				course.setSubject(Integer.parseInt(subject));
				course.setCourseName(courseName);
				course.setInstitute(Integer.parseInt(institute));
				course.setStartInstitute(Integer.parseInt(startInstitute));
				course.setPriority(Integer.parseInt(priority));
				course.setAllClassHours(Integer.parseInt(allClassHours));
				course.setCredit(Double.parseDouble(credit));
				course.setCourseType(Integer.parseInt(courseType));
				courseMapper.insert(course);
				sqlSession.commit();
				
				//获得p_id加入article中
				Integer pId = courseMapper.selectByPrimaryKey(course.getCourseId(),course.getDepartment(),course.getSubject()).getpId();
				//添加未分配状态的课程大纲
				ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
				Article article = new Article();
				article.setpId(pId);
				article.setCourse(course.getCourseId());
				article.setDepartment(course.getDepartment());
				article.setSubject(course.getSubject());
				article.setArticleName(course.getCourseName());
				article.setContidion(1);
				article.setStartInstitute(course.getStartInstitute());
				article.setInstitute(course.getInstitute());
				System.out.println(article);
				articleMapper.insert(article);
				
				sqlSession.commit();
				sqlSession.close();
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("/cos/showCourse?subId="+subject,200));
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
