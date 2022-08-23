package kr.co.foody.mypage;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface MypageService {

	public Map<String, Object> mypage(HttpSession sess);
	
}
