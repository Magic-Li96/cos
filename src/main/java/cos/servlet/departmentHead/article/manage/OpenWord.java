package cos.servlet.departmentHead.article.manage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.zhuozhengsoft.pageoffice.OpenModeType;
import com.zhuozhengsoft.pageoffice.PageOfficeCtrl;
import com.zhuozhengsoft.pageoffice.wordwriter.WordDocument;

import cos.bean.Article;
import cos.dao.ArticleMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class OpenWord
 */
@WebServlet("/checkArticle")
public class OpenWord extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String src = request.getParameter("src");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			List<Article> articles = articleMapper.selectAll();
			for (Article article : articles) {
				if (article.getArticleSrc()!=null && article.getArticleSrc().equals(src)) {
					//获取信息，参数直接用就可以
					//Mbti mbti = mbtiService.getUserById (id);
					PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
					//不用改
					poCtrl1.setServerPage(request.getContextPath() + "/poserver.zz");
					//隐藏Office工具条
					poCtrl1.setOfficeToolbars(false);
					//隐藏自定义工具栏
					poCtrl1.setCustomToolbar(false);
					//设置页面的显示标题
					poCtrl1.setCaption(article.getArticleName());
					
					
					poCtrl1.webOpen(src,OpenModeType.docReadOnly,article.getTeacher());
					//打开文件,和open.jsp页面的id要对应
					poCtrl1.setTagId("PageOfficeCtrl1");
				
					request.getRequestDispatcher("/system/departmentHead/articleCompile.jsp").forward(request, response);
				
					return;
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
