package kr.co.foody.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.user.UserVO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	MypageMapper mapper;

	@Override // 레시피에 대한 데이터 받아옴
	public Map<String, Object> index(MypageVO vo, HttpSession sess) {
		UserVO mvo = (UserVO)sess.getAttribute("loginInfo");
		
		// 레시피에 대한 값을 List에 담는다
		List<MypageVO> list = mapper.myRecipe((int)mvo.getNo());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		return map;
	}

	@Override // 회원에 대한 하루평균섭취 칼로리 산식(세션에서 회원데이터 받음)
	public Map<String, Object> myInfo(HttpSession sess) {
		// 회원의 로그인 정보를 세션에 저장
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		// 회원의 주민번호 7번째 자리를 가져온다
		String gVal = uv.getBirth().substring(6, 7);
		// 기본값으로 21 / 비교한 값(성별)이 1,3 이면 남성(22) 
		int g = 21;
		if (gVal.equals("1") || gVal.equals("3")) {
			g = 22;
		}
		// 하루평균권장 섭취량 공식 : 키/100 * 키/100 * g(남성=22/여성=21) * 활동지수
		int cal = (int)(uv.getHeight()/100 * uv.getHeight()/100 * g * uv.getActivity());

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
		map.put("cal", cal);
		map.put("allergyList", allergy); 
		map.put("preferList", prefer);
		
		return map;
	}

}
