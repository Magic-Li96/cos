package cos.servlet.departmentHead.article.manage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuozhengsoft.moboffice.FileSaver;
import com.zhuozhengsoft.pageoffice.PageOfficeCtrl;

/**
 * Servlet implementation class SaveArticle
 */
@WebServlet("/saveArticle")
public class SaveArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String src = (String)request.getSession().getAttribute("savePath");
		PageOfficeCtrl poCtrl=(PageOfficeCtrl)request.getSession().getAttribute("poCtrl");
		request.setAttribute("poCtrl", poCtrl);
		System.out.println(src);
		FileSaver fs = new FileSaver(request, response);
		fs.saveToFile(src);
		fs.close();
		
	}

}
