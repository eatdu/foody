package kr.co.foody.constants;

import java.util.HashMap;
import java.util.Map;

public class RecipeCategory {

	public static Map<String, Integer> rcpCate = new HashMap<String, Integer>();
	public static final String[] RcpCateArr = {
	        "밥", "떡/한과", "만두/면류", "국", "나물/생채/샐러드"
	        , "구이", "볶음", "밑반찬/김치", "조림", "찜"
	        , "튀김/커틀릿", "찌개/전골/스튜", "도시락/간식", "부침", "샌드위치/햄버거"
	        , "빵/과자", "양념장", "음료", "그라탕/리조또"
	};
	
	public static Map getRcpCate() {
        rcpCate.put("밥", 1);
        rcpCate.put("떡/한과", 2);
        rcpCate.put("만두/면류", 3);
        rcpCate.put("국", 4);
        rcpCate.put("나물/생채/샐러드", 5);
        rcpCate.put("구이", 6);
        rcpCate.put("볶음", 7);
        rcpCate.put("밑반찬/김치", 8);
        rcpCate.put("조림", 9);
        rcpCate.put("찜", 10);
        rcpCate.put("튀김/커틀릿", 11);
        rcpCate.put("찌개/전골/스튜", 12);
        rcpCate.put("도시락/간식", 13);
        rcpCate.put("부침", 14);
        rcpCate.put("샌드위치/햄버거", 15);
        rcpCate.put("빵/과자", 16);
        rcpCate.put("양념장", 17);
        rcpCate.put("음료", 18);
        rcpCate.put("그라탕/리조또", 19);
		
		return rcpCate;
	}
	
}
