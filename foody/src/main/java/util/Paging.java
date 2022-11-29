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








