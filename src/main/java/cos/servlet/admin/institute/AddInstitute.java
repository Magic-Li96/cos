package cos.servlet.admin.institute;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Institute;
import cos.dao.InstituteMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class AddInstitute
 */
@WebServlet("/addInstitute")
public class AddInstitute extends HttpServlet {

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
		SqlSession sqlSession = null;
		try {
			String insName = request.getParameter("insName");
			sqlSession = MybatisUtil.openSqlSession();
			InstituteMapper mapper = sqlSession.getMapper(InstituteMapper.class);
			List<Institute> allInstitute = mapper.selectAllInstitute();
			for (Institute institute : allInstitute) {
				if (insName.equals(institute.getInstituteName())) {
					response.setContentType("application/json");
					response.getWriter().write(new JsonResult().byJsonStr("学院名重复", 500));
					sqlSession.close();
					return;
				}
			}
			Institute institute = new Institute();
			institute.setInstituteName(insName);  
			mapper.insert(institute);
			sqlSession.commit();
			sqlSession.close();
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("/cos/system/admin/instituteManageIndex.jsp", 200));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			sqlSession.close();
			System.out.println(e);
		}
	}
	
	
}
