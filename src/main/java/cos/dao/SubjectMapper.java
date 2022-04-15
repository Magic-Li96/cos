package cos.dao;

import cos.bean.Subject;
import java.util.List;

public interface SubjectMapper {
    int deleteByPrimaryKey(Integer subjectId);

    int insert(Subject record);

    Subject selectByPrimaryKey(Integer subjectId);

    List<Subject> selectAll();

    int updateByPrimaryKey(Subject record);
    
    int updateByName(Subject record);
}