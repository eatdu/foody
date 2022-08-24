package util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Paging {
	
	private int page; //pageNum
	private int pageRow; // amount
	private String stype;
	private String sword;
	private int startIdx;
	
	 
	public Paging() {
		this.page = 1;
		this.pageRow = 20;
	}
	
	public Paging(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
}








