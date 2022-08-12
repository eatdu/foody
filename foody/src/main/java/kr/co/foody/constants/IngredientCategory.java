package kr.co.foody.constants;

import java.util.HashMap;
import java.util.Map;

public class IngredientCategory {

	public static Map<String, Integer> ingreCate = new HashMap<String, Integer>();
	public static final String[] IngreCateArr = {
                                 "곡류 및 그 제품", "감자 및 전분류", "당류", "두류", "견과류 및 종실류"
                                 , "채소류", "버섯류", "과실류", "육류", "난류"
                                 , "어패류 및 기타 수산물", "해조류", "우유 및 유제품류", "유지류", "차류"
                                 , "음료류", "주류", "조미료류", "조리가공품류", "기타"
                                 , "갑각류", "두족류", "수산가공품", "어류", "패류"}; 
	
	public static Map getIngreCate() {
        ingreCate.put("곡류 및 그 제품", 1);
        ingreCate.put("감자 및 전분류", 2);
        ingreCate.put("당류", 3);
        ingreCate.put("두류", 4);
        ingreCate.put("견과류 및 종실류", 5);
        ingreCate.put("채소류", 6);
        ingreCate.put("버섯류", 7);
        ingreCate.put("과실류", 8);
        ingreCate.put("육류", 9);
        ingreCate.put("난류", 10);
        ingreCate.put("어패류 및 기타 수산물", 11);
        ingreCate.put("해조류", 12);
        ingreCate.put("우유 및 유제품류", 13);
        ingreCate.put("유지류", 14);
        ingreCate.put("차류", 15);
        ingreCate.put("음료류", 16);
        ingreCate.put("주류", 17);
        ingreCate.put("조미료류", 18);
        ingreCate.put("조리가공품류", 19);
        ingreCate.put("기타", 20);
        ingreCate.put("갑각류", 21);
        ingreCate.put("두족류", 22);
        ingreCate.put("수산가공품", 23);
        ingreCate.put("어류", 24);
        ingreCate.put("패류", 25);
		
		return ingreCate;
	}
	
}
