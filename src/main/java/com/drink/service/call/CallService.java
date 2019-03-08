/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.call;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.drink.commonHandler.Exception.DrinkException;
import com.drink.commonHandler.bind.RequestMap;
import com.drink.commonHandler.util.DataMap;
import com.drink.dao.GenericMapperImpl;

/** 
* @ ClassName: MainService 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
*  
*/
@Service("CallService")
public class CallService {
	private static final Logger logger = LogManager.getLogger(CallService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	
	public List getCallList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Call.getCallList",map.getMap());
		
		return param;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void CallInsert ( Map<String, Object> map) throws DrinkException{
		
		logger.debug("service 111111111 :: " + map.toString());
		List<DataMap> param = new ArrayList<>();
		
		
		String gubun = (String) map.get("gubun");
		String emp_no = (String) map.get("emp_no");
		String scallStaDt = (String) map.get("scallStaDt");
		
		List<Map<String, Object>> data = (List<Map<String, Object>>) map.get("_addPram");
		
		for(int i=0; i< data.size();i++){
			 logger.debug(i+" :: " + data.get(i).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data.get(i);
			 svMap.put("emp_no", emp_no);
			 svMap.put("scall_dt", scallStaDt);
			 svMap.put("login_id", map.get("regId"));
			 gdi.update("Call.masterInsert",svMap);
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void CallDelete ( Map<String, Object> map) throws DrinkException{
		
		logger.debug("service 111111111 :: " + map.toString());
		List<DataMap> param = new ArrayList<>();
		
		
		List<Map<String, Object>> data = (List<Map<String, Object>>) map.get("_addPram");
		
		for(int i=0; i< data.size();i++){
			 logger.debug(i+" :: " + data.get(i).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data.get(i);
			 gdi.update("Call.callDelete",svMap);
		}
	}
	
	public DataMap CallView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		logger.debug("map==" + map);
		param = (DataMap) gdi.selectOne("Call.callView",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void CallUpdate(RequestMap map) throws DrinkException{
		
		int rtCnt = gdi.update("Call.masterUpdate", map.getMap());
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
		}
			
	}
	
}
