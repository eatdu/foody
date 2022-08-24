package kr.co.foody.user;

import java.sql.Timestamp;
import java.util.List;

import kr.co.foody.mypage.MypageVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import util.Paging;

@Getter
@Setter
@ToString
public class UserVO extends Paging {

	private int no;
	private String name;
	private String birth;
	private String nik_name;
	private String selfi;
	private String email;
	private String tel;
	private String pwd;
	private String zipcode;
	private String addr1;
	private String addr2;
	private double height;
	private double weight;
	private int activity;
	private String intro;
	private Timestamp regdate;
	private int print;
	private int exit;
	
	private int allergy_no;
	private int prefer_no;
	private String allergy;
	
	private List<MypageVO> mypageList;
	
	private int recipe_count;
	private int comment_count;
	
	
	
	
	public void setHeight(String height) {
		try {
			this.height = Double.valueOf(height);
		} catch (Exception e) {
			this.height = 0;
		}
	}
	public void setWeight(String weight) {
		try {
			this.weight = Double.valueOf(weight);
		} catch (Exception e) {
			this.weight = 0;
		}
	}
}