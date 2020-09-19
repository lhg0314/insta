package com.instagram.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.instagram.dto.ImageDto;
import com.instagram.dto.tagDto;
import com.instagram.service.ImageService;

@Controller
public class ImageController {
	
	@Autowired
	ImageService imgService;
	
	@RequestMapping("/post/upload")
	public String uploadPost() {
		
		return "images/upload";
	}
	
	
	@PostMapping("/image/uploadProc")
	public String imageUploadProc(
			@RequestParam("file") MultipartFile file, @RequestParam("caption") String caption,@RequestParam("userid") String userid,
			@RequestParam("location") String location, @RequestParam("tags") String tags,HttpServletRequest req) throws IOException {

		ImageDto img=new ImageDto();
		img.setCaption(caption);
		img.setLocation(location);
		img.setWriter(userid);
		
		
		UUID uuid = UUID.randomUUID();//파일이름을 위해 고유식별자를 만듬
		String filerename=uuid+"_"+file.getOriginalFilename();
		img.setFilename(filerename);
		imgService.insertImage(img);
		
		
		
		//파일의 url지정
		ServletContext context=req.getServletContext();
		String fileurl=context.getRealPath("/uploadFiles");
		System.out.println(fileurl);
		
		File newfile=new File(fileurl,filerename);//새로운 파일 객체 생성
		
		
		IOUtils.copy(file.getInputStream(), new FileOutputStream(newfile));//폴더에 파일 업로드
		
		return "redirect:/";
	}
	
	
	public static List<String> tagParser(String tags){//태그를 여러개 달았을때 파싱하는 메소드
		String temp[] = tags.split("#");
		
		List<String> tagList = new ArrayList<String>();
		
		int len = temp.length;
		
		for(int i=1; i<len; i++) {
			tagList.add(temp[i]);
		}
		return tagList;
	}

}
