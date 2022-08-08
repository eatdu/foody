package kr.co.foody.recipe;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecipeMapper {
	
	int insert(RecipeVO vo);
}
