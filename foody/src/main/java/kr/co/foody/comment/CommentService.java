package kr.co.foody.comment;

import java.util.List;
import java.util.Map;

public interface CommentService {

	int insert(CommentVO vo);
	Map index(CommentVO vo);
	Map wholeList(CommentVO vo); // 관리자 전체 댓글목록 조회
	int insert_reCmt(CommentVO vo);

	List<CommentVO> selectPhotoReview(int no); // 포토리뷰만 조회
	
	int printUpdate(int no); // 댓글 삭제
	
	// int update(CommentVO vo);
	// int delete(int no);
}
