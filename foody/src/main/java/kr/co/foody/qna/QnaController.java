package kr.co.foody.qna;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.foody.user.UserVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping
@Slf4j
public class QnaController {
	
	@Autowired
	QnaService service;
	
	// 목록보기
	@GetMapping("/qna/qna.do")
	public String index(QnaVO vo, Model model) {
		model.addAttribute("data", service.getFaq(vo));
		return "board/qna";
	}
	
	// 등록폼
	@GetMapping("/board/write.do")
	public String write() {
		return "board/write";
	}
	
	// 등록처리
	@PostMapping("/board/insert.do")
	public String insert(QnaVO vo, Model model,
			@RequestParam MultipartFile file,
			HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		UserVO uv = (UserVO)session.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		
		if (service.insert(vo) == 1) {
			model.addAttribute("msg", "게시물이 저장되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "게시물을 저장할 수 없습니다.");
			return "common/alert";
		}
	}
	
	// 상세보기
	@GetMapping("/board/view.do")
	public String view(QnaVO vo, Model model) {
		QnaVO data = service.view(vo.getNo());
		model.addAttribute("data", data);
		return "board/view";
	}
	
	// 수정폼
	@GetMapping("/board/edit.do")
	public String edit(QnaVO vo, Model model) {
		QnaVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "board/edit";
	}
	
	// 수정처리
	@PostMapping("board/update.do")
	public String update(QnaVO vo, Model model) {
		
		if (service.update(vo) == 1) {
			model.addAttribute("msg", "게시물이 수정되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "게시물을 수정할 수 없습니다.");
			return "common/alert";
		}
	}
	
	// 삭제처리
	@GetMapping("board/delete.do")
	public String delete(QnaVO vo, Model model) {
		if (service.delete(vo.getNo())) {
			model.addAttribute("msg", "게시물이 삭제되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "게시물을 삭제할 수 없습니다.");
			return "common/alert";
		}
	}
	
	
	
}