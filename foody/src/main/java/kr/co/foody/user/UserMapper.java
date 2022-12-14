package kr.co.foody.user;
import java.util.List;
import java.util.Map;

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
	
	// 회원 데이터 수정
	int modifyUserInfo(UserVO vo);
	int userAllergyDelete(int ano);
	int userPreferDelete(int ano);
	List<MypageVO> userAllergyNo(int no);
	int userProfileDelete(int no);
	
	int getUserTotalCount();
	
	// 회원 탈퇴
	int userExit(int no);
	
	// 회원 월별 통계(관리자)
	int countAllUser();
	List<Map> countUserWithPeriod();
	
}
