package kr.co.foody.recipe;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class SampleDataMaker {

	@Autowired
	RecipeMapper mapper;
	
	//@Test
	public void randomRecent() {
		for(int user_no = 23; user_no <= 121; user_no++) {
			for(int recipe_no = 1; recipe_no <= 200; recipe_no++) {
				Map map = new HashMap();
				map.put("user_no", user_no);
				map.put("recipe_no", recipe_no);
				if (Math.random() < 0.05) {
					mapper.insertRecent(map);
				}
			}
		}
	}
	
	//@Test
	public void randomRcpUser() {
		for(int i = 351; i <= 500; i++) {
			Map map = new HashMap();
			map.put("userNo", 55 + (int)(Math.random() * 10));
			map.put("no", i);
			//System.out.println(map);
			mapper.randomRcpUser(map);
		}
	}
	
	@Test
	public void randomReg() {
		for (int i=351; i<=500; i++) {
			mapper.randomReg(i);
		}
	}
	
	//@Test
	public void feedbackMaker() {
		// 회원번호 - 21~120 / 레시피 번호 - 1~200
		for (int userNo = 21; userNo <= 120; userNo++) {
			double bmkProb = Math.random();
			double starProb = Math.random();
			for (int rcpNo = 1; rcpNo<= 200; rcpNo++) {
				int bmk = 0;
				int star = -1;
				Map user = new HashMap();
				if (Math.random() < bmkProb) {
					bmk = 1;
				}
				if (Math.random() < starProb + 0.2) {
					star = (int)(Math.random() * 11) * 5;
				}
				user.put("userNo", userNo);
				user.put("rcpNo", rcpNo);
				user.put("bmk", bmk);
				user.put("star", star);
				if(bmk != 0 && star != -1) {
					mapper.insertFeedback(user);
				}
			}
		}
	}
	
	public String telMaker() {
		int a = 1000 + (int)(Math.random() * 9000);
		int b = 1000 + (int)(Math.random() * 9000);
		return "010" + a + b;
	}
	
	public String birthMaker() {
		int yy = 60 + (int)(Math.random() * 40);
		int mm = (int)(Math.random() * 12);
		int dd = (int)(Math.random() * 30);
		int gender = 1+ (int)(Math.random() * 2);
	
		if (mm < 10) {
			if (dd < 10) {
				return "" + yy + "0" + mm + "0" + dd + gender;
			} else {
				return "" + yy + "0" + mm + dd + gender;
			}
		} else {
			if (dd < 10) {
				return "" + yy + mm + "0" + dd + gender;
			} else {
				return "" + yy + mm + dd + gender;
			}
		}
	}
	
	//@Test
	public void insertUser() {
		for (int i=0; i<100; i++) {
			Map user = new HashMap();
			user.put("email", RandomUserInsertTest.emailArr[i]);
			user.put("nik_name", RandomUserInsertTest.nickArr1[i/10] + RandomUserInsertTest.nickArr2[i%10]);
			user.put("name", RandomUserInsertTest.nameArr[i]);
			user.put("intro", RandomUserInsertTest.intro);
			user.put("pwd", "test1234");
			user.put("tel", telMaker());
			user.put("birth", birthMaker());
			user.put("height", 160 + (int)(Math.random() * 20));
			user.put("weight", 50 + (int)(Math.random() * 30));
			mapper.insertRandomUser(user);
		}
	}
	
	//@Test
	public void insertUserAllergy() {
		for (int i = 23; i <= 121; i++) {
			Random r = new Random();
			int count = (int)(Math.random() * 4);
			int a[] = new int[count];
			
			for(int k=0; k<count; k++){
				a[k] = r.nextInt(19) + 1; // 1 ~ 99까지의 난수 
				for(int j=0; j<k; j++){
					if(a[k] == a[j]){
						k--;
					}
				}
			}
			for(int k=0; k<count; k++) {
				Map user = new HashMap();
				user.put("userNo", i);
				user.put("preferFood", a[k]);
				//System.out.println(user);
				mapper.insertAllergyUser(user);
			}
		}
	}
}
