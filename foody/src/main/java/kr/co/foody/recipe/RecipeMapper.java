package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecipeMapper {

	int insert(RecipeVO vo);

	List<IngredientVO> selectIngreList(int no);
	
	List<RecipeVO> selectRecipeListWithCri(Map map);
}
