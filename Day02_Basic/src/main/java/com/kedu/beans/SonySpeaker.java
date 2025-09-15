package com.kedu.beans;

public class SonySpeaker implements Speaker{
	
	@Override
	public void volumeUp() {
		System.out.println("Sony 스피커 볼륨 올림");
	}
	
	@Override
	public void volumeDown() {
		
	}
}
