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

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public List DeptList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Team.getDeptList",param);
		
		return param;
	}
	
	
	public void checkTeam(RequestMap map) throws DrinkException{
		logger.debug("map==="+ map.toString());
		
		if(!map.getString("deptno").equals("")){
			int rtCnt = gdi.update("Team.masterUpdate", map.getMap());
			if(rtCnt < 1){
				throw new DrinkException(new String[]{"messageError","수정에 실패 하였습니다."});
			}
		}else {
			DataMap param = new DataMap();
			param = (DataMap) gdi.selectOne("Team.checkTeam",map.getMap());
			
			if(param.getInt("CNT")==0){
				param = (DataMap) gdi.selectOne("Team.getT_DEPT_M_Cnt",map.getMap());
				map.put("sort_ord", param.getInt("CNT")+1);
				
				//logger.debug("map==="+ map.toString());
				
				int rtCnt = gdi.update("Team.masterInsert", map.getMap());
				if(rtCnt < 1){
					throw new DrinkException(new String[]{"messageError","저장에 실패 하였습니다."});
				}
			}else {
				throw new DrinkException(new String[]{"messageError","중복된 팀명 존재합니다."});
			}
		}
	}
}
