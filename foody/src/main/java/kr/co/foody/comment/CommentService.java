package kr.co.foody.comment;

import java.util.List;
import java.util.Map;

public interface CommentService {

	int insert(CommentVO vo);
	int update(CommentVO vo);
	int delete(int no);
	Map index(CommentVO vo);
	Map wholeList(CommentVO vo);
	int insert_reCmt(CommentVO vo);
	
	//게시글 번호로 사진 있는 리뷰만 리턴
	List<CommentVO> selectPhotoReview(int no);
	
}
