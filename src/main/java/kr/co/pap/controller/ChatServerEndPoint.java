package kr.co.pap.controller;

import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.pap.chat.DateNow;
import kr.co.pap.chat.ChatVO;
import kr.co.pap.chat.SpringContextUtil;
import kr.co.pap.services.BoardServiceImpl;
import kr.co.pap.services.chatServiceImpl;

@ServerEndpoint("/chatServerEndpoint/{username}")
public class ChatServerEndPoint {
	static Set<Session> listUser = (Set<Session>) Collections.synchronizedSet(new HashSet<Session>());
	
	private chatServiceImpl chatService;
	private BoardServiceImpl boardService;
	
	
	@OnOpen
	public void hanndleOpen(Session session, @PathParam("username") String username) {
		listUser.add(session);
		session.getUserProperties().put("username", username);
		System.out.println(username +" : 파라미터로 받은 OnOpen username");
		System.out.println("connect with client " + session.getId());
	} // end of handleOpen()
	
	@OnMessage
	public void handleMessage(String message, Session session) throws Exception{
		JsonElement element = JsonParser.parseString(message);
		System.out.println(message +"=> json message");
		JsonObject obj = element.getAsJsonObject();
		
		// get info of messenger : sender, receiver, message, date
		String usernameFrom = obj.get("usernameFrom").toString();
		usernameFrom = usernameFrom.substring(1, usernameFrom.length() - 1);

		String usernameTo = obj.get("usernameTo").toString();
		usernameTo = usernameTo.substring(1, usernameTo.length() - 1);
		
		String contentChat = obj.get("message").toString();
		contentChat = contentChat.substring(1, contentChat.length() - 1);
		
		// create object message and save to database
		ChatVO chatMessage = new ChatVO();
		chatMessage.setCh_fromid(usernameFrom);
		chatMessage.setCh_toid(usernameTo);
		chatMessage.setCh_content(contentChat);
		chatMessage.setCh_sendtime(DateNow.getDateNowFull());
		System.out.println("onmessage worked. DB저장 채팅 : " +chatMessage);
		
		// 서비스 호출. 웹소켓 서버로 주입 안되고있음 => SprintContextUtil로 서비스 받음
		if(this.chatService == null) {
			chatService =  (chatServiceImpl)SpringContextUtil.getBean("chatServiceImpl");
		}
		chatService.addChat(chatMessage);
		
		
		// send message to receiver
		Iterator<Session> iterator = listUser.iterator();
		while (iterator.hasNext()) {
			Session tmpUser = iterator.next();
			if (tmpUser.getUserProperties().get("username").equals(usernameTo)
				|| tmpUser.getUserProperties().get("username").equals(usernameFrom)) {
				if(this.boardService == null) {
					boardService =  (BoardServiceImpl)SpringContextUtil.getBean("boardServiceImpl");
				}
				chatMessage.setCh_fromid(boardService.getName(chatMessage.getCh_fromid()));
				System.out.println(chatMessage);
				
				tmpUser.getBasicRemote().sendText(buildToJSON(chatMessage, usernameFrom, usernameTo));
			
				System.out.println("server end point : sending");
				}
		
			} // end of iterator.hasNext()
		
		
	} // end of handleMessage()
	
	@OnClose
	public void handleClose(Session session) {
		listUser.remove(session);
		System.out.println("disconnect... " + session.getId());
	} // end of handleClose
	
	private String buildToJSON(ChatVO contentChat, String ch_fromid, String ch_toid) {
		String result = "{ \"content\" : \"" + contentChat.toString() + "\", \"usernameFrom\" : \"" + ch_fromid + "\"," 
				+ " \"usernameTo\" : \"" + ch_toid + "\"}";
		return result;
	} // end of buildToSJON
	
	
	
	
}
