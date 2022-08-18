package kr.co.foody.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.mypage.MypageVO;

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
	public boolean loginCheck(UserVO vo, HttpSession sess) { // 로그인성공시 세션에 회원데이터 저장
		boolean r = false;
		UserVO loginInfo = mapper.loginCheck(vo);
		if(mapper.loginCheck(vo) != null) {
			r = true;
			sess.setAttribute("loginInfo", loginInfo);
			
			// 로그인 성공시 회원에 대한 알레르기 정보 세션에 저장
			UserVO uv = (UserVO)sess.getAttribute("loginInfo");
			
			String gVal = uv.getBirth().substring(6, 7);
			// 기본값으로 21 / 비교한 값(성별)이 1,3 이면 남성(22) 
			int g = 21;
			if (gVal.equals("1") || gVal.equals("3")) {
				g = 22;
			}
			// 하루평균권장 섭취량 공식 : 키/100 * 키/100 * g(남성=22/여성=21) * 활동지수
			int cal = (int)(uv.getHeight()/100 * uv.getHeight()/100 * g * uv.getActivity());
			
			// 알러지no 세션에 저장
			List<Integer> allergyNo = mapper.allergyNoList(uv.getNo());
			// 선호음식no 세션에 저장
			List<Integer> preferNo = mapper.preferNoList(uv.getNo());
			sess.setAttribute("allergyNo", allergyNo);
			sess.setAttribute("preferNo", preferNo);
			sess.setAttribute("cal", cal);
		}
		return r;
	}

	@Override
	public UserVO findEmail(UserVO vo) { // 이메일 찾기
		return mapper.findEmail(vo);
	}

//	@Override
//	public UserVO findPwd(UserVO vo) { // 비밀번호 재설정(해당이메일로 임시비밀번호 전송 및 DB저장)
//		// update
//		UserVO mv = mapper.findEmail(vo);
//		if(mv != null) {
//			// 임시비밀번호 생성
//			// 영문두자리, 숫자두자리
//			String temp = "";
//			for (int i=0; i<2; i++) {
//				temp += (char)(Math.random()*26+65);
//			}
//			for (int i=0; i<2; i++) {
//				temp += (int)(Math.random()*9);
//			}
//			// 임시비밀번호 update
//			vo.setPwd(temp); // 임시비밀번호를 DB에 저장
//			mapper.updateTempPwd(vo);
//			
//			// email발송
//			SendMail.sendMail("2do2023@naver.com", vo.getEmail(), "[더좋은]임시비밀번호", "임시비밀번호:"+temp);
//			return mv;
//		} else {
//			return null;
//		}
//	}

	@Override
	public int prefer(UserVO vo) { 
		return mapper.prefer(vo);
	}

	@Override
	public int signUpNext(UserVO vo) {
		return mapper.insertAdd(vo);
	}

	@Override
	public int userAllergy(UserVO vo) {
		return mapper.userAllergy(vo);
	}
	
	@Override
	public int userPrefer(UserVO vo) {
		return mapper.userPrefer(vo);
	}

	@Override
	public List<String> getAllergy() {
		return mapper.getAllergy();
	}

	@Override
	public Map<String, Object> modify(HttpSession sess) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		
		// 회원가입시 유저가 선택한 알레르기에 대한 값들을 List에 담는다
		List<MypageVO> allergy = mapper.allergyList(uv.getNo());
		
		// 회원가입시 유저가 선택한 선호음식에 대한 값들을 List에 preferNo를 담는다
		List<MypageVO> preferNo = mapper.preferList(uv.getNo());
		List<String> prefer = new ArrayList<String>();
		// for문을 preferNo만큼 실행한다.
		for(int i=0; i<preferNo.size(); i++) {
			// 선택된 해당값들만 RcpCateArr배열에 index(-1)로 담는다
			prefer.add(RecipeCategory.RcpCateArr[(preferNo.get(i).getPrefer_food()) - 1]);		
		}
		
		// 출력된 값들을 map에 담아서 리턴해준다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allergyList", allergy); 
		map.put("preferList", prefer);
		
		return map;
	}





	
}
