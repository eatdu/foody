package kr.co.foody.recipe;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IngredientMapper {

	List<String> large_cate(int i);
}
