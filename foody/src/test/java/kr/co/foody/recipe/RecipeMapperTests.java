package kr.co.foody.recipe;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

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
	public void countTest(){
		Map cri = new HashMap();
		int[] a = {2};
		cri.put("rcpCateArr", a);
		System.out.println(mapper.countWithFilter(cri));
	}
}
