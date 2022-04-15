package cos.servlet.departmentHead.courseManage;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.ibatis.session.SqlSession;

import cos.bean.DepartmentHead;
import cos.bean.User;
import cos.dao.DepartmentHeadMapper;
import cos.util.AnalysisExcel;
import cos.util.MybatisUtil;

/**
 * Servlet implementation class CourseMessageBatchInsertModel
 */
@WebServlet("/courseMessageBatchInsertModel")

// 使用注解@MultipartConfig将一个Servlet标识为支持文件上传
@MultipartConfig
public class CourseMessageBatchInsertModel extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String User = null;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response){
		doPost(request, response);
	}

	/**
	 * 上传数据及保存文件
	 * 
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		
		SqlSession sqlSession=null;
		
		User user = (User)request.getSession().getAttribute("user");
		int department_id = 0;
		int instiute_id = user.getInstitute();
		
		
		String fileName=null;
		try {
			sqlSession = MybatisUtil.openSqlSession();
			DepartmentHeadMapper departmentHeadMapper = sqlSession.getMapper(DepartmentHeadMapper.class);
			List<DepartmentHead> departmentHeads = departmentHeadMapper.selectAll();
			for (DepartmentHead departmentHead : departmentHeads) {
				if (departmentHead.getDepartmentHeadId().equals(user.getUserId())){
					department_id=departmentHead.getDepartmentId();
				}
			}
			
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			
			// 临时存储路径
			String savePath = request.getServletContext().getRealPath("/WEB-INF/uploadFile");
			
			// 获取上传的文件集合
			Collection<Part> parts = request.getParts();
			
			// 上传单个文件
			if (parts.size() == 1) {
				Part part = request.getPart("file");// 通过表单file控件(<input type="file" name="file">)的名字直接获取Part对象
				fileName = part.getSubmittedFileName();
				String path=savePath + File.separator + fileName;
				
				//判断是否重复导入，如果是重复导入，删除源文件
				File file = new File(path);
				if (file.exists()) {
					file.delete();
				}
				
				//把文件写到指定路径
				System.out.println("save file:"+path);
				part.write(path);
				new AnalysisExcel().analysis(path,department_id,instiute_id);
				// 解析处理该专业文件
				/**
				 * 
				 */
				// 跳转回该专业课程信息文件
				response.sendRedirect("/cos/showCourse?subId="+fileName.split("[-]")[0]);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
	}
}
