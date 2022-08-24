package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface RecipeService {
	
	int insert(Map cri);
	int insertProcess(Map cri);
	int insertIngredient(Map cri);
	
	List<String> large_cate(int i);
	RecipeVO view(int no);
	
	Map search(Map cri, Model model, HttpSession sess); 
	
	List<Map> makeIngreNameList(int no);
	List<Map> makeIngreNameList(String keyword);
	List<Map> makeIngreDetailList(String keyword);
	
}
