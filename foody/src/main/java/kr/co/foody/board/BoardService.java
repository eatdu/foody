package kr.co.foody.board;

import java.util.Map;

public interface BoardService {
	
	int insert(BoardVO vo);
	Map list(BoardVO vo);
	BoardVO view(int no);
	BoardVO edit(int no);
	int update(BoardVO vo);
	boolean delete(int no);
	
}