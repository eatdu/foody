package kr.co.foody.mypage;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.foody.recipe.RecipeVO;
import kr.co.foody.user.UserService;
import kr.co.foody.user.UserVO;

@Controller
public class MypageController {

	@Autowired
	MypageService service;
	@Autowired
	UserService uService;
	
	@GetMapping("/mypage/mypage.do")
	public String mypage(Model model, HttpSession sess) {
		model.addAttribute("mypage", service.mypage(sess));
		return "/mypage/mypage";
	}
	
	@GetMapping("mypage/myRecipe")
	public String myRecipe(Model model, HttpSession sess, MypageVO vo) {
		model.addAttribute("myRecipe", service.myRecipe(sess,vo));
		return "/mypage/myRecipe";
	}
	
	@GetMapping("mypage/recentRecipe")
	public String recentRecipe(Model model, HttpSession sess, MypageVO vo) {
		model.addAttribute("recentRecipe", service.recentRecipe(sess,vo));	
		return "/mypage/recentRecipe";
	}
	
	@GetMapping("mypage/likeRecipe")
	public String likeRecipe(Model model, HttpSession sess, MypageVO vo) {
		model.addAttribute("likeRecipe", service.likeRecipe(sess,vo));
		return "/mypage/likeRecipe";
	}
	
	@GetMapping("mypage/myInfo")
	public String myInfo(Model model, HttpSession sess) {
		model.addAttribute("myInfo", service.userInfo(sess));
		return "/mypage/myInfo";
	}
	
	@GetMapping("/mypage/delete.do")
	public String deleteRecipe(Model model, int no) {
		if(service.deleteRecipe(no)) {
			model.addAttribute("msg", "레시피가 삭제되었습니다.");
			model.addAttribute("url", "/foody/mypage/mypage.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제실패");
			return "common/alert";
		}
	}
	
	@GetMapping("/mypage/test.do")
	public String myInfo() {
		return "/mypage/test";
	}
}
