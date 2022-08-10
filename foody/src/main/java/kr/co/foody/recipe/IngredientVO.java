package kr.co.foody.recipe;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class IngredientVO {
	private int no;
	private String name;
	private double carbo;
	private double protein;
	private double fat;
	private int large_cate;
	private int print;

}
