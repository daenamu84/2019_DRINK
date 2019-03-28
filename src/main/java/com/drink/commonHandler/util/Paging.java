/** 
* @ Title: Paging.java 
* @ Package: com.drink.commonHandler.util
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오전 10:41:34 
* @ Version V0.0 
*/
package com.drink.commonHandler.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

/** 
* @ ClassName: Paging 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오전 10:41:34 
*  
*/
@Component
public class Paging {
	private int recordsPerPage = CommonConfig.Paging.RECORDSPERPAGE.getValue(); // 페이지당 레코드 수
	private int firstPageNo; // 첫번째 페이지 번호
	private int prevPageNo; // 이전 페이지 번호
	private int startPageNo; // 시작 페이지 (페이징 너비 기준)
	private int currentPageNo = CommonConfig.Paging.CURRENTPAGENO.getValue(); // 페이지 번호
	private int endPageNo; // 끝 페이지 (페이징 너비 기준)
	private int nextPageNo; // 다음 페이지 번호
	private int finalPageNo; // 마지막 페이지 번호
	private int numberOfRecords; // 전체 레코드 수
	private int sizeOfPage = CommonConfig.Paging.SIZEOFPAGE.getValue(); // 보여지는 페이지 갯수 (1,2,3,4,5 갯수)
	private String jsFunc;

	private static final Logger logger = LogManager.getLogger(Paging.class);
	
	public Paging() {
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		//recordsPerPage가 0이 아니면 recordsPerPage, 아니면 디폴트
		this.recordsPerPage = (recordsPerPage != 0) ? recordsPerPage : CommonConfig.Paging.RECORDSPERPAGE.getValue();
		this.recordsPerPage = (recordsPerPage > 100) ? 100 : this.recordsPerPage;
	}

	public int getFirstPageNo() {
		return firstPageNo;
	}

	public void setFirstPageNo(int firstPageNo) {
		this.firstPageNo = firstPageNo;
	}

	public int getPrevPageNo() {
		return prevPageNo;
	}

	public void setPrevPageNo(int prevPageNo) {
		this.prevPageNo = prevPageNo;
	}

