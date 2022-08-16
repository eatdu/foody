package kr.co.foody.user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.foody.constants.RecipeCategory;

@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@GetMapping("/user/signUp.do") // 회원가입창(필수) 이동
	public String signUp() {
		return "user/signUp";
	}
	
	@GetMapping("/user/signUpNext.do") // 회원가입창(추가) 이동
	public String signUpNext(Model model) {
		List<String> allergy = service.getAllergy();
		String[] rcpCateArr = RecipeCategory.RcpCateArr;
		model.addAttribute("rcpCateArr", rcpCateArr);
		model.addAttribute("allergy",allergy);
		return "user/signUpNext";
	}
	
	@GetMapping("/user/login.do") // 로그인창 이동
	public String login() {
		return "user/login";
	}
	
	@GetMapping("/user/findEmail.do") // 이메일 찾기 이동
	public String findEmail() {
		return "user/findEmail";
	}
	
	@GetMapping("/user/findPwd.do") // 비밀번호 찾기 이동
	public String findPwd() {
		return "user/findPwd";
	}
	
	@GetMapping("/user/kcal.do") // 칼로리 계산기 모달창
	public String kcal() {
		return "user/kcal";
	}
	
	@PostMapping("/user/login.do") // 로그인 이메일 비밀번호 일치 확인
	public String login(UserVO vo, HttpSession sess, Model model) {
		if(service.loginCheck(vo, sess)) {
			return "redirect:/recipe/main.do";
		} else {
			model.addAttribute("msg", "이메일 비밀번호를 확인해 주세요.");
			return "common/alert";
		}
	}
	
	@GetMapping("/user/logout.do") // 로그아웃
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate();
		model.addAttribute("msg", "로그아웃");
		model.addAttribute("url", "/foody/recipe/main.do");
		return "common/alert";
	}
	
	@GetMapping("/user/emailDupCheck.do") // 이메일 중복체크
	public void emailDupCheck(@RequestParam String email, HttpServletResponse res) throws IOException {
		int count = service.emailDupCheck(email);
		boolean r = false;
		if(count == 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@GetMapping("/user/nik_nameDupCheck.do") // 닉네임 중복체크
	public void nik_nameDupCheck(@RequestParam String nik_name, HttpServletResponse res) throws IOException {
		int count = service.nik_nameDupCheck(nik_name);
		boolean r = false;
		if(count == 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@GetMapping("/user/telDupCheck.do") // 전화번호 중복체크
	public void telDupCheck(@RequestParam String tel, HttpServletResponse res) throws IOException {
		int count = service.telDupCheck(tel);
		boolean r = false;
		if(count == 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@PostMapping("/user/signUp.do") // 회원가입 추가입력 
	public String signUp(UserVO vo, Model model, HttpServletRequest req) {
		if(service.insert(vo) > 0) {
			if ("login".equals(req.getParameter("route"))) {
				model.addAttribute("msg", "회원가입되었습니다");
				model.addAttribute("url", "login.do");
			} else {
				HttpSession sess = req.getSession();
				sess.setAttribute("signUp", vo);
				model.addAttribute("msg", "회원가입되었습니다 추가정보를 입력하세요.");
				model.addAttribute("url", "signUpNext.do");
			}
			
			return "common/alert"; 
		} else {
			model.addAttribute("msg", "회원가입 오류");
			return "common/alert";
		}
	}
	
	
	@PostMapping("/user/findEmail.do") // 이메일 찾기
	public void findEmail(HttpServletResponse res, UserVO param) throws IOException {
		UserVO vo = service.findEmail(param);
		if (vo != null) {
			PrintWriter out = res.getWriter();
			out.print(vo);
			out.flush();
		}
	}
	
	@PostMapping("/user/findPwd.do")
	public String findPwd(Model model, UserVO param) {
		UserVO vo = service.findPwd(param);
		if (vo != null) {
			model.addAttribute("result" ,vo.getPwd());
		}
		return "common/return";
	}
	
	@PostMapping("/user/signUpNext.do")
	public String signUpNext(Model model, UserVO vo
			, @RequestParam MultipartFile chooseFile
			,HttpServletRequest req) {
		try {
			String[] allergy_no = req.getParameterValues("allergy_no");
			for(int i=0; i<allergy_no.length; i++) {
				vo.setAllergy_no(Integer.parseInt(allergy_no[i]));
				service.userAllergy(vo);
			}
			String[] prefer_no = req.getParameterValues("prefer_no");
			for(int i=0; i<prefer_no.length; i++) {
				vo.setPrefer_no(Integer.parseInt(prefer_no[i]));
				service.userPrefer(vo);
			}
		} catch (Exception e) {}
		System.out.println(vo);
		if(!chooseFile.isEmpty()) {
			// 파일명 초기화
			String org = chooseFile.getOriginalFilename();
			String ext = org.substring(org.lastIndexOf("."));
			String real = new Date().getTime()+ext;
			
			// 파일저장
			String path = req.getRealPath("/upload/");
			try {
				chooseFile.transferTo(new File(path+real));
			} catch(Exception e) {}
			vo.setSelfi(real);
		}
		if(service.signUpNext(vo) > 0) {
			model.addAttribute("msg", "환영합니다.");
			model.addAttribute("url", "login.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "추가정보 입력 실패");
			return "common/alert";
		}
	}
	
	
	
	
}
