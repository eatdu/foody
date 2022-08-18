package kr.co.foody.admin;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.recipe.IngredientVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminServiceImpl svc;
	
	@GetMapping("/admin/ingre.do")
	public String ingre(Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		return "admin/ingre";
	}
	
	@PostMapping(value = "/admin/ingreInfo.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String ingreInfo(@RequestBody Map cri, Model model){
		IngredientVO vo = svc.ingreInfo(Integer.parseInt((String)cri.get("no")));
		model.addAttribute("result", vo);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		model.addAttribute("selected", cri.get("selected"));
		model.addAttribute("allergyArr", svc.makeAllergyList());
		model.addAttribute("allergyNo", vo.getAllergy_no());
		return "common/ingreInfo";
	}
}
