package com.instagram.storage;

import java.util.Set;

public class UserStorage {//채팅방의 유저정보를 저장하는 용도
	
	
	private static UserStorage instance;
	
	private Set<String> users;
	
	private UserStorage() {}
	public static synchronized UserStorage getInstance() {
		if(instance ==null) {
			instance=new UserStorage();
		}
		return instance;
	}
	public Set<String> getUsers(){
		return users;
	}
	
	public void setUser(String userName) throws Exception {
		if(users.contains(userName)) {
			throw new Exception("해당 유저는 이미 "+userName+"으로 참가했습니다");
		}
		users.add(userName);
	}
}
