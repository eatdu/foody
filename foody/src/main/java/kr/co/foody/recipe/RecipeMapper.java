package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecipeMapper {

	int insert(RecipeVO vo);

	List<IngredientVO> selectIngreList(int no);
	List<String> selectIngreNameList(int no);
	List<String> selectIngreNameList2(String keyword);
	List<IngredientVO> selectIngreDetail(String keyword);
	
	
	List<RecipeVO> selectAll(Map cri);
	List<RecipeVO> selectIngreOrKey(Map cri);
	List<RecipeVO> selectR(Map cri);
	List<RecipeVO> selectWithFilter(Map cri);
	int countWithFilter(Map cri);
	
	List<Integer> selectIngreNo(String str);
	
	int insertRandomUser(Map user);
	int insertAllergyUser(Map user);
	int insertFeedback(Map User);
	int randomReg(int no);
}
