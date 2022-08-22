package kr.co.foody.recipe;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecipeVO {
	
	private int no;
	private int user_no; //NULL
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
 	
 	//정렬기준
 	private int bookmark;
 	private double star;
 	private int reply;
 	
 	public double getStar() {
 		return (int)(star * 10) / 100.0;
 	}
 	
}
