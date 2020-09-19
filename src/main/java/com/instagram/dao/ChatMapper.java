package com.instagram.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


import com.instagram.dto.ChatDto;

@Mapper
public interface ChatMapper {


	//채팅내역 전체출력
	public ArrayList<ChatDto> getChatListById(String fromID,String toID,String chatID);
	
	//최근 채팅내역 몇개반 가져옴(cnt 수 만큼)
	public ArrayList<ChatDto> getChatListByRecent(String fromID,String toID,int cnt);
		
	//메시지를 보내는 메서드에 저장
	public int submit(ChatDto chat);
	
	//메시지 읽었는지 체크
	public int readChat(String fromID,String toID);
	
	//읽지 않았는지 메시지의 수 가쳐오기
	public int getAllUnreadChat(String userID);
	
	//메시지함에 메시지 가지고오는 함수 구현
	public ArrayList<ChatDto> getBox(String userID);
	
	//안읽은 메시지 가져오기
	public int geUnreadChat(Map<String,String> map);
	
}
