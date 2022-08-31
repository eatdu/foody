package kr.co.foody.recipe;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.co.foody.comment.CommentMapper;
import lombok.extern.log4j.Log4j;
import util.DownloadImg;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class SampleDataMaker {

	@Autowired
	RecipeMapper mapper;
	@Autowired
	CommentMapper commentMapper;
	
	//@Test
	public void tipMaker() {
		//2648
		for (int no = 177; no <= 500; no++) {
			RecipeVO vo = mapper.view(no);
			if (vo == null || vo.getTip() != null) continue;
			Map map = new HashMap();
			map.put("no", no);
			map.put("tip", "맛있게 드세요~!!^^");
			mapper.copyThumbnail(map);
		}
	}
	
	//@Test
	public void imgDownloader() {
//		for (int no = 11; no <= 2648; no++) {
//			ProcessVO vo = mapper.selectProcess(no);
//			if (vo == null) continue;
//			Map map = new HashMap();
//			map.put("no", no);
//			map.put("photo", vo.getPhoto());
//			mapper.copyThumbnail(map);
//		}
		
		List<Integer> errorList = new ArrayList<Integer>();
		for (int no = 11; no <= 2648; no++) {
			ProcessVO vo = mapper.selectProcess(no);
			if (vo == null || "".equals(vo.getPhoto())) continue;
			String url = vo.getPhoto();
			String realPath = "C:\\Users\\tjoeun-jr-902-10\\git\\foody\\foody\\src\\main\\webapp\\upload\\";
			String ext = "jpg";
			String fileName = new Date().getTime() + "";
			try {
				DownloadImg.saveImage(url, realPath, fileName, ext);
				Map map = new HashMap();
				map.put("no", no);
				map.put("photo", fileName + "." + ext);
				mapper.copyThumbnail(map);
			} catch (Exception e) {
				e.printStackTrace();
				errorList.add(no);
			}
		}
		System.out.println(errorList);
	}
	
	
	//@Test
	public void updatePwd() {
		for(int i = 23; i < 122; i++) {
			mapper.updatePwd(i);
		}
	}
	
	//@Test
	public void randomComment2() {
		for(int i = 5057; i < 5197; i++) {
			Map map = new HashMap();
			map.put("gno", i);
			mapper.updateComment2(map);
		}
	}
	
	//@Test
	public void randomComment() {
		for(int boardNo = 1; boardNo <= 14; boardNo++) {
			for(int i = 0; i < 10; i++) {
				Map map = new HashMap();
				map.put("boardNo", boardNo);
				map.put("userNo", 22 + (int)(Math.random() * 100));
				mapper.insertComment(map);
			}
		}
	}
	
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
		System.out.println(Math.random());
//		for(int i = 351; i <= 500; i++) {
//			Map map = new HashMap();
//			map.put("userNo", 55 + (int)(Math.random() * 10));
//			map.put("no", i);
//			//System.out.println(map);
//			mapper.randomRcpUser(map);
//		}
	}
	
	//@Test
	public void randomReg() {
		for (int i=56; i<=5196; i++) {
			mapper.randomReg(i);
		}
	}
	
	//@Test
	public void feedbackMaker() {
		for (int rcpNo = 11; rcpNo<= 500; rcpNo++) {
			commentMapper.updateAvgstar(rcpNo);
		}
		
		// 회원번호 - 22~121 / 레시피 번호 - 1~200
//		for (int userNo = 22; userNo <= 121; userNo++) {
//			double bmkProb = Math.random();
//			double starProb = Math.random();
//			for (int rcpNo = 201; rcpNo<= 500; rcpNo++) {
//				int bmk = 0;
//				int star = -1;
//				Map user = new HashMap();
//				if (Math.random() < bmkProb) {
//					bmk = 1;
//				}
//				if (Math.random() < starProb + 0.2) {
//					star = (int)(Math.random() * 3 + 3) * 10;
//				}
//				user.put("userNo", userNo);
//				user.put("rcpNo", rcpNo);
//				user.put("bmk", bmk);
//				user.put("star", star);
//				if(bmk != 0 || star != -1) {
//					//System.out.println(user);
//					mapper.insertFeedback(user);
//				}
//			}
//		}
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
				System.out.println(user);
				//mapper.insertAllergyUser(user);
			}
		}
	}
}
