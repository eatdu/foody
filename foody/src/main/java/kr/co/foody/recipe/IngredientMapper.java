package kr.co.foody.recipe;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.foody.recipe.IngredientVO;

@Mapper
public interface IngredientMapper {
	
	int insert(RecipeVO vo);
	List<String> large_cate(int large_cate);
	List<IngredientVO> detail_cate(String detail_cate);
	List<IngredientVO>nameSearch();
	
	IngredientVO ingreInfo(int no);
	IngredientVO ingreInfoWithName(int no);
	
}
