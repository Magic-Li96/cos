package cos.util;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import cos.bean.Institute;
import cos.dao.InstituteMapper;

public final class Institute_data {
	public static HashMap<Integer, String> is = new HashMap<>();

	static {
		SqlSession sqlSession;
		try {
			sqlSession = MybatisUtil.openSqlSession();
			InstituteMapper instituteMapper = sqlSession.getMapper(InstituteMapper.class);
			List<cos.bean.Institute> institutes = instituteMapper.selectAllInstitute();
			for (Institute institute : institutes) {
				is.put(institute.getInstituteId(),institute.getInstituteName());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
