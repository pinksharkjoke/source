package kr.co.pap.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;

import kr.co.pap.services.AccountService;
import kr.co.pap.services.BoardService;
import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.board.HeartVO;
import kr.co.pap.board.PageMaker;
import kr.co.pap.board.ReplyVO;
import kr.co.pap.board.SearchCriteria;

@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardService service;
	@Autowired
	AccountService acservice;

	// 게시판 카테고리 별 글작성 폼 이동
	@RequestMapping(value = "board/insert", method = RequestMethod.GET)
	public String insert(@RequestParam int ca, Model model, HttpSession session, HttpServletResponse response)
			throws IOException {

		int type = ca;
		model.addAttribute("type", type);

		LoginVO user = (LoginVO) session.getAttribute("user");
		if (user == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인이 필요한 서비스입니다.'); history.go(-1); </script>");
			out.flush();
		}

		return "board/insert";
	}

	// 글 작성
	@RequestMapping(value = "board/insert", method = RequestMethod.POST)
	public String insert(@RequestParam int ca, Model model, BoardVO boardVO, HttpServletRequest request,
			HttpSession session, HttpServletResponse response, String photo) throws Exception {

		logger.info("d" + boardVO.getUi_id());
		int a = (acservice.selectOne(boardVO.getUi_id())).getUi_prohibit();
		logger.info("d" + a);

		if (a == 2) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('글쓰기가 제한되었습니다.');history.go(-1);</script>");
			out.flush();
			return "redirec:/";
		}

		if (boardVO.getBo_title() == "") {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('제목을 입력하세요');history.go(-1);</script>");
			out.flush();
			return "redirec:/";
		}

		for (int i = 0; i < boardVO.getBo_num(); i++) {

		}

		request.setCharacterEncoding("utf-8");

		logger.info("글 작성 내용 : " + boardVO + "사진" + photo);
		String tempcon = boardVO.getBo_content();
		if (photo == null) {
			int r = service.insert(boardVO);
			int temp = ca;
			if (temp < 100 || temp == 901 || temp == 902) {
				return "redirect:/board/list?ca=" + temp;
			} else if (temp < 200) {
				return "redirect:/board/listpicpet?ca=" + temp;
			} else if (temp < 300) {
				return "redirect:/board/list?ca=" + temp;
			} else {
				return "redirect:/board/listpicmarket?ca=" + temp;
			}
		} else {

//			String content = tempcon.replace(photo, "");
//		boardVO.setBo_content(content);
			if (photo != null) {

				boardVO.setBo_photo(photo);

			}

			int r = service.insert(boardVO);

			int temp = ca;
			if (temp < 100) {
				return "redirect:/board/list?ca=" + temp;
			} else if (temp < 200) {
				return "redirect:/board/listpicpet?ca=" + temp;
			} else if (temp < 300) {
				return "redirect:/board/list?ca=" + temp;
			} else {
				return "redirect:/board/listpicmarket?ca=" + temp;
			}

		}

	}

	// 써머노트 글 작성 사진업로드 커스텀
	@RequestMapping(value = "board/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request, Model model) {
		String photo = null;
		JsonObject jsonObject = new JsonObject();

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */

		// 내부 경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		System.out.println(contextRoot);
		String fileRoot = contextRoot + "resources/fileupload/";

		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			jsonObject.addProperty("url", "/pap/resources/fileupload/" + savedFileName); // contextroot + resources +
																							// 저장할 내부 폴더 명
			jsonObject.addProperty("responseCode", "success");

			photo = request.getContextPath() + "/resources/fileupload/" + savedFileName;
			
			
			
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("a", a);
		map.putIfAbsent("photo", photo);

		return map;
	}

	// 펫자랑 게시판 조회
	@RequestMapping(value = "board/listpicpet", method = RequestMethod.GET)
	public String listpicpet(@RequestParam("ca") int ca, Model model, @ModelAttribute("scri") SearchCriteria scri)
			throws Exception {
		int type = ca;
		model.addAttribute("type", type);

		scri.setCa_num(ca);
		List<BoardVO> list = service.list(scri);
		
		for(int i =0; i<list.size();i++) {
			if(list.get(i).getBo_photo()!=null) {
			String thumbnail = null;
			String [] st =list.get(i).getBo_photo().split(",");
			thumbnail = st[0];
			list.get(i).setBo_photo(thumbnail);
		}
		
	}
		
		
		
		logger.info("내용 : " + list);
		model.addAttribute("list", list);
		logger.info("내용 : " + service.listCount(scri));

		List<BoardVO> listnotice = service.listnotice(ca);
		model.addAttribute("listnotice", listnotice);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		logger.info(scri.toString());
		logger.info(pageMaker.toString());

		// 댓글 총 갯수 표시
		int[] replyCnt = new int[list.size()];
		for (int i = 0; i < list.size(); i++) {
			replyCnt[i] = service.replyCount(list.get(i).getBo_num());
		}
		model.addAttribute("replyCount", replyCnt);

		// 최근 글 목록 조회
		List<BoardVO> listRecent = service.listRecent(ca);
		model.addAttribute("listRecent", listRecent);

		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncName = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ncName[i] = service.getName(list.get(i).getUi_id());
		}
		model.addAttribute("ncName", ncName);

		return "board/listpicpet";
	}

	// 판매중인 글만 보기

	@RequestMapping(value = "board/listing", method = RequestMethod.GET)
	public String listing(@RequestParam("ca") int ca, Model model, @ModelAttribute("scri") SearchCriteria scri)
			throws Exception {

		int type = ca;
		model.addAttribute("type", type);

		scri.setCa_num(ca);
		List<BoardVO> list = service.listing(scri);
		
		for(int i =0; i<list.size();i++) {
			if(list.get(i).getBo_photo()!=null) {
			String thumbnail = null;
			String [] st =list.get(i).getBo_photo().split(",");
			thumbnail = st[0];
			list.get(i).setBo_photo(thumbnail);
		}
		
	}

		logger.info("내용 : " + list);
		model.addAttribute("list", list);
		logger.info("내용 : " + service.listingCount(scri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listingCount(scri));
		model.addAttribute("pageMaker", pageMaker);

		// 댓글 총 갯수 표시
		int[] replyCnt = new int[list.size()];
		for (int i = 0; i < list.size(); i++) {
			replyCnt[i] = service.replyCount(list.get(i).getBo_num());
		}
		model.addAttribute("replyCount", replyCnt);

		// 최근 글 목록 조회
		List<BoardVO> listRecent = service.listRecent(ca);
		model.addAttribute("listRecent", listRecent);

		logger.info(scri.toString());
		logger.info(pageMaker.toString());

		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncName = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ncName[i] = service.getName(list.get(i).getUi_id());
		}
		model.addAttribute("ncName", ncName);

		return "board/listing";

	}

	// 중고장터 게시판 조회
	@RequestMapping(value = "board/listpicmarket", method = RequestMethod.GET)
	public String listpicmarket(@RequestParam("ca") int ca, Model model, @ModelAttribute("scri") SearchCriteria scri)
			throws Exception {

		int type = ca;
		model.addAttribute("type", type);

		scri.setCa_num(ca);
		List<BoardVO> list = service.list(scri);
		logger.info("내용 : " + list);
		model.addAttribute("list", list);
		logger.info("내용 : " + service.listCount(scri));

	
	

		for(int i =0; i<list.size();i++) {
			if(list.get(i).getBo_photo()!=null) {
			String thumbnail = null;
			String [] st =list.get(i).getBo_photo().split(",");
			thumbnail = st[0];
			list.get(i).setBo_photo(thumbnail);
		}
		
	}
		
		
		
		List<BoardVO> listnotice = service.listnotice(ca);
		model.addAttribute("listnotice", listnotice);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		logger.info(scri.toString());
		logger.info(pageMaker.toString());

		// 댓글 총 갯수 표시
		int[] replyCnt = new int[list.size()];
		for (int i = 0; i < list.size(); i++) {
			replyCnt[i] = service.replyCount(list.get(i).getBo_num());
		}
		model.addAttribute("replyCount", replyCnt);

		// 최근 글 목록 조회
		List<BoardVO> listRecent = service.listRecent(ca);
		model.addAttribute("listRecent", listRecent);

		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncName = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ncName[i] = service.getName(list.get(i).getUi_id());
		}
		model.addAttribute("ncName", ncName);

		return "board/listpicmarket";
	}

	// 일반게시판 전체조회
	@RequestMapping(value = "board/list", method = RequestMethod.GET)
	public String list(@RequestParam("ca") int ca, Model model, @ModelAttribute("scri") SearchCriteria scri)
			throws Exception {

		int type = ca;
		model.addAttribute("type", type);

		scri.setCa_num(ca);
		List<BoardVO> list = service.list(scri);
		logger.info("내용 : " + list);
		model.addAttribute("list", list);
		logger.info("내용 : " + service.listCount(scri));

		List<BoardVO> listnotice = service.listnotice(ca);
		model.addAttribute("listnotice", listnotice);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		logger.info(scri.toString());
		logger.info(pageMaker.toString());

		// 댓글 총 갯수 표시
		int[] replyCnt = new int[list.size()];
		for (int i = 0; i < list.size(); i++) {
			replyCnt[i] = service.replyCount(list.get(i).getBo_num());
		}
		model.addAttribute("replyCount", replyCnt);

		// 글테이블 id로 유저테이블ncName가져오기
		String[] ncName = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ncName[i] = service.getName(list.get(i).getUi_id());
		}
		model.addAttribute("ncName", ncName);

		// 글테이블 id로 유저테이블Grade가져오기
		String[] grade = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			grade[i] = service.getGrade(list.get(i).getUi_id());
		}
		model.addAttribute("grade", grade);

		return "board/list";
	}

	// 게시글 상세 조회
	@RequestMapping(value = "board/detail", method = RequestMethod.GET)
	public String detail(@RequestParam int num, HttpSession session, Model model,
			@ModelAttribute("scri") SearchCriteria scri, HttpServletResponse response) throws Exception {
		logger.info("=====detail====" + num);

		int bo_num = num;
		BoardVO board = service.detail(bo_num);

		// 삭제된 글 url접근 막기
		if (board.getBo_status() == 1 || board.getBo_status() == 3) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('삭제된 글입니다.'); history.go(-1); </script>");
			out.flush();
		}

		model.addAttribute("board", board);

		model.addAttribute("replyCount", service.replyCount(bo_num));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);

		// 글 테이블 id로 유저테이블 닉네임 조회
		String ncName = service.getName(board.getUi_id());
		model.addAttribute("ncName", ncName);

		// 좋아요
		LoginVO user = (LoginVO) session.getAttribute("user");

		if (user == null) {
			// 좋아요 조회
			HeartVO heart = new HeartVO();
			heart.setBo_num(bo_num);
			System.out.println(heart.getUi_id());
			System.out.println(heart.getBo_num() + "게시글번호");

			Integer like = service.findLike(heart);
			if (like != null) {

				model.addAttribute("like", like);
				return "board/detail";
			} else {
				model.addAttribute("like", 0);
				return "board/detail";
			}

		} else if (board.getCa_num() == 902) {
			if (user == null) {
				return "redirect:/login";
			} else if (!(user.getUi_grade().equals("관리자") || user.getUi_grade().equals("매니저")
					|| user.getUi_id().equals(board.getUi_id()))) {
				logger.info("글쓴이 id : " + board.getUi_id() + " / 로그인 id : " + user.getUi_id());
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('권한이 없습니다.'); history.go(-1); </script>");
				out.flush();
				return "board/list?ca=902";
			} else {
				logger.info("글쓴이 id : " + board.getUi_id() + " / 로그인 id : " + user.getUi_id());
				return "board/detail";
			}
		} // end of else if
		else {

			// 좋아요 조회
			HeartVO heart = new HeartVO();
			heart.setBo_num(bo_num);
			heart.setUi_id(user.getUi_id());
			System.out.println(heart.getUi_id());
			System.out.println(heart.getBo_num() + "게시글번호");

			Integer like = service.findLike(heart);
			if (like != null) {

				model.addAttribute("like", like);
				return "board/detail";
			} else {
				model.addAttribute("like", 0);
				return "board/detail";
			}

		} // end of else

	}

	// 게시글 삭제
	@RequestMapping(value = "board/delete", method = RequestMethod.GET)
	public String delete(@RequestParam int num, HttpSession session, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		logger.info("====delete====" + num);
		request.setCharacterEncoding("utf-8");
		BoardVO board = service.detail(num);
		int temp = board.getCa_num();

		LoginVO user = (LoginVO) session.getAttribute("user");
		if (user == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인이 필요한 서비스입니다.'); history.go(-1); </script>");
			out.flush();
		} else if (user.getUi_grade().equals("관리자") || user.getUi_grade().equals("매니저")
				|| user.getUi_id().equals(board.getUi_id())) {
			response.setContentType("text/html; charset=UTF-8");
			int r = service.delete(num);

			if (temp < 100 || temp == 901 || temp == 902) {
				return "redirect:/board/list?ca=" + temp;
			} else if (temp < 200) {
				return "redirect:/board/listpicpet?ca=" + temp;
			} else if (temp < 300) {
				return "redirect:/board/list?ca=" + temp;
			} else {
				return "redirect:/board/listpicmarket?ca=" + temp;
			}

		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('권한이 필요한 서비스입니다.'); history.go(-1); </script>");
			out.flush();
		}

		if (temp < 100 || temp == 901 || temp == 902) {
			return "redirect:/board/list?ca=" + temp;
		} else if (temp < 200) {
			return "redirect:/board/listpicpet?ca=" + temp;
		} else if (temp < 300) {
			return "redirect:/board/list?ca=" + temp;
		} else {
			return "redirect:/board/listpicmarket?ca=" + temp;
		}

	}

	// 게시글 수정 폼
	@RequestMapping(value = "board/update", method = RequestMethod.GET)
	public String update(@RequestParam int num, Model model) throws Exception {
		BoardVO board = service.detail(num);
		model.addAttribute("board", board);

		// 글 테이블 id로 유저테이블 닉네임 조회
		String ncName = service.getName(board.getUi_id());
		model.addAttribute("ncName", ncName);

		return "board/update";
	}

	// 게시글 수정 DB 저장
	@RequestMapping(value = "board/update", method = RequestMethod.POST)
	public String update(@RequestParam int num, BoardVO boardVO, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		logger.info("수정내용 : " + boardVO);
		
		String imagecheck = boardVO.getBo_content();
		imagecheck.indexOf("<img");
		String photocheck = boardVO.getBo_photo();
		
		
		
		String [] ph = imagecheck.split("\"");
		for(int i =0; i<ph.length; i++){
			System.out.println("ph:"+ph[i]);
			}
		
		
		
		if(imagecheck.indexOf("<img")==-1) {
			boardVO.setBo_photo(null);
		}else if(imagecheck.indexOf(photocheck)==-1) {
			boardVO.setBo_photo(ph[1]);
		}
		

	
		
		int r = service.update(boardVO);
		if (r > 0) { // 수정에 성공하면 상세보기로 이동

			return "redirect:detail?num=" + num;
		}

		// 수정에 실패하면 수정보기 화면으로 이동
		return "redirect:update?num=" + num;

	}

