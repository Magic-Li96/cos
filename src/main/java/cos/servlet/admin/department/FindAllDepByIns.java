package cos.servlet.admin.department;

import java.io.IOException;
import java.util.ArrayList;
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
 * Servlet implementation class FindAllDepByIns
 */
@WebServlet("/findAllDepByIns")
public class FindAllDepByIns extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String instituteId = request.getParameter("instituteId");
		try {
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
			List<Department> departments = departmentMapper.selectAll();
			ArrayList<Department> result=new ArrayList<>();
			for (Department department : departments) {
				if (department.getInstitute().equals(Integer.parseInt(instituteId)))
					result.add(department);
			}
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr(result, 200));
			sqlSession.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
