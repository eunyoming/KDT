package com.kedu.commons;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

// 이 인터페이스 클래스를 상속한 클래스는
// 스캔돌면서 인스턴스를 생성하고, 안에 있는 메서드도 실행시킨다.
@Component 
public class SpringProvider implements ApplicationContextAware{
	
	// 스프링 인스턴스의 주소를 담기 위한 변수
	public static ApplicationContext ctx;
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		// 스프링 인스턴스 주소 담기.
		this.ctx = applicationContext;
		
	}
	
}
