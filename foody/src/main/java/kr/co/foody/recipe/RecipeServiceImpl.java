package kr.co.foody.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	RecipeMapper mapper;
	
	@Override
	public int insert(RecipeVO vo){
		return mapper.insert(vo);
	}

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
	

	@Override
	public Map search(Map cri) {
		List keywordArr = (List)cri.get("keywordArr");
		List ingreCateArr = (List)cri.get("ingreCateArr");
		List rcpCateArr = (List)cri.get("rcpCateArr");
		boolean keyword = keywordArr.size() == 0;
		boolean ingre = ingreCateArr.size() == 0;
		boolean rcp = rcpCateArr.size() == 0;
		Map result = new HashMap();
		result.put("type", cri.get("type"));

		if(cri.get("type").equals("search")) {
			//조건없이 검색
			if (keyword && ingre && rcp) {
				result.put("list1", mapper.selectAll(cri));
				result.put("list1Name", "모든 레시피");
			}
			//키워드로 검색
			if (!keyword && ingre && rcp) {
				cri.remove("ingreCateArr");
				cri.remove("rcpCateArr");
				result.put("list1", mapper.selectIngreOrKey(cri));
				result.put("list1Name", "재료 검색으로 검색한 결과");
			}
			//재료분류로 검색
			if (keyword && !ingre && rcp) {
				cri.remove("keywordArr");
				cri.remove("rcpCateArr");
				result.put("list1", mapper.selectIngreOrKey(cri));
				result.put("list1Name", "재료 분류로 검색한 결과");
			}
			//요리분류로 검색
			if (keyword && ingre && !rcp) {
				result.put("list1", mapper.selectR(cri));
				result.put("list1Name", "요리 분류로 검색한 결과");
			}
			//재료분류, 요리분류로 검색 -> IR -> I 조건 순
			if (keyword && !ingre && !rcp) {
				//IR
				cri.remove("keywordArr");
				result.put("list1", mapper.selectIngreOrKey(cri));
				result.put("list1Name", "재료 분류, 요리 분류로 검색한 결과");
				//I
				cri.remove("rcpCateArr");
				result.put("list2", mapper.selectIngreOrKey(cri));
				result.put("list2Name", "재료 분류로 검색한 결과");
			}
			//재료키워드, 요리분류로 검색 -> KR -> K 조건 순
			if (!keyword && ingre && !rcp) {
				//KR
				cri.remove("ingreCateArr");
				result.put("list1", mapper.selectIngreOrKey(cri));
				result.put("list1Name", "재료 키워드, 요리 분류로 검색한 결과");
				//K
				cri.remove("rcpCateArr");
				result.put("list2", mapper.selectIngreOrKey(cri));
				result.put("list2Name", "재료 키워드로 검색한 결과");
			}
			//재료키워드, 재료분류로 검색 -> KI -> K -> I 조건 순
			if (!keyword && !ingre && rcp) {
				//KI
				cri.remove("rcpCateArr");
				result.put("list1", mapper.selectIngreOrKey(cri));
				result.put("list1Name", "재료 분류, 재료 키워드로 검색한 결과");
				//K
				cri.remove("ingreCateArr");
				result.put("list2", mapper.selectIngreOrKey(cri));
				result.put("list2Name", "재료 키워드로 검색한 결과");
				//I
				cri.remove("keywordArr");
				cri.put("ingreCateArr", ingreCateArr);
				result.put("list3", mapper.selectIngreOrKey(cri));
				result.put("list3Name", "재료 분류 검색한 결과");
			}
			//재료키워드, 재료분류, 음식분류로 검색 -> KIR -> KI -> K -> I 조건 순
			if (!keyword && !ingre && !rcp) {
				//KIR
				result.put("list1", mapper.selectIngreOrKey(cri));
				result.put("list1Name", "재료 분류, 재료 키워드, 음식분류로 검색한 결과");
				//KI
				cri.remove("rcpCateArr");
				result.put("list2", mapper.selectIngreOrKey(cri));
				result.put("list2Name", "재료 분류, 재료 키워드로 검색한 결과");
				//K
				cri.remove("ingreCateArr");
				result.put("list3", mapper.selectIngreOrKey(cri));
				result.put("list3Name", "재료 키워드로 검색한 결과");
				//I
				cri.remove("keywordArr");
				cri.put("ingreCateArr", ingreCateArr);
				result.put("list4", mapper.selectIngreOrKey(cri));
				result.put("list4Name", "재료 분류 검색한 결과");
			}
		} else if (cri.get("type").equals("best")) {
			cri.put("startNo", 1);
			cri.put("endNo", 20);
			result.put("list1", mapper.selectAll(cri));
			result.put("list1Name", "인기 레시피");
		} else if (cri.get("type").equals("prefer")) {
			cri.put("startNo", 1);
			cri.put("endNo", 20);
			result.put("list1", mapper.selectAll(cri));
			result.put("list1Name", "추천 레시피");
		}
		
		return result;
	}
		


}
