package com.instagram.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.instagram.dto.ImageDto;

@Repository
@Mapper
public interface ImageMapper {
	
	//게시물 등록
	public int insertImage(ImageDto img);
	
	public List<ImageDto> getImageList();

	public int getImgCnt(String id);

	public List<ImageDto> getImagesbyId(String id);

	public int countByImageId(int imgNo);
	
	

}
