package kr.co.foody.recipe;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecipeMapper {

	int insert(Map cri);
	int insert2(Map cri);
	int insert3(Map cri);
	
	int updateRecipeViewCount(int no);
	RecipeVO view(int no);
	Map userView(int no);
	List<Map> processView(int no);
	List<Map> ingredientView(int no);
	
	int updateRecipe(Map cri);
	int deleteRecipe2(int no);
	int deleteRecipe3(int no);
	
	RegdateVO bringRegdate(RegdateVO vo);
	int updateRegdate(RegdateVO vo);
	int insertRegdate(RegdateVO vo);
	
	List<IngredientVO> selectIngreList(int no);
	List<String> selectIngreNameList(int no);
	List<String> selectIngreNameList2(Map keyword);
	List<IngredientVO> selectIngreDetail(String keyword);
	
	List<RecipeVO> selectAll(Map cri);
	List<RecipeVO> selectIngreOrKey(Map cri);
	List<RecipeVO> selectR(Map cri);
	List<RecipeVO> selectWithFilter(Map cri);
	int countWithFilter(Map cri);
	
	List<Integer> selectIngreNo(String str);
	
	
	//관리자 관련 메소드
	//  총 레시피 개수 집계
	int count(String where);
	List<Map> selectRcpAdmin(Map cri);
	int countRcpAdmin(Map cri);
	//  레시피 조회시 확인여부 변경
	boolean updateAdminChk(int no);
	//  레시피 삭제시 삭제여부 변경
	boolean updatePrint(int no);
	
	
	//샘플 데이터 생성용
	int insertRandomUser(Map user);
	int insertAllergyUser(Map user);
	int insertFeedback(Map User);
	int randomReg(int no);
	int randomRcpUser(Map map);
	int insertRecent(Map map);
	int insertComment(Map map);
	int updateComment2(Map map);
	int updatePwd(int no);
}