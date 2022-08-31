package kr.co.foody.qna;

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
	
	// FAQ 페이지 출력
	@GetMapping("/board/qna.do")
	public String getFaq(QnaVO vo, Model model) {
		model.addAttribute("data", service.getFaq(vo));
		return "board/qna";
	}
	
	// 내가 한 질문 페이지 출력
	@GetMapping("/board/myQna.do")
	public String getmyQna(QnaVO vo, Model model, HttpSession sess) {
		
		UserVO uv = (UserVO)sess.getAttribute("loginInfo");
		if (uv != null) {
			vo.setUser_no(uv.getNo());
			model.addAttribute("myQna", service.getMyQna(vo));
			return "board/myQna";
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/foody/user/login.do");
			return "common/alert";
		}
	}
	
	// 등록폼
	@GetMapping("/board/qna_write.do")
	public String write() {
		return "board/qna_write";
	}
	
	// 등록처리
	@PostMapping("/board/qna_insert.do")
	public String insert(QnaVO vo, Model model,
			@RequestParam MultipartFile file,
			HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		UserVO uv = (UserVO)session.getAttribute("loginInfo");
		vo.setUser_no(uv.getNo());
		
		if (service.insert(vo) == 1) {
			model.addAttribute("msg", "게시물이 저장되었습니다.");
			model.addAttribute("url", "myQna.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "게시물을 저장할 수 없습니다.");
			return "common/alert";
		}
	}
	
	// 답변폼
	@GetMapping("/board/qna_reply.do")
	public String reply(QnaVO vo, Model model) {
		QnaVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "reply/reply";
	}
	
	// 답변처리
	/*
	@PostMapping("/board/qna_reply.do")
	public String reply(QnaVO vo, Model model, HttpServletRequest req) {
		
		// member_no 저장 // write.jsp 에서 하기보다 안전
		HttpSession sess = req.getSession();
		UserVO mv = (UserVO)sess.getAttribute("loginInfo"); // 세션에서 loginInfo 꺼내
		if (mv != null) vo.setUser_no(mv.getNo()); // mv에 있는 no만 꺼내 vo에 set
		
		if (service.reply(vo) == 1) { // 여기 수정해야 새글 아닌 답변이 등록됨
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "index.do"); // 저장 성공 후 게시판으로 이동
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장 실패했습니다.");
			return "common/alert";
		}
	}
	*/
	
	// 상세보기
	@GetMapping("/board/qna_view.do")
	public String view(QnaVO vo, Model model) {
		QnaVO data = service.view(vo.getNo());
		model.addAttribute("data", data);
		return "board/qna_view";
	}
	
	// 수정폼
	@GetMapping("/board/qna_edit.do")
	public String edit(QnaVO vo, Model model) {
		QnaVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "board/edit";
	}
	
	// 수정처리
	@PostMapping("board/qna_update.do")
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
	@GetMapping("board/qna_delete.do")
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