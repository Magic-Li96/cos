package cos.servlet.admin.department;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.dao.DepartmentMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class DeleteInstitute
 */
@WebServlet("/deleteDepartment")
public class DeleteDepartment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		SqlSession sqlSession=null;
		try {
			String departmentId = request.getParameter("departmentId");
			String instituteId = request.getParameter("instituteId");
			sqlSession = MybatisUtil.openSqlSession();
			DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
			mapper.deleteByPrimaryKey(Integer.parseInt(departmentId));
			sqlSession.commit();
			sqlSession.close();
			response.sendRedirect("/cos/system/admin/departmentManageIndex.jsp?insId="+instituteId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sqlSession.close();
		}
	}

}
