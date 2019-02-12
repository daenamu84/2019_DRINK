package com.drink.commonHandler.util;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/** 
* @ ClassName: PagingTag 
* @ Description: 페이징 처리용 custom tab lib
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 3:40:50 
*  
*/
@SuppressWarnings("serial")
public class PagingTag extends TagSupport {

	private static final Logger logger = LogManager.getLogger(PagingTag.class);

	String var;
	private String jsFunc;

	private int recordsPerPage; // 페이지당 레코드 수
	private int currentPageNo; // 페이지 번호
	private int numberOfRecords; // 전체 레코드 수
	private int sizeOfPage; // 보여지는 페이지 갯수 (1,2,3,4,5 갯수)

	/**
	 * @return the var
	 */
	public String getVar() {
		return var;
	}

	/**
	 * @param var the var to set
	 */
	public void setVar(String var) {
		this.var = var;
	}

	public PagingTag getPagingTab() {
		return this;
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
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
		this.sizeOfPage = (sizeOfPage != 0) ? sizeOfPage : 10;
	}

	@Override
	public int doEndTag() throws JspException {
		Paging pagign = new Paging();
		pagign.setRecordsPerPage(this.recordsPerPage);
		pagign.setCurrentPageNo(this.currentPageNo);
		pagign.setNumberOfRecords(this.numberOfRecords);
		pagign.setSizeOfPage(this.sizeOfPage);
		pagign.setJsFunc(this.jsFunc);
		pagign.makePaging();

		pageContext.setAttribute(var, pagign);

		return EVAL_PAGE;
	}

	/**
	 * @param jsFunc the jsFunc to set
	 */
	public void setJsFunc(String jsFunc) {
		this.jsFunc = jsFunc;
	}

}
