package kr.co.pap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;
import kr.co.pap.chat.ChatVO;
import kr.co.pap.services.BoardService;
import kr.co.pap.services.chatService;

@Controller
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);	
	@Inject
	chatService service;
	
	@Inject
	BoardService bService;
	
	// 미니채팅
		@ResponseBody
		@GetMapping(value="miniChat")
		public Map<String, Object> minichat(Model model, HttpSession session, HttpServletRequest request, @RequestParam(name="usernameTO", required=false) String ch_toid)
				throws Exception {
			LoginVO user = (LoginVO)session.getAttribute("user");
			System.out.println("유저정보:"+user);
			System.out.println("재귀호출 id: " + ch_toid);
			
				LoginVO userTo = new LoginVO();
				List<UserVO> listUsers = service.listUsers();
				System.out.println("대화목록 정보:"+listUsers);
				if (ch_toid == null) {
					if (listUsers.get(0).getUi_ncName().equals(user.getUi_ncname())) {
						userTo.setUi_id(listUsers.get(1).getUi_id());
						userTo.setUi_pw(listUsers.get(1).getUi_pw());
						userTo.setUi_ncname(listUsers.get(1).getUi_ncName());
						
					} else {
						userTo.setUi_id(listUsers.get(0).getUi_id());
						userTo.setUi_pw(listUsers.get(0).getUi_pw());
						userTo.setUi_ncname(listUsers.get(0).getUi_ncName());
					
					}
				} else {
					for (UserVO u : listUsers) {
						if (u.getUi_id().equals(ch_toid)) {
							userTo.setUi_id(u.getUi_id());
							userTo.setUi_pw(u.getUi_id());
							userTo.setUi_ncname(u.getUi_ncName());
							break;
						}
					}
				
				}	
			
			ChatVO chatVO = new ChatVO();
			chatVO.setCh_fromid(user.getUi_id());
			chatVO.setCh_toid(userTo.getUi_id());
			
			Map<String,Object> chat =new HashMap<>();
			chat.put("username", user.getUi_id());
			chat.put("listUsers", listUsers);
			chat.put("userTo",userTo.getUi_id());
			chat.put("chat_content", service.getChat(chatVO));
	
			System.out.println("컨트롤러 결과 값"+chat);
			return chat;
			}// end of minichat
			
		
		// ajax id로 유저테이블 닉네임 가져오기
		@ResponseBody
		@GetMapping(value="getName")
		public Map<String,Object> getName3(@RequestParam("re_id") String re_id) throws Exception{
			
			System.out.println("아이디"+re_id);

//			logger.info(ncName);
			Map<String,Object> ncName =new HashMap<>();
			ncName.put("name", bService.getName(re_id));
			
			return ncName;
		}
		
		
		
		
		
	}
	
	

