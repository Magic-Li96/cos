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
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class SearchUserById
 */
@WebServlet("/searchUserById")
public class SearchUserById extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SqlSession sqlSession = null;
		try {
			String userId = request.getParameter("userId");
			sqlSession = MybatisUtil.openSqlSession();
			UserMapper mapper = sqlSession.getMapper(UserMapper.class);
			User user = mapper.selectByPrimaryKey(userId);
			if (user == null) {
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("用户不存在", 500));
				sqlSession.close();
			} else {
				List<User> userList = new ArrayList<User>();
				userList.add(user);
				request.getSession().setAttribute("userSearchList", userList);
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/userSearch.jsp", 200));
				sqlSession.close();
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
