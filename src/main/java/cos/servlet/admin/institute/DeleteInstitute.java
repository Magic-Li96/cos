package cos.servlet.admin.institute;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.dao.InstituteMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class DeleteInstitute
 */
@WebServlet("/deleteInstitute")
public class DeleteInstitute extends HttpServlet {
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
			String insID = request.getParameter("insID");
			sqlSession = MybatisUtil.openSqlSession();
			InstituteMapper mapper = sqlSession.getMapper(InstituteMapper.class);
			mapper.deleteByPrimaryKey(Integer.parseInt(insID));
			sqlSession.commit();
			sqlSession.close();
//			response.sendRedirect("/cos/system/admin/instituteManageIndex.jsp");
			response.sendRedirect("/cos/showInstitute");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sqlSession.close();
		}
	}

}
