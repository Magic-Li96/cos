package cos.servlet.departmentHead.article.manage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Article;
import cos.dao.ArticleMapper;
import cos.util.JsonResult;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class DistributeArticle
 */
@WebServlet("/distributeArticle")
public class DistributeArticle extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Integer courseId = Integer.parseInt(request.getParameter("course_id"));
			Integer department = Integer.parseInt(request.getParameter("department"));
			Integer subject = Integer.parseInt(request.getParameter("subject"));
			String teacher = request.getParameter("teacher");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			Article article = articleMapper.selectByPrimaryKey(courseId, department, subject);
			article.setTeacher(teacher);
			article.setContidion(2);
			articleMapper.updateByPrimaryKey(article);
			sqlSession.commit();
			sqlSession.close();
			response.setContentType("application/json");
			response.getWriter().write(new JsonResult().byJsonStr("/cos/waitDistributionArticle?subId="+subject,200));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
