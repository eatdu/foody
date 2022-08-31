package kr.co.foody.qna;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {
	
	int insert(QnaVO vo);
	int gnoUpdate(int no);
	int onoUpdate(QnaVO vo);
	
	int reply(QnaVO vo);
	int updateResponse(int qna_no);
	
	int count(QnaVO vo);
	int count_faq(QnaVO vo);
	List<QnaVO> getFaq(QnaVO vo);
	List<QnaVO> getQna(QnaVO vo);
	
	int count_myQna(QnaVO vo);
	List<QnaVO> getMyQna(QnaVO vo);
	
	QnaVO view(int no);
	int update(QnaVO vo);
	boolean delete(int no);
	
}