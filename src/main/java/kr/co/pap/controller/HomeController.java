package kr.co.pap.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import java.util.Map;
import java.util.UUID;

import java.util.Random;


import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;
import kr.co.pap.adminpage.BannerDTO;
import kr.co.pap.adminpage.EventVO;
import kr.co.pap.adminpage.UserboardManageService;
import kr.co.pap.board.BoardVO;
import kr.co.pap.services.AccountService;
import kr.co.pap.services.BannerService;
import kr.co.pap.services.BoardService;
import kr.co.pap.services.ChartService;
import kr.co.pap.services.EventService;
import lombok.extern.slf4j.Slf4j;

/**
 */
@Slf4j
@Controller
public class HomeController {
	
    @Autowired
    AccountService service;
    @Autowired
	EventService eservice;
	@Autowired
	BannerService bservice;
	@Autowired
	ChartService cservice;
	@Autowired
	UserboardManageService uservice;
	@Autowired
	BoardService BoService;
	@Autowired
	private JavaMailSender mailSender;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		logger.info("Welcome homed! The client locale is {}.", locale);
		
		List<EventVO> vo = eservice.list2();
		List<BannerDTO> banner = bservice.list();
		model.addAttribute("eventList", vo);
		model.addAttribute("bannerlist", banner);
		
		// 나눔글 최근 글 목록 조회
		List<BoardVO> listRecent = BoService.listRecent(308);
		model.addAttribute("listRecent", listRecent);
		
		// 댓글 총 갯수 표시
		int[] replyCnt = new int[listRecent.size()];
			for (int i = 0; i < listRecent.size(); i++) {
				replyCnt[i] = BoService.replyCount(listRecent.get(i).getBo_num());
			}
		model.addAttribute("replyCount", replyCnt);
		
		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncName = new String[listRecent.size()];
				for(int i=0; i<listRecent.size(); i++) {
					ncName[i] = BoService.getName(listRecent.get(i).getUi_id());
				}
		model.addAttribute("ncName", ncName);
		
		// 인기글 7일 이내 목록 조회
		List<BoardVO> listHot = BoService.getHot();
		model.addAttribute("listHot", listHot);
		
		// 댓글 총 갯수 표시
		int[] replyCntHot = new int[listHot.size()];
			for (int i = 0; i < listHot.size(); i++) {
					replyCntHot[i] = BoService.replyCount(listHot.get(i).getBo_num());
				}
		model.addAttribute("replyCountHot", replyCntHot);
				
		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncNameHot = new String[listHot.size()];
					for(int i=0; i<listHot.size(); i++) {
						ncNameHot[i] = BoService.getName(listHot.get(i).getUi_id());
					}
		model.addAttribute("ncNameHot", ncNameHot);
		
		
		//이달의 펫 조회 
		List<BoardVO> monthpet = BoService.monthPet();
		model.addAttribute("monthpet", monthpet);
		
