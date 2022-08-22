package kr.co.foody.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.foody.user.UserVO;

@Mapper
public interface AdminMapper {
	
	List<UserVO> userList();

}
