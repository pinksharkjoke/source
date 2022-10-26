package kr.co.pap.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.pap.adminpage.EventVO;
import kr.co.pap.services.EventService;

@Controller
public class EventController {

	@Autowired
	EventService service;
	
	@RequestMapping(value = "admin/event")
	public ModelAndView eventmain() throws Exception {
		ModelAndView mav = new ModelAndView();
		List<EventVO> vo = service.list();
		mav.addObject("eventvo", vo);
		mav.setViewName("admin/event/eventmanage");
		
		return mav;
	}
	@RequestMapping(value = "admin/event/eventdetail")
	public ModelAndView eventdetail(int ev_id) throws Exception{
		ModelAndView mav = new ModelAndView();
		EventVO vo = service.detail(ev_id);
		mav.addObject("detail",vo);
		mav.setViewName("admin/event/eventdetail");
		
		
		
		return mav;
		
	}
	@GetMapping(value = "admin/event/eventadd")
	public String eventadd() throws Exception{
		
		
		
		return "admin/event/eventadd";
		
	}
	
	
	@PostMapping(value = "admin/event/eventadd")
	public ModelAndView eventadd(EventVO vo,@RequestParam("evpic") MultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception{
		System.out.println(file);
		ModelAndView mav = new ModelAndView();
		if(file.getOriginalFilename()=="") {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
	        out.println("<script>alert('이미지 파일은 필수입니다.');history.back()</script>");
			out.flush();
			out.close();
		
		}else {
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/images/event");
		String fileRealName = file.getOriginalFilename();//파일명을 얻어낼 수 있는 메서드!
		long size = file.getSize(); //파일 사이즈
		
		System.out.println("파일명 : "  + fileRealName);
		System.out.println("파일크기(byte) : " + size);
		//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
		String uploadFolder = saveDir;
		System.out.println(uploadFolder);
		/*
		  파일 업로드시 파일명이 동일한 파일이 이미 존재할 수도 있고 사용자가 
		  업로드 하는 파일명이 언어 이외의 언어로 되어있을 수 있습니다. 
		  타인어를 지원하지 않는 환경에서는 정산 동작이 되지 않습니다.(리눅스가 대표적인 예시)
		  고유한 랜던 문자를 통해 db와 서버에 저장할 파일명을 새롭게 만들어 준다.
		 */
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		String[] uuids = uuid.toString().split("-");
		
		String uniqueName = uuids[0];
		System.out.println("생성된 고유문자열:" + uniqueName);
		System.out.println("확장자명:" + fileExtension);
		
		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
		
		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
		try {
			file.transferTo(saveFile); //// 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		vo.setEv_pic(uniqueName+fileExtension);
		
		int r = service.insert(vo);
		if(r>0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		mav.setViewName("redirect:/admin/event");
		}
		return mav;
	}
	@GetMapping(value = "admin/event/eventupdate")
	public ModelAndView eventupdate(int ev_id) throws Exception {
		ModelAndView mav = new ModelAndView();
		EventVO vo = service.detail(ev_id);
		mav.addObject("vo", vo);
		mav.setViewName("admin/event/eventupdate");
		
		return mav;
	}
	@PostMapping(value="admin/event/eventupdate")
	public String eventupdate(EventVO vo,@RequestParam("evpic") MultipartFile file,HttpServletRequest request,@RequestParam("orgpic") String orgpic) throws Exception{
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/images/event");

		
		if(file.getSize() != 0) {
		String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드!
		long size = file.getSize();  //파일 사이즈
		
		System.out.println("파일명 : "  + fileRealName);
		System.out.println("파일용량(byte) : " + size);
		//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
		String uploadFolder = saveDir;
		System.out.println(uploadFolder);
		/*
		  파일 업로드시 파일명이 동일한 파일이 이미 존재할 수도 있고 사용자가 
		  업로드 하는 파일명이 언어 이외의 언어로 되어있을 수 있습니다. 
		  타인어를 지원하지 않는 환경에서는 정산 동작이 되지 않습니다.(리눅스가 대표적인 예시)
		  고유한 랜던 문자를 통해 db와 서버에 저장할 파일명을 새롭게 만들어 준다.
		 */
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		String[] uuids = uuid.toString().split("-");
		
		String uniqueName = uuids[0];
		System.out.println("생성된 고유 문자열 :" + uniqueName);
		System.out.println("파일 확장자 :" + fileExtension);
		
		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
		
		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
		try {
			file.transferTo(saveFile);  // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(orgpic!=null) {
			File deletepic = new File(saveDir+orgpic);
			deletepic.delete();
		}
		vo.setEv_pic(uniqueName+fileExtension);
		}
		else {
			vo.setEv_pic(orgpic);
		}
		service.update(vo);
		
		return "redirect:/admin/event";
	}
	@GetMapping(value="admin/event/eventdelete")
	public String eventdelete(int ev_id,HttpServletRequest request) throws Exception {
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/images/event");

		EventVO vo = service.detail(ev_id);
		if(vo.getEv_pic()!=null) {
			File deletepic = new File(saveDir+vo.getEv_pic());
			  if(deletepic.exists()) {
		            
		            // 첨부된 이미지 파일삭제
		            deletepic.delete(); 
		            
		            System.out.println("파일삭제 완료.");
		            
		        } else {
		            System.out.println("삭제할 파일이 존재하지 않음.");
		        }
		}
		service.delete(ev_id);
		
		return "redirect:/admin/event";
	}
}
