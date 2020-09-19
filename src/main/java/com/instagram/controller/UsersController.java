package com.instagram.controller;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.instagram.dto.Member;
import com.instagram.service.SecurityService;
import com.instagram.storage.UserStorage;

//@controller는 view화면은 리턴하는것이 주용도 이고 이것응ㄴ 데이터를 리턴하는것이 주용도이다
@RestController
@CrossOrigin
public class UsersController {
	@Autowired
    SecurityService securityService;

    @GetMapping("/registration/{userName}")
    public ResponseEntity<Void> register(@PathVariable String userName) {
        System.out.println("handling register user request: " + userName);
        try {
            UserStorage.getInstance().setUser(userName);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok().build();
    }

    @GetMapping("/fetchAllUsers")
    public Set<String> fetchAll() {
        return UserStorage.getInstance().getUsers();
    }
    
    @PostMapping("/userRegister/check")
    public String userCheck(@RequestParam String userID) throws Exception {
    	Member searchMem=securityService.getSelectMeberInfo(userID);
    	if(searchMem==null) {
    		return "1";
    	}else {
    	
    	return "0";
    	}
    }
}
