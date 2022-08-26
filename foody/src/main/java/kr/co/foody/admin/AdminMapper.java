package kr.co.foody.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.foody.user.UserVO;

@Mapper
public interface AdminMapper {
	
	// 전체회원 조회
	List<UserVO> userList(UserVO vo);
	int userCount();
	
	// 탈퇴회원 월별통계
	List<Map> exitUserWithMonth();
	int exitUserCount();
	
}
