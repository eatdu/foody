package kr.co.foody.recipe;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@ResponseBody
	@PostMapping(value = "mainCate_drop.action", produces="application/json; charset=UTF-8")	
	public Object selLargecate (@RequestParam int num) {
		return service2.large_cate(num);
	}
	
	@ResponseBody
	@PostMapping(value = "ingredientName_drop.action", produces="application/json; charset=UTF-8")	
	public Object selMediumcate (@RequestParam String name) {

		return service2.detail_cate(name);
	}
	
	@ResponseBody
	@PostMapping(value = "searchName_drop.action", produces="application/json; charset=UTF-8")
	public Object nameSearchList() {
		
		return service2.nameSearch();
	}
	
	
}
