package kr.co.foody.comment;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentVO {
	
	private int no;
	private int user_no;
	private int board_no;
	private Timestamp regdate;
	private String tablename;
	private String photo;
	private String content;
	private String user_name;
	private Timestamp updatedate;
	
	private int startIdx;
	private int page;
	private int pageRow;
	
	public CommentVO() {
		this.page = 1;
		this.pageRow = 10;
	}

}
