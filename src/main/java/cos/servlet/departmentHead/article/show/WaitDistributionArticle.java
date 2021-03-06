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
import cos.bean.DepartmentHead;
import cos.bean.User;
import cos.dao.ArticleMapper;
import cos.dao.DepartmentHeadMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class WaitDistributionArticle
 */
@WebServlet("/waitDistributionArticle")
public class WaitDistributionArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			request.getSession().setAttribute("wdA", new Object());
			
			User user = (User) request.getSession().getAttribute("user");
			int subId = Integer.parseInt(request.getParameter("subId"));
			String userId = user.getUserId();
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			DepartmentHeadMapper departmentHeadMapper = sqlSession.getMapper(DepartmentHeadMapper.class);
			List<DepartmentHead> departmentHeads = departmentHeadMapper.selectAll();
			for (DepartmentHead departmentHead : departmentHeads) {
				if (departmentHead.getDepartmentHeadId().equals(userId)) {
					Integer departmentId = departmentHead.getDepartmentId();
					ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
					List<Article> articles = articleMapper.selectAll();
					ArrayList<Article> result = new ArrayList<>();
					for (Article article : articles) {
						// ?????????????????????????????????????????????
						if (article.getDepartment().equals(departmentId) 
								&& article.getContidion().equals(1)
								&& article.getSubject().equals(subId)) {
							result.add(article);
						}
					}

					// ??????????????????
					int page_quantity = 0;
					if (result.size() % 9 != 0) {
						page_quantity = result.size() / 9 + 1;
					} else {
						page_quantity = result.size() / 9;
					}

					/**
					 * ???????????????
					 */
					// 1.????????????????????????????????????list<ArrayList<Institute>>
					ArrayList<ArrayList<Article>> arrays = new ArrayList<>();
					for (int i = 0; i < page_quantity; i++) {
						arrays.add(i, new ArrayList<Article>());
					}

					// 2.??????????????????
					for (int i = 0, j = 0; i < result.size();) {
						arrays.get(j).add(result.get(i++));
						if (i % 9 == 0)
							j++;
					}

					// ????????????????????????
					if (arrays.size() == 0) {
						request.getSession().setAttribute("articles", new ArrayList<Article>());
						request.getSession().setAttribute("page_quantity", 0);
						request.getSession().setAttribute("current_page", 0);
						response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
						return;
					}

					// ???????????????
					Integer current_page = null;
					if (request.getParameter("current_page") == null) {
						// ??????????????????
						request.getSession().setAttribute("articles", arrays.get(0));
						request.getSession().setAttribute("page_quantity", page_quantity);
						request.getSession().setAttribute("current_page", 0);
						response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
						return;
					} else {
						current_page = Integer.parseInt(request.getParameter("current_page"));
					}

					// ??????????????????
					if (request.getParameter("page_index").equals("next")) {
						if ((current_page + 1) == page_quantity) {
							// ??????????????????
							request.getSession().setAttribute("articles", arrays.get(0));
							request.getSession().setAttribute("page_quantity", page_quantity);
							request.getSession().setAttribute("current_page", 0);
							response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
							return;
						} else {
							// ????????????????????????????????????????????????
							request.getSession().setAttribute("articles", arrays.get(current_page + 1));
							request.getSession().setAttribute("page_quantity", page_quantity);
							request.getSession().setAttribute("current_page", current_page + 1);
							response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
							return;
						}
					}

					// ??????????????????
					if (request.getParameter("page_index").equals("prior")) {
						if ((current_page - 1) == -1) {
							// ?????????????????????
							request.getSession().setAttribute("articles", arrays.get(page_quantity - 1));
							request.getSession().setAttribute("page_quantity", page_quantity);
							request.getSession().setAttribute("current_page", page_quantity - 1);
							response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
							return;
						} else {
							// ????????????????????????????????????????????????
							request.getSession().setAttribute("articles", arrays.get(current_page - 1));
							request.getSession().setAttribute("page_quantity", page_quantity);
							request.getSession().setAttribute("current_page", current_page - 1);
							response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
							return;
						}
					}

					// ??????????????????
					int page_index = Integer.parseInt(request.getParameter("page_index"));
					request.getSession().setAttribute("articles", arrays.get(page_index));
					request.getSession().setAttribute("page_quantity", page_quantity);
					request.getSession().setAttribute("current_page", page_index);
					response.sendRedirect("/cos/system/departmentHead/article.jsp?title=" + subId);
					sqlSession.close();
					return;
					// return;
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