	public int getStartPageNo() {
		return startPageNo;
	}

	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = (currentPageNo != 0) ? currentPageNo : CommonConfig.Paging.CURRENTPAGENO.getValue();
	}

	public int getEndPageNo() {
		return endPageNo;
	}

	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}

	public int getNextPageNo() {
		return nextPageNo;
	}

	public void setNextPageNo(int nextPageNo) {
		this.nextPageNo = nextPageNo;
	}

	public int getFinalPageNo() {
		return finalPageNo;
	}

	public void setFinalPageNo(int finalpageNo) {
		this.finalPageNo = finalpageNo;
	}

	public int getNumberOfRecords() {
		return numberOfRecords;
	}

	public void setNumberOfRecords(int numberOfRecords) {
		this.numberOfRecords = numberOfRecords;
	}

	public int getSizeOfPage() {
		return sizeOfPage;
	}

	public void setSizeOfPage(int sizeOfPage) {
		this.sizeOfPage = (sizeOfPage != 0) ? sizeOfPage : CommonConfig.Paging.SIZEOFPAGE.getValue();
		this.sizeOfPage = (sizeOfPage > 10) ? 10 : this.sizeOfPage;
	}

	/**
	 * @return the jsFunc
	 */
	public String getJsFunc() {
		return jsFunc;
	}

	/**
	 * @param jsFunc the jsFunc to set
	 */
	public void setJsFunc(String jsFunc) {
		this.jsFunc = jsFunc;
	}

	/**
	 * 페이징 생성
	 */
	public void makePaging() {
		if (numberOfRecords == 0) // 게시글 전체 수가 없는 경우
			return;

		if (currentPageNo == 0)
			setCurrentPageNo(CommonConfig.Paging.CURRENTPAGENO.getValue()); // 기본 값 설정

		if (recordsPerPage == 0)
			setRecordsPerPage(CommonConfig.Paging.RECORDSPERPAGE.getValue()); // 기본 값 설정

		// 마지막 페이지
		int finalPage = (numberOfRecords + (recordsPerPage - 1)) / recordsPerPage;

		if (currentPageNo > finalPage)
			setCurrentPageNo(finalPage);// 기본 값 설정

		if (currentPageNo < 0 || currentPageNo > finalPage)
			currentPageNo = 1; // 현재 페이지 유효성 체크
							// 시작 페이지 (전체)
		boolean isNowFirst = currentPageNo == 1 ? true : false;
		boolean isNowFinal = currentPageNo == finalPage ? true : false;

		int startPage = ((currentPageNo - 1) / sizeOfPage) * sizeOfPage + 1;
		int endPage = startPage + sizeOfPage - 1;

		if (endPage > finalPage)
			endPage = finalPage;

		setFirstPageNo(1); // 첫번째 페이지 번호

		if (isNowFirst)
			setPrevPageNo(1); // 이전 페이지 번호
		else // 이전 페이지 번호
			setPrevPageNo(((currentPageNo - 1) < 1 ? 1 : (currentPageNo - 1)));

		setStartPageNo(startPage); // 시작페이지
		setEndPageNo(endPage); // 끝 페이지

		if (isNowFinal)
			setNextPageNo(finalPage); // 다음 페이지 번호
		else
			setNextPageNo(((currentPageNo + 1) > finalPage ? finalPage : (currentPageNo + 1)));

		setFinalPageNo(finalPage); // 마지막 페이지 번호
	}

	public String printPaging() {
		StringBuilder pageTag = new StringBuilder();

		pageTag.append("<p class=\"paging\">");

		if (this.getCurrentPageNo() > this.getSizeOfPage()) {
			pageTag.append("<a href=\"javascript:goPageMethod(" + jsFunc + ", " + (this.getFirstPageNo()) + ", " + this.getRecordsPerPage() + ")\" class=\"prevF\"><<</a>");
			pageTag.append("<a href=\"javascript:goPageMethod(" + jsFunc + ", " + (this.getStartPageNo()-1) + ", " + this.getRecordsPerPage() + ")\" class=\"prev\">이전</a>");
		}

		for (int i = this.getStartPageNo(); i <= this.getEndPageNo(); i++) {
			if (i == this.getCurrentPageNo()) {
				pageTag.append("<b><font size=+1>");
				pageTag.append("<a href=\"javascript:goPageMethod(" + jsFunc + ", " + i + ", " + this.getRecordsPerPage() + ")\" class=\"choice\">" + i + "</a>");
				pageTag.append("</font></b>");
			} else {
				pageTag.append("<a href=\"javascript:goPageMethod(" + jsFunc + ", " + i + ", " + this.getRecordsPerPage() + ")\">" + i + "</a>");

			}
		}

		if ((this.getEndPageNo()) < this.getFinalPageNo()) {
			pageTag.append("<a href=\"javascript:goPageMethod(" + jsFunc + ", " + (this.getEndPageNo()+1) + ", " + this.getRecordsPerPage() + ")\" class=\"next\">다음</a>");
			pageTag.append("<a href=\"javascript:goPageMethod(" + jsFunc + ", " + (this.getFinalPageNo()) + ", " + this.getRecordsPerPage() + ")\" class=\"nextF\">>></a>");
		}

		pageTag.append("</p>");
		return pageTag.toString();

	}
	
	public String printBtPaging() {
		StringBuilder pageTag = new StringBuilder();
		if(this.getEndPageNo() > 0){
			pageTag.append("<ul class=\"pagination justify-content-center\">");
	
			if (this.getCurrentPageNo() > this.getSizeOfPage()) {
				pageTag.append("<li class=\"page-item\">");
				pageTag.append("<a class=\"page-link\" href=\"javascript:goPageMethod(" + jsFunc + ", " + (this.getStartPageNo()-1) + ", " + this.getRecordsPerPage() + ")\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span><span class=\"sr-only\">Previous</span></a>");
				pageTag.append("</li>");
			}
			for (int i = this.getStartPageNo(); i <= this.getEndPageNo(); i++) {
				if (i == this.getCurrentPageNo()) {
					pageTag.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:goPageMethod(" + jsFunc + ", " + i + ", " + this.getRecordsPerPage() + ")\">"+i+"</a></li>");
				} else {
					pageTag.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:goPageMethod(" + jsFunc + ", " + i + ", " + this.getRecordsPerPage() + ")\"><font style=\"color:#808080;\">"+i+"</font></a></li>");
	
				}
			}
	
			if (this.getEndPageNo() < this.getFinalPageNo()) {
				pageTag.append("<li class=\"page-item\">");
				pageTag.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:goPageMethod(" + jsFunc + ", " + (this.getEndPageNo()+1) + ", " + this.getRecordsPerPage() + ")\" aria-label=\"Next\"><span aria-hidden=\"true\">&raquo;</span><span class=\"sr-only\">Next</span></a></li>");
				pageTag.append("</li>");
				
			}
	
			pageTag.append("</ul>");
		}
		return pageTag.toString();

	}
	
	

	/** 
	* @ Title: toString 
	* @ Description: 
	* @ Param: @return 
	* @ Date: 2016. 11. 3. 오후 2:59:11
	* @ Throws 
	* @see java.lang.Object#toString() 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/

	@Override
	public String toString() {
		return "Paging [recordsPerPage=" + recordsPerPage + ", firstPageNo=" + firstPageNo + ", prevPageNo=" + prevPageNo + ", startPageNo=" + startPageNo + ", currentPageNo=" + currentPageNo + ", endPageNo=" + endPageNo + ", nextPageNo=" + nextPageNo + ", finalPageNo=" + finalPageNo + ", numberOfRecords=" + numberOfRecords + ", sizeOfPage=" + sizeOfPage + ", jsFunc=" + jsFunc + "]";
	}

}
