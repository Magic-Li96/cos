package cos.servlet.institute;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import cos.bean.Article;
import cos.bean.User;
import cos.dao.ArticleMapper;
import cos.dao.PositionMapper;
import cos.dao.UserMapper;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class InstituteWorkerOfStatistical
 */
@WebServlet("/instituteWorkerOfStatistical")
public class InstituteWorkerOfStatistical extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	class InsUser{
		
		String userId;
		int articleSum=0;
		String username;
		String position;

		@Override
		public String toString() {
			return "InsUser [userId=" + userId + ", articleSum=" + articleSum + ", username=" + username + ", position="
					+ position + "]";
		}
		
	}
	
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			SqlSession sqlSession = MybatisUtil.openSqlSession();
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			PositionMapper positionMapper = sqlSession.getMapper(PositionMapper.class);
			ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
			List<User> users = userMapper.selectAll();
			
			ArrayList<InsUser> us = new ArrayList<InsUser>();
			for (User u : users) {
				if (u.getInstitute().equals(user.getInstitute())) {
					InsUser insUser = new InsUser();
					insUser.userId=u.getUserId();
					insUser.username=u.getUserName();
					insUser.position=positionMapper.selectByPrimaryKey(u.getPosition()).getPositionName();
					us.add(insUser);
				}
			}
			
			List<Article> articles = articleMapper.selectAll();
			for (Article article : articles) {
				for (InsUser insUser : us) {
					if (insUser.userId.equals(article.getTeacher())) {
						insUser.articleSum++;
					}
				}
			}
			
			//??????excel??????
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("?????????????????????????????????");
			HSSFRow title = sheet.createRow(0);
			HSSFCell c1 = title.createCell(0);
			c1.setCellValue("??????");
			HSSFCell c2 = title.createCell(1);
			c2.setCellValue("??????");
			HSSFCell c3 = title.createCell(2);
			c3.setCellValue("??????");
			HSSFCell c4 = title.createCell(3);
			c4.setCellValue("?????????????????????");
			for (int i = 0; i < us.size(); i++) {
				HSSFRow row = sheet.createRow(i+1);
				HSSFCell cell_1 = row.createCell(0);
				cell_1.setCellValue(us.get(i).username);
				HSSFCell cell_2 = row.createCell(1);
				cell_2.setCellValue(us.get(i).userId);
				HSSFCell cell_3 = row.createCell(2);
				cell_3.setCellValue(us.get(i).position);
				HSSFCell cell_4 = row.createCell(3);
				cell_4.setCellValue(us.get(i).articleSum);
			}
			
			ServletOutputStream outputStream = response.getOutputStream();
			response.reset();
			response.setHeader("Content-disposition","attachment; filename=statistical.xls");
			response.setContentType("application/msexcel");
			workbook.write(outputStream);
			outputStream.close();
			sqlSession.close();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
	}
	
}
