package kr.co.foody.mypage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageMapper {

	// 나의 레시피 리스트
	List<MypageVO> myRecipe(MypageVO vo);
	int myRecipeCount(int no);
	
	// 최근 본 레시피 리스트
	List<MypageVO> recentRecipe(MypageVO vo);
	int recentRecipeCount(int no);
	
	// 즐겨찾기 레시피 리스트
	List<MypageVO> likeRecipe(MypageVO vo);
	int likeRecipeCount(int no);
	
	// 알러지, 선호음식 리시트
	List<MypageVO> allergyList(int no);
	List<MypageVO> preferList(int no);
	
	// 회원의 레시피 삭제
	int deleteRecipe(int no);
	
	// 마이페이지 정보
	Integer userRecipeCount(int no); 
	Integer userBookmarkCount(int no); 
	Integer userTotalViewCount(int no); 
	Integer userCommentCount(int no); 
	
}
	