/** 
* @ Title: SecurityUtils.java 
* @ Package: com.drink.commonHandler.util 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 23. 오전 11:21:12 
* @ Version V0.0 
*/ 
package com.drink.commonHandler.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import org.springframework.stereotype.Component;

import com.drink.commonHandler.Exception.DrinkException;

/** 
* @ ClassName: SecurityUtils 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 12. 23. 오전 11:21:12 
*  
*/
@Component
public class SecurityUtils {
	
	/*  암호화 모듈 Encrypt ,  Decrypt  메소드 개발
	 *  MD5 SHA-1  SHA-256  
	 *  SEED(ECB, CBC, CTR : KISA 참고 - 인증키 디폴트 지정 외 유동적으로 처리 가능하게 개발) 
	 *  ARIA (KISA 참고  - 인증키 디폴트 지정 외 유동적으로 처리 가능하게 개발) 
	 *   AES128 AES256 (인증키 디폴트 지정 외 유동적으로 처리 가능하게 개발) 
	 *  java.security 참고
	 *  
	 *  Base64 - encode, decode 메소드 개발
	 *  
	 *  ※ 암호화 처리 순서 
	 *   1. 암호화 알고리즘으로  암호화
	 *   2. Base64 인코딩 
	 *   
	 *  ※ 복호화 처리 순서
	 *   1. Base64 디코딩
	 *   2. 암호화 알고리즘으로 복호화
	 *   
	 *  - 기본 Base64로 인코딩 디코딩 처리 하지만 각 암호화 알고리즘에서 자동 처리 하지 않고 
	 *   Base64 메소드를 다시 호출해서 사용 하는 방식으로 채택 
	 * 
	 */
	
	public String SHA256Encryptor(String str) throws DrinkException
    {
		String SHA = null;
		
		try 
		{			
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) 
			{
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
				        
			SHA = sb.toString();
		} 
		catch (NoSuchAlgorithmException e) 
		{
			e.printStackTrace();
			SHA = "Exception : " + e.getMessage();
			throw new DrinkException("SHA256 인코딩중 에러가 발생 했습니다.", e);
		}
		
		return SHA;
    }
		
	public String base64Encryptor(String str) throws DrinkException{
		
		Encoder encoder = Base64.getEncoder();
		byte[] encodedByte = null;
		try {
			encodedByte = encoder.encode(str.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			throw new DrinkException("base64 인코딩중 에러가 발생 했습니다.", e);
		}
		
		return new String(encodedByte);
	}
	
	public String base64Decryptor(String str) throws DrinkException{
		
		Decoder decoder = Base64.getDecoder();
		byte[] decodedByte = null;
		decodedByte = decoder.decode(str);
		return new String(decodedByte);
	}
}
