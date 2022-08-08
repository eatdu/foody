package kr.co.foody.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import util.SendMail;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper mapper;
	
	@Override
	public int insert(UserVO vo) { // 회원가입
		return mapper.insert(vo);
	}

	@Override
	public UserVO selectOne(int no) { // 미정
		return mapper.selectOne(no);
	}

	@Override
	public int emailDupCheck(String email) { // 이메일 중복체크
		return mapper.emailDupCheck(email);
	}
	
	@Override
	public int nik_nameDupCheck(String nik_name) { // 닉네임 중복체크
		return mapper.nik_nameDupCheck(nik_name);
	}

	@Override
	public int telDupCheck(String tel) { // 전화번호 중복체크
		return mapper.telDupCheck(tel);
	}
	
	@Override
	public boolean loginCheck(UserVO vo, HttpSession sess) {
		boolean r = false;
		UserVO loginInfo = mapper.loginCheck(vo);
		if(mapper.loginCheck(vo) != null) {
			r = true;
			sess.setAttribute("loginInfo", loginInfo);
		}
		return r;
	}

	@Override
	public UserVO findEmail(UserVO vo) {
		return mapper.findEmail(vo);
	}

	@Override
	public UserVO findPwd(UserVO vo) {
		// update
		UserVO mv = mapper.findEmail(vo);
		if(mv != null) {
			// 임시비밀번호 생성
			// 영문두자리, 숫자두자리
			String temp = "";
			for (int i=0; i<2; i++) {
				temp += (char)(Math.random()*26+65);
			}
			for (int i=0; i<2; i++) {
				temp += (int)(Math.random()*9);
			}
			// 임시비밀번호 update
			vo.setPwd(temp); // 임시비밀번호를 DB에 저장
			mapper.updateTempPwd(vo);
			
			// email발송
			SendMail.sendMail("2do2023@naver.com", vo.getEmail(), "[더좋은]임시비밀번호", "임시비밀번호:"+temp);
			return mv;
		} else {
			return null;
		}
	}



	
}
