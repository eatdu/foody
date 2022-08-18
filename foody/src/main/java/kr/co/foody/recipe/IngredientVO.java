package kr.co.foody.recipe;

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
	
	//레시피-재료 매핑하여 가져올 때 레시피에 필요한 수량 정보
	private double weight;
	private String quantity;
	//알러지 no로 조회하여 가져온 알러지 명
	private String allergyName;
	//분류 no로 조회하여 가져온 분류 명
	private String cateName;
}
