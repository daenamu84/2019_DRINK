/** 
* @ Title: ProductService.java 
* @ Package: com.drink.service.product 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2019. 2. 26. 오전 8:56:09 
* @ Version V0.0 
*/

package com.drink.service.product;

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
import com.drink.service.brand.BrandService;

@Service("ProductService")
public class ProductService {
	private static final Logger logger = LogManager.getLogger(BrandService.class);
	@Autowired
	GenericMapperImpl<Object, Object> gdi;

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void productInsert(RequestMap map) throws DrinkException{
		
		if(map.getString("brandId").equals("")){
			 throw new DrinkException(new String[]{"messageError","브랜드코드은 필수 값 입니다."});
		}
		if(map.getString("subBrandId").equals("")){
			throw new DrinkException(new String[]{"messageError","서브브랜드코드은 필수 값 입니다."});
		}
		if(map.getString("prodMlCd").equals("")){
			throw new DrinkException(new String[]{"messageError","용량은 필수 값 입니다."});
		}
		if(map.getString("useYn").equals("")){
			throw new DrinkException(new String[]{"messageError","활성화는 필수 값 입니다."});
		}
		
		logger.debug("service :: " + map.toString());
		int rtCnt = gdi.update("Product.productInsert", map.getMap());
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","저장된 데이터가 없습니다."});
		}
	}
	
	public List productList(RequestMap map) throws DrinkException{
		List<DataMap> param = new ArrayList<>();
		map.put("brandId", ((String)map.get("brandId")).split(",") );
		
		param = gdi.selectList("Product.getProductList",map.getMap());
		
		return param;
	}
	
	public DataMap productDetail(RequestMap map) throws DrinkException{
		DataMap param = new DataMap();
		param = (DataMap) gdi.selectOne("Product.getProductDetail",map.getMap());
		
		return param;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void productUpdate(RequestMap map) throws DrinkException{
		
		if(map.getString("prodNo").equals("")){
			 throw new DrinkException(new String[]{"messageError","제품No는 필수 값 입니다."});
		}
		if(map.getString("prodMlCd").equals("")){
			throw new DrinkException(new String[]{"messageError","용량은 필수 값 입니다."});
		}
		if(map.getString("useYn").equals("")){
			throw new DrinkException(new String[]{"messageError","활성화는 필수 값 입니다."});
		}
		
		logger.debug("service :: " + map.toString());
		int rtCnt = gdi.update("Product.productUpdate", map.getMap());
		if(rtCnt < 1){
			throw new DrinkException(new String[]{"messageError","수정된 데이터가 없습니다."});
		}
	}
}