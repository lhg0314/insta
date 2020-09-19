package com.instagram.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.instagram.dao.ImageMapper;
import com.instagram.dto.ImageDto;

@Service
public class ImageService {
	
	@Autowired
	ImageMapper imgDao;
	
	public void insertImage(ImageDto img) {
		int res=imgDao.insertImage(img);
		if(res>0) {
			System.out.println("db삽입 성공");
		}else {
			System.out.println("db삽입 실패");
		}
		
	}
	
	public List<ImageDto> getImageList(){
		return imgDao.getImageList();
	}

	//게시글 수 가져오기
	public int getImgCnt(String id) {
		// TODO Auto-generated method stub
		return imgDao.getImgCnt(id);
	}

	//아이디를 사용해서 아이디 주인의 게시물 리스트 가져오기
	public List<ImageDto> getImagesbyId(String id) {
		// TODO Auto-generated method stub
		return imgDao.getImagesbyId(id);
	}

	//이미지 번호에따른 좋아요 수 가져오기
	public int countByImageId(int imgNo) {
		// TODO Auto-generated method stub
		return imgDao.countByImageId(imgNo);
	}

	

}
