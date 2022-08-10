package kr.co.foody.recipe;

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
	public List<RecipeVO> selectRecipeListWithCri(Map cri) {
		
		return mapper.selectRecipeListWithCri(cri);
	}
}