//	게시글 신고
	@RequestMapping(value = "board/report", method = RequestMethod.GET)
	public String report(@RequestParam int num) throws Exception {
		logger.info("====report====" + num);

		int r = service.report(num);
		BoardVO board = service.detail(num);

		int temp = board.getCa_num();
		if (temp < 100 || temp == 901 || temp == 902) {
			return "redirect:/board/list?ca=" + temp;
		} else if (temp < 200) {
			return "redirect:/board/listpicpet?ca=" + temp;
		} else if (temp < 300) {
			return "redirect:/board/list?ca=" + temp;
		} else {
			return "redirect:/board/listpicmarket?ca=" + temp;
		}

	}

//	ajax 댓글에 대한 매핑과 메소드를 구현(model에 싣는게 아님)
	@ResponseBody
	@PostMapping(value = "board/list3")
	public Map<String, Object> list3(@RequestParam("bo_num") int bo_num) throws Exception {
		logger.info(Integer.toString(bo_num) + "번 게시글 댓글 리스트");
		List<ReplyVO> list = service.list3(bo_num);

		Map<String, Object> list3 = new HashMap<>();
		list3.put("comments", list);

		// 댓글테이블 id로 유저테이블ncName가져오기
		String[] ncName = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ncName[i] = service.getName(list.get(i).getUi_id());
		}

		list3.put("ncName", ncName);

		return list3;
	}

