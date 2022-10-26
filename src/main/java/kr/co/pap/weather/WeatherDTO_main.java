package kr.co.pap.weather;

import java.util.Map;

import lombok.Data;

@Data
public class WeatherDTO_main {
	private double feels_like;
	private int grnd_level;
	private int humidity;
	private int pressure;
	private int sea_level;
	private double temp;
	private double temp_kf;
	private double temp_max;
	private double temp_min;
//	
//	public WeatherDTO_main(double feels_like, int grnd_level, int humidity, int pressure, int sea_level, double temp,
//			double temp_kf, double temp_max, double temp_min) {
//		
//		this.feels_like = feels_like;
//		this.grnd_level = grnd_level;
//		this.humidity = humidity;
//		this.pressure = pressure;
//		this.sea_level = sea_level;
//		this.temp = temp;
//		this.temp_kf = temp_kf;
//		this.temp_max = temp_max;
//		this.temp_min = temp_min;
//	}
//	
//	public WeatherDTO_main(Map<String,Object> map) {
//		this.feels_like = DataConverter.convertDouble(map.get("feels_like"));
//		this.grnd_level = DataConverter.convertInt(map.get("grnd_level"));
//		
//		
//	}
	
	
	
	
}
