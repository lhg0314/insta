package com.instagram.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ProfileMapper {

	int countByFromUserId(String id);

	int countByToUserId(String id);
	
	

}
