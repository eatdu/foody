package kr.co.foody.recipe;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IngredientServiceImpl implements IngredientService {

	@Autowired
	IngredientMapper mapper;
	
	@Override
	public List<String> large_cate(int i) {
		return mapper.large_cate(i);
	}

}
