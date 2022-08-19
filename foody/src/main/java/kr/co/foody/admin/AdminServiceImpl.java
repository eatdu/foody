package kr.co.foody.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.recipe.IngredientMapper;
import kr.co.foody.recipe.IngredientVO;
import kr.co.foody.user.UserMapper;
import kr.co.foody.user.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	IngredientMapper ingreMapper;
	
	@Autowired
	UserMapper userMapper;
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
	@Override
	public boolean userReport(HttpSession sess) {
		sess.setAttribute("countAllUser", userMapper.countAllUser());
		sess.setAttribute("countUserWithPeriod", userMapper.countUserWithPeriod());
		return false;
	}
	
}
