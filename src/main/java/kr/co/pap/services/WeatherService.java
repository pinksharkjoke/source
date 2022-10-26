package kr.co.pap.services;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.pap.weather.CityDTO;
import kr.co.pap.weather.City_name;
import kr.co.pap.weather.GetData;
import kr.co.pap.weather.GetWeatherDataDTO;
import kr.co.pap.weather.WeatherDTO;

public interface WeatherService {
	
	public JSONArray weatherDataProc(City_name cn);
	public JSONObject allLocDataProc(ArrayList<WeatherDTO> wlist, String name);
	public int countGeo(GetData gd);
	public JSONArray weatherAllLoc();
	public int insertState(String pod, String main, String description);
	
}
