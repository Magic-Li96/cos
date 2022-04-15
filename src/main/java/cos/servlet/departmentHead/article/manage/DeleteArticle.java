package cos.servlet.departmentHead.article.manage;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
 * Servlet implementation class DeleteArticle
 */
@WebServlet("/deleteArticle")
public class DeleteArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String src = new String(request.getParameter("src").getBytes(),"UTF-8");
			File file = new File(src);
			file.delete();
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			List<Article> articles = articleMapper.selectAll();
			for (Article article : articles) {
				if (article.getArticleSrc()!=null&&article.getArticleSrc().equals(src)) {
					article.setArticleSrc(null);
					article.setContidion(2);
					articleMapper.updateByPrimaryKey(article);
				}
			}
			sqlSession.commit();
			sqlSession.close();
			response.sendRedirect("/cos/myArticle");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
