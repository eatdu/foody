package kr.co.foody.recipe;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;

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
	
	@PostMapping(value = "search.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String search(@RequestBody Map cri, Model model){
		model.addAttribute("result", service.search(cri));
		return (String)cri.get("jsp");
	}
	
	@PostMapping(value = "comboBox.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String comboBox(@RequestBody Map cri, Model model){
		if(cri.get("name").equals("ingreCateDrop")) {
			model.addAttribute("list", service.makeIngreNameList(Integer.parseInt((String)cri.get("data"))));
		}
		if(cri.get("name").equals("keyword")) {
			model.addAttribute("list", service.makeIngreNameList((String)cri.get("data")));
		}
		return "common/comboBox";
	}
		
	@GetMapping("/recipe/search.do")
	public String search(Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		return "recipe/search";
	}
	
	@GetMapping("/recipe/main.do")
	public String main() {
		return "recipe/main";
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
