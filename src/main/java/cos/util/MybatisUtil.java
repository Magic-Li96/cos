package cos.util;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;


public class MybatisUtil {
	
	private static SqlSessionFactory getSqlSessionFactory() throws Exception {
		
		String resource = "mybatis-config.xml";
		InputStream inputStream = Resources.getResourceAsStream(resource);
		return new SqlSessionFactoryBuilder().build(inputStream);
	
	}
	
	public static SqlSession openSqlSession() throws Exception {
		return getSqlSessionFactory().openSession();
	}
	
	public static SqlSession openSqlSession(boolean tag) throws Exception {
		return getSqlSessionFactory().openSession(tag);
	}
	
}
