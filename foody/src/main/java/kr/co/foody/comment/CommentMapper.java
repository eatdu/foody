package kr.co.foody.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {
	
	// 사용자
	int insert(CommentVO vo); // 댓글 등록
	
	int count(CommentVO vo);
	List<CommentVO> list(CommentVO vo); // 해당 글에 달린 댓글목록 조회
	
	int update(CommentVO vo); // 댓글 수정 (추후)
	
	// int delete(int no);
	
	int insert_reCmt(CommentVO vo); // 대댓글 등록
	int gnoUpdate(int no);
	int onoUpdate(CommentVO vo);

	boolean getStar(CommentVO vo);
	void updateAvgstar(int recipe_no);
	
	int printUpdate(int no); // (대)댓글 삭제시 print 컬럼 1로 변경
	
	
	// 관리자
	int wholeCount(CommentVO vo); // 관리자 전체 댓글수 조회
	List<CommentVO> wholeList(CommentVO vo); // 관리자 전체 댓글목록 조회
	
	List<CommentVO> selectPhotoReview(int no);  // 포토리뷰만 리스트로 리턴
}
