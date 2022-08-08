package kr.co.foody.user;

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
	private String addr1;
	private String addr2;
	private double height;
	private double weight;
	private int activity;
	private String intro;
	private int print;
	private int exit;
}