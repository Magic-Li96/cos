package cos.dao;

import cos.bean.MessageState;
import java.util.List;

public interface MessageStateMapper {
    int deleteByPrimaryKey(Integer messageStateId);

    int insert(MessageState record);

    MessageState selectByPrimaryKey(Integer messageStateId);

    List<MessageState> selectAll();

    int updateByPrimaryKey(MessageState record);
}