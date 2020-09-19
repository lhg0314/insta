package com.instagram.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.instagram.dao.ChatMapper;
import com.instagram.dto.ChatDto;

@Service
public class ChatService {
	
	@Autowired
	private ChatMapper chatDao;
	
	
	//채팅내역 전체출력
		public ArrayList<ChatDto> getChatListById(String fromID,String toID,String chatID){
			return chatDao.getChatListById(fromID, toID, chatID);
		}
		
		//최근 채팅내역 몇개반 가져옴(cnt 수 만큼)
		public ArrayList<ChatDto> getChatListByRecent(String fromID,String toID,int cnt){
			return chatDao.getChatListByRecent(fromID, toID, cnt);
		}
			
		//메시지를 보내는 메서드
		public int submit(ChatDto chat) {
			return chatDao.submit(chat);
		}
		
		//메시지 읽었는지 체크
		public int readChat(String fromID,String toID) {
			return chatDao.readChat(fromID, toID);
		}
		
		//읽지 않았는지 메시지의 수 가쳐오기
		public int getAllUnreadChat(String userID) {
			return chatDao.getAllUnreadChat(userID);
		}
		
		public List<ChatDto> getBox(String userID){
			List<ChatDto> chatBox=chatDao.getBox(userID);
			
			for (int i = 0; i < chatBox.size(); i++) {
				ChatDto x=chatBox.get(i);
				for (int j = 0; j < chatBox.size(); j++) {
					ChatDto y=chatBox.get(j);
					if((x.getFromID()).equals(y.getToID()) && (x.getToID()).equals(y.getFromID())) {
						if(x.getChatID()<y.getChatID()) {
							chatBox.remove(x);
							i--;
							break;
						}else {
							chatBox.remove(y);
							j--;
							break;
						}
					}
				}
			}
			for (ChatDto chatDto : chatBox) {
				
			}
			System.out.println("");
			return chatBox;
			
		}
		
		public int getUnreadMessage(String fromId,String toId) {
			Map<String,String> userMap=new HashMap<String,String>();
			
			userMap.put("fromId", fromId);
			userMap.put("toId", toId);
			return chatDao.geUnreadChat(userMap);
		}

}
