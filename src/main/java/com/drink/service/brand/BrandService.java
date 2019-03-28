/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.brand;

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
@Service("BrandService")
public class BrandService {
	private static final Logger logger = LogManager.getLogger(BrandService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	public List BrandList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Brand.getBrandList",map.getMap());
		
		return param;
	}

	public List BrandSubList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Brand.getBrandSubList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void BrandInsert(RequestMap map) throws DrinkException{
		logger.debug("service 111111111 :: " + map.toString());
		
		if(map.getString("brandNm").equals("")){
			 throw new DrinkException(new String[]{"messageError","브랜드명은 필수 값 입니다."});
		}
		map.put("brandId", map.getString("brandId").replaceAll(" ","").toUpperCase());
		map.put("brandNm", map.getString("brandNm").trim());
		map.put("sortOrd", map.getInt("sortOrd"));
		
		logger.debug("service :: " + map.toString());
		DataMap countMap = (DataMap) gdi.selectOne("Brand.getBrandCnt",  map.getMap()); 
		if(countMap != null && countMap.getInt("CNT") == 0 ){
			gdi.update("Brand.masterInsert", map.getMap());
		}else{
			int rtCnt = gdi.update("Brand.masterUpdate", map.getMap());
			if(rtCnt < 1){
				throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
			}
		}
	}
	
	public DataMap BrandView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Brand.getBrandView",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void BrandSubInsert(RequestMap map) throws DrinkException{
		
		if(map.getString("subBrandNm").equals("")){
			 throw new DrinkException(new String[]{"messageError","서브 브랜드명은 필수 값 입니다."});
		}
		map.put("subBrandId", map.getString("subBrandId").replaceAll(" ","").toUpperCase());
		map.put("subBrandNm", map.getString("subBrandNm").trim());
		map.put("subSortOrd", map.getInt("subSortOrd"));
		
		DataMap countMap = (DataMap) gdi.selectOne("Brand.getBrandSubCnt",  map.getMap()); 
		if(countMap != null && countMap.getInt("CNT") == 0 ){
			gdi.update("Brand.subInsert", map.getMap());
		}else{
			int rtCnt = gdi.update("Brand.subUpdate", map.getMap());
			if(rtCnt < 1){
				throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
			}
		}
	}
	
	public DataMap BrandSubView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Brand.getBrandSubView",map.getMap());
		
		return param;
	}
	
	public List BrandMCdList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Brand.getBrandMCd",param);
		return param;
	}
	public List BrandSCdList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		param = gdi.selectList("Brand.getBrandSCd",map.getMap());
		return param;
	}
	
}
