package kr.co.foody.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.user.UserMapper;
import kr.co.foody.user.UserVO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	MypageMapper mapper;
	@Autowired
	UserMapper umapper;

	@Override // 마이페이지 메인 정보 조회
	public Map<String, Object> mypage(HttpSession sess) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		Integer userRecipeCount = mapper.userRecipeCount(uv.getNo());
		Integer userBookmarkCount = mapper.userBookmarkCount(uv.getNo());
		Integer userTotalViewCount = mapper.userTotalViewCount(uv.getNo());
		Integer userCommentCount = mapper.userCommentCount(uv.getNo());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userRecipeCount", userRecipeCount); // 회원이 작성한 레시피 카운트
		map.put("userBookmarkCount", userBookmarkCount); // 회원의 레시피에 달린 북마크 카운트
		map.put("userTotalViewCount", userTotalViewCount); // 회원의 레피시들의 조회수 카운트
		map.put("userCommentCount", userCommentCount); // 회원의 레시피에 달린 댓글 카운트
		return map;
	}

	
	@Override // 내가 작성한 레시피 정보 조회
	public Map<String, Object> myRecipe(HttpSession sess, MypageVO vo) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		int totalCount = mapper.myRecipeCount(vo.getUser_no());
		vo.pagingProcess(15,totalCount); // 페이지당 15개의 리스트 , total레시피수(페이징)
		List<MypageVO> myRecipeList = mapper.myRecipe(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("myList", myRecipeList);
		return map;
	}
	
	@Override // 최근 본 레시피 정보 조회
	public Map<String, Object> recentRecipe(HttpSession sess, MypageVO vo) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		int totalCount = mapper.recentRecipeCount(vo.getUser_no());
		vo.pagingProcess(15,totalCount); // 페이지당 15개의 리스트 , total레시피수(페이징)
		List<MypageVO> recentRecipeList = mapper.recentRecipe(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recipeList", recentRecipeList);
		return map;
	}
	
	@Override // 찜한 레시피 정보 조회
	public Map<String, Object> likeRecipe(HttpSession sess, MypageVO vo) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		int totalCount = mapper.likeRecipeCount(vo.getUser_no());
		vo.pagingProcess(15,totalCount); // 페이지당 15개의 리스트 , total레시피수(페이징)
		List<MypageVO> likeRecipeList = mapper.likeRecipe(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("likeList", likeRecipeList);
		return map;
	}

	@Override // 회원정보 조회 페이지
	public Map<String, Object> userInfo(HttpSession sess) {
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		UserVO uvl = umapper.selectOne(uv.getNo());
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
		map.put("uv", uvl);
		
		return map;
	}

	@Override // 레시피 삭제
	public boolean deleteRecipe(int no) {
		return mapper.deleteRecipe(no) > 0 ? true : false;
	}
	
	


}
