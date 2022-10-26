package kr.co.pap.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.BoardDAO;
import kr.co.pap.DAO.chatDAO;
import kr.co.pap.account.UserVO;
import kr.co.pap.chat.ChatVO;

@Service
public class chatServiceImpl implements chatService{
	@Autowired
	private chatDAO dao;
	
	@Autowired
	private BoardDAO bDao;
	
	
	@Override
	public int addChat(ChatVO chatVO) throws Exception {
		// 대화내용저장
		return dao.addChat(chatVO);
	}

	@Override
	public List<UserVO> listUsers() throws Exception {
		// 회원목록조회
		return dao.listUsers();
	}

	@Override
	public String getChat(ChatVO chatVO) throws Exception {
		// 대화목록 불러오기
		String chat_content="";
		List<ChatVO> chat = dao.getChat(chatVO);
		
		for(ChatVO chatOne : chat) {
			chatOne.setCh_fromid(bDao.getName(chatOne.getCh_fromid()));
			chat_content = chat_content + chatOne +"\n";
		}
		
	//	chat_content = chat_content + chat.toString() + "\n"; => 리스트를 스트링으로 뽑아서 줄바꿈 없음.
		
		return chat_content;
	}

}
