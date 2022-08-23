package kr.co.foody.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.user.UserVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper mapper;
	
	@Override
	public int insert(BoardVO vo) {
		return mapper.insert(vo);
	}
	
	@Override
	public Map list(BoardVO vo) {
		int totalCount = mapper.count(vo); // 총게시물수
		int totalPage = totalCount / vo.getPageRow(); // 총페이지수
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() - 1) * vo.getPageRow(); // 시작인덱스
		vo.setStartIdx(startIdx);
		List<BoardVO> list = mapper.list(vo);
		
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
	
	@Override
	public BoardVO view(int no) {
		mapper.updateViewcount(no);
		return mapper.view(no);
	}
	@Override
	public BoardVO edit(int no) {
		return mapper.view(no);
	}
	
	@Override
	public int update(BoardVO vo) {
		return mapper.update(vo);
	}
	@Override
	public boolean delete(int no) {
		return mapper.delete(no);
	}
	
}