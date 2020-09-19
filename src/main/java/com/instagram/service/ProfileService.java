package com.instagram.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.instagram.dao.ProfileMapper;

@Service
public class ProfileService {
	
	@Autowired
	ProfileMapper proDao;
	
	
	//유저의 팔로우 수 반환 
		public int countByFromUserId(String id) {
			// TODO Auto-generated method stub
			return proDao.countByFromUserId(id);
		}

		//유저의 팔로워 수 반환
		public int countByToUserId(String id) {
			// TODO Auto-generated method stub
			return proDao.countByToUserId(id);
		}

}
