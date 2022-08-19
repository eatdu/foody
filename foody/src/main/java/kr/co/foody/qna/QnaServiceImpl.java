package kr.co.foody.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	QnaMapper mapper;
	
	@Override
	public int insert(QnaVO vo) {
		return mapper.insert(vo);
	}
	
	@Override
	public int reply(QnaVO vo) {
		mapper.onoUpdate(vo);
		vo.setOno(vo.getOno()+1);
		vo.setDepth(vo.getDepth()+1);
		return mapper.reply(vo);
	}
	
	@Override
	public Map getFaq(QnaVO vo) {
		int totalCount = mapper.count(vo); // 총게시물수
		int totalPage = totalCount / vo.getPageRow(); // 총페이지수
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() - 1) * vo.getPageRow(); // 시작인덱스
		vo.setStartIdx(startIdx);
		List<QnaVO> list = mapper.getFaq(vo);
		
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
	public Map getMyQna(QnaVO vo) {
		int totalCount = mapper.count_myQna(vo); // 총게시물수
		int totalPage = totalCount / vo.getPageRow(); // 총페이지수
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() - 1) * vo.getPageRow(); // 시작인덱스
		vo.setStartIdx(startIdx);
		List<QnaVO> list = mapper.getMyQna(vo);
		
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
	public QnaVO edit(int no) {
		return mapper.view(no);
	}
	
	@Override
	public QnaVO view(int no) {
		return mapper.view(no);
	}
	
	@Override
	public int update(QnaVO vo) {
		return mapper.update(vo);
	}
	@Override
	public boolean delete(int no) {
		return mapper.delete(no);
	}

	
}