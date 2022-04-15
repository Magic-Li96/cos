package cos.dao;

import cos.bean.Article;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ArticleMapper {
    int deleteByPrimaryKey(@Param("course") Integer course, @Param("department") Integer department, @Param("subject") Integer subject);

    int insert(Article record);

    Article selectByPrimaryKey(@Param("course") Integer course, @Param("department") Integer department, @Param("subject") Integer subject);

    List<Article> selectAll();

    int updateByPrimaryKey(Article record);
}