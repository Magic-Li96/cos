package cos.servlet.admin.subject;

import java.io.IOException;

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
@WebServlet("/updateSubjectByName")
public class UpdateSubjectByName extends HttpServlet {
	
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
			Subject subject =mapper.selectByPrimaryKey(Integer.parseInt(subjectId));
			if (subject==null) {
				subject=new Subject();
				subject.setSubjectId(Integer.parseInt(subjectId));
				subject.setSubjectName(subjectName);
				subject.setDepartmentId(Integer.parseInt(departmentId));
				mapper.updateByName(subject);
				sqlSession.commit();
				sqlSession.close();
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/departmentManageIndex.jsp?insId="+instituteId, 200));
				return;
			}else {
				sqlSession.close();
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("专业ID重复！", 500));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			sqlSession.close();
		}
	}

}
