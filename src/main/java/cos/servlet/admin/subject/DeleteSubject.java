package cos.servlet.admin.subject;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.dao.SubjectMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class AddSubject
 */
@WebServlet("/deleteSubject")
public class DeleteSubject extends HttpServlet {
	
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
			String subjectId = request.getParameter("subjectId");
			String instituteId = request.getParameter("instituteId");
			sqlSession = MybatisUtil.openSqlSession();
			SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
			mapper.deleteByPrimaryKey(Integer.parseInt(subjectId));
			sqlSession.commit();
			sqlSession.close();
			response.sendRedirect("/cos/system/admin/departmentManageIndex.jsp?insId="+instituteId);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			sqlSession.close();
		}
	}

}
