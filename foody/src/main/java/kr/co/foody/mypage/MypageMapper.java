package kr.co.foody.mypage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageMapper {

	List<MypageVO> myRecipe(int no);
	
	List<MypageVO> allergyList(int no);
	
	List<MypageVO> preferList(int no);
	
}
	