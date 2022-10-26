package kr.co.pap.weather;

import lombok.Data;

@Data
public class WeatherDTO_wind {
	private double speed;
	private double deg;
	private double gust;
}
