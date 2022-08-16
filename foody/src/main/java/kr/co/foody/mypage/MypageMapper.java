package kr.co.foody.mypage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageMapper {

	List<MypageVO> myRecipe(MypageVO vo);
	
	int bookmark(int rno);
	
	
	
	MypageVO allergyList(MypageVO vo); 
	
}
	