package kr.co.recipe.recipe;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IngredientServiceImpl implements IngredientService {

	@Autowired
	IngredientMapper mapper;
	
	@Override
	public List<String> large_cate(int large_cate) {
		return mapper.large_cate(large_cate);
	}
	
	@Override
	public List<IngredientVO> detail_cate(String detail_cate){
		
//		List<IngredientVO> list = mapper.detail_cate(detail_cate);
//		List<String> detailList = new ArrayList<>();
//		
//		for(int i=0; i<list.size(); i++) {	
//			detailList.add(list.get(i).getDetail());
//		}
		return mapper.detail_cate(detail_cate);
	}
	
	@Override
	public List<IngredientVO> nameSearch(){
		return mapper.nameSearch();
	}
}
