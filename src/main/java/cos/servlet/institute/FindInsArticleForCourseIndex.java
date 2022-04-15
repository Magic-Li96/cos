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
import cos.bean.DepartmentHead;
import cos.bean.User;
import cos.dao.ArticleMapper;
import cos.dao.DepartmentHeadMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class FindArticleForCourseIndex
 */
@WebServlet("/findInsArticleForCourseIndex")
public class FindInsArticleForCourseIndex extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			User user = (User) request.getSession().getAttribute("user");
			String courseId = request.getParameter("courseId");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			List<Article> articles = articleMapper.selectAll();
			ArrayList<Article> result = new ArrayList<>();

			for (Article article : articles) {
				if (article.getInstitute().equals(user.getInstitute()) 
						&& article.getCourse().equals(Integer.parseInt(courseId))) {
					result.add(article);
				}
			}

			// 确定分页总数
			int page_quantity = 0;
			if (result.size() % 9 != 0) {
				page_quantity = result.size() / 9 + 1;
			} else {
				page_quantity = result.size() / 9;
			}

			/**
			 * 封装结果集
			 */
			// 1.初始化一个与页数相匹配的list<ArrayList<Institute>>
			ArrayList<ArrayList<Article>> arrays = new ArrayList<>();
			for (int i = 0; i < page_quantity; i++) {
				arrays.add(i, new ArrayList<Article>());
			}

			// 2.存入分页数据
			for (int i = 0, j = 0; i < result.size();) {
				arrays.get(j).add(result.get(i++));
				if (i % 9 == 0)
					j++;
			}

			// 结果集为空的处理
			if (arrays.size() == 0) {
				request.getSession().setAttribute("articles", new ArrayList<Article>());
				request.getSession().setAttribute("page_quantity", 0);
				request.getSession().setAttribute("current_page", 0);
				response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
				return;
			}

			// 返回结果集
			Integer current_page = null;
			if (request.getParameter("current_page") == null) {
				// 从第一页开始
				request.getSession().setAttribute("articles", arrays.get(0));
				request.getSession().setAttribute("page_quantity", page_quantity);
				request.getSession().setAttribute("current_page", 0);
				response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
				return;
			} else {
				current_page = Integer.parseInt(request.getParameter("current_page"));
			}

			// 向前跳转一页
			if (request.getParameter("page_index").equals("next")) {
				if ((current_page + 1) == page_quantity) {
					// 从第一页开始
					request.getSession().setAttribute("articles", arrays.get(0));
					request.getSession().setAttribute("page_quantity", page_quantity);
					request.getSession().setAttribute("current_page", 0);
					response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
					return;
				} else {
					// 返回下一页数据，当前页标随即变化
					request.getSession().setAttribute("articles", arrays.get(current_page + 1));
					request.getSession().setAttribute("page_quantity", page_quantity);
					request.getSession().setAttribute("current_page", current_page + 1);
					response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
					return;
				}
			}

			// 向后跳转一页
			if (request.getParameter("page_index").equals("prior")) {
				if ((current_page - 1) == -1) {
					// 跳转到最后一页
					request.getSession().setAttribute("articles", arrays.get(page_quantity - 1));
					request.getSession().setAttribute("page_quantity", page_quantity);
					request.getSession().setAttribute("current_page", page_quantity - 1);
					response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
					return;
				} else {
					// 返回上一页数据，当前页标随即变化
					request.getSession().setAttribute("articles", arrays.get(current_page - 1));
					request.getSession().setAttribute("page_quantity", page_quantity);
					request.getSession().setAttribute("current_page", current_page - 1);
					response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
					return;
				}
			}

			// 跳转到指定页
			int page_index = Integer.parseInt(request.getParameter("page_index"));
			request.getSession().setAttribute("articles", arrays.get(page_index));
			request.getSession().setAttribute("page_quantity", page_quantity);
			request.getSession().setAttribute("current_page", page_index);
			response.sendRedirect("/cos/system/instituteOffice/article.jsp?title=search");
			sqlSession.close();
			return;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
