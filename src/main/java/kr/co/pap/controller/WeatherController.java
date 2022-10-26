package kr.co.pap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.co.pap.services.WeatherService;
import kr.co.pap.weather.City_name;
import kr.co.pap.weather.GetData;
import kr.co.pap.weather.GetWeatherDataDTO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class WeatherController {
	
	@Autowired
	private WeatherService service;
	
	@GetMapping(value = "weather/home")
	public String wHome() {
		
		return "weather/weatherHome";
	}

	@GetMapping(value = "weather/myLoc")
	public String myLoc(@RequestParam("data")JSONArray data, Model model) {
		model.addAttribute("data", data);
		return "weather/myLocForecast";
	}
	
//	@PostMapping(value = "weather/detailLoc")
//	public String acnotherLoc() throws Exception {
//	    System.out.println(result);
//	    System.out.println("digh");
//	    response.sendRedirect("weather/detailLocForecast");
//	    
//	    
//		return "weather/detailLocForecast";
//	}
	
	@GetMapping(value = "weather/allLoc")
	public String allLoc(Model model) {
		
		JSONArray jarr = service.weatherAllLoc();
		
		model.addAttribute("data", jarr);
		
		return "weather/allLocForecast";
	}
	
	@PostMapping(value = "weather/detailProc")
	public String anotherProc(City_name cn, Model model) throws IOException {
		System.out.println(cn);
	    JSONArray jar = service.weatherDataProc(cn);
	    model.addAttribute("data", jar);
		
		return "weather/detailLocForecast";
	}
	
}
