package kr.co.foody.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.foody.comment.CommentMapper;
import kr.co.foody.comment.CommentVO;
import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.recipe.IngredientMapper;
import kr.co.foody.recipe.IngredientVO;
import kr.co.foody.recipe.RecipeMapper;
import kr.co.foody.user.UserMapper;
import kr.co.foody.user.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	IngredientMapper ingreMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	AdminMapper adminMapper;
	@Autowired
	RecipeMapper rcpMapper;
	@Autowired
	CommentMapper commentMapper;
	
	// 재료 정보 관련
	@Override
	public IngredientVO ingreInfo(int no) {
		IngredientVO vo = ingreMapper.ingreInfo(no); 
		if (vo.getAllergy_no() == 0) {
			vo.setAllergyName("없음");
			vo.setCateName(IngredientCategory.IngreCateArr[vo.getLarge_cate() - 1]);
			return vo;
		} else {
			IngredientVO vo2 = ingreMapper.ingreInfoWithName(no);
			vo2.setCateName(IngredientCategory.IngreCateArr[vo.getLarge_cate() - 1]);
			return vo2;
		}
	}

	@Override
	public List<String> makeAllergyList() {
		List list = userMapper.getAllergy();
		List result = new ArrayList();
		for(int i=0; i<list.size(); i++) {
			result.add(((UserVO)list.get(i)).getAllergy());
		}
		return result;
	}
	
	//가입자 통계 관련
	//메인 - 가입자 카운트
	@Override
	public boolean userReport(HttpSession sess) {
		Map result = new HashMap();
		result.put("all", userMapper.countAllUser());
		result.put("withM", userMapper.countUserWithPeriod());
		sess.setAttribute("cntUser", result);
		return false;
	}

	//레시피 통계 관련
	//1. 메인 - 레시피 카운트
		
	@Override
	public boolean rcpCount(Map cri, HttpSession sess) {
		Map result = new HashMap();
		String where = " ";
		result.put("all", rcpMapper.count(where));
		where += "WHERE regdate > SUBDATE(NOW(), INTERVAL 1 WEEK)"
				+" AND regdate < NOW()";
		result.put("weekAll", rcpMapper.count(where));
		String where1 = where 
				+ " AND adminchk = 1";
		result.put("checked", rcpMapper.count(where1));
		String where2 = where
				+ " AND adminchk = 0";
		result.put("notChecked", rcpMapper.count(where2));
		sess.setAttribute("cntRcp", result);
		return false;
	}

	//2. 메인 - 댓글 카운트
	@Override
	public void commentCount(HttpSession sess) {
		CommentVO vo = new CommentVO();
		Map result = new HashMap();
		vo.setPeriod("all");
		result.put("all", commentMapper.wholeCount(vo));
		vo.setPeriod("1 month");
		result.put("month", commentMapper.wholeCount(vo));
		vo.setPeriod("1 week");
		result.put("week", commentMapper.wholeCount(vo));
		vo.setPeriod("1 day");
		result.put("day", commentMapper.wholeCount(vo));
		sess.setAttribute("cntCom", result);
	}
	
	@Override
	public Map<String, Object> userList(UserVO vo) {
		int totalCount = adminMapper.userCount();
		int totalPage = totalCount / vo.getPageRow(); // 총페이지수
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() - 1) * vo.getPageRow(); // 시작인덱스
		vo.setStartIdx(startIdx);
		
		List<UserVO> userList = adminMapper.userList(vo);
		
		int endPage = (int)(Math.ceil(vo.getPage()/10.0) * 10); // 끝페이지
		int startPage = endPage - 9; // 시작페이지
		
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false; // prev 버튼
		boolean next = endPage < totalPage ? true : false; // next 버튼
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("userList", userList);
		
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		return map;
	}

	
	@Override
	public boolean selectRcpAdmin(Map cri, Model model) {
		//검색 결과 카운트
		int count = rcpMapper.countRcpAdmin(cri); 
		int pageNo = (int)cri.get("pageNo");
		int rcpPerPage = Integer.parseInt(((String)cri.get("rcpPerPage")));
		
		//sql로 넘길것 : rno 검색조건
		int startRno = (pageNo - 1) * rcpPerPage + 1;
		int endRno = pageNo * rcpPerPage;
		cri.put("startRno", startRno);
		cri.put("endRno", endRno);
		//(첫 페이지, 끝 페이지) - 배열로 넘김
		int startNo = (pageNo - 1) / 5 * 5 + 1;
		int endNo = startNo + 4;
		//이전 여부
		if (startNo == 1) model.addAttribute("prev", false);
		else model.addAttribute("prev", true);
		//다음 여부
		if (endNo > (count - 1) / rcpPerPage + 1) {
			model.addAttribute("next", false);
			endNo = (count - 1) / rcpPerPage + 1;
		}
		else model.addAttribute("next", true);
		
		List<Integer> paging = new ArrayList();
		for(int i = startNo; i <= endNo; i++) {
			paging.add(i);
		}
		model.addAttribute("paging", paging);
		model.addAttribute("curNo", pageNo);
		model.addAttribute("count", count);
		
		List<Map> result = rcpMapper.selectRcpAdmin(cri);
		for(Map res : result) {
			res.put("type", RecipeCategory.RcpCateArr[(int)res.get("type") - 1]);
		}
		
		model.addAttribute("result", result);
		return false;
	}

	@Override
	public boolean exitUserList(HttpSession sess) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("exitUserCount", adminMapper.exitUserCount());
		map.put("exitCountMonth", adminMapper.exitUserWithMonth());
		sess.setAttribute("exitUserMS", map);
		System.out.println("map!!!!!!!!!!!!!!!!!!!!"+map);
		return false;
	}
	//레시피 상세 보기 로직
	@Override
	public void rcpDetail(int no) {
		rcpMapper.updateAdminChk(no);
	}

	@Override
	public AdminVO adminLogin1(AdminVO vo) {
		return adminMapper.adminLogin1(vo);
	}


}
