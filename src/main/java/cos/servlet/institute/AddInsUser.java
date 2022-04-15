package cos.servlet.institute;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.DepartmentHead;
import cos.bean.User;
import cos.dao.DepartmentHeadMapper;
import cos.dao.UserMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

@WebServlet("/addInsUser")
public class AddInsUser extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SqlSession sqlSession = null;
		try {
			String userID = request.getParameter("userID");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String cell = request.getParameter("cellphone");
			String authority = request.getParameter("authority");
			String condition = request.getParameter("condition");
			String instituteID = request.getParameter("institute");
			String positionID = request.getParameter("position");
			sqlSession = MybatisUtil.openSqlSession();
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			User user = userMapper.selectByPrimaryKey(userID);
			if (user == null) {
				user = new User();
				user.setUserId(userID);
				user.setUserName(username);
				user.setPassword(password);
				user.setCellphone(cell);
				user.setAuthority(Integer.parseInt(authority));
				user.setState(Integer.parseInt(condition));
				user.setInstitute(Integer.parseInt(instituteID));
				user.setPosition(Integer.parseInt(positionID));
				userMapper.insert(user);
				//教学系主任桥表处理
				if (user.getPosition().equals(2)) {
					String departmentID = request.getParameter("department");
					DepartmentHeadMapper departmentHeadMapper = sqlSession.getMapper(DepartmentHeadMapper.class);
					DepartmentHead departmentHead = departmentHeadMapper.selectByPrimaryKey(Integer.parseInt(departmentID));
					if (departmentHead!=null) {
						userMapper.deleteByPrimaryKey(userID);
						response.setContentType("application/json");
						response.getWriter().write(new JsonResult().byJsonStr("该系已有系主任,新建用户失败...", 500));
						return;
					}else {
						departmentHead=new DepartmentHead();
						departmentHead.setDepartmentHeadId(userID);
						departmentHead.setDepartmentId(Integer.parseInt(departmentID));
						departmentHeadMapper.insert(departmentHead);
					}
				}
				sqlSession.commit();
				sqlSession.close();
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("/cos/system/instituteOffice/userManageIndex.jsp", 200));
			} else {
				response.setContentType("application/json");
				response.getWriter().write(new JsonResult().byJsonStr("用户ID重复", 500));
				sqlSession.close();
			}

		} catch (Exception e) {
			System.out.println(e);
			sqlSession.close();
			e.printStackTrace();
		}
	}

}
