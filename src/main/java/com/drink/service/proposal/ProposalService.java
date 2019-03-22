/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.proposal;

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
@Service("ProposalService")
public class ProposalService {
	private static final Logger logger = LogManager.getLogger(ProposalService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;
	
	
	public List getProPosalList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Proposal.getProPosalList",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public DataMap proposalWork(Map<String, Object> map) throws DrinkException{
		DataMap param = new DataMap();
		logger.debug("map==="+ map.toString());
		
		gdi.update("Proposal.masterInsert",map);
		param = (DataMap) gdi.selectOne("Proposal.getPRPS_ID",map);
		
		return param;
	}
	
	
}
