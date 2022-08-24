package kr.co.foody.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;

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
	
	@Override
	public RecipeVO view(int no) {
		mapper.updateRecipeViewCount(no);
		return mapper.view(no);
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
	public Map search(Map cri, Model model, HttpSession sess) {
		String title2 = "";

		//로그인 한 경우 알러지 조건 추가
		if (sess.getAttribute("loginInfo") != null
				&& ((List)sess.getAttribute("allergyNo")).size() != 0 
				&& cri.get("allergyChk").equals("1")) {
			cri.put("allergyArr", sess.getAttribute("allergyNo"));
		}
		//검색어 배열을 sql날리기 위해 재조합
		if (cri.get("keywordArr") != null) {
			String str = "'" + (String)((List)cri.get("keywordArr")).get(0);
			for (int i=1; i<((List)cri.get("keywordArr")).size(); i++) {
				str += "|" + (String)((List)cri.get("keywordArr")).get(i);
			}
			str += "'";
			cri.put("keywordArr", mapper.selectIngreNo(str));
			
			//검색 결과 제목 설정 - 키워드;
			title2 += "재료(" + str.replace("'", "").replace("|", ",") + ") ";
		}
		//검색 결과 제목 설정 - 음식 분류
		if (cri.get("rcpCateArr") != null) {
			String str = "" + RecipeCategory.RcpCateArr[Integer.parseInt((String)((List)cri.get("rcpCateArr")).get(0)) - 1] ;
			for (int i = 1; i < ((List)cri.get("rcpCateArr")).size(); i++) {
				str += "," + RecipeCategory.RcpCateArr[Integer.parseInt((String)((List)cri.get("rcpCateArr")).get(i)) - 1];
			}
			title2 += "음식 분류(" + str + ") ";
		}
		//검색 결과 제목 설정 - 재료 분류
		if (cri.get("ingreCateArr") != null) {
			String str = "" + IngredientCategory.IngreCateArr[Integer.parseInt((String)((List)cri.get("ingreCateArr")).get(0)) - 1] ;
			for (int i = 1; i < ((List)cri.get("ingreCateArr")).size(); i++) {
				str += "," + IngredientCategory.IngreCateArr[Integer.parseInt((String)((List)cri.get("ingreCateArr")).get(i)) - 1];
			}
			title2 += "재료 분류(" + str + ") ";
		}
		
		
		Map result = new HashMap();
		result.put("title", (String)cri.get("title"));
		result.put("areaNo", cri.get("areaNo"));
		result.put("orderBy", cri.get("orderBy"));

		//검색타입 - 상세검색(common)
		if(cri.get("type").equals("common")) {
			result.put("title2", title2);
			//키워드 입력으로 검색 들어온 경우
			if (cri.get("sType") != null && cri.get("keyword") != null) {
				model.addAttribute("sType", cri.get("sType"));
				model.addAttribute("keyword", cri.get("keyword"));
				//제목 입력
				if ("recipe".equals(cri.get("sType"))) {
					cri.put("rKeyword", cri.get("keyword"));
					result.put("title2", "요리명 " + cri.get("keyword") + "(으)로 검색한 결과");
				}
				//재료 입력
				else if ("ingre".equals(cri.get("sType"))) {
					cri.put("keywordArr", mapper.selectIngreNo("'" + cri.get("keyword") + "'"));
					result.put("title2", "재료 " + cri.get("keyword") + "(으)로 검색한 결과");
				}
			}
			//검색조건 하에서 총 게시물 수
			int count = mapper.countWithFilter(cri);
			result.put("count", count);

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
			//최종 검색
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
		System.out.println(cri);
		return result;
	}
}
