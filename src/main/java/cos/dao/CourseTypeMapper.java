package cos.dao;

import cos.bean.CourseType;
import java.util.List;

public interface CourseTypeMapper {
    int deleteByPrimaryKey(Integer courseTypeId);

    int insert(CourseType record);

    CourseType selectByPrimaryKey(Integer courseTypeId);

    List<CourseType> selectAll();

    int updateByPrimaryKey(CourseType record);
}