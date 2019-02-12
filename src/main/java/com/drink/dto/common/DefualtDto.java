/** 
* @ Title: paginVo.java 
* @ Package: com.drink.vo.common 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 12:27:47 
* @ Version V0.0 
*/
package com.drink.dto.common;

/** 
* @ ClassName: paginVo 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 12:27:47 
*  
*/
public abstract class DefualtDto {
	int totCnt;
	int totPage;

	/**
	 * @return the totCnt
	 */
	public int getTotCnt() {
		return totCnt;
	}

	/**
	 * @param totCnt the totCnt to set
	 */
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	/**
	 * @return the totPage
	 */
	public int getTotPage() {
		return totPage;
	}

	/**
	 * @param totPage the totPage to set
	 */
	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}
}
