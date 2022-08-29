package kr.co.foody.mypage;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import util.Paging;

@Getter
@Setter
@ToString
public class MypageVO extends Paging {

	private int no;
	private int user_no;
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
 	private int comment_count;
 	
 	private int urcount;
 	private int ubcount;
 	private int utvcount;
 	private int uccount;

 	public void pagingProcess(int pageRow, int totalCount) {
		this.pageRow = pageRow;
		
		this.totalPage = totalCount / pageRow;
		if(totalCount % pageRow > 0) totalPage++;
		
		this.endPage = (int)(Math.ceil(page/10.0) * 10);
		this.startPage = endPage - 9;
		
		if(endPage > totalPage) endPage = totalPage;
		this.prev = startPage > 1;
		this.next = endPage < totalPage;
	}
 	
 	public int getStartIdx() {
 		return this.startIdx = (this.page - 1) * this.pageRow;
 	}

}