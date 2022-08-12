package kr.co.foody.recipe;

import java.util.List;

public interface RecipeService {
	
	int insert(RecipeVO vo);
	List<String> large_cate(int i);

}
