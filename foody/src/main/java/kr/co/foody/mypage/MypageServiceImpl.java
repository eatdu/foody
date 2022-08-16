package kr.co.foody.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.user.UserVO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	MypageMapper mapper;

	@Override
	public Map<String, Object> index(MypageVO vo, HttpSession sess) {
		// 레시피에 대한 데이터 받아옴
		List<MypageVO> list = mapper.myRecipe(vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		
		return map;
	}

	@Override
	public Map<String, Object> myInfo(HttpSession sess) {
			// 회원에 대한 하루평균섭취 칼로리 산식(세션에서 회원데이터 받음)
			UserVO uv = (UserVO)sess.getAttribute("loginInfo");
			String gVal = uv.getBirth().substring(6, 7);
			int g = 21;
			if (gVal.equals("1") || gVal.equals("3")) {
				g = 22;
			}
			int cal = (int)(uv.getHeight()/100 * uv.getHeight()/100 * g * uv.getActivity());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cal", cal);
		
		return map;
	}


}
