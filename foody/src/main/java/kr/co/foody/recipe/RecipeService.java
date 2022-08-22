package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface RecipeService {
	
	int insert(RecipeVO vo);
	List<String> large_cate(int i);
	RecipeVO view(int no);
	
	Map search(Map cri, HttpSession sess); 
	
	List<Map> makeIngreNameList(int no);
	List<Map> makeIngreNameList(String keyword);
	List<Map> makeIngreDetailList(String keyword);
	
}
