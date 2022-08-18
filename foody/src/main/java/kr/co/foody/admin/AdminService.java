package kr.co.foody.admin;

import java.util.List;
import java.util.Map;

import kr.co.foody.recipe.IngredientVO;

public interface AdminService {
	IngredientVO ingreInfo(int no);
	List<String> makeAllergyList();
}
