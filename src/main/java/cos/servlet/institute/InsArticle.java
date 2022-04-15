package cos.servlet.institute;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Article;
import cos.bean.User;
import cos.dao.ArticleMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class InsArticle
 * 
 * 我的课程大纲
 */
@WebServlet("/insArticle")
public class InsArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user=(User)request.getSession().getAttribute("user");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			List<Article> articles = articleMapper.selectAll();
			ArrayList<Article> result = new ArrayList<>();
			for (Article article : articles) {
				if (article.getTeacher()!=null && article.getTeacher().equals(user.getUserId())) {
					result.add(article);
				}
			}
			sqlSession.close();
			request.getSession().setAttribute("page_quantity",0);
			request.getSession().setAttribute("current_page",0);
			request.getSession().setAttribute("articles", result);
			response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=myArticle");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