// ajax 댓글 id로 유저테이블 닉네임 가져오기
	@ResponseBody
	@GetMapping(value = "board/getName3")
	public Map<String, Object> getName3(@RequestParam("re_id") String re_id) throws Exception {

		System.out.println("댓글 아이디" + re_id);
//		String ncName = service.getName(re_id);
//		logger.info(ncName);
		Map<String, Object> ncName = new HashMap<>();
		ncName.put("name", service.getName(re_id));
		ncName.put("grade", service.getGrade(re_id));

		return ncName;
	}

	// ajax 댓글 id로 유저테이블 등급 가져오기
	@ResponseBody
	@GetMapping(value = "board/getGrade3")
	public Map<String, Object> getGrade3(@RequestParam("re_id") String re_id) throws Exception {

		System.out.println("댓글 아이디" + re_id);

		Map<String, Object> ncGrade = new HashMap<>();
		ncGrade.put("grade", service.getGrade(re_id));

		return ncGrade;
	}

//	ajax 댓글 쓰기 
	@ResponseBody
	@PostMapping(value = "board/insert3")
	public int insert3(ReplyVO reply) throws Exception {
		return service.insert3(reply);
	}

	// ajax 댓글 수정
	@ResponseBody
	@PostMapping(value = "board/update3")
	public int update3(ReplyVO replyvo) throws Exception {

		return service.update3(replyvo);
	}

