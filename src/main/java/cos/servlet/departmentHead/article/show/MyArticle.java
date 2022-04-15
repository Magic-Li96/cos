package cos.servlet.departmentHead.article.show;

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
 * Servlet implementation class MyArticle
 */
@WebServlet("/myArticle")
public class MyArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user =(User)request.getSession().getAttribute("user");
			String userId = user.getUserId();
			SqlSession sqlSession=MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			List<Article> articles = articleMapper.selectAll();
			ArrayList<Article> result = new ArrayList<>();
			for (Article article : articles) {
				if (article.getTeacher()!=null&&article.getTeacher().equals(userId)) {
					result.add(article);
				}
			}
			sqlSession.close();
			request.getSession().setAttribute("articles", result);
			request.getSession().setAttribute("page_quantity",0);
			request.getSession().setAttribute("current_page",0);
			response.sendRedirect("/cos/system/departmentHead/article.jsp?title=myArticle");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
