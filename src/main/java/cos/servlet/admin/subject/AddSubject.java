package cos.servlet.admin.subject;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Subject;
import cos.dao.SubjectMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class AddSubject
 */
@WebServlet("/addSubject")
public class AddSubject extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SqlSession sqlSession=null;
		try {
			String subjectName = request.getParameter("subjectName");
			String subjectId = request.getParameter("subjectId");
			String departmentId = request.getParameter("departmentId");
			String instituteId = request.getParameter("instituteId");
			sqlSession = MybatisUtil.openSqlSession();
			SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
			List<Subject> subjects = mapper.selectAll();
			for (Subject subject : subjects) {
				if (subject.getSubjectName().equals(subjectName)||subject.getSubjectId().equals(Integer.parseInt(subjectId))) {
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("专业名或ID已存在！", 500));
					sqlSession.close();
					return;
				}
			}
			Subject subject = new Subject();
			subject.setSubjectId(Integer.parseInt(subjectId));
			subject.setSubjectName(subjectName);
			subject.setDepartmentId(Integer.parseInt(departmentId));
			mapper.insert(subject);
			sqlSession.commit();
			sqlSession.close();
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/departmentManageIndex.jsp?insId="+instituteId, 200));
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			sqlSession.close();
		}
	}

}