		// 댓글 총 갯수 표시
		int[] replyCntPet = new int[monthpet.size()];
			for (int i = 0; i < monthpet.size(); i++) {
					replyCntPet[i] = BoService.replyCount(monthpet.get(i).getBo_num());
				}
		model.addAttribute("replyCountPet", replyCntPet);
		
		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncNamePet = new String[monthpet.size()];
					for(int i=0; i<monthpet.size(); i++) {
						ncNamePet[i] = BoService.getName(monthpet.get(i).getUi_id());
					}
		model.addAttribute("ncNamePet", ncNamePet);
		
		
		return "index";
	}
	
	@RequestMapping(value="layout")
	public String Test() {
		
	
		return "layout";
	}

	
	@RequestMapping(value="login")
	public String login() {
		
		
		return "login";
	}
	
	@RequestMapping(value="login" , method = RequestMethod.POST)
	public String login(LoginVO vo,HttpServletRequest request,HttpServletResponse response,
			HttpSession session,Model model) throws Exception 
	{	request.setCharacterEncoding("utf-8");

		System.out.println(vo);
		
		LoginVO user = service.login(vo);
		

		if(user == null) {
			return "redirect:login";
		}else {

			UserVO uv = service.selecOneUser(vo.getUi_id());
			
			model.addAttribute("uv", uv);

			if(uv.getUi_prohibit()==0) {//제재없음
				if(cservice.loginduplicate(vo.getUi_id())==null) {
					cservice.logincnt(vo.getUi_id());
				}
				session.setAttribute("user", user);
				return "redirect:/";
			}else {//제재있을때
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
				String today = null;
				Date todate = null;
				Date enprohibitday = null;
				today = sdf.format(new Date());
				enprohibitday = sdf.parse(uv.getUi_enprohibit());
				todate = sdf.parse(today);
				
				
				if(enprohibitday.before(todate)) {
					uservice.banclear(uv.getUi_id());
					session.setAttribute("user", user);
					return "redirect:/";
				}else if(enprohibitday.equals(sdf.parse("2999-12-31"))){
					model.addAttribute("msg", "회원님은 영구정지 되었습니다. "
							+ "자세한 문의사항은 고객센터(111-1234)로 문의하세요.");
					model.addAttribute("url", "/pap/");
				}else {
					
					if(uv.getUi_prohibit()==1) {
					session.setAttribute("user", user);
					model.addAttribute("msg", "회원님은 게시판 정지 되었습니다. "
							+ "기간:" + uv.getUi_stprohibit() + "~" + uv.getUi_enprohibit());
					model.addAttribute("url", "/pap/");
					}if(uv.getUi_prohibit()==2) {
						model.addAttribute("msg", "회원님은 사이트 이용 정지 되었습니다. "
							+ "기간:" + uv.getUi_stprohibit() + "~" + uv.getUi_enprohibit());
						model.addAttribute("url", "/pap/");
					}
				}
				
				return "alert";
			}
		}
	}
	
	
	@RequestMapping(value="personal/password", method = RequestMethod.GET)
	public String perPassword(@RequestParam("ui_id") String ui_id){
		return "/psnal/personalPassword";
	}
	
	
	@RequestMapping(value="personal/password", method = RequestMethod.POST)
	public String confirmPW(LoginVO vo) throws Exception {
		String ui_pw = service.confirmPW(vo);
		
		if(ui_pw==null) {
			return "personalPassword";
		}else {
			return "redirect:update?ui_id=" + vo.getUi_id();
		}
	}
	
	@RequestMapping(value="personal/update", method = RequestMethod.GET)
	public String personalUpdate(@RequestParam("ui_id")String ui_id, Model model) throws Exception {
		UserVO uv = service.selecOneUser(ui_id);
		model.addAttribute("uv", uv);
		return "/psnal/personalUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value="persnal/updateProc", method = RequestMethod.POST)
	public int personalUpdate(@RequestBody UserVO vo) throws Exception {
		
		return service.userupdate(vo);
	}
	
	@GetMapping(value="personal/delete")
	public String userdel(@RequestParam("ui_id")String ui_id,HttpSession session, Model model) {
		int r = service.userdel(ui_id);
		if(r>0) {
			session.invalidate();
			model.addAttribute("msg", "탈퇴 완료되었습니다.");
			model.addAttribute("url", "/pap/");
			return "alert";
		}else {
			model.addAttribute("msg", "서버 오류로 탈퇴 처리 실패. 다시 시도하세요");
			model.addAttribute("url", "update?ui_id=" + ui_id);
			return "alert";
		}
	}
	
	@RequestMapping(value="logout" , method = RequestMethod.GET)
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping(value="register")
	public String registerForm() {
		
		return "registerForm";
	}
	
	@ResponseBody
	@RequestMapping(value="account/dueplicate", method = RequestMethod.POST)
	public int dueplicate(@RequestParam("id") String id) throws Exception {
		
		return service.dueplicate(id);
	}
	
	@ResponseBody
	@RequestMapping(value="account/ncdueplicate", method = RequestMethod.POST)
	public int ncdueplicate(@RequestParam("ncName") String ncName) throws Exception {
		
		return service.ncdueplicate(ncName);

	}
	
	@ResponseBody
	@PostMapping(value = "account/emduplicate")
	public int emduplicate(String email) throws Exception {
	    
	    return service.countEmail(email);
	}
	
	@ResponseBody
	@PostMapping(value = "registerEmail")
	public String registerEmail(String email){
	    System.out.println(email);
	    //      create rnadom number 
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		// send e-mail
		String setForm = "rkdmf601@naver.com";
		String toMail = email;
		String title = "PAP 회원가입 인증메일 입니다.";
		String content = "저희 Pit_A_Pet 홈페이지에 회원가입을 신청해주셔서 감사합니다." + 
		        "<br><br>" +
		        "인증번호는 " + checkNum + "입니다." + 
		        "<br>" +
		        "위의 인증번호를 회원가입 창의 '인증번호'란에 입력해주세요.";
		
		try {
		    
		    MimeMessage message = mailSender.createMimeMessage();
		    MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		    helper.setFrom(setForm);
		    helper.setTo(toMail);
		    helper.setSubject(title);
		    helper.setText(content);
		    mailSender.send(message);
		    
		}catch(Exception e) {
		    e.printStackTrace();
		}
		

		return Integer.toString(checkNum);
	}

	@ResponseBody
	@RequestMapping(value="registerProc", method = RequestMethod.POST)
	public int registerProc(UserVO vo) throws Exception {

		logger.info("4");
		
		cservice.joincnt();
		
		return service.registerUser(vo);
	}
	
	@RequestMapping(value="adminindex")
	public String adminindex() {
		return "admin/adminindex";

	}
	@RequestMapping(value="login/kakao")
	public String kakaologin(String id,String email,HttpSession session) throws Exception {
		LoginVO user = service.kakaocheck(id);
		if(user == null) {
			UserVO kakao = new UserVO();
			kakao.setUi_email(email);
			kakao.setUi_id(id);
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String randomncname = uuids[1];
			kakao.setUi_ncName(randomncname);
			kakao.setUi_pw("1234");
			kakao.setUi_registertype(1);
			kakao.setUi_grade("평회원");
			service.kakaoregister(kakao);
			LoginVO kakaoregister = service.kakaocheck(kakao.getUi_id());
			cservice.joincnt();
			session.setAttribute("user", kakaoregister);
			return"redirect:/";
		}
		else {
			if(cservice.loginduplicate(id)==null) {
				cservice.logincnt(id);
			}
			session.setAttribute("user",user);
			return "redirect:/";
		}
		
	}
	@RequestMapping(value="login/navertest")
	public String navertest() {
		return "navertest";
	}
	@RequestMapping(value="login/naver")
	public String naverlogin(String id,String email,String phonenum,HttpSession session) throws Exception {
		LoginVO user = service.kakaocheck(id);
		if(user == null) {
			UserVO naver = new UserVO();
			naver.setUi_email(email);
			naver.setUi_id(id);
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String randomncname = uuids[1];
			naver.setUi_ncName(randomncname);
			naver.setUi_registertype(2);
			naver.setUi_pw("1234");
			naver.setUi_phonenum(phonenum);
			naver.setUi_grade("평회원");
			service.kakaoregister(naver);
			LoginVO kakaoregister = service.kakaocheck(naver.getUi_id());
			cservice.joincnt();
			session.setAttribute("user", kakaoregister);
			return"redirect:/";
		}
		else {
			if(cservice.loginduplicate(id)==null) {
				cservice.logincnt(id);
			}
			session.setAttribute("user",user);
			return "redirect:/";
		}
	
	}
}
