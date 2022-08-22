package kr.co.foody.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.co.foody.recipe.IngredientVO;

public interface AdminService {
	//재료 정보 관련
	IngredientVO ingreInfo(int no);
	List<String> makeAllergyList();
	
	//가입자 통계 관련
	boolean userReport(HttpSession sess);
	
	// 회원 목록
	Map<String, Object> userList();
	//레시피 통계 관련
	boolean rcpCount(Map cri, HttpSession sess);
}
