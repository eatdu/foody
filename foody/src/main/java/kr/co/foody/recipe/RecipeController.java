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

import kr.co.foody.admin.AdminService;
import kr.co.foody.board.BoardVO;
import kr.co.foody.comment.CommentService;
import kr.co.foody.comment.CommentVO;
import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.user.UserVO;

@Controller
public class RecipeController {

	@Autowired
	AdminService adminSvc;
	@Autowired
	RecipeService service;
	@Autowired
	IngredientService service2;
	@Autowired
	CommentService cservice;

	@GetMapping("/recipe/write.do")
	public String write() {

		return "recipe/write";
	}

	@PostMapping("/recipe/write.do")
	public String insert(@RequestParam Map cri, HttpSession sess, Model model, HttpServletRequest req,
			@RequestParam MultipartFile[] photo, @RequestParam MultipartFile[] thumbnail) {

		var success = 0;
		var success1 = 0;
		var success2 = 0;
		
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
			success1 = service.insertIngredient(cri);
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
				success2 = service.insertProcess(cri);
			} else {
				cri.put("photo", null);
				success2 = service.insertProcess(cri);
			}

		}

		if (success == 1 && success1 == 1 && success == 1) {
			model.addAttribute("msg", "게시물이 저장되었습니다.");
			model.addAttribute("url", "/foody/mypage/mypage.do");
			return "/recipe/alert";
		} else {
			model.addAttribute("msg", "게시물을 저장할 수 없습니다.");
			return "/recipe/alert";
		}

	}
	
	@GetMapping("/recipe/view.do")
	public String view(RecipeVO vo, CommentVO cvo, Model model, HttpSession sess, HttpServletRequest req) {

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
		
		cvo.setBoard_no(recipeNo);
		cvo.setTablename("recipe");
		model.addAttribute("comment", cservice.index(cvo)); // 레시피에 대한 포토리뷰
		
		//관리자페이지에서 접속한 경우 실행되는 코드
		if (vo.isAdmin()) {
			adminSvc.rcpDetail(vo.getNo());
			return "common/rcpAdminModal";
		}
		
		return "recipe/view";
	}
	
	//수정
	@GetMapping("/recipe/modify.do")
	public String modify(HttpServletRequest req, Model model) {
		int recipeNo = Integer.parseInt(req.getParameter("no"));
		
		Map cri = service.viewModify(recipeNo);
		
		model.addAttribute("recipe", cri.get("recipe"));
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("Ingredientlist", cri.get("ingredient"));
		model.addAttribute("processlist", cri.get("process"));
		
		return "recipe/modify";
	}
	
	@PostMapping("/recipe/modify.do")
	public String update(@RequestParam Map cri, HttpServletRequest req, Model model,@RequestParam MultipartFile[] thumbnail, @RequestParam MultipartFile[] photo) {
		var success = 0;
		var success1 = 0;
		var success2 =0;
		int recipeNo = Integer.parseInt(req.getParameter("no"));
		cri.put("no",recipeNo);
		
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
		
		success = service.updateRecipe(cri);
		service.deleteIngredient(recipeNo);
		service.deleteProcess(recipeNo);
		
		String[] ingredient_no = req.getParameterValues("ingredient_no");
		String[] weight = req.getParameterValues("weight");
		String[] quantity = req.getParameterValues("quantity");

		for (int i = 0; i < ingredient_no.length; i++) {
			cri.put("ingredient_no", ingredient_no[i]);
			cri.put("weight", weight[i]);
			cri.put("quantity", quantity[i]);
			success1 = service.insertIngredient(cri);
			
		}
		
		String[] content = req.getParameterValues("content");
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
				success2 = service.insertProcess(cri);
			} else {
				cri.put("photo", null);
				success2 = service.insertProcess(cri);
			}
		}
		
		if (success == 1 && success1 == 1 && success2 == 1) {
			model.addAttribute("msg", "게시물이 저장되었습니다.");
			model.addAttribute("url", "/foody/recipe/view.do?no="+recipeNo);
			return "/recipe/alert";
		}else if(success ==1 && success1 ==1){
			model.addAttribute("msg","과정때문에 저장할 수 없습니다.");
			return "/recipe/alert";
		} 
		else {
			model.addAttribute("msg", "게시물을 저장할 수 없습니다.");
			return "/recipe/alert";
		}
		
	}
	

	@PostMapping(value = "search.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String search(@RequestBody Map cri, Model model, HttpSession sess) {
		model.addAttribute("result", service.search(cri, model, sess));
		return (String) cri.get("jsp");
	}

	@PostMapping(value = "comboBox.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public String comboBox(@RequestBody Map cri, Model model) {
		if (cri.get("name").equals("ingreCateDrop")) {
			model.addAttribute("list", service.makeIngreNameList(Integer.parseInt((String)cri.get("data"))));
			model.addAttribute("head", "==재료명==");
		}
		if (cri.get("name").equals("keyword")) {
			model.addAttribute("list", service.makeIngreNameList(cri));
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
	@PostMapping(value = "/recipe/mainCate_drop.action", produces = "application/json; charset=UTF-8")
	public Object selLargecate(@RequestParam int num) {
		return service2.large_cate(num);
	}

	@ResponseBody
	@PostMapping(value = "/recipe/ingredientName_drop.action", produces = "application/json; charset=UTF-8")
	public Object selMediumcate(@RequestParam String name) {

		return service2.detail_cate(name);
	}

	@ResponseBody
	@PostMapping(value = "/recipe/searchName_drop.action", produces = "application/json; charset=UTF-8")
	public Object nameSearchList() {

		return service2.nameSearch();
	}
	
	@GetMapping("/comment/clist.do")
	public String list(CommentVO vo, Model model) {
		model.addAttribute("comment", cservice.index(vo)); // 레시피 글에 대한 댓글리뷰
		return "common/comment";
	}
}
