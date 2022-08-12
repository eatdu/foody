package kr.co.recipe.recipe;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class IngredientVO {
	private int no;
	private int allergy_no;
	private String name;
	private double carbo;
	private double protein;
	private double fat;
	private int large_cate;
	private String detail;
	private int print;

//	private List<IngredientVO> IngredientVOList;
//
//	public List<IngredientVO> getIngredientVOList() {
//		return IngredientVOList;
//	}
//
//	public void setIngredientVOList(List<IngredientVO> IngredientVOList) {
//		this.IngredientVOList = IngredientVOList;
//	}

}
