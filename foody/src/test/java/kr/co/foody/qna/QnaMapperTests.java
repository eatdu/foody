package kr.co.foody.qna;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.foody.comment.CommentMapper;
import kr.co.foody.comment.CommentVO;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class QnaMapperTests {

	@Autowired
	private QnaMapper mapper;
	@Autowired
	private CommentMapper Cmapper;
	
	//@Test
	public void insert() { // 행삽입
		QnaVO vo = new QnaVO();
		vo.setUser_no(23);
		vo.setQtype(3);
		vo.setTitle("내가 쓴 댓글을 수정하고 싶어요.");
		vo.setContent("내가 쓴 댓글을 수정하고 싶어요.");
		mapper.insert(vo);
//		int r = 0;
//		for(int i=0; i<200; i++) {
//			r += mapper.insert(vo);
//		}
		log.info(vo);
	}
	
	//@Test
	public void insertComment() {
		CommentVO vo = new CommentVO();
		vo.setUser_no(26);
		vo.setBoard_no(13);
		vo.setTablename("recipe");
		vo.setContent("추천합니당");
		Cmapper.insert(vo);
		
	}

	
	
	
}
