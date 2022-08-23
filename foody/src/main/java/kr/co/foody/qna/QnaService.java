package kr.co.foody.qna;

import java.util.Map;

public interface QnaService {
	
	int insert(QnaVO vo);
	int reply(QnaVO vo);
	
	Map getFaq(QnaVO vo);
	Map getMyQna(QnaVO vo);
	Map getQna(QnaVO vo);
	
	QnaVO view(int no);
	QnaVO edit(int no);
	int update(QnaVO vo);
	boolean delete(int no);
	
}