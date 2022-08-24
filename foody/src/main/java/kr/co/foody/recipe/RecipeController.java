package kr.co.foody.recipe;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.foody.board.BoardVO;
import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.user.UserVO;

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
	public String insert(RecipeVO vo, HttpSession sess, Model model) {
		UserVO uv = (UserVO) sess.getAttribute("loginInfo");

		model.addAttribute("cal", (int) sess.getAttribute("cal"));
		model.addAttribute("loginInfo", uv);
		vo.setUser_no(uv.getNo());

		service.insert(vo);
		return "recipe/write";
	}

	@GetMapping("/recipe/view.do")
	public String view(RecipeVO vo, Model model,HttpSession sess, HttpServletRequest req) { 
		
		int recipeNo = Integer.parseInt(req.getParameter("no"));
		RecipeVO recipeDatas = service.view(recipeNo);
		model.addAttribute("recipeDatas", recipeDatas); 
		return "recipe/view";
	}
	
	@PostMapping(value = "search.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String search(@RequestBody Map cri, Model model, HttpSession sess){
		model.addAttribute("result", service.search(cri, model, sess));
		return (String) cri.get("jsp");
	}

	@PostMapping(value = "comboBox.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String comboBox(@RequestBody Map cri, Model model) {
		if (cri.get("name").equals("ingreCateDrop")) {
			model.addAttribute("list", service.makeIngreNameList(Integer.parseInt((String) cri.get("data"))));
			model.addAttribute("head", "==재료명==");
		}
		if (cri.get("name").equals("keyword")) {
			model.addAttribute("list", service.makeIngreNameList((String) cri.get("data")));
			model.addAttribute("head", "==재료명==");
		}
		if (cri.get("name").equals("ingreNameList")) {
			model.addAttribute("list", service.makeIngreDetailList((String) cri.get("data")));
			model.addAttribute("head", "==상세==");
		}
		return "common/comboBox";
	}

	@GetMapping("/recipe/search.do")
	public String search(@RequestParam Map cri, Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		if (cri.get("sType") != null) model.addAttribute("sType", cri.get("sType"));
		if (cri.get("keyword") != null) model.addAttribute("keyword", cri.get("keyword"));
		return "recipe/search";
	}

	@GetMapping("/recipe/main.do")
	public String main(HttpSession sess, Model model) {

		return "recipe/main";
	}

	@ResponseBody
	@PostMapping(value = "mainCate_drop.action", produces = "application/json; charset=UTF-8")
	public Object selLargecate(@RequestParam int num) {
		return service2.large_cate(num);
	}

	@ResponseBody
	@PostMapping(value = "ingredientName_drop.action", produces = "application/json; charset=UTF-8")
	public Object selMediumcate(@RequestParam String name) {

		return service2.detail_cate(name);
	}

	@ResponseBody
	@PostMapping(value = "searchName_drop.action", produces = "application/json; charset=UTF-8")
	public Object nameSearchList() {

		return service2.nameSearch();
	}
}
