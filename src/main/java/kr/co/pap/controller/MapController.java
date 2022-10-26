package kr.co.pap.controller;


import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.pap.account.LoginVO;
import kr.co.pap.map.MapCriteria;
import kr.co.pap.map.MapVO;
import kr.co.pap.map.MapPageMaker;
import kr.co.pap.services.MapService;

@Controller
public class MapController {

	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	@Autowired
	MapService service;

//	지도 이동 
	@GetMapping(value = "map")
	public String map(Model model, HttpSession session, MapCriteria cri) throws Exception {

		List<MapVO> list = service.listmap(cri);
		model.addAttribute("list", list);

		MapPageMaker pageMaker = new MapPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());

		model.addAttribute("pageMaker", pageMaker);

		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);
		logger.info(jsonText);
		return "map/map";
	}

	// 지도추가

	@ResponseBody
	@RequestMapping(value = "map/insert", method = RequestMethod.POST)
	public int insertmap(MapVO map) throws Exception {
		logger.info("인서트" + map);
		return service.insertmap(map);
	}

	// 병원
	@GetMapping(value = "maphospital")
	public String maphospital(Model model) throws Exception {

		List<MapVO> list = service.listhospital();
		model.addAttribute("list", list);


		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);

		return "map/maphospital";
	}

	// 식당
	@GetMapping(value = "maprestaurant")
	public String maprestaurant(Model model) throws Exception {

		List<MapVO> list = service.listrestaurant();
		model.addAttribute("list", list);


		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);

		return "map/maprestaurant";
	}

	// 놀이터
	@GetMapping(value = "mapplayground")
	public String mapplayground(Model model) throws Exception {

		List<MapVO> list = service.listplayground();
		model.addAttribute("list", list);

		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);

		return "map/mapplayground";
	}

	// 카페
	@GetMapping(value = "mapcafe")
	public String mapcafe(Model model) throws Exception {

		List<MapVO> list = service.listcafe();

		model.addAttribute("list", list);


		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);

		return "map/mapcafe";
	}

	// 마트
	@GetMapping(value = "mapmart")
	public String mapmart(Model model) throws Exception {
		List<MapVO> list = service.listmart();
		model.addAttribute("list", list);


		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);

		return "map/mapmart";
	}
	// 기타

	@GetMapping(value = "mapetc")
	public String mapetc(Model model) throws Exception {

		List<MapVO> list = service.listetc();

		model.addAttribute("list", list);


		;


		ObjectMapper mapper = new ObjectMapper();
		String jsonText = mapper.writeValueAsString(list);
		model.addAttribute("json", jsonText);

		return "map/mapetc";
	}

	// 지도 삭제
	@RequestMapping(value = "deletemap", method = RequestMethod.GET)
	public String deletemap(@RequestParam String pl_name, HttpSession session, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		logger.info("====delete====" + pl_name);
		request.setCharacterEncoding("utf-8");
		MapVO map = service.detailmap(pl_name);

		LoginVO user = (LoginVO) session.getAttribute("user");
		if (user == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인이 필요한 서비스입니다.'); history.go(-1); </script>");
			out.flush();
		} else if (user.getUi_grade().equals("관리자") || user.getUi_grade().equals("매니저")
				|| user.getUi_id().equals(map.getUi_id())) {
			response.setContentType("text/html; charset=UTF-8");
			int r = service.deletemap(pl_name);

			if (r > 0) {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('삭제완료.'); </script>");
			}

		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('권한이 필요한 서비스입니다.'); history.go(-1); </script>");
			out.flush();
		}

		return "redirect:map";

	}

	// 지도 수정 이동
	@RequestMapping(value = "updatemap", method = RequestMethod.GET)
	public String update(@RequestParam String pl_name, Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		MapVO map = service.detailmap(pl_name);
		model.addAttribute("map", map);

		return "map/updatemap";
	}

	// 지도 DB 저장
	@RequestMapping(value = "updatemap", method = RequestMethod.POST)
	public String updatemap(@RequestParam String pl_name, MapVO mapVO, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		int r = service.updatemap(mapVO);
		logger.info("수정내용 : " + mapVO);

		return "redirect:map";
	}


}
