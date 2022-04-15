package cos.dao;

import cos.bean.Course;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CourseMapper {
    int deleteByPrimaryKey(@Param("courseId") Integer courseId, @Param("department") Integer department, @Param("subject") Integer subject);

    int insert(Course record);

    Course selectByPrimaryKey(@Param("courseId") Integer courseId, @Param("department") Integer department, @Param("subject") Integer subject);

    List<Course> selectAll();

    int updateByPrimaryKey(Course record);
}