package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;


public interface RecipeService {

	int insert(RecipeVO vo);
	List<String> large_cate(int i);
	
	List<RecipeVO> selectRecipeListWithCri(Map cri);

	Map search(Map cri); 
	
	List<Map> makeIngreNameList(int no);
	
}
