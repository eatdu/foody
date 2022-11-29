package kr.co.foody.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.es.ESMapper;
import lombok.extern.log4j.Log4j;
import util.ElasticSearch;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class ESTest {

	@Autowired
	ESMapper mapper;
	
//	@Test
	public void test() {
		List<Map<String, Object>> res = mapper.findIngresByNo(10);
		System.out.println(res);
	}
	
//	@Test
	public void dateTest() throws Exception {
		Map res = mapper.selectByNo(1);
		
		System.out.println(res.get("regdate").toString());
	}
	
	@Test
	public void putTest() throws Exception {
		for(int i=224; i<=500; i++) {
			Map res = mapper.selectByNo(i);
			
			List<Map<String, Object>> ingreList = mapper.findIngresByNo(i);
			List<Map<String, Object>> ingres = new ArrayList<Map<String, Object>>();
			
			Map<String, Object> doc = new HashMap<String, Object>();
			
			for(Map ingre : ingreList) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("iname", ingre.get("name"));
				map.put("icate", IngredientCategory.IngreCateArr[Integer.parseInt(ingre.get("large_cate").toString()) - 1]);
				map.put("detail", ingre.get("detail"));
				ingres.add(map);
			}
			
			doc.put("ingres", ingres);		
			doc.put("rname",res.get("name"));
			doc.put("intro",res.get("intro"));
			doc.put("rtype",RecipeCategory.RcpCateArr[Integer.parseInt(res.get("type").toString()) - 1]);
			doc.put("avgstar",res.get("avgstar"));
			doc.put("bookmark",res.get("bookmark"));
			doc.put("regdate",res.get("regdate").toString());
			doc.put("reply",res.get("reply"));
			doc.put("rno",res.get("no"));
			doc.put("serving",res.get("serving"));
			doc.put("thumbnail",res.get("thumbnail"));
			doc.put("time",res.get("time"));
			doc.put("viewcount",res.get("viewcount"));

			ElasticSearch.putDocument("foody_recipe", Integer.toString(i) , doc);
			System.out.println(i);
		}
	}
	
}
