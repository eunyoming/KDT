package com.kedu.beans;

public interface Tv { // interface : 추상 클래스
	
	// 메서드 이름을 강제 시킨다.
	// 추상메서드라 {} 열면 안됨.
	public void powerOn();
	public void powerOff();
	public void volumeUp();
	public void volumeDown();
	
	
}
