package cos.servlet.admin.userManage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.User;
import cos.dao.UserMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class SearchUserByInstitute
 */
@WebServlet("/searchUserByInstitute")
public class SearchUserByInstitute extends HttpServlet {
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
			String instituteId = request.getParameter("instituteId");
			sqlSession=MybatisUtil.openSqlSession();
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			
			List<User> list = mapper.selectAll();
			List<User> result=new ArrayList<User>();
			
			for (User user : list) {
				if (user.getInstitute().equals(Integer.parseInt(instituteId))) {
					result.add(user);
				}
			}
			sqlSession.close();			
			request.getSession().setAttribute("userSearchList", result);
			response.sendRedirect("/cos/system/admin/userSearch.jsp");
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			sqlSession.close();
		}
	}

}
