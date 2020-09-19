package com.instagram.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.instagram.dto.ImageDto;
import com.instagram.service.ImageService;

@Controller
public class BasicController {
	@Autowired
	ImageService imgService;
	
	@RequestMapping("/")
	public String index(Model model,Authentication auth,HttpSession session) {
		
		session.setAttribute("userID", (String) auth.getPrincipal());//인증후 아이디값 세션에 저장
		List<ImageDto> images=imgService.getImageList();
		System.out.println(images);
		model.addAttribute("images",images);
		
		return "index";
	}

}
