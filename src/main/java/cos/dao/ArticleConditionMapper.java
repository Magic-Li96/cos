package cos.dao;

import cos.bean.ArticleCondition;
import java.util.List;

public interface ArticleConditionMapper {
    int deleteByPrimaryKey(Integer articleConditionId);

    int insert(ArticleCondition record);

    ArticleCondition selectByPrimaryKey(Integer articleConditionId);

    List<ArticleCondition> selectAll();

    int updateByPrimaryKey(ArticleCondition record);
}