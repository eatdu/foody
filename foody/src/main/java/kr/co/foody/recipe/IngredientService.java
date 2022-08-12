package kr.co.foody.recipe;

import java.util.List;

public interface IngredientService {
	
	List<String> large_cate(int large_cate);
	List<IngredientVO> detail_cate(String detail_cate);
	List<IngredientVO> nameSearch();
}
