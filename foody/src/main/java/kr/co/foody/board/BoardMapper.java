package kr.co.foody.board;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	
	int insert(BoardVO vo);
	int count(BoardVO vo);
	List<BoardVO> list(BoardVO vo);
	BoardVO view(int no);
	int updateViewcount(int no);
	int update(BoardVO vo);
	boolean delete(int no);
	
}