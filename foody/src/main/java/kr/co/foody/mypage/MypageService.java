package kr.co.foody.mypage;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface MypageService {

	Map<String, Object> myRecipe(HttpSession sess, MypageVO vo);
	Map<String, Object> recentRecipe(HttpSession sess, MypageVO vo);
	Map<String, Object> likeRecipe(HttpSession sess, MypageVO vo);
	Map<String, Object> userInfo(HttpSession sess);
	boolean deleteRecipe(int no);
	
	
}
