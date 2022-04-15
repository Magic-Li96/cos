package cos.dao;

import cos.bean.DepartmentHead;
import java.util.List;

public interface DepartmentHeadMapper {
    int deleteByPrimaryKey(Integer departmentId);
    
    int deleteByUserId(String userId);

    int insert(DepartmentHead record);

    DepartmentHead selectByPrimaryKey(Integer departmentId);

    List<DepartmentHead> selectAll();

    int updateByPrimaryKey(DepartmentHead record);
}