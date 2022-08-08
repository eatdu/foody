package kr.co.foody.recipe;

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

}
