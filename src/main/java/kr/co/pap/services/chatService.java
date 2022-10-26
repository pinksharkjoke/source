package kr.co.pap.services;

import java.util.List;

import kr.co.pap.account.UserVO;
import kr.co.pap.chat.ChatVO;

public interface chatService {
	//대화내용추가
	public int addChat(ChatVO chatVO) throws Exception;
	
	//회원목록조회
	public List<UserVO> listUsers() throws Exception;
	
	//대화목록 불러오기
	public String getChat(ChatVO chatVO) throws Exception;
}
