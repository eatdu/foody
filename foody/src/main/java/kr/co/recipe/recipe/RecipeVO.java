package kr.co.recipe.recipe;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecipeVO {

	private int no;
//	private int user_no; //NULL
	private String name;
	private String intro;
	private int type;
	private String time;
//	private String thumbnail;
	private String tip;
	private int serving;
	private Timestamp regdate;
 	private int print;
//	private int temp; //임시저장
}
