package kr.co.foody.recipe;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.foody.constants.RecipeCategory;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class RecipeMapperTests {

	@Autowired
	RecipeMapper mapper;
	
	@Test
	public void test() {
		System.out.println(RecipeCategory.RcpCateArr[15-1]);

	public String telMaker() {
		int a = 1000 + (int)(Math.random() * 9000);
		int b = 1000 + (int)(Math.random() * 9000);
		return "010" + a + b;
	}
	
//	public void birthMaker() {
//		int yy = 60 + (int)(Math.random() * 40);
//		int mm = (int)(Math.random() * 12);
//		
//		
//		int mm 
//	}
	
	//@Test
	public void insertUser() {
		for (int i=0; i<100; i++) {
			Map user = new HashMap();
			user.put("email", RandomUserInsertTest.emailArr[i]);
			user.put("nik_name", RandomUserInsertTest.nickArr1[i/10] + RandomUserInsertTest.nickArr1[i%10]);
			user.put("name", RandomUserInsertTest.nameArr[i]);
			user.put("intro", RandomUserInsertTest.intro);
			user.put("pwd", "test1234");
			user.put("tel", telMaker());
			
		}
		
		
	}
	
}
