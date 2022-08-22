package kr.co.foody.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import kr.co.foody.recipe.IngredientVO;

public interface AdminService {
	//재료 정보 관련
	IngredientVO ingreInfo(int no);
	List<String> makeAllergyList();
	
	//가입자 통계 관련
	boolean userReport(HttpSession sess);
	
	//레시피 통계 관련
	boolean rcpCount(Map cri, HttpSession sess);
	
	//레시피 목록 조회
	boolean selectRcpAdmin(Map cri, Model model);
}
