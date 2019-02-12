/** 
* @ Title: CommonRepository.java 
* @ Package: com.drink.dao.common 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 31. 오전 11:19:13 
* @ Version V0.0 
*/ 
package com.drink.dao.common;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;

/** 
* @ ClassName: CommonRepository 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2017. 10. 31. 오전 11:19:13 
*  
*/
@Repository
public class CommonRepository {
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	public DataMap getDeliCompanyRefCd(String deliCompId){
		DataMap result = (DataMap) gdi.selectOne("Common.deliCompany", deliCompId);
		return result;
	}
	public List<DataMap> getDeliCompanyAll(){
		List<DataMap> result = gdi.selectList("Common.deliCompanyAll");
		return result;
	}
	
	public DataMap getSysDate(){
		DataMap result = (DataMap) gdi.selectOne("Common.getSysDate");
		return result;
	}
}
