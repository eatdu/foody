package kr.co.foody.recipe;

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
	public List<RecipeVO> selectRecipeListWithCri(Map cri) {
		
		return mapper.selectRecipeListWithCri(cri);
	}
	
}
