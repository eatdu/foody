package kr.co.foody.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import kr.co.foody.recipe.IngredientVO;
import kr.co.foody.user.UserVO;

public interface AdminService {
	//재료 정보 관련
	IngredientVO ingreInfo(int no);
	List<String> makeAllergyList();
	
	//가입자 통계 관련
	boolean userReport(HttpSession sess);
	//레시피 통계 관련
	boolean rcpCount(Map cri, HttpSession sess);
	
	Map<String, Object> userList(UserVO vo);
	//레시피 목록 조회
	boolean selectRcpAdmin(Map cri, Model model);
	
	boolean exitUserList(HttpSession sess);
	//레시피 상세보기시 프로세스
	void rcpDetail(int no);
}
