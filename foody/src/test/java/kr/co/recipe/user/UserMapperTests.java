package kr.co.recipe.user;

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
public class UserMapperTests {

	@Autowired
	private UserMapper mapper;
	
	//@Test
	public void testMapper() {
		log.info(mapper); 
	}
	
	//@Test
	public void insert() { // 행삽입
		UserVO vo = new UserVO();
		vo.setName("이두현");
		vo.setBirth("1234567");
		vo.setNik_name("eatdu");
		vo.setEmail("eatdu0918@naver.com");
		vo.setSelfi("1");
		vo.setPwd("10101");
		vo.setAddr1("서울");
		vo.setAddr2("서울");
		vo.setHeight(174);
		vo.setWeight(66);
		vo.setActivity(1);
		vo.setIntro("안녕하세요");
		mapper.insert(vo);
//		int r = 0;
//		for(int i=0; i<200; i++) {
//			r += mapper.insert(vo);
//		}
		log.info(vo);
	}


	
	//@Test 
	public void selectOne() { // idx 번호로 해당행 가져오기
		UserVO vo = new UserVO();
		mapper.selectOne(2);
		log.info(vo);
	}
	
	@Test
	public void prefer() {
		UserVO vo = new UserVO();
		mapper.prefer(vo);
		
	}
	
	//@Test
//	public void list() { // 리스트 출력
//		UserVO vo = new UserVO();
////		Map map = new HashMap();
////		map.put("stype", "title");
////		map.put("sword", "1");
////		map.put("startIdx", 0);
////		map.put("pageRow", 10);
//		vo.setTitle("제목");
//		vo.setContent("1");
//		vo.setStartIdx(0);
//		vo.setPageRow(10);
//		List<UserVO> list = mapper.list(vo);
//		list.forEach(vo ->log.info(vo));
//	}

	
	
	
	
}
