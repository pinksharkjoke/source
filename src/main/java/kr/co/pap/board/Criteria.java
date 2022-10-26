package kr.co.pap.board;

import lombok.Data;

@Data
public class Criteria {
	
	private int page;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	private int ca_num;
	private int bo_num;
	private int bo_pstatus;
	private String sort;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		this.ca_num = 0;
		this.bo_num=0;
	}
	
	public Criteria(int ca,int bo_num) {
		this.page = 1;
		this.perPageNum = 10;
		this.ca_num=ca;
		this.bo_num =bo_num;
	}
	
	public void setSort(String sort) {
		if (sort == null) {
			this.sort = null;
			return;
		}
		this.sort = sort;
	}
	
	
	
	
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {

		rowStart = ((page - 1) * perPageNum);

		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = perPageNum ;
		return rowEnd;
	}
	public String getSort() {
		return sort;
	}
	
	
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
	
	
}