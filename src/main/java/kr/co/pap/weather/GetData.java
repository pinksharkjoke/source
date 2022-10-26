package kr.co.pap.weather;

import lombok.Data;

@Data
public class GetData {
	private GetWeatherDataDTO weatherData;
	private City_name cn;
}
