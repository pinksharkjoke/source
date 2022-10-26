package kr.co.pap.weather;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class WeatherDTO {
	
	private String dt;
	private String dt_txt;
	private WeatherDTO_main main;
	private double pop;
	private Map<String,String> sys;
	private List<WeatherDTO_weather> weather;
	private Map<String,Integer> clouds;
	private WeatherDTO_wind wind;
	private int visibility;
	
}
