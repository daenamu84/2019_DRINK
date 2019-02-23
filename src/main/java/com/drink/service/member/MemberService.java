/** 
* @ Title: MainService.java 
* @ Package: com.drink.service.brand 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 18. 오전 11:50:18 
* @ Version V0.0 
*/ 
package com.drink.service.member;

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
@Service("MemberService")
public class MemberService {
	private static final Logger logger = LogManager.getLogger(MemberService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	
	public List getDeptList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Member.getDeptList",param);
		
		return param;
	}
	
	public List getEmpMList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		
		param = gdi.selectList("Member.getEmpMList",param);
		
		return param;
	}
	
	public DataMap duplicateIDCheck(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		
		param = (DataMap) gdi.selectOne("Member.duplicateIDCheck",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void memberWork(RequestMap map) throws DrinkException{
		
		logger.debug("map==="+ map.toString());
		DataMap param = new DataMap();
		
		gdi.update("Member.empInsert", map.getMap());
		
		int empNo = 0;
		
		param = (DataMap) gdi.selectOne("Member.getEmpNo",map.getMap());
		
		if(param.getString("EMP_NO")!= ""){
			empNo = param.getInt("EMP_NO");
		}
		
		if(empNo==0) {
			throw new DrinkException(new String[]{"messageError","팀원입력에 실패했습니다."});
		}
			map.put("emp_no", empNo);
			gdi.update("Member.empteam_dept_relInsert", map.getMap());
				
		
		List<DataMap> tempList = (List)map.get("mng_dept_no");
		//logger.debug("tempList==="+tempList.size());
		if(tempList.size()>0) {
			for (int i=0;i<tempList.size();i++) {
				logger.debug("1--"+tempList.get(i));
				map.put("deptno",tempList.get(i));
				gdi.update("Member.empteam_mng_dept_relInsert", map.getMap());
			}	
		}
	}
	
	
}
