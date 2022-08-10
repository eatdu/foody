package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
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

	@RequestMapping(value = "large_cate.action", method = { RequestMethod.POST })	
	public Object selcate (@RequestParam int i) {
		
		return service2.large_cate(i);
	}
	
	@ResponseBody
	@PostMapping(value = "search.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public List<RecipeVO> search(@RequestBody Map cri){
		return service.selectRecipeListWithCri(cri);
	}
	
	@GetMapping("search.do")
	public String search(Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		return "recipe/search";
	}
}
