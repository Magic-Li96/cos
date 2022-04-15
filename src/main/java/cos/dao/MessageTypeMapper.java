package cos.dao;

import cos.bean.MessageType;
import java.util.List;

public interface MessageTypeMapper {
    int deleteByPrimaryKey(Integer messageTypeId);

    int insert(MessageType record);

    MessageType selectByPrimaryKey(Integer messageTypeId);

    List<MessageType> selectAll();

    int updateByPrimaryKey(MessageType record);
}