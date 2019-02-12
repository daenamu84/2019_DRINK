/** 
* @ Title: PagingParam.java 
* @ Package: com.drink.vo.model.user 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 3:53:34 
* @ Version V0.0 
*/
package com.drink.dto.model.user;


import java.io.Serializable;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

/** 
* @ ClassName: PagingParam 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 11. 2. 오후 3:53:34 
*  
*/
public class PagingParam implements Serializable{
	
	/** 
	* @ Fields: serialVersionUID: 
	*/ 
	private static final long serialVersionUID = 1L;

	@NotNull
	int page;
	
	@DecimalMax(value="100")
	@Digits(integer=3, fraction=0)
	int pageLine;
	
	@NotNull
	String searchNm;

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @param page the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}

	/**
	 * @return the pageLine
	 */
	public int getPageLine() {
		return pageLine;
	}

	/**
	 * @param pageLine the pageLine to set
	 */
	public void setPageLine(int pageLine) {
		this.pageLine = pageLine;
	}

	
	/**
	 * @return the searchNm
	 */
	public String getSearchNm() {
		return searchNm;
	}

	/**
	 * @param searchNm the searchNm to set
	 */
	public void setSearchNm(String searchNm) {
		this.searchNm = searchNm;
	}

	/** 
	* @ Title: toString 
	* @ Description: 
	* @ Param: @return 
	* @ Date: 2016. 11. 15. 오후 12:09:17
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
		return "PagingParam [page=" + page + ", pageLine=" + pageLine + ", searchNm=" + searchNm + "]";
	}


}
