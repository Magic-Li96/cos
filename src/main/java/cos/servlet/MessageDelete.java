package cos.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.dao.MessageMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class MessageDelete
 */
@WebServlet("/messageDelete")
public class MessageDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String msg_id = request.getParameter("msg_id");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			MessageMapper messageMapper = sqlSession.getMapper(MessageMapper.class);
			messageMapper.deleteByPrimaryKey(Integer.parseInt(msg_id));
			sqlSession.commit();
			sqlSession.close();
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("success", 200));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
