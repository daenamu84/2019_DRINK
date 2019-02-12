/** 
* @ Title: Cmuser.java 
* @ Package: com.drink.vo.table.user 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:02:53 
* @ Version V0.0 
*/ 
package com.drink.dto.table.user;

import java.io.Serializable;

/** 
* @ ClassName: Cmuser 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:02:53 
*  
*/
public class Cmuser implements Serializable{

	/** 
	* @ Fields: serialVersionUID: 
	*/ 
	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String userNm;
	private String loginId;
	private String passwd;
	private String email;
	private String vdNm;
	private String vendorId;
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the loginId
	 */
	public String getLoginId() {
		return loginId;
	}
	/**
	 * @param loginId the loginId to set
	 */
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the passwd
	 */
	public String getPasswd() {
		return passwd;
	}
	/**
	 * @param passwd the passwd to set
	 */
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public String getVdNm() {
		return vdNm;
	}
	
	public void setVdNm(String vdNm) {
		this.vdNm = vdNm;
	}
	
	public String getVendorId() {
		return vendorId;
	}
	
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	/** 
	* @ Title: toString 
	* @ Description: 
	* @ Param: @return 
	* @ Date: 2017. 10. 26. 오후 4:22:19
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
		return "Cmuser [userId=" + userId + ", userNm=" + userNm + ", loginId=" + loginId + ", passwd=" + passwd + ", email=" + email + ", vdNm=" + vdNm + ", vendorId=" + vendorId + "]";
	}
	
	
	
}
