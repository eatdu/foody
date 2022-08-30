package kr.co.foody.admin;

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

import kr.co.foody.board.BoardService;
import kr.co.foody.comment.CommentService;
import kr.co.foody.comment.CommentVO;
import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.qna.QnaService;
import kr.co.foody.qna.QnaVO;
import kr.co.foody.recipe.IngredientMapper;
import kr.co.foody.recipe.IngredientServiceImpl;
import kr.co.foody.recipe.IngredientVO;
import kr.co.foody.user.UserVO;
import util.SendMail;

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
	@Autowired
	AdminMapper amapper;
	
	
	@GetMapping("/admin/login.do")
	public String login() {
		return "admin/login";
	}
	
	//관리자 1차 로그인 - 아이디, 비밀번호
	@ResponseBody
	@PostMapping(value = "/admin/login1.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public boolean login1(@RequestBody AdminVO vo, Model model, HttpSession sess) {
		System.out.println(vo);
		AdminVO result = service.adminLogin1(vo);
		if (result != null) {
			String confirm = SendMail.confirmMail(result.getEmail());
			sess.setAttribute("confirm", confirm);
			sess.setAttribute("adminInfoTemp", result);
			return true;
		} else return false; 
	}
	//관리자 2차 로그인 - 이메일 인증번호 입력
	@ResponseBody
	@PostMapping(value = "/admin/login2.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/json;charset=UTF-8")
	public boolean login2(@RequestBody Map confirm, Model model, HttpSession sess) {
		boolean result = sess.getAttribute("confirm").equals(confirm.get("confirm"));
		if (result) {
			AdminVO adminInfo = (AdminVO)sess.getAttribute("adminInfoTemp");
			adminInfo.setPwd(null);
			sess.setAttribute("adminInfo", adminInfo);
			sess.removeAttribute("adminInfoTemp");
			sess.removeAttribute("confirm");
		}			
		return result;
	}
	//관리자 로그아웃
	@GetMapping("/admin/logout.do")
	public String logout(HttpSession sess) {
		sess.removeAttribute("adminInfo");
		return "admin/login";
	}
	
	
	@GetMapping("/admin/main.do")
	public String main(Model model, HttpSession sess) {
		svc.userReport(sess);
		svc.rcpCount(null, sess);
		return "admin/main";
	}
	//레시피 목록 조회 페이지
	@GetMapping("/admin/recipe.do")
	public String recipe(Model model, HttpSession sess, @RequestParam int mode) {
		model.addAttribute("mode", mode);
		return "admin/recipe";
	}
	//레시피 목록 조회 결과
	@PostMapping("/admin/recipe.do")
	public String recipe(@RequestBody Map cri, Model model) {
		svc.selectRcpAdmin(cri, model);
		return "common/rcpAdmin";
	}
	//레시피 상세보기 모달
	@PostMapping("/admin/rcpDetail.do")
	public String rcpDetail(@RequestBody Map cri, Model model) {
		int no = (int)cri.get("no");
		svc.rcpDetail(no);
		model.addAttribute("no", no);
		return "/common/rcpAdminModal";
	}
	//레시피 삭제 처리
	//@PostMapping("/admin/deleteRcp.do")
	
	

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
	CommentService Cservice;
	
	// QnA 게시판 조회
	@GetMapping("/admin/qna.do")
	public String getQna(QnaVO vo, Model model) {
		model.addAttribute("data", Qservice.getQna(vo));
		return "admin/qna";
	}
	// QnA 게시판 답변 팝업창
	@GetMapping("/admin/reply.do")
	public String reply(QnaVO vo, Model model) {
		model.addAttribute("data", Qservice.view(vo.getNo()));
		return "admin/reply";
	}
	// QnA 게시판 답변 등록처리
	@PostMapping("/admin/reply.do")
	public String reply(QnaVO vo, Model model, HttpServletRequest req) {
		if (Qservice.reply(vo) == 1) {
			model.addAttribute("msg", "답변 등록 완료.");
			return "common/alertClose";
		} else {
			model.addAttribute("msg", "답변 등록 실패");
			return "common/alertClose";
		}
	}
	
	// 댓글목록 조회
	@GetMapping("/admin/comment.do")
	public String getComment(CommentVO vo, Model model) {
		model.addAttribute("comment", Cservice.wholeList(vo));
		return "admin/comment";
	}
	// 댓글목록 팝업창
	@PostMapping("/admin/comment.do")
	public String controlComment(CommentVO vo, Model model) {
		model.addAttribute("comment", Cservice.wholeList(vo));
		return "admin/comment";
	}
	// 댓글 삭제
	@GetMapping("/admin/delete.do")
	public String delete(CommentVO vo, Model model, @RequestParam int no) {
		if (Cservice.delete(no) == 1) {
			model.addAttribute("msg", "댓글 삭제 완료");
			model.addAttribute("url", "comment.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "댓글 삭제 실패");
			return "common/alert";
		}
	}
	
	// 회원목록 조회
	@GetMapping("/admin/userList.do")
	public String userList(Model model, UserVO vo, HttpSession sess) {
		svc.userReport(sess);
		svc.exitUserList(sess);
		model.addAttribute("data", service.userList(vo));
		return "admin/userList";
	}
	
	
}
