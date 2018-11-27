package com.blog.common.aspect;

import com.blog.service.IndexService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.util.Arrays;

@Aspect
@Component
public class LogAspect {
	private static final Logger LOGGER=LoggerFactory.getLogger(DataSource.class);
	
	@Autowired
	IndexService testservice;
	
	@Pointcut("execution(* com.blog.controller.*.*(..))")
	public void webLog() {};
	
	@Before("webLog()")
	public void doBefore(JoinPoint joinPoint) throws Throwable{
		//接收到请求，记录请求内容
		ServletRequestAttributes attributes=(ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request=attributes.getRequest();
		//记录下请求内容
		LOGGER.info("url :"+request.getRequestURL().toString()+" IP:"+request.getRemoteAddr()+" CLASS_METHOD:"+joinPoint.getSignature().getDeclaringTypeName()+
				"."+joinPoint.getSignature().getName()+", ARGS:"+Arrays.toString(joinPoint.getArgs()));
	}
	
	@AfterReturning(returning="object",pointcut="webLog()")
	public void doAfterReturning(Object object) throws Throwable {
		//返回请求内容
		LOGGER.info("RESPONSE :"+object);
	}
	@Pointcut("execution(* com.blog.dao.*.*(..))")
	public void mapperLog() {};
	
	@Before("mapperLog()")
	public void mapperBefore(JoinPoint joinPoint) throws Throwable{
		
	}
}
