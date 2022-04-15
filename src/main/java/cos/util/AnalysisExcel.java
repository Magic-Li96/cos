package cos.util;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;

import com.mysql.jdbc.Driver;

import cos.bean.Article;
import cos.bean.Course;
import cos.dao.ArticleMapper;
import cos.dao.CourseMapper;

public class AnalysisExcel {

	public AnalysisExcel() {

	}

	/**
	 * 获取合并单元格的值
	 * 
	 * @param sheet
	 * @param row
	 * @param column
	 * @return
	 */
	public String getMergedRegionValue(Sheet sheet, int row, int column) {
		int sheetMergeCount = sheet.getNumMergedRegions();

		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress ca = sheet.getMergedRegion(i);
			int firstColumn = ca.getFirstColumn();
			int lastColumn = ca.getLastColumn();
			int firstRow = ca.getFirstRow();
			int lastRow = ca.getLastRow();

			if (row >= firstRow && row <= lastRow) {
				if (column >= firstColumn && column <= lastColumn) {
					Row fRow = sheet.getRow(firstRow);
					Cell fCell = fRow.getCell(firstColumn);

					return fCell.getStringCellValue();
				}
			}
		}

		return null;
	}

	/**
	 * 判断是否为合并单元格的
	 * 
	 * @param sheet
	 * @param row
	 * @param column
	 * @return
	 */
	public boolean isMergedRegion(Sheet sheet, int row, int column) {
		int sheetMergeCount = sheet.getNumMergedRegions();

		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress ca = sheet.getMergedRegion(i);
			int firstColumn = ca.getFirstColumn();
			int lastColumn = ca.getLastColumn();
			int firstRow = ca.getFirstRow();
			int lastRow = ca.getLastRow();

			if (row >= firstRow && row <= lastRow) {
				if (column >= firstColumn && column <= lastColumn) {
					return true;
				}
			}
		}

		return false;
	}

	/**
	 * 返回课程编号单元格值
	 * 
	 * @param sheet
	 * @param row
	 * @param colume
	 * @return
	 */
	public String getCourseIdValue(Sheet sheet, int row, int colume) {
		Cell cell = sheet.getRow(row).getCell(colume);
		if (Cell.CELL_TYPE_NUMERIC == cell.getCellType()) {
			Integer value = (int) cell.getNumericCellValue();
			return value.toString();
		} else {
			return cell.getStringCellValue().split("[-]")[0];
		}
	}

	/**
	 * 返回数值单元格值
	 * 
	 * @param sheet
	 * @param row
	 * @param colume
	 * @return
	 */
	public Double getNumberValue(Sheet sheet, int row, int colume) {
		return sheet.getRow(row).getCell(colume).getNumericCellValue();
	}

	/**
	 * 返回字符串单元格值
	 * 
	 * @param sheet
	 * @param row
	 * @param colume
	 * @return
	 */
	public String getStringValue(Sheet sheet, int row, int colume) {
		return sheet.getRow(row).getCell(colume).getStringCellValue();
	}

	public void analysis(String path, int department_id, int institute) throws Exception {
		String fileName = path.split("\\\\")[path.split("\\\\").length - 1];

		// 1.subject
		Integer sub_id = Integer.parseInt(fileName.split("[-]")[0]);
		// 2.department
		Integer department = department_id;
		// 3.institute
		Integer institute_id = institute;

		FileInputStream fis = new FileInputStream(path);
		Workbook workbook = new HSSFWorkbook(fis);
		Sheet sheet = workbook.getSheetAt(1);

		Driver driver = new Driver();
		Connection connection = DriverManager.getConnection(DButil.DB_URL, DButil.USER, DButil.PASS);
		connection.setAutoCommit(false);
		
		Statement statement = connection.createStatement();
		statement.execute("delete from course where subject = "+sub_id);
		connection.commit();
		statement.close();

		String sql = "insert into course(course_id,department,subject,course_name,institute,start_institute,priority,all_class_hours,credit,course_type) values(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = connection.prepareStatement(sql);
		// 解析并存入通识课程
		int row = 5;
		
		while (true) {
			
			//终止条件
			if (isMergedRegion(sheet, row, 3) && getMergedRegionValue(sheet, row, 3).equals("合计")) {
				break;
			}
			
			//隐藏行跳过
			if ((sheet.getRow(row).getZeroHeight())==true) {
				row++;
				continue;
			}
			
			//C_ID单元格为合并单元格，行跳过
			if (isMergedRegion(sheet, row, 3)) {
				row++;
				continue;
			}

			if (getCourseIdValue(sheet, row, 3)==null || getCourseIdValue(sheet, row, 3).isEmpty()) {
				row++;
				continue;
			}
			
			// course_id
			int c_id = Integer.parseInt(getCourseIdValue(sheet, row, 3));
			// course_name
			String c_name = getStringValue(sheet, row, 4);
			// credit
			Double credit = getNumberValue(sheet, row, 5);
			// all_class_hours
			int ach = (int) (double) getNumberValue(sheet, row, 6);
			// start_institute
			int start_institute = 0;
			if (isMergedRegion(sheet, row, 19)) {
				String startInstitute = getMergedRegionValue(sheet, row, 19);
				HashMap<Integer, String> isMap = Institute_data.is;
				Set<Entry<Integer, String>> isSet = isMap.entrySet();
				for (Entry<Integer, String> entry : isSet) {
					if (entry.getValue().equals(startInstitute)) {
						start_institute=entry.getKey();
					}
				}
			}else {
				String startInstitute = getStringValue(sheet, row, 19);
				HashMap<Integer, String> isMap = Institute_data.is;
				Set<Entry<Integer, String>> isSet = isMap.entrySet();
				for (Entry<Integer, String> entry : isSet) {
					if (entry.getValue().equals(startInstitute)) {
						start_institute=entry.getKey();
					}
				}
			}
			
			// 优先级
			int priority = 0;
			for (int colume = 11, p = 1; colume <= 18; colume++, p++) {
				if (!getStringValue(sheet, row, colume).isEmpty()) {
					priority = p;
					break;
				}
			}
			ps.setInt(1, c_id);
			ps.setInt(2, department);
			ps.setInt(3, sub_id);
			ps.setString(4, c_name);
			ps.setInt(5, institute);
			ps.setInt(6, start_institute);
			ps.setInt(7, priority);
			ps.setInt(8, ach);
			ps.setDouble(9, credit);
			String courseType = getMergedRegionValue(sheet, row, 0);
			HashMap<Integer, String> ctMap = CourseType.ct;
			Set<Entry<Integer, String>> ctSet = ctMap.entrySet();
			for (Entry<Integer, String> entry : ctSet) {
				if (entry.getValue().equals(courseType)) {
					ps.setInt(10, entry.getKey());
				}
			}
			ps.addBatch();

			row++;
		}

		ps.executeBatch();
		connection.commit();
		connection.close();

		insertArticle(sub_id);
	}

	public void insertArticle(int subject) throws Exception {
		SqlSession sqlSession = MybatisUtil.openSqlSession();
		CourseMapper courseMapper = sqlSession.getMapper(CourseMapper.class);
		ArticleMapper articleMapper = sqlSession.getMapper(ArticleMapper.class);
		List<Course> courses = courseMapper.selectAll();
		for (Course course : courses) {
			if (course.getSubject().equals(subject)) {
				Article record = new Article();
				record.setpId(course.getpId());
				record.setCourse(course.getCourseId());
				record.setDepartment(course.getDepartment());
				record.setSubject(course.getSubject());
				record.setArticleName(course.getCourseName());
				record.setContidion(1);
				record.setStartInstitute(course.getStartInstitute());
				record.setInstitute(course.getInstitute());
				articleMapper.insert(record);
			}
		}
		sqlSession.commit();
		sqlSession.close();
	}
}
