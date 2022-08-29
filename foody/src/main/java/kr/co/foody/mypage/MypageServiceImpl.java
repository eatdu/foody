package kr.co.foody.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.user.UserVO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	MypageMapper mapper;


	@Override
	public Map<String, Object> mypage(HttpSession sess) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		int userRecipeCount = mapper.userRecipeCount(uv.getNo());
		int userBookmarkCount = mapper.userBookmarkCount(uv.getNo());
		int userTotalViewCount = mapper.userTotalViewCount(uv.getNo());
		int userCommentCount = mapper.userCommentCount(uv.getNo());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userRecipeCount", userRecipeCount);
		map.put("userBookmarkCount", userBookmarkCount);
		map.put("userTotalViewCount", userTotalViewCount);
		map.put("userCommentCount", userCommentCount);
		return map;
	}

	
	@Override
	public Map<String, Object> myRecipe(HttpSession sess, MypageVO vo) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		int totalCount = mapper.myRecipeCount(vo.getUser_no());
		vo.pagingProcess(12,totalCount);
		List<MypageVO> myRecipeList = mapper.myRecipe(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("myList", myRecipeList);
		return map;
	}
	
	@Override
	public Map<String, Object> recentRecipe(HttpSession sess, MypageVO vo) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		int totalCount = mapper.recentRecipeCount(vo.getUser_no());
		vo.pagingProcess(12,totalCount);
		List<MypageVO> recentRecipeList = mapper.recentRecipe(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recipeList", recentRecipeList);
		return map;
	}
	
	@Override
	public Map<String, Object> likeRecipe(HttpSession sess, MypageVO vo) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		int totalCount = mapper.likeRecipeCount(vo.getUser_no());
		vo.pagingProcess(12,totalCount);
		List<MypageVO> likeRecipeList = mapper.likeRecipe(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("likeList", likeRecipeList);
		return map;
	}

	@Override
	public Map<String, Object> userInfo(HttpSession sess) {
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
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allergy", allergy);
		map.put("prefer", prefer);
		map.put("cal", cal);
		
		return map;
	}

	@Override
	public boolean deleteRecipe(int no) {
		return mapper.deleteRecipe(no) > 0 ? true : false;
	}
	
	


}
