package kr.co.foody.recipe;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RecipeController {
	
	@Autowired
	RecipeService service;
	@Autowired
	IngredientService service2;
	
	@GetMapping("write.do")
	public String write() {
		
		return "recipe/write";
	}
	
	@PostMapping("write.do")
	public String insert(RecipeVO vo) {
		service.insert(vo);
		return "recipe/write";
	}
	
	@RequestMapping(value = "large_cate.action", method = { RequestMethod.POST })	
	public Object selcate (@RequestParam int i) {
		
		return service2.large_cate(i);
	}
	
}
