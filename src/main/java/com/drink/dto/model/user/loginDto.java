/** 
* @ Title: loginVo.java 
* @ Package: com.drink.vo.model.user 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:09:04 
* @ Version V0.0 
*/ 
package com.drink.dto.model.user;

import java.io.Serializable;

import com.drink.dto.table.user.Cmuser;

/** 
* @ ClassName: loginVo 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 16. 오전 10:09:04 
*  
*/
public class loginDto implements Serializable{
	

	/** 
	* @ Fields: serialVersionUID: 
	*/ 
	private static final long serialVersionUID = 1L;
	
	private Cmuser cmUser = new Cmuser();
	
	/**
	 * @return
	 * @see com.drink.dto.table.user.Cmuser#getLoginId()
	 */
	public String getLoginId() {
		return cmUser.getLoginId();
	}

	/**
	 * @param loginId
	 * @see com.drink.dto.table.user.Cmuser#setLoginId(java.lang.String)
	 */
	public void setLoginId(String loginId) {
		cmUser.setLoginId(loginId);
	}

	/**
	 * @return
	 * @see com.drink.dto.table.user.Cmuser#getPasswd()
	 */
	public String getPasswd() {
		return cmUser.getPasswd();
	}

	/**
	 * @param passwd
	 * @see com.drink.dto.table.user.Cmuser#setPasswd(java.lang.String)
	 */
	public void setPasswd(String passwd) {
		cmUser.setPasswd(passwd);
	}
	
	/**
	 * @return
	 * @see com.drink.dto.table.user.Cmuser#getLoginId()
	 */
	public String getVdNm() {
		return cmUser.getVdNm();
	}

	/**
	 * @param loginId
	 * @see com.drink.dto.table.user.Cmuser#setLoginId(java.lang.String)
	 */
	public void setVdNm(String vdNm) {
		cmUser.setVdNm(vdNm);
	}
	
	/**
	 * @return
	 * @see com.drink.dto.table.user.Cmuser#getLoginId()
	 */
	public String getVendorId() {
		return cmUser.getVendorId();
	}

	/**
	 * @param loginId
	 * @see com.drink.dto.table.user.Cmuser#setLoginId(java.lang.String)
	 */
	public void setVendorId(String vendorId) {
		cmUser.setVendorId(vendorId);
	}
	
	/**
	 * @return
	 * @see com.drink.dto.table.user.Cmuser#getLoginId()
	 */
	public String getUserId() {
		return getUserId();
	}

	/**
	 * @param loginId
	 * @see com.drink.dto.table.user.Cmuser#setLoginId(java.lang.String)
	 */
	public void setUserId(String userId) {
		cmUser.setUserId(userId);
	}
	
	
	/** 
	* @ Title: toString 
	* @ Description: 
	* @ Param: @return 
	* @ Date: 2017. 10. 16. 오전 11:29:07
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
		return "loginVo [cmUser=" + cmUser.toString() + "]";
	}

	
	
	
}
