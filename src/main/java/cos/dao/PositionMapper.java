package cos.dao;

import java.util.List;

import cos.bean.Position;

public interface PositionMapper {
    int deleteByPrimaryKey(Integer positionId);

    int insert(Position record);

    Position selectByPrimaryKey(Integer positionId);
    
    Position selectByPositionName(String positionName);

    int updateByPrimaryKey(Position record);
    
    List<Position> selectAllPosition();
}