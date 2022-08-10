package kr.co.foody.recipe;

public class IngredientVO {
	private int no;
	private String name;
	private double carbo;
	private double protein;
	private double fat;
	private int large_cate;
	private int print;
	
	//레시피-재료 매핑하여 가져올 때 레시피에 필요한 수량 정보
	private double weight;
	private String quantity;
}
