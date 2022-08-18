package kr.co.foody.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface UserService {

	UserVO selectOne(int no);
	int emailDupCheck(String email);
	int nik_nameDupCheck(String nik_name);
	int telDupCheck(String tel);
	int insert(UserVO vo);
	boolean loginCheck(UserVO vo, HttpSession sess);
	UserVO findEmail(UserVO vo);
	//UserVO findPwd(UserVO vo);
	int prefer(UserVO vo);
	int signUpNext(UserVO vo);
	List<String> getAllergy();
	int userAllergy(UserVO vo);
	int userPrefer(UserVO vo);
	
	Map<String, Object> modify(HttpSession sess);
}
