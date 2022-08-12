package kr.co.foody.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {

	@GetMapping("/mypage/mypage.do")
	public String mypage() {
		return "/mypage/mypage";
	}
	
	@GetMapping("mypage/myRecipe")
	public String myRecipe() {
		return "/mypage/myRecipe";
	}
	
	@GetMapping("mypage/recentRecipe")
	public String recentRecipe() {
		return "/mypage/recentRecipe";
	}
	
	@GetMapping("mypage/likeRecipe")
	public String likeRecipe() {
		return "/mypage/likeRecipe";
	}
	
	@GetMapping("mypage/myInfo")
	public String myInfo() {
		return "/mypage/myInfo";
	}
}
