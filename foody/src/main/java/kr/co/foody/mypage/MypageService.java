package kr.co.foody.mypage;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface MypageService {

	public Map<String, Object> index(MypageVO vo, HttpSession sess);
	public Map<String, Object> myInfo(MypageVO vo,HttpSession sess);
	
}
