package kr.co.foody.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {
	
	int insert(CommentVO vo);
	int count(CommentVO vo);
	List<CommentVO> list(CommentVO vo);
	int update(CommentVO vo);
	int delete(int no);
	
	int insert_reCmt(CommentVO vo);
	int gnoUpdate(int no);
	int onoUpdate(CommentVO vo);

	boolean getStar(CommentVO vo);
	void updateAvgstar(int recipe_no);
}
