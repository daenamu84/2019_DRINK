/** 
* @ Title: MetaTagVo.java 
* @ Package: com.drink.vo.model.meta 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 6. 오후 5:25:53 
* @ Version V0.0 
*/ 
package com.drink.dto.model.meta;

import java.io.Serializable;

/** 
* @ ClassName: MetaTagVo 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 6. 오후 5:25:53 
*  
*/
public class MetaTagDto implements Serializable {

	/** 
	* @ Fields: serialVersionUID: 
	*/ 
	private static final long serialVersionUID = 1L;
	
	String headTitle;
	String metaSubject;
	String metaTitle;
	String metaDescription;
	String metaKeywords;
	String metaDistribution;
	/**
	 * @return the headTitle
	 */
	public String getHeadTitle() {
		return headTitle;
	}
	/**
	 * @param headTitle the headTitle to set
	 */
	public void setHeadTitle(String headTitle) {
		this.headTitle = headTitle;
	}
	/**
	 * @return the metaSubject
	 */
	public String getMetaSubject() {
		return metaSubject;
	}
	/**
	 * @param metaSubject the metaSubject to set
	 */
	public void setMetaSubject(String metaSubject) {
		this.metaSubject = metaSubject;
	}
	/**
	 * @return the metaTitle
	 */
	public String getMetaTitle() {
		return metaTitle;
	}
	/**
	 * @param metaTitle the metaTitle to set
	 */
	public void setMetaTitle(String metaTitle) {
		this.metaTitle = metaTitle;
	}
	/**
	 * @return the metaDescription
	 */
	public String getMetaDescription() {
		return metaDescription;
	}
	/**
	 * @param metaDescription the metaDescription to set
	 */
	public void setMetaDescription(String metaDescription) {
		this.metaDescription = metaDescription;
	}
	/**
	 * @return the metaKeywords
	 */
	public String getMetaKeywords() {
		return metaKeywords;
	}
	/**
	 * @param metaKeywords the metaKeywords to set
	 */
	public void setMetaKeywords(String metaKeywords) {
		this.metaKeywords = metaKeywords;
	}
	/**
	 * @return the metaDistribution
	 */
	public String getMetaDistribution() {
		return metaDistribution;
	}
	/**
	 * @param metaDistribution the metaDistribution to set
	 */
	public void setMetaDistribution(String metaDistribution) {
		this.metaDistribution = metaDistribution;
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
		return "MetaTagVo [headTitle=" + headTitle + ", metaSubject=" + metaSubject + ", metaTitle=" + metaTitle + ", metaDescription=" + metaDescription + ", metaKeywords=" + metaKeywords + ", metaDistribution=" + metaDistribution + "]";
	}
}
