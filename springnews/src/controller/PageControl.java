package controller;

public class PageControl {
	private int lineCnt = 5; 	// 한 화면에 구성하는 글 개수
	private int pageCnt = 5;  	// 한 화면의 페이지 개수
	private int postCnt = 0; 	// 요구 사항을 만족하는 글의 전체 개수
	private int pgNum = 0; 	    // 현재 페이지 넘버
	
	public PageControl(int page, int postCnt) {
		this.pgNum = page;
		this.postCnt = postCnt;
	}	
	
	// 글의 개수에 따른 페이지 개수 계산 
	public int getPageCount() {
		int totalPage = postCnt / lineCnt;		
		if(postCnt % lineCnt != 0) totalPage++;
		
		return totalPage;
	}
	
	// 각 화면별 시작 페이지 번호
	// ((현재 페이지넘버-1)/한 화면의 페이지 개수)*한 화면의 페이지 개수+1
	public int getPageStart() {
		return ((pgNum-1)/pageCnt) * pageCnt + 1;
	}
	
	// 각 화면별 종료 페이지 번호
	// 각 화면 별 시작 페이지 번호 + 한 화면의 페이지 개수 - 1 과 전체 페이지 개수 중에서 작은 값
	public int getPageEnd() {		
		int start = getPageStart();
		int count = getPageCount();
		start = start + pageCnt - 1;
		
		return start < count ? start : count;
	}

	// 이전 페이지들을 출력하는 left 이미지 출력 여부 결정
	// 화면별 시작 페이지 번호가 1이 아니면 출력
	public boolean isPreData() {
		if(pgNum != 1)	return true;
		else 			return false;
	}
	
	
 	// 이전 페이지들을 출력하는 right 이미지 출력 여부 결정 
	// 각 화면별 종료 페이지 번호가 전체 페이지 개수보다 작으면 출력	
	public boolean isNextData() {
		if(getPageEnd() <= getPageCount())	return true;
		else 								return false;
	}
	
	// 현재 페이지 넘버에 따라 DB 서버에서 가져올 글의 시작 행 넘버와 종료 행 넘버 - 시작 행 넘버:
	// 시작 행 넘버: 종료 행 넘버 – 한 화면을 구성하는 게시판 글 개수 + 1
	public int getWritingStart() {
		return getWritingEnd() - lineCnt + 1;
	}
	
	// 종료 행 넘버: 현재 페이지 넘버 * 한 화면을 구성하는 게시판 글 개수 
	public int getWritingEnd() {
		return pgNum * lineCnt;
	}
}