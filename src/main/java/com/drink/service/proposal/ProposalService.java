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
	
	public DataMap proposalView(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		logger.debug("map==="+ map.toString());
		
		param = (DataMap) gdi.selectOne("Proposal.ProPosalView",map.getMap());
		
		return param;
	}
	
	public List proposalView2(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map==="+ map.toString());
		param =  gdi.selectList("Proposal.ProPosalProdD_DView",map.getMap());
		
		return param;
	}
	
	public List proposalView2_1(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map==="+ map.toString());
		param =  gdi.selectList("Proposal.ProPosalProdD_DView2_1",map.getMap());
		
		return param;
	}
	
	public List proposalView2_2(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map==="+ map.toString());
		param =  gdi.selectList("Proposal.ProPosalProdD_DView2_2",map.getMap());
		
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
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void proposalUpdate(Map<String, Object> map) throws DrinkException{
		
		int rtCnt = gdi.update("Proposal.masterUpdate", map);
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
		}
			
	}
	
	public List getProPosal03List(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		logger.debug("map---"+ map.getMap());
		param = gdi.selectList("Proposal.getProPosal03List",map.getMap());
		
		return param;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void  proposalDelete2 ( Map<String, Object> map) throws DrinkException{
		
		logger.debug("service 111111111 :: " + map.toString());
		List<DataMap> param = new ArrayList<>();
		
		String prps_id = (String) map.get("prps_id");
		gdi.update("Proposal.subDelete",map);
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void proposalWork2 ( Map<String, Object> map) throws DrinkException{
		
		logger.debug("service 111111111 :: " + map.toString());
		List<DataMap> param = new ArrayList<>();
		
		
		String prps_id = (String) map.get("prps_id");
		
		
		List<Map<String, Object>> data = (List<Map<String, Object>>) map.get("_addPram");
		
		for(int i=0; i< data.size();i++){
			 logger.debug(i+" :: " + data.get(i).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data.get(i);
			 svMap.put("prps_id", prps_id);
			 svMap.put("prod_sitem_divs_cd", "01");
			 svMap.put("prod_no_sitem_nm", svMap.get("prodNoSitemCd"));
			 svMap.put("delivery_cnt", svMap.get("deliveryCnt"));
			 svMap.put("delivery_amt", svMap.get("deliveryAmt"));
			 svMap.put("dc_rate", Float.valueOf((String)svMap.get("dcRate")));
			 svMap.put("last_deliver_amt", svMap.get("lastDeliverAmt"));
			 svMap.put("login_id", map.get("regId"));
			 
			 gdi.update("Proposal.subInsert",svMap);
		}
		
		List<Map<String, Object>> data1 = (List<Map<String, Object>>) map.get("_addPram1");
		for(int j=0; j< data1.size();j++){
			 logger.debug(j+" :: " + data1.get(j).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data1.get(j);
			 svMap.put("prps_id", prps_id);
			 svMap.put("prod_sitem_divs_cd", "02");
			 svMap.put("prod_no_sitem_nm", svMap.get("prodNoSitemNm1"));
			 svMap.put("delivery_cnt", svMap.get("deliveryCnt1"));
			 svMap.put("delivery_amt", svMap.get("deliveryAmt1"));
			 svMap.put("dc_rate", Float.valueOf((String)svMap.get("dcRate1")));
			 svMap.put("last_deliver_amt", svMap.get("lastDeliverAmt1"));
			 svMap.put("login_id", map.get("regId"));
			 
			 gdi.update("Proposal.subInsert",svMap);
		}
		
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void proposalWork3 ( Map<String, Object> map) throws DrinkException{
		
		List<Map<String, Object>> data = (List<Map<String, Object>>) map.get("_addPram");
		
		if(data.size()>0){
			gdi.update("Proposal.proposalWork3Delete", ((Map<String, Object>)data.get(0)).get("prpsId"));
		}
		for(int i=0; i< data.size();i++){
			 logger.debug(i+" :: " + data.get(i).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data.get(i);
			 svMap.put("prpsId", svMap.get("prpsId"));
			 svMap.put("prodSitemDivsCd", svMap.get("prodSitemDivsCd"));
			 svMap.put("prodNoSitemNm", svMap.get("prodNoSitemNm"));
			 svMap.put("deliDate", svMap.get("deliDate"));
			 svMap.put("planCnt", svMap.get("planCnt"));
			 svMap.put("login_id", map.get("regId"));
			 gdi.update("Proposal.proposalWork3Insert",svMap);
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void proposalWork4 ( Map<String, Object> map) throws DrinkException{
		
		List<Map<String, Object>> data = (List<Map<String, Object>>) map.get("_addPram");
		
		if(data.size()>0){
			gdi.update("Proposal.proposalWork3Delete", ((Map<String, Object>)data.get(0)).get("prpsId"));
		}
		for(int i=0; i< data.size();i++){
			 logger.debug(i+" :: " + data.get(i).toString());
			 Map<String, Object> svMap = (Map<String, Object>) data.get(i);
			 svMap.put("prpsId", svMap.get("prpsId"));
			 svMap.put("prodSitemDivsCd", svMap.get("prodSitemDivsCd"));
			 svMap.put("prodNoSitemNm", svMap.get("prodNoSitemNm"));
			 svMap.put("deliDate", svMap.get("deliDate"));
			 svMap.put("planCnt", svMap.get("planCnt"));
			 svMap.put("real_delivery_cnt", svMap.get("real_delivery_cnt"));
			 svMap.put("real_delivery_cntn", svMap.get("real_delivery_cntn"));
			 svMap.put("login_id", map.get("regId"));
			 gdi.update("Proposal.proposalWork4Insert",svMap);
		}
	}
	
	public DataMap proposalProdMonD(DataMap dm) throws DrinkException{
		DataMap param = new DataMap();
	
		param = (DataMap) gdi.selectOne("Proposal.proPosalMonSearch",dm);
		
		return param;
	}
}
