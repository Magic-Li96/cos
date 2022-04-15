package cos.dao;

import java.util.List;

import cos.bean.Institute;

public interface InstituteMapper {
    
	int deleteByPrimaryKey(Integer instituteId);

    int insert(Institute record);

    Institute selectByPrimaryKey(Integer instituteId);
    
    Institute selectByInstituteName(String instituteName);

    int updateByPrimaryKey(Institute record);
    
    List<Institute> selectAllInstitute();
    
}