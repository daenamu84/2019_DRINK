/** 
* @ Title: MetaTagVo.java 
* @ Package: com.wizwid.vo.model.meta 
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
	String lgin_id;
	String log_nm;
	String emp_grd_cd;
	String emp_no;
	String dept_no; 
	
	public String getDept_no() {
		return dept_no;
	}
	public void setDept_no(String dept_no) {
		this.dept_no = dept_no;
	}
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
	public String getLgin_id() {
		return lgin_id;
	}
	public void setLgin_id(String lgin_id) {
		this.lgin_id = lgin_id;
	}
	public String getLog_nm() {
		return log_nm;
	}
	public void setLog_nm(String log_nm) {
		this.log_nm = log_nm;
	}
	public String getEmp_grd_cd() {
		return emp_grd_cd;
	}
	public void setEmp_grd_cd(String emp_grd_cd) {
		this.emp_grd_cd = emp_grd_cd;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	@Override
	public String toString() {
		return "SessionDto [sessionId=" + sessionId + ", lgin_id=" + lgin_id + ", log_nm=" + log_nm + ", emp_grd_cd="
				+ emp_grd_cd + ", emp_no=" + emp_no + ", dept_no=" + dept_no + "]";
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

}
