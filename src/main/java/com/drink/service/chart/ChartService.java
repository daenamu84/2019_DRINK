/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/
package com.drink.service.chart;

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
 * @ ClassName: MainService @ Description: @ Author: Daenamu @ Date: 2019. 2.
 * 18. 오전 11:50:18
 * 
 */
@Service("ChartService")
public class ChartService {
	private static final Logger logger = LogManager.getLogger(ChartService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	public List getEmpMList(RequestMap map) throws DrinkException {
		
		List<DataMap> param = new ArrayList<>();
		logger.debug("map===" + map.getMap());
		param = gdi.selectList("Chart.getEmpMList",map.getMap());
		
		return param;
	}
	
	public List getDeptList(RequestMap map) throws DrinkException {
		
		List<DataMap> param = new ArrayList<>();
		logger.debug("map===" + map.getMap());
		param = gdi.selectList("Chart.getDeptList",map.getMap());
		
		return param;
	}
	
	
	public List getBrandList(RequestMap map) throws DrinkException {
		
		List<DataMap> param = new ArrayList<>();
		logger.debug("map===" + map.getMap());
		param = gdi.selectList("Chart.getBrandList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List pord_sumSearchList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		int rtCnt = gdi.update("Chart.chart06_temp_delete",map.getMap());
		gdi.update("Chart.chart06_temp_insert",map.getMap());
		param = gdi.selectList("Chart.pord_sumSearchList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List pord_DeptsumSearchList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		int rtCnt = gdi.update("Chart.chart01_temp_delete",map.getMap());
		gdi.update("Chart.chart01_temp_insert",map.getMap());
		param = gdi.selectList("Chart.pord_DeptsumSearchList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List prod_DisAccountsumSearchList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		int rtCnt = gdi.update("Chart.chart02_temp_delete",map.getMap());
		gdi.update("Chart.chart02_temp_insert",map.getMap());
		param = gdi.selectList("Chart.prod_DisAccountsumSearchList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List prod_DistrubutionSearchList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		int rtCnt = gdi.update("Chart.chart04_temp_delete",map.getMap());
		gdi.update("Chart.chart04_temp_insert",map.getMap());
		param = gdi.selectList("Chart.prod_DistrubutionSearchList",map.getMap());
		
		return param;
	}
	
	public List getBrand_SubBrandList(RequestMap map) throws DrinkException {
		
		List<DataMap> param = new ArrayList<>();
		logger.debug("map2===" + map.getMap());
		param = gdi.selectList("Chart.getBrand_SubBrandList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List prod_ActivationSearchList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		int rtCnt = gdi.update("Chart.chart05_temp_delete",map.getMap());
		gdi.update("Chart.chart05_temp_insert",map.getMap());
		param = gdi.selectList("Chart.prod_ActivationSearchList",map.getMap());
		
		return param;
	}
}
