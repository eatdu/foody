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
public class IngredientMapperTests {

	@Autowired
	IngredientMapper mapper;
	
	@Test
	public void updateTest(){
		IngredientVO vo = new IngredientVO();
		vo.setCarbo(5);
		vo.setFat(15);
		vo.setProtein(10);
		vo.setNo(3680);
		vo.setName("테스트2");
		vo.setDetail("상세2");
		vo.setAllergy_no(5);
		vo.setLarge_cate(5);
		mapper.updateIngre(vo);
	}
}
