package kr.co.foody.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CommentController {
	
	@Autowired
	CommentService service;
	
	@GetMapping("/comment/list.do")
	public String list(CommentVO vo, Model model) {
		model.addAttribute("comment", service.index(vo));
		return "common/comment";
	}
	
	@GetMapping("/comment/insert.do")
	public String insert(CommentVO vo, Model model) {
		model.addAttribute("result", service.insert(vo));
		return "common/return";
	}
	
	@PostMapping("/comment/update.do")
	public String update(CommentVO vo, Model model) {
		model.addAttribute("result", service.update(vo));
		return "common/return";
	}
	
	@GetMapping("/comment/delete.do")
	public String delete(CommentVO vo, Model model) {
		model.addAttribute("result", service.delete(vo));
		return "common/return";
	}
}
