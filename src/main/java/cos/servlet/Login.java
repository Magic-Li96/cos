package cos.servlet;

import java.io.IOException;

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
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userID = request.getParameter("userID");
		String password = request.getParameter("password");
		SqlSession sqlSession=null;
		try {
			sqlSession = MybatisUtil.openSqlSession();
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			User user = userMapper.selectByPrimaryKey(userID);
			sqlSession.close();
			if (user!=null&&user.getPassword().equals(password)) {
				request.getSession().setAttribute("user", user);
				switch (user.getPosition()) {
				// 管理员登录
				case 0:
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/index.jsp", 200));
					break;
				// 教师登录
				case 1:
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("/cos/system/teacher/index.jsp", 200));
					break;
				// 教学系主任登录
				case 2:
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("/cos/system/departmentHead/index.jsp", 200));
					break;
				// 院办工作人员
				case 3:
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("/cos/system/instituteOffice/index.jsp", 200));
					break;
				// 学院领导
				case 4:
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("/cos/system/leader/index.jsp", 200));
					break;
				}
				
			}else if (userID.equals("admin")&&password.equals("admin")) {
				request.getSession().setAttribute("user", "admin");
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/index.jsp", 200));
			}else {
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("用户信息错误", 500));				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
