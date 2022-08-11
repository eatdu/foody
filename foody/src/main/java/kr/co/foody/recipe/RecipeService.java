package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

public interface RecipeService {
	
	int insert(RecipeVO vo);

	Map search(Map cri); 
	
	List<Map> makeIngreNameList(int no);
	List<Map> makeIngreNameList(String keyword);
	
}
