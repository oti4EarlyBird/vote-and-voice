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
	    
	    public int startPage;  // 페이지네이션 시작 페이지 번호
	    public int endPage;	   // 페이지네이션 끝 페이지 번호
	    
	    public void setTotalCnt(int totalCnt) {
	        this.totalCnt = totalCnt;
	        int endPage = (int) Math.ceil((double) totalCnt / listSize);
	        int startPage = (pageNum - 1) / 10 * 10 + 1;
	        this.endPage = endPage;
	        this.startPage = startPage;
	        
	     // 현재 페이지에서의 마지막 게시물 번호
	        this.endList = Math.min(startList + listSize, totalCnt);
	    }
}
