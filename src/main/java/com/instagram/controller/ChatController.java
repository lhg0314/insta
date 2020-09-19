package com.instagram.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.instagram.dao.ChatMapper;
import com.instagram.dto.ChatDto;
import com.instagram.service.ChatService;

@Controller
public class ChatController {
	@Autowired
	ChatService chatService;
	
	@Autowired
	ChatMapper chatdao;
	
	@ResponseBody
	@RequestMapping("chat/submit")
	public int chatinsert(ChatDto chat,Model model) throws UnsupportedEncodingException {
		
		
		if(chat.getFromID()==null || chat.getToID()==null ||chat.getChatContent()==null||chat.getFromID().equals("")
				||chat.getToID().equals("")) {
			return 0;
		}else { 
			
			chat.setChatContent(URLDecoder.decode(chat.getChatContent(),"UTF-8"));
			return chatService.submit(chat);
			
		}
	}
	
	@ResponseBody
	@RequestMapping("chat/list")
	public String chatList(ChatDto chat,HttpServletRequest req) throws UnsupportedEncodingException {
//		System.out.println(chat);
		
		String listType=(String) req.getParameter("listType");
		System.out.println(listType);
		if(chat.getFromID()==null || chat.getToID()==null ||listType==null||(chat.getFromID()).equals("")||(chat.getToID()).equals("")||listType.equals("")) {
			
			return "";
		}else if(listType=="ten" ||listType.equals("ten")){
			System.out.println("열개 출력한다");
			return getTen(chat.getFromID(),chat.getToID());
		}else { 
			return getId(chat.getFromID(),chat.getToID(),listType);
			
//			chat.setChatContent(URLDecoder.decode(chat.getChatContent(),"UTF-8"));
//			System.out.println(chat);
//			return chatService.submit(chat);
			
		}
		
	}
	
	public String getTen(String fromID,String toID) {
		StringBuffer result=new StringBuffer("");
		result.append("{\"result\":[");
		ArrayList<ChatDto> chatList=chatdao.getChatListByRecent(fromID, toID, 50);
//		System.out.println("getten:"+chatList);
		if(chatList.size()==0)return "";
		for (int i = 0; i <chatList.size(); i++) {
			result.append("[{\"value\": \""+chatList.get(i).getFromID()+"\"},");
			result.append("{\"value\": \""+chatList.get(i).getToID()+"\"},");
			result.append("{\"value\": \""+chatList.get(i).getChatContent()+"\"},");
			result.append("{\"value\": \""+chatList.get(i).getChatTime()+"\"}]");
			
			if(i != chatList.size()-1) {
				result.append(",");
			}
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size()-1).getChatID()+"\"}");
		chatService.readChat(fromID, toID);//채팅을 읽었음을 표시
		return result.toString();
		
	}
	
	public String getId(String fromID,String toID,String chatID) {
		String result="";
		result="{\"result\":[";
		System.out.println(chatID);
		ArrayList<ChatDto> chatList=chatdao.getChatListById(fromID, toID, chatID);
		System.out.println("chatLIst: "+chatList);
		if(chatList.size()==0)return "";
		for (int i = 0; i <chatList.size(); i++) {
			result+="[{\"value\": \""+chatList.get(i).getFromID()+"\"},";
			result+="{\"value\": \""+chatList.get(i).getToID()+"\"},";
			result+="{\"value\": \""+chatList.get(i).getChatContent()+"\"},";
			result+="{\"value\": \""+chatList.get(i).getChatTime()+"\"}]";
			
			if(i != chatList.size()-1) {
				result+=",";
			}
		}
		result+="], \"last\":\"" + chatList.get(chatList.size()-1).getChatID()+"\"}";
		//System.out.println(result);
		chatService.readChat(fromID, toID);//채팅을 읽었음을 표시
		return result.toString();
		
	}
	
	@RequestMapping("chat/unread")
	@ResponseBody
	public String chatUnread(@RequestParam String userID) throws UnsupportedEncodingException {
		if(userID==null || userID.equals("")) {
			return "0";
		}else {
			userID=URLDecoder.decode(userID,"UTF-8");
			return chatService.getAllUnreadChat(userID)+"";
		}
		
		
	}
	
	@ResponseBody
	@RequestMapping("get/box")
	public String chatbox(@RequestParam String userID) throws UnsupportedEncodingException {
		if(userID==null || userID.equals("")) {
			return "0";
		}else {
			userID=URLDecoder.decode(userID,"UTF-8");
			return getBox(userID);
		}
		
		
	}
	
	public String getBox(String userID) {
		String result="";
		result="{\"result\":[";
		
		List<ChatDto> chatList=chatService.getBox(userID);
		
		
		
		if(chatList.size()==0)return "";
		for (int i = chatList.size()-1; i >=0; i--) {
			String unread="";
			if(userID.equals(chatList.get(i).getToID())) {//사용자가 toId인것중에 안읽은것 출력
				unread=chatService.getUnreadMessage(chatList.get(i).getFromID(), userID)+"";
				if(unread.equals("0")) {//안읽은 메시지가 없을때
					unread="";
				}
			}
			result+="[{\"value\": \""+chatList.get(i).getFromID()+"\"},";
			result+="{\"value\": \""+chatList.get(i).getToID()+"\"},";
			result+="{\"value\": \""+chatList.get(i).getChatContent()+"\"},";
			result+="{\"value\": \""+chatList.get(i).getChatTime()+"\"},";
			result+="{\"value\": \""+unread+"\"}]";
			
			if(i != 0) {
				result+=",";
			}
		}
		result+="], \"last\":\"" + chatList.get(chatList.size()-1).getChatID()+"\"}";
		System.out.println(result);
		
		return result.toString();
	}
	
	@RequestMapping("chat/box")
	public String chatBoxMapping() {
		return "/chat/box";
	}

	
	
	

	
}
