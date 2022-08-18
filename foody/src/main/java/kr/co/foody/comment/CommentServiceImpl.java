package kr.co.foody.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.board.BoardVO;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentMapper mapper;

	@Override // 댓글 등록
	public int insert(CommentVO vo) {
		int r = mapper.insert(vo);
		if (r == 1) mapper.gnoUpdate(vo.getNo()); // 등록되면 gno를 no로 업뎃
		return r;
	}
	
	@Override // 대댓글 등록
	public int insert_reCmt(CommentVO vo) {
		mapper.onoUpdate(vo);
		vo.setOno(vo.getOno()+1);
		vo.setDepth(vo.getDepth()+1);
		int r = mapper.insert_reCmt(vo);
		return r;
	}

	@Override
	public int update(CommentVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(CommentVO vo) {
		return mapper.delete(vo.getNo());
	}

	@Override
	public Map index(CommentVO vo) {
		
		int totalCount = mapper.count(vo); // 총게시물수
		int totalPage = totalCount / vo.getPageRow(); // 총페이지수
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() - 1) * vo.getPageRow(); // 시작인덱스
		vo.setStartIdx(startIdx);
		List<CommentVO> list = mapper.list(vo);
		
		int endPage = (int)(Math.ceil(vo.getPage()/10.0) * 10); // 끝페이지
		int startPage = endPage - 9; // 시작페이지
		
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false; // prev 버튼
		boolean next = endPage < totalPage ? true : false; // next 버튼
		
		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("list", list);
		
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		
		return map;
	}

}