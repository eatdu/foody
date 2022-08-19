package kr.co.foody.mypage;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MypageVO {

	private int no;
//	private int user_no; //NULL
	private String name;
	private String intro;
	private int type;
	private String time;
	private String thumbnail;
	private String tip;
	private int serving;
	private Timestamp regdate;
 	private int print;
//	private int temp; //임시저장
 	private int viewcount;
	
	//private RecipeVO recipe;
 	
 	private int u_allergyNo;
 	private String allergy;
 	private int allergy_no;
 	private int prefer_food;
 	
 	private int bookmark;


}