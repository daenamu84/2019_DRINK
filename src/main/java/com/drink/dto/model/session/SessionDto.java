/** 
* @ Title: MetaTagVo.java 
* @ Package: com.drink.vo.model.meta 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 6. 오후 5:25:53 
* @ Version V0.0 
*/ 
package com.drink.dto.model.session;

import java.io.Serializable;

/** 
* @ ClassName: MetaTagVo 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 6. 오후 5:25:53 
*  
*/
public class SessionDto implements Serializable{
	
	/** 
	* @ Fields: serialVersionUID: 
	*/ 
	private static final long serialVersionUID = 1L;
	
	String sessionId;
	String vdNm;
	String vendorId;
	String userId;
	
	/**
	 * @return the headTitle
	 */
	public String getSessionId() {
		return sessionId;
	}
	/**
	 * @param headTitle the headTitle to set
	 */
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	
	
	public String getUserId() {
		return userId;
	}
	/**
	 * @param headTitle the headTitle to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getVdNm() {
		return vdNm;
	}
	/**
	 * @param headTitle the headTitle to set
	 */
	public void setVdNm(String vdNm) {
		this.vdNm = vdNm;
	}
	
	public String getVendorId() {
		return vendorId;
	}
	/**
	 * @param headTitle the headTitle to set
	 */
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	/** 
	* @ Title: toString 
	* @ Description: 
	* @ Param: @return 
	* @ Date: 2016. 12. 6. 오후 5:28:04
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
		return "SessionDto [sessionId=" + sessionId + ", userId=" + userId + ", vdNm=" + vdNm + ", vendorId=" + vendorId + "]";
	}
}
