package kr.co.foody.user;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.foody.mypage.MypageVO;

@Mapper
public interface UserMapper {

	UserVO selectOne(int no);
	int insert(UserVO vo);
	int emailDupCheck(String email);
	int nik_nameDupCheck(String nik_name);
	int telDupCheck(String tel);
	UserVO loginCheck(UserVO vo);
	UserVO findEmail(UserVO vo);
	UserVO pwdEmail(UserVO vo);
	int updateTempPwd(UserVO vo);
	int prefer(UserVO vo);
	int insertAdd(UserVO vo);
	List<UserVO> getAllergy();
	int userAllergy(UserVO vo);
	int userPrefer(UserVO vo);
	
	
	// 회원의 알레르기, 선호음식 no 조회
	List<Integer> allergyNoList(int no);
	List<Integer> preferNoList(int no);
	
	// 회원의 알레르기, 선호음식 리스트 조회
	List<MypageVO> allergyList(int no);
	List<MypageVO> preferList(int no);
	
}
