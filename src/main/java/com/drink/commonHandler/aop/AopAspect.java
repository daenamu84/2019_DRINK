/** 
* @ Title: AopAspect.java 
* @ Package: com.drink.commonHandler.aop
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오전 10:10:46 
* @ Version V0.0 
*/
package com.drink.commonHandler.aop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.stereotype.Component;

/** 
* @ ClassName: AopAspect 
* @ Description: 
* @ Author: Daenamu
* @ Date: 2016. 10. 28. 오전 10:10:46 
*  
*/
@Component
public class AopAspect {
	private static final Logger logger = LogManager.getLogger(AopAspect.class);

	/** 
	* @ Title: someBeforeAdviceMethod 
	* @ Description: AOP Before
	* @ Param: @param joinPoint 
	* @ Return: void
	* @ Date: 2016. 10. 28. 오전 10:18:26
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/
	public void someBeforeAdviceMethod(JoinPoint joinPoint) {
		// 대상 객체 메서드 실행전 수행할 공통기능
	}

	/** 
	* @ Title: someAfterAdviceMethod 
	* @ Description: AOP After
	* @ Param: @param joinPoint 
	* @ Return: void
	* @ Date: 2016. 10. 28. 오전 10:18:28
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/
	public void someAfterAdviceMethod(JoinPoint joinPoint) {
		// 대상 객체 메서드 정상/Exception 발생여부와 상관없이 실행 후 수행할 공통기능
	}

	/** 
	* @ Title: someAroundAdviceMethod 
	* @ Description: AOP around
	* @ Param: @param joinPoint
	* @ Param: @return
	* @ Param: @throws Throwable 
	* @ Return: Object
	* @ Date: 2016. 10. 28. 오전 10:19:12
	* @ Throws 
	*
	*   <-- Modification Infomation -->
	*   수정일			수정자			수정내용
	*   ------			------			--------------------------------
	*
	*/
	public Object someAroundAdviceMethod(ProceedingJoinPoint joinPoint) throws Throwable {
		// 대상 객체 메서드 실행 전 실행될 공통 기능
		long start = System.currentTimeMillis();
		String signature = joinPoint.getSignature().toString();
		try {
			// 대상 객체 메서드 실행
			Object returnValFromTargetObjectMethod = joinPoint.proceed();
			return returnValFromTargetObjectMethod;
			// 대상 객체 메서드 실행 후 실행될 공통 기능  
		} finally {
			// 대상 객체 메서드 정상 실행 여부와 상관없이 실행될 공통 기능
			long end = System.currentTimeMillis();
			logger.info("class ::"+ signature +"★Proceed Start : " + start + " ★end : " + end + " ★TIME : " + (end - start) + "ms");
		}
	}

}
