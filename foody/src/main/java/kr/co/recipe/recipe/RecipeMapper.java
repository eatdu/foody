package kr.co.recipe.recipe;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecipeMapper {

	int insert(RecipeVO vo);
	
}
