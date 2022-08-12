package kr.co.recipe.recipe;

import java.util.List;

public interface RecipeService {
	
	int insert(RecipeVO vo);
	List<String> large_cate(int i);

}
