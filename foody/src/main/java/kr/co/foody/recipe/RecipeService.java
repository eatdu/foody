package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface RecipeService {
	
	int insert(Map cri);
	int insertProcess(Map cri);
	int insertIngredient(Map cri);
	
	Map viewRecipe(int no, HttpSession sess);
	Map viewModify(int no);
	int updateRecipe(Map cri);
	int deleteIngredient(int no);
	int deleteProcess(int no);
	
	List<String> large_cate(int i);
	Map search(Map cri, Model model, HttpSession sess); 
	
	List<Map> makeIngreNameList(int no);
	List<Map> makeIngreNameList(Map cri);
	List<Map> makeIngreDetailList(String keyword);
	
	int insertBmk(Map bmk);
	int deleteBmk(Map bmk);
	
}
