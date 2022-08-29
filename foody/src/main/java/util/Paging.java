package util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Paging {
	
	protected int page; //pageNum
	protected int pageRow; // amount
	protected String stype;
	protected String sword;
	protected int startIdx;
	
	protected int startPage;
	protected int endPage;
	protected boolean prev, next;
	
	protected int totalPage;
	protected int totalCount;
	
	public Paging() {
		this.page = 1;
		this.pageRow = 20;
	}
	
	public Paging(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
	
	
}








