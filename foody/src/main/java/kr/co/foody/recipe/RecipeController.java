package kr.co.foody.recipe;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;

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
	public String insert(@RequestParam Map cri, HttpSession sess, Model model, HttpServletRequest req,
			@RequestParam MultipartFile[] photo, @RequestParam MultipartFile[] thumbnail) {

		var success = 0;
		UserVO uv = (UserVO) sess.getAttribute("loginInfo");
		model.addAttribute("cal", (int) sess.getAttribute("cal"));
		model.addAttribute("loginInfo", uv);
		cri.put("user_no", uv.getNo());

		for (int k = 0; k < thumbnail.length; k++) {
			if (!thumbnail[k].isEmpty()) {
				String org = thumbnail[k].getOriginalFilename();
				String ext = org.substring(org.lastIndexOf("."));
				String real = new Date().getTime() + ext;
				String path = req.getRealPath("/upload/");
				try {
					thumbnail[k].transferTo(new File(path + real)); // 파일 저장
				} catch (Exception e) {
				}

				if (k == 0) {
					cri.put("thumbnail", real);
				} else if (k == 1) {
					cri.put("addedpicture1", real);
				} else {
					cri.put("addedpicture2", real);
				}
			} else {
				if (k == 0) {
					cri.put("thumbnail", null);
				} else if (k == 1) {
					cri.put("addedpicture1", null);
				} else {
					cri.put("addedpicture2", null);
				}
			}
		}

		success = service.insert(cri);

		String[] content = req.getParameterValues("content");
		String[] ingredient_no = req.getParameterValues("ingredient_no");
		String[] weight = req.getParameterValues("weight");
		String[] quantity = req.getParameterValues("quantity");

		for (int j = 0; j < ingredient_no.length; j++) {
			cri.put("ingredient_no", ingredient_no[j]);
			cri.put("weight", weight[j]);
			cri.put("quantity", quantity[j]);
			service.insertIngredient(cri);
		}

		for (int i = 0; i < content.length; i++) {
			cri.put("order_no", (i + 1));
			cri.put("content", content[i]);

			if (!photo[i].isEmpty()) {
				String org = photo[i].getOriginalFilename();
				String ext = org.substring(org.lastIndexOf("."));
				String real = new Date().getTime() + ext;
				String path = req.getRealPath("/upload/");
				try {
					photo[i].transferTo(new File(path + real)); // 파일 저장
				} catch (Exception e) {
				}
				cri.put("photo", real);
				service.insertProcess(cri);
			} else {
				cri.put("photo", null);
				service.insertProcess(cri);
			}

		}

		if (success == 1) {
			model.addAttribute("msg", "게시물이 저장되었습니다.");
			model.addAttribute("url", "/foody/mypage/mypage.do");
			return "recipe/alert";
		} else {
			model.addAttribute("msg", "게시물을 저장할 수 없습니다.");
			return "recipe/alert";
		}

	}

	@GetMapping("/recipe/view.do")
	public String view(RecipeVO vo, Model model, HttpSession sess, HttpServletRequest req) {

		UserVO uv = (UserVO) sess.getAttribute("loginInfo");
		int recipeNo = Integer.parseInt(req.getParameter("no"));
		
		Map cri = service.viewRecipe(recipeNo, sess);
		
		List<Integer> userAllergyNo = (List<Integer>) sess.getAttribute("allergyNo");

		model.addAttribute("loginUser", uv);
		model.addAttribute("user", cri.get("user"));
		model.addAttribute("recipe", cri.get("recipe"));
		model.addAttribute("recipeType", cri.get("recipeType"));
		model.addAttribute("processlist", cri.get("process"));
		model.addAttribute("Ingredientlist", cri.get("ingredient"));
		model.addAttribute("sessAllergyNo", sess.getAttribute("allergyNo"));
		model.addAttribute("sessCal", sess.getAttribute("cal"));
		
		model.addAttribute("sumCarbo", cri.get("sumCarbo"));
		model.addAttribute("sumProtein", cri.get("sumProtein"));
		model.addAttribute("sumFat", cri.get("sumFat"));
		model.addAttribute("sumKcal", cri.get("sumKcal"));
		
		return "recipe/view";
	}

	@PostMapping(value = "search.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String search(@RequestBody Map cri, Model model, HttpSession sess) {
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
	
	
	@GetMapping("modify.do")
	public String modify() {

		return "recipe/modify";
	}

	@GetMapping("/recipe/search.do")
	public String search(@RequestParam Map cri, Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		if (cri.get("sType") != null)
			model.addAttribute("sType", cri.get("sType"));
		if (cri.get("keyword") != null)
			model.addAttribute("keyword", cri.get("keyword"));
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
