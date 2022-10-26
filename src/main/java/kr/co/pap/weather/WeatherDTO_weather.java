package kr.co.pap.weather;

import lombok.Data;

@Data
public class WeatherDTO_weather {
	
	private int id;
	private String main;
	private String description;
	private String icon;

}
