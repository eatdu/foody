package kr.co.foody.comment;

import java.util.Map;

public interface CommentService {

	int insert(CommentVO vo);
	int update(CommentVO vo);
	int delete(CommentVO vo);
	Map index(CommentVO vo);
	Map wholeList(CommentVO vo);
	int insert_reCmt(CommentVO vo);
	
}
