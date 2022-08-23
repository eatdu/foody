package kr.co.foody.board;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.foody.user.UserVO;

@Mapper
public interface BoardMapper {
	
	int insert(BoardVO vo);
	int count(BoardVO vo);
	List<BoardVO> list(BoardVO vo);
	BoardVO view(int no);
	int updateViewcount(int no);
	int update(BoardVO vo);
	boolean delete(int no);
	
	// 회원 리스트
	List<UserVO> userList(BoardVO vo);
	int userCount(BoardVO vo);
}