package kr.co.foody.comment;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CommentController {
	
	@Autowired
	CommentService service;
	
	@GetMapping("/comment/list.do")
	public String list(CommentVO vo, Model model) {
		model.addAttribute("comment", service.index(vo));
		return "common/comment";
	}
	
	@PostMapping("/comment/insert.do")
	public String insert(CommentVO vo, Model model,
						@RequestParam MultipartFile uploadFile, HttpServletRequest req) {
		
		if (!uploadFile.isEmpty()) {
			// 파일명 구하기
			String org = uploadFile.getOriginalFilename(); // 사용자가 첨부한 첨부파일명
			String ext = org.substring(org.lastIndexOf(".")); // 확장자 추출
			String real = new Date().getTime()+ext; // 실제 파일명
			
			// 파일 저장
			String path = req.getRealPath("/upload/"); // 경로 불러오는 방법 중 하나 - request에서
			System.out.println(path);
			try {
				uploadFile.transferTo(new File(path+real));
			} catch (Exception e) {System.out.println(e.toString());}
			
			vo.setPhoto(real);
		}
		model.addAttribute("result", service.insert(vo));
		return "common/return";
	}
	
	@PostMapping("/comment/insert_reCmt.do")
	public String insert_reCmt(CommentVO vo, Model model) {
		
		model.addAttribute("result", service.insert_reCmt(vo));
		return "common/return";
	}
	
	@PostMapping("/comment/update.do")
	public String update(CommentVO vo, Model model) {
		model.addAttribute("result", service.update(vo));
		return "common/return";
	}
	
	@GetMapping("/comment/delete.do")
	public String delete(CommentVO vo, Model model, @RequestParam int no) {
		model.addAttribute("result", service.delete(no));
		return "common/return";
	}
	
}
