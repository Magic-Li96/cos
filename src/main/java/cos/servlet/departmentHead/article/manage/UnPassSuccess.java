package cos.servlet.departmentHead.article.manage;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Article;
import cos.bean.Message;
import cos.bean.User;
import cos.dao.ArticleMapper;
import cos.dao.MessageMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class PassSuccess
 */
@WebServlet("/unPassSuccess")
public class UnPassSuccess extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String src = new String(request.getParameter("src").getBytes(),"UTF-8");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			MessageMapper messageMapper = sqlSession.getMapper(MessageMapper.class);
			List<Article> articles = articleMapper.selectAll();
			for (Article article : articles) {
				if (article.getArticleSrc()!=null&&article.getArticleSrc().equals(src)) {
					article.setContidion(3);
					articleMapper.updateByPrimaryKey(article);
					Message message = new Message();
					message.setMessageType(2);
					User user=(User)request.getSession().getAttribute("user");
					message.setSendUser(user.getUserId());
					message.setReceiveUser(article.getTeacher());
					message.setMessage(request.getParameter("msg"));
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					message.setTime(df.format(new Date()));
					message.setMessageState(2);
					messageMapper.insert(message);
					
					sqlSession.commit();
					sqlSession.close();
					response.sendRedirect("/cos/waitFirstAssessArticle?subId="+article.getSubject());
					return;
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
