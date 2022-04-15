package cos.servlet.institute;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Message;
import cos.dao.MessageMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class ShowMessage
 */
@WebServlet("/showInsMessage")
public class ShowInsMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String id = request.getParameter("id");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			MessageMapper messageMapper = sqlSession.getMapper(MessageMapper.class);
			Message message = messageMapper.selectByPrimaryKey(Integer.parseInt(id));
			message.setMessageState(1);
			messageMapper.updateByPrimaryKey(message);
			sqlSession.commit();
			sqlSession.close();
			response.sendRedirect("/cos/system/instituteOffice/index.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
