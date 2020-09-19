package com.instagram.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.instagram.dto.ImageDto;
import com.instagram.dto.Member;

import com.instagram.service.ImageService;
import com.instagram.service.ProfileService;
import com.instagram.service.UserServiceImpl;

@Controller
public class MypageController {
	@Autowired
	ImageService imgService;
	
	@Autowired
	UserServiceImpl userService;
	
	@Autowired
	ProfileService proService;
	
	@RequestMapping("/user/mypage/{id}")
	public String profile(@PathVariable String id, Model model,HttpSession session) throws Exception {

		/**
		 * 1. imageCount 2. followerCount 3. followingCount 4. User 오브젝트 (Image
		 * (likeCount) 컬렉션) 5. followCheck 팔로우 유무 (1 팔로우, 1이 아니면 언팔로우)
		 */

		//해당 마이페이지의 유저 정보 가져옴
		Member mem=userService.getSelectMeberInfo(id);

		// 이미지의 수 가져오기
		int imageCount = imgService.getImgCnt(id);
		model.addAttribute("imageCount", imageCount);

		//  follow 수 저장
		
		int followCount = proService.countByFromUserId(id);
		model.addAttribute("followCount", followCount);

		//  follower 수 저장
		
		int followerCount = proService.countByToUserId(id);
		model.addAttribute("followerCount", followerCount);
		
		List<ImageDto> imgList=imgService.getImagesbyId(id);
		
		// 이미지에 따른 좋아요 수 가져오기
		for (ImageDto item : imgList) {
			int likeCount = imgService.countByImageId(item.getImgNo());
			item.setLikes(likeCount);;
		}

		model.addAttribute("user", mem);
		model.addAttribute("images",imgList);
		System.out.println(imgList);
		
		
		// 프로필대상과 본인이 팔로우 되었는지 check
//		Member me = userService.getSelectMeberInfo((String) session.getAttribute("userID"));

		//반환값이 2일경우 맞팔 1일경우 한쪽만 팔로우
//		int followCheck = proService.countByFromUserIdAndToUserId(me.getId(), id);
//		System.out.println("followCheck : " + followCheck);
//		model.addAttribute("followCheck", followCheck);

		return "user/mypage";
	}
	
	@RequestMapping("/chat/index")
	public String chatIndex() {
		
		return "chat/index";
	}
	

}
