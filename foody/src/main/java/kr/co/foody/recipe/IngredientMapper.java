package kr.co.foody.recipe;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IngredientMapper {

	List<String> large_cate(int large_cate);
	List<IngredientVO> detail_cate(String detail_cate);
	List<IngredientVO>nameSearch();
	
}
