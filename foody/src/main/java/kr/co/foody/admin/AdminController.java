package kr.co.foody.admin;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.recipe.IngredientMapper;
import kr.co.foody.recipe.IngredientServiceImpl;
import kr.co.foody.recipe.IngredientVO;
import kr.co.foody.user.UserVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminServiceImpl svc;
	@Autowired
	IngredientServiceImpl ingreSvc;
	@Autowired
	IngredientMapper ingreMapper;
	@Autowired
	AdminService service;
	
	
	@GetMapping("/admin/ingre.do")
	public String ingre(Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		model.addAttribute("allergyList", ingreMapper.allergyList());
		return "admin/ingre";
	}
	@GetMapping("/admin/main.do")
	public String main(Model model, HttpSession sess) {
		svc.userReport(sess);
		return "admin/main";
	}
	
	@PostMapping(value = "/admin/ingreInfo.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String ingreInfo(@RequestBody Map cri, Model model){
		IngredientVO vo = svc.ingreInfo(Integer.parseInt((String)cri.get("no")));
		model.addAttribute("result", vo);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		model.addAttribute("selected", vo.getLarge_cate());
		model.addAttribute("allergyArr", svc.makeAllergyList());
		model.addAttribute("allergyNo", vo.getAllergy_no());
		return "common/ingreInfo";
	}
	
	@ResponseBody
	@PostMapping(value = "/admin/ingreUpdate.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public boolean ingreUpdate(@RequestBody IngredientVO vo, Model model){
		System.out.println(vo);
		boolean res = ingreSvc.updateIngre(vo);
		return res;
	}

	@ResponseBody
	@PostMapping(value = "/admin/ingreInsert.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public boolean ingreInsert(@RequestBody IngredientVO vo, Model model){
		return ingreSvc.insertIngre(vo);
	}
	
	@GetMapping("/admin/userList.do")
	public String userList(Model model, UserVO vo) {
		model.addAttribute("data", service.userList());
		return "admin/userList";
	}
	
	
}
