package kr.co.foody.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.recipe.IngredientMapper;
import kr.co.foody.recipe.IngredientVO;
import kr.co.foody.recipe.RecipeMapper;
import kr.co.foody.user.UserMapper;
import kr.co.foody.user.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	IngredientMapper ingreMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	RecipeMapper rcpMapper;
	
	
	// 재료 정보 관련
	@Override
	public IngredientVO ingreInfo(int no) {
		IngredientVO vo = ingreMapper.ingreInfo(no); 
		if (vo.getAllergy_no() == 0) {
			vo.setAllergyName("없음");
			vo.setCateName(IngredientCategory.IngreCateArr[vo.getLarge_cate() - 1]);
			return vo;
		} else {
			IngredientVO vo2 = ingreMapper.ingreInfoWithName(no);
			vo2.setCateName(IngredientCategory.IngreCateArr[vo.getLarge_cate() - 1]);
			return vo2;
		}
	}

	@Override
	public List<String> makeAllergyList() {
		List list = userMapper.getAllergy();
		List result = new ArrayList();
		for(int i=0; i<list.size(); i++) {
			result.add(((UserVO)list.get(i)).getAllergy());
		}
		return result;
	}
	
	//가입자 통계 관련
	//메인 - 가입자 카운트
	@Override
	public boolean userReport(HttpSession sess) {
		Map result = new HashMap();
		result.put("all", userMapper.countAllUser());
		result.put("withM", userMapper.countUserWithPeriod());
		sess.setAttribute("cntUser", result);
		return false;
	}

	//레시피 통계 관련
	//1. 메인 - 레시피 카운트
	@Override
	public boolean rcpCount(Map cri, HttpSession sess) {
		Map result = new HashMap();
		String where = " ";
		result.put("all", rcpMapper.count(where));
		where += "WHERE regdate > SUBDATE(NOW(), INTERVAL 1 WEEK)"
				+" AND regdate < NOW()";
		result.put("weekAll", rcpMapper.count(where));
		String where1 = where 
				+ " AND adminchk = 1";
		result.put("checked", rcpMapper.count(where1));
		String where2 = where
				+ " AND adminchk = 0";
		result.put("notChecked", rcpMapper.count(where2));
		sess.setAttribute("cntRcp", result);
		return false;
	}
}
