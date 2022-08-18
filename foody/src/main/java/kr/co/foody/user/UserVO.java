package kr.co.foody.user;

import java.util.List;

import kr.co.foody.mypage.MypageVO;
import lombok.Data;

@Data
public class UserVO {

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
	private int print;
	private int exit;
	
	private int allergy_no;
	private int prefer_no;
	private String allergy;
	
	private List<MypageVO> mypageList;
	
	
	
	
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