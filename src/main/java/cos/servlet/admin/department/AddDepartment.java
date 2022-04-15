package cos.servlet.admin.department;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Department;
import cos.dao.DepartmentMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class AddDepartment
 */
@WebServlet("/addDepartment")
public class AddDepartment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SqlSession sqlSession = null;
		try {
			String departmentName = request.getParameter("departmentName");
			int instituteId = Integer.parseInt(request.getParameter("instituteId"));
			sqlSession = MybatisUtil.openSqlSession();
			DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
			List<Department> departments = mapper.selectAll();
			for (Department department : departments) {
				if (departmentName.equals(department.getDepartmentName())) {
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("系名重复！", 500));
					sqlSession.close();
					return;
				}
			}
			Department department = new Department();
			department.setDepartmentName(departmentName);
			department.setInstitute(instituteId);
			mapper.insert(department);
			sqlSession.commit();
			sqlSession.close();
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/departmentManageIndex.jsp?insId="+instituteId, 200));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			sqlSession.close();
			System.out.println(e);
		}
	}

}
