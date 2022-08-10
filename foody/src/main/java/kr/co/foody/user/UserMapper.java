package kr.co.foody.user;

import org.apache.ibatis.annotations.Mapper;

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
}
