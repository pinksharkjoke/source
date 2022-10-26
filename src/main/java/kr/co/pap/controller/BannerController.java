package kr.co.pap.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.pap.adminpage.BannerDTO;
import kr.co.pap.services.BannerService;




@Controller
public class BannerController {
	
	
	@Autowired
	BannerService service;
	
	@RequestMapping(value="admin/banner",method= RequestMethod.GET)
	public String bannermanage() {
		
		
		return "admin/banner/bannermanage";
	}	
	@ResponseBody
	@PostMapping(value="admin/banner/bannerdelete")
	public int bannerdelete(int bn_num,String bn_img,HttpServletRequest request) {
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/images/banner/");
		File deletepic = new File(saveDir+bn_img);
		deletepic.delete();
		service.deleteBanner(bn_num);
		List<BannerDTO> list = service.list();
		for(int i =0;i<list.size();i++) {
			list.get(i).setBn_order(i+1);
		}
		for(int i = 0;i<list.size();i++) {
			service.reorderbanner(list.get(i));
		}
		return 1;
	}
	@ResponseBody
	@PostMapping(value="admin/banner/bannerupdate")
	public int bannerupdate(@RequestPart(value="key") BannerDTO dto,@RequestPart(value="file",required = false) MultipartFile file,HttpServletRequest request) {
		List<BannerDTO> list = service.list();
		BannerDTO origin = service.SelBanner(dto.getBn_num());
		list.remove(origin.getBn_order()-1);
		System.out.println(dto);
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/images/banner/");
		if(file!=null) {
		String fileRealName = file.getOriginalFilename(); // //파일명을 얻어낼 수 있는 메서드
		long size = file.getSize();  //파일 사이즈
		
		System.out.println("파일명: "  + fileRealName);
		System.out.println("용량크기(byte) : " + size);
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
		System.out.println("생성된 고유문자열" + uniqueName);
		System.out.println("확장자명" + fileExtension);
		
		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // ���� ��
		try {
			file.transferTo(saveFile);// 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		File deletepic = new File(saveDir+dto.getBn_img());
		deletepic.delete();
		dto.setBn_img(uniqueName+fileExtension);
		}
		int newbanneridx = dto.getBn_order()-1;
		list.add(newbanneridx,dto);
		for(int i =0;i<list.size();i++) {
			if(i==newbanneridx) {
				dto.setBn_order(i+1);
			}else {
			list.get(i).setBn_order(i+1);
			}
		}
		list.remove(newbanneridx);
		for(int i = 0;i<list.size();i++) {
			service.reorderbanner(list.get(i));
		}
		return service.updateBanner(dto);
		
	}
	
	@ResponseBody
	@RequestMapping(value="admin/banner/bannerlist",method=RequestMethod.POST)
	public List<BannerDTO> bannerlist(){
		
		
		return service.list();
	}
	@ResponseBody
	@PostMapping(value="admin/banner/banneradd")
	public int banneradd(@RequestPart(value="key")BannerDTO dto,@RequestPart(value="file",required = false) MultipartFile file,HttpServletRequest request) {
		String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드!
		long size = file.getSize(); //파일 사이즈
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/images/banner/");
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
		System.out.println("생성된 고유문자열" + uniqueName);
		System.out.println("확장자명" + fileExtension);
		
		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid적용 전
		
		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
		try {
			file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		dto.setBn_img(uniqueName+fileExtension);
		List<BannerDTO> list = service.list();
		int newbanneridx = dto.getBn_order()-1;
		list.add(newbanneridx,dto);
		for(int i =0;i<list.size();i++) {
			if(i==newbanneridx) {
				dto.setBn_order(i+1);
			}else {
			list.get(i).setBn_order(i+1);
			}
		}
		list.remove(newbanneridx);
		for(int i = 0;i<list.size();i++) {
			service.reorderbanner(list.get(i));
		}
		
		
		return service.insertBanner(dto);
	}
	
	
}
