/** 
* @ Title: FileParam.java 
* @ Package: com.drink.vo.model.file 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 6. 20. 오후 2:59:08 
* @ Version V0.0 
*/ 
package com.drink.dto.model.file;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/** 
* @ ClassName: FileParam 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 6. 20. 오후 2:59:08 
*  
*/
public class FileParam implements Serializable{
	 
	/** 
	* @ Fields: serialVersionUID: 
	*/ 
	private static final long serialVersionUID = 1L;
	List<MultipartFile> files;

	/**
	 * @return the files
	 */
	public List<MultipartFile> getFiles() {
		return files;
	}

	/**
	 * @param files the files to set
	 */
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	/**
	 * @param files the files to set
	 */
	public void setFiles(MultipartFile files) {
		ArrayList<MultipartFile> fm = new ArrayList<>();
		fm.add(files);
		this.files = fm;
	}

	
	

}
