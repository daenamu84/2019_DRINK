/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.code;

import java.util.ArrayList;
import java.util.List;

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
@Service("CodeService")
public class CodeService {
	private static final Logger logger = LogManager.getLogger(CodeService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List CodeList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Code.getCodeList",map.getMap());
		int TotalCnt = (int) gdi.selectOne("Team.selectTotalRecords");
		map.put("TotalCnt", TotalCnt);	
		
		return param;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void CodeInsert(RequestMap map) throws DrinkException{
		logger.debug("service 111111111 :: " + map.toString());
		
		if(map.getString("cmm_cd_grp_nm").equals("")){
			 throw new DrinkException(new String[]{"messageError","크드명은 필수 값 입니다."});
		}
		map.put("cmm_cd_grp_id", map.getString("cmm_cd_grp_id").replaceAll(" ","").toUpperCase());
		map.put("cmm_cd_grp_nm", map.getString("cmm_cd_grp_nm").trim());
		
		
		logger.debug("service :: " + map.toString());
		
		DataMap countMap = (DataMap) gdi.selectOne("Code.getMasterCodeCnt",map.getMap());
		 
		if(countMap != null && countMap.getInt("CNT") == 0 ){
			gdi.update("Code.masterInsert", map.getMap());
		}else{
			int rtCnt = gdi.update("Code.masterUpdate", map.getMap());
			if(rtCnt < 1){
				throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
			}
		}
	}
	
	public DataMap MasterCodeView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Code.getMasterCodeView",map.getMap());
		
		return param;
	}
	
	
	public List CodeSubList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Code.getCodeSubList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void CodeSubInsert(RequestMap map) throws DrinkException{
		
		if(map.getString("cmm_cd_grp_id").equals("")){
			 throw new DrinkException(new String[]{"messageError","마스터 id 가 없습니다."});
		}
		
		if(map.getString("cmm_cd_nm").equals("")){
			 throw new DrinkException(new String[]{"messageError","서브 크드명 필수 값 입니다."});
		}
		map.put("cmm_cd", map.getString("cmm_cd").replaceAll(" ","").toUpperCase());
		map.put("cmm_cd_nm", map.getString("cmm_cd_nm").trim());
		
		
		DataMap countMap = (DataMap) gdi.selectOne("Code.getCodeSubCnt",  map.getMap()); 
		
		if(countMap != null && countMap.getInt("CNT") == 0 ){
			DataMap cntMap = (DataMap) gdi.selectOne("Code.getCodeSubToalCnt",map.getMap());
			map.put("sort_ord", cntMap.getInt("CNT")+1);
			gdi.update("Code.subInsert", map.getMap());
		}else{
			int rtCnt = gdi.update("Code.subUpdate", map.getMap());
			if(rtCnt < 1){
				throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
			}
		}
	}
	
	public DataMap CodeSubView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Code.getCodeSubView",map.getMap());
		
		return param;
	}
	
	
}
