package kr.co.foody.recipe;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IngredientMapper {
	
	int insert(RecipeVO vo);
}
