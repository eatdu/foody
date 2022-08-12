package kr.co.foody.board;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	
	private int no;
	private int user_no;
	private String title;
	private String content;
	private int viewcount;
	private Timestamp regdate;
	private int like;
	private String filename_org;
	private String filename_real;
	private String user_name;
	private int comment_count;
	private String writer;
	
	private String stype;
	private String sword;
	
	private int startIdx;
	private int page; // 현재 페이지번호
	private int pageRow; // 한페이지당 게시글수
	
	public BoardVO() {
		this.page = 1;
		this.pageRow = 10;
	}
	
	public BoardVO(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
}
