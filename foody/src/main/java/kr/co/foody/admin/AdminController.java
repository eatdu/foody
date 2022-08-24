package kr.co.foody.admin;

import java.util.HashMap;
import java.util.Map;

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

import kr.co.foody.board.BoardService;
import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.qna.QnaMapper;
import kr.co.foody.qna.QnaService;
import kr.co.foody.qna.QnaVO;
import kr.co.foody.recipe.IngredientMapper;
import kr.co.foody.recipe.IngredientServiceImpl;
import kr.co.foody.recipe.IngredientVO;

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
	@Autowired
	BoardService paging;
	
	
	@GetMapping("/admin/main.do")
	public String main(Model model, HttpSession sess) {
		svc.userReport(sess);
		svc.rcpCount(null, sess);
		return "admin/main";
	}
	//레시피 목록 조회 페이지
	@GetMapping("/admin/recipe.do")
	public String recipe(Model model, HttpSession sess) {
		return "admin/recipe";
	}
	//레시피 목록 조회 결과
	@PostMapping("/admin/recipe.do")
	public String recipe(@RequestParam HashMap cri, Model model) {
		System.out.println(cri);
		svc.selectRcpAdmin(cri, model);
		return "admin/recipe";
	}
	
	
	
	//재료 조작 페이지
	@GetMapping("/admin/ingre.do")
	public String ingre(Model model) {
		model.addAttribute("rcpCateArr", RecipeCategory.RcpCateArr);
		model.addAttribute("ingreCateArr", IngredientCategory.IngreCateArr);
		model.addAttribute("allergyList", ingreMapper.allergyList());
		return "admin/ingre";
	}
	//재료 정보 조회
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
	//재료 정보 업데이트
	@ResponseBody
	@PostMapping(value = "/admin/ingreUpdate.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public boolean ingreUpdate(@RequestBody IngredientVO vo, Model model){
		System.out.println(vo);
		boolean res = ingreSvc.updateIngre(vo);
		return res;
	}
	//재료 정보 추가
	@ResponseBody
	@PostMapping(value = "/admin/ingreInsert.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public boolean ingreInsert(@RequestBody IngredientVO vo, Model model){
		return ingreSvc.insertIngre(vo);
	}
	
	@Autowired
	QnaService Qservice;
	@Autowired
	QnaMapper mapper;
	
	// QnA 게시판 조회
	@GetMapping("/admin/qna.do")
	public String getQna(QnaVO vo, Model model) {
		model.addAttribute("data", Qservice.getQna(vo));
		return "admin/qna";
	}
	@GetMapping("/admin/userList.do")
	public String userList(Model model) {
		model.addAttribute("data", service.userList());
		return "admin/userList";
	}
	
	
}
