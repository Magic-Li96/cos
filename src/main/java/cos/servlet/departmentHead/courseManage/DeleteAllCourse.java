package cos.servlet.departmentHead.courseManage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.mysql.jdbc.Driver;

import cos.util.DButil;

/**
 * Servlet implementation class DeleteCourse
 */
@WebServlet("/deleteAllCourse")
public class DeleteAllCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int subject = Integer.parseInt(request.getParameter("subId"));
			
			Driver driver = new Driver();
			Connection connection = DriverManager.getConnection(DButil.DB_URL,DButil.USER,DButil.PASS);

			Statement st = connection.createStatement();
			st.execute("delete from course where subject = "+subject);
			
			response.sendRedirect("/cos/showCourse?subId="+subject);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