// 	ajax 댓글 삭제
	@ResponseBody
	@PostMapping(value = "board/delete3")
	public int delete3(@RequestParam("co_num") int co_num) throws Exception {

		return service.delete3(co_num);
	}

//	ajax 댓글 신고 
	@ResponseBody
	@PostMapping(value = "board/report3")
	public int report3(@RequestParam("co_num") int co_num) throws Exception {

		return service.report3(co_num);
	}

	// ajax 게시글 좋아요
	@ResponseBody
	@PostMapping(value = "board/like")
	public int like(@RequestBody HeartVO vo) throws Exception {
		System.out.println(vo.getUi_id());
		System.out.println(vo.getBo_num());

		service.like(vo.getBo_num());
		return service.like2(vo);
	}

	// ajax 게시글 좋아요 취소
	@ResponseBody
	@PostMapping(value = "board/dislike")
	public int dislike(@RequestBody HeartVO vo) throws Exception {

		System.out.println(vo.getBo_num());
		System.out.println(vo.getHe_num() + "醫뗭븘�슂 踰덊샇");

		service.dislike(vo.getBo_num());
		return service.dislike2(vo.getHe_num());

	}

	// ajax 댓글 좋아요 & 취소
	@ResponseBody
	@PostMapping(value = "board/like3")
	public int like3(@RequestBody HeartVO vo) throws Exception {
		System.out.println(vo.getUi_id());
		System.out.println(vo.getCo_num());

		// 좋아요 조회
		Integer likeCheck = service.findLike3(vo);
		if (likeCheck == null) {
			// 좋아요 처음누름
			service.like3(vo.getCo_num());
			service.like2(vo);
			likeCheck = 0;
			return likeCheck;
		} else { // 좋아요 눌려있는 경우
			service.dislike3(vo.getCo_num());
			service.dislike4(vo);
			likeCheck = 1;
			return likeCheck;
		}

	}

	// 처음 detail들어갈 때 댓글 좋아요 조회
	@ResponseBody
	@PostMapping(value = "board/likeReply")
	public int likeReply(@RequestBody HeartVO vo) throws Exception {
		Integer likeCheck = service.findLike3(vo);
		if (likeCheck == null) {
			likeCheck = 0;
			return likeCheck;
		} else {
			likeCheck = 1;
			return likeCheck;
		}

	}

	// 관련 글 보기
	@RequestMapping(value = "map/relatedPost", method = RequestMethod.GET)
	public String relatedPost(@RequestParam("pl_name") String pl_name, Model model) throws Exception {

		List<BoardVO> list = service.relatedPost(pl_name);
		logger.info("내용 : " + list);
		model.addAttribute("list", list);

		return "map/relatedPost";
	}

}
