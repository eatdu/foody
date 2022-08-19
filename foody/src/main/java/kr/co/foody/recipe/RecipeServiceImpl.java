package kr.co.foody.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	RecipeMapper mapper;
	
	@Autowired
	IngredientMapper mapper2;
	
	@Override
	public int insert(RecipeVO vo){
		return mapper.insert(vo);
	}

	@Override
	public List<String> large_cate(int i) {
		return mapper2.large_cate(i);
	}
	//재료명 리스트 - 재료 분류 번호
	@Override
	public List<Map> makeIngreNameList(int no) {
		List<String> result = mapper.selectIngreNameList(no);
		List<Map> list = new ArrayList<Map>();
		for (String name : result) {
			Map map = new HashMap();
			map.put("text", name);
			map.put("value", name);
			list.add(map);
		}
		return list;
	}
	//재료명 리스트 - 검색어
	@Override
	public List<Map> makeIngreNameList(String keyword) {
		List<String> result = mapper.selectIngreNameList2(keyword);
		List<Map> list = new ArrayList<Map>();
		for (String name : result) {
			Map map = new HashMap();
			map.put("text", name);
			map.put("value", name);
			list.add(map);
		}
		return list;
	}
	//재료 상세 리스트
	@Override
	public List<Map> makeIngreDetailList(String keyword) {
		List<IngredientVO> result = mapper.selectIngreDetail(keyword);
		List<Map> list = new ArrayList<Map>();
		for (IngredientVO vo : result) {
			Map map = new HashMap();
			map.put("text", vo.getDetail());
			map.put("value", vo.getNo());
			list.add(map);
		}
		return list;
	}

	@Override
	public Map search(Map cri, HttpSession sess) {
		//로그인 한 경우 알러지 조건 추가
		if (sess.getAttribute("loginInfo") != null && ((List)sess.getAttribute("allergyNo")).size() != 0 ) {
			cri.put("allergyArr", sess.getAttribute("allergyNo"));
		}
		//검색어 배열을 sql날리기 위해 재조합
		if (cri.get("keywordArr") != null) {
			String str = "'" + (String)((List)cri.get("keywordArr")).get(0);
			for (int i=1; i<((List)cri.get("keywordArr")).size(); i++) {
				str += '|' + (String)((List)cri.get("keywordArr")).get(i);
			}
			str += "'";
			cri.put("keywordArr", mapper.selectIngreNo(str));
		}
		Map result = new HashMap();
		result.put("title", (String)cri.get("title"));

		//검색타입 - 상세검색(common)
		if(cri.get("type").equals("common")) {
			//검색조건 하에서 총 게시물 수
			int count = mapper.countWithFilter(cri);

			//받아올것 : 현재 페이지 - pageNo / 페이지당 12개 / 블럭당 5개
			int pageNo = (int)cri.get("pageNo");
			
			//sql로 넘길것 : rno 검색조건
			int startRno = (pageNo - 1) * 12 + 1;
			int endRno = pageNo * 12;
			cri.put("startRno", startRno);
			cri.put("endRno", endRno);

			//(첫 페이지, 끝 페이지) - 배열로 넘김
			int startNo = (pageNo - 1) / 5 * 5 + 1;
			int endNo = startNo + 4;
			//이전 여부
			if (startNo == 1) result.put("prev", false);
			else result.put("prev", true);
			//다음 여부
			if (endNo > (count - 1) / 12 + 1) {
				result.put("next", false);
				endNo = (count - 1) / 12 + 1;
			}
			else result.put("next", true);
			
			List<Integer> paging = new ArrayList();
			for(int i = startNo; i <= endNo; i++) {
				paging.add(i);
			}
			result.put("paging", paging);
			//현재 페이지
			result.put("curNo", pageNo);
			result.put("list", mapper.selectWithFilter(cri));
		} else if (cri.get("type").equals("best")) {
			//인기레시피 - 인기순 정렬
			cri.put("startRno", 1);
			cri.put("endRno", 20);
			result.put("list", mapper.selectWithFilter(cri));
		} else if (cri.get("type").equals("prefer")) {
			//추천레시피 - 개인 선호도 필터
			if (sess.getAttribute("loginInfo") != null && ((List)sess.getAttribute("preferNo")).size() != 0 ) {
				cri.put("rcpCateArr", sess.getAttribute("preferNo"));
			}
			cri.put("startRno", 1);
			cri.put("endRno", 20);
			result.put("list", mapper.selectWithFilter(cri));
		}
		return result;
	}



}
