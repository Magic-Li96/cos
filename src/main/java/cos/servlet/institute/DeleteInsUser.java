package cos.servlet.institute;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.dao.UserMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class DeleteUser
 */
@WebServlet("/deleteInsUser")
public class DeleteInsUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SqlSession sqlSession=null;
		try {
			String userId = request.getParameter("userId");
			sqlSession=MybatisUtil.openSqlSession();
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			mapper.deleteByPrimaryKey(userId);
			
			sqlSession.commit();
			sqlSession.close();
			response.sendRedirect("/cos/system/instituteOffice/userManageIndex.jsp");
			
		} catch (Exception e) {
			System.out.println(e);
			sqlSession.close();
		}
		
	}

}
