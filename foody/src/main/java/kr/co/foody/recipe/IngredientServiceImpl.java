package kr.co.foody.recipe;

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
		
		return mapper.detail_cate(detail_cate);
	}
	
	@Override
	public List<IngredientVO> nameSearch(){
		return mapper.nameSearch();
	}

	@Override
	public boolean updateIngre(IngredientVO vo) {
		return mapper.updateIngre(vo);
	}
	
	@Override
	public boolean insertIngre(IngredientVO vo) {
		return mapper.insertIngre(vo);
	}
}
