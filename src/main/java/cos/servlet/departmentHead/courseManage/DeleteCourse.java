package cos.servlet.departmentHead.courseManage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.dao.CourseMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class DeleteCourse
 */
@WebServlet("/deleteCourse")
public class DeleteCourse extends HttpServlet {
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
		SqlSession sqlSession=null;
		try {
			sqlSession = MybatisUtil.openSqlSession();
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			int department = Integer.parseInt(request.getParameter("department"));
			int subject = Integer.parseInt(request.getParameter("subject"));
			CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
			courseMapper.deleteByPrimaryKey(courseId, department, subject);
			sqlSession.commit();
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("/cos/system/departmentHead/course.jsp?subId="+subject,200));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
