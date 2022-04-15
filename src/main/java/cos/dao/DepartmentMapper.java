package cos.dao;

import cos.bean.Department;
import java.util.List;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Integer departmentId);

    int insert(Department record);

    Department selectByPrimaryKey(Integer departmentId);

    List<Department> selectAll();

    int updateByPrimaryKey(Department record);
}