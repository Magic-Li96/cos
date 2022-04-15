package cos.util;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import cos.dao.CourseTypeMapper;

public final class CourseType {
	
	public static HashMap<Integer, String> ct=new HashMap<>();
	
	static {
		SqlSession sqlSession;
		try {
			sqlSession = MybatisUtil.openSqlSession();
			CourseTypeMapper courseTypeMapper = sqlSession.getMapper(CourseTypeMapper.class);
			List<cos.bean.CourseType> courseTypes = courseTypeMapper.selectAll();
			for (cos.bean.CourseType courseType : courseTypes) {
				ct.put(courseType.getCourseTypeId(), courseType.getCourseTypeName());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} 
	
}
