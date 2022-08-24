package kr.co.foody.mypage;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {

	@Autowired
	MypageService service;
	
	@GetMapping("/mypage/mypage.do")
	public String mypage() {
		return "/mypage/mypage";
	}
	
	@GetMapping("mypage/myRecipe")
	public String myRecipe(Model model, HttpSession sess) {
		model.addAttribute("myRecipe", service.mypage(sess));
		return "/mypage/myRecipe";
	}
	
	@GetMapping("mypage/recentRecipe")
	public String recentRecipe(Model model, HttpSession sess) {
		model.addAttribute("recentRecipe", service.mypage(sess));	
		return "/mypage/recentRecipe";
	}
	
	@GetMapping("mypage/likeRecipe")
	public String likeRecipe() {
		return "/mypage/likeRecipe";
	}
	
	@GetMapping("mypage/myInfo")
	public String myInfo(Model model, HttpSession sess) {
		model.addAttribute("myInfo", service.mypage(sess));
		return "/mypage/myInfo";
	}
	
	
}
