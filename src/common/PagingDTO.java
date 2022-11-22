package common;

public class PagingDTO {
	
	// ***** 페이징 변수 ******
	// 1.시작 레코드번호 : LIMIT의 시작값
	private int startNum;
	// 2.페이지당 레코드개수 : LIMIT의 개수
	final private int onePageCnt = 3;
	// 3.전체 레코드수
	private int totalCnt;
	// 4.리스트 그룹수 : 전체개수 ÷ 페이지당개수
	private int listGroup;
	// 5.남은 레코드수 : 리스트 그룹에서 남은 레코드수
	private int etcRecord;
	// 6.한계수체크 변수
	private int limit;
	// 7.파라미터 형변환 변수
	private int pageSeq;
	
	
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getListGroup() {
		return listGroup;
	}
	public void setListGroup(int listGroup) {
		this.listGroup = listGroup;
	}
	public int getEtcRecord() {
		return etcRecord;
	}
	public void setEtcRecord(int etcRecord) {
		this.etcRecord = etcRecord;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getPageSeq() {
		return pageSeq;
	}
	public void setPageSeq(int pageSeq) {
		this.pageSeq = pageSeq;
	}
	public int getOnePageCnt() {
		return onePageCnt;
	}
}
