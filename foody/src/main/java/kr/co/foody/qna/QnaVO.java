package kr.co.foody.qna;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QnaVO {
	
	private int no;
	private int user_no;
	private int manager_no;
	private int qtype; // category 대신 qType 으로 컬럼명 수정
	private String title;
	private String content;
	private Timestamp regdate;
	private Timestamp replydate;
	private int response;
	private int gno;
	private int ono;
	private int depth;
	private String user_name;
	private int qna_no;
	private String answer;
	
	private String stype;
	private String sword;
	private String period;
	
	private int startIdx;
	private int page; // 현재 페이지번호
	private int pageRow; // 한페이지당 게시글수
	
	public QnaVO() {
		this.page = 1;
		this.pageRow = 10;
		this.response = -1;
	}
	
	public QnaVO(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
}
