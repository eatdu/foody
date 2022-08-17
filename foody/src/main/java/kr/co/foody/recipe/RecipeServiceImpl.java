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
		if (cri.get("keywordArr") != null) {
			String str = "'" + (String)((List)cri.get("keywordArr")).get(0);
			for (int i=1; i<((List)cri.get("keywordArr")).size(); i++) {
				str += (String)((List)cri.get("keywordArr")).get(i);
			}
			str += "'";
			cri.put("keywordArr", mapper.selectIngreNo(str));
		}
		Map result = new HashMap();
		result.put("title", (String)cri.get("title"));

		if(cri.get("type").equals("common")) {
			result.put("list", mapper.selectWithFilter(cri));
		} else if (cri.get("type").equals("best")) {
			cri.put("startNo", 1);
			cri.put("endNo", 20);
			result.put("list1", mapper.selectAll(cri));
			result.put("list1Name", "인기 레시피");
		} else if (cri.get("type").equals("prefer")) {
			cri.put("rcpCateArr", cri.get("preferArr"));
			result.put("list", mapper.selectWithFilter(cri));
		}
		return result;
	}

}
