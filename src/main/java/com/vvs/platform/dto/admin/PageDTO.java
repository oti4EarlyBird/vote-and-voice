package com.vvs.platform.dto.admin;

import lombok.Data;

@Data
public class PageDTO {
	 private int pageNum; // 현재 페이지 번호
	    private int listSize; // 페이지당 보여질 게시물 수
	    private int startList; // 시작 게시물 번호
	    private int endList; // 끝 게시물 번호
	    private int totalCnt; // 총 게시물 수

	    public PageDTO(int pageNum, int listSize) {
	        this.pageNum = pageNum;
	        this.listSize = listSize;
	        this.startList = (pageNum - 1) * listSize;
	    }
	    
	    public int startPage;
	    public int endPage;
	    
	    public void setTotalCnt(int totalCnt) {
	        this.totalCnt = totalCnt;
	        int endPage = (int) Math.ceil((double) totalCnt / listSize);
	        int startPage = (pageNum - 1) / 10 * 10 + 1;
	        this.endPage = endPage;
	        this.startPage = startPage;
	    }
}
