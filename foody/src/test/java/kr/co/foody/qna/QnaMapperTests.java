package kr.co.foody.qna;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.foody.user.UserMapper;
import kr.co.foody.user.UserVO;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class QnaMapperTests {

	@Autowired
	private QnaMapper mapper;
	
	@Test
	public void insert() { // 행삽입
		QnaVO vo = new QnaVO();
		vo.setUser_no(3);
		vo.setCategory(1);
		vo.setTitle("");
		mapper.insert(vo);
//		int r = 0;
//		for(int i=0; i<200; i++) {
//			r += mapper.insert(vo);
//		}
		log.info(vo);
	}

	
	
	
}
