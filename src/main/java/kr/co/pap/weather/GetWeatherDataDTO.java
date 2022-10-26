package kr.co.pap.weather;

import java.util.List;

import lombok.Data;

@Data
public class GetWeatherDataDTO {
	private CityDTO city;
	private int cnt;
	private String cod;
	private List<WeatherDTO> list;
	private int message;
}
