package kr.co.pap.weather;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.Gson;

import kr.co.pap.services.DataConverter;

public class WeatherOpenApi {
	
	
	public GetWeatherDataDTO ForecastopenApi(Map<String, Object> map) {
		BufferedReader bfr;
		String result = "";
		GetWeatherDataDTO gwdto;
		
		String apiKey = "320165d843c1f515ebec63f4e051df40";
		String str = "http://api.openweathermap.org/data/2.5/forecast?";
		double lat = 0.0;
		double lon = 0.0;

		lat = DataConverter.convertDouble(map.get("glat"));
		lon = DataConverter.convertDouble(map.get("glon"));
		
		try {
			
			URL url = new URL(str + "lat=" + lat + "&lon=" + lon + "&appid=" + apiKey + "&units=metric");
			
			bfr = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			
			result = bfr.readLine();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		Gson gson = new Gson();
		gwdto = gson.fromJson(result, GetWeatherDataDTO.class);
		
		return gwdto;
	}
	
	public GetWeatherDataDTO CurrentopenApi(Map<String, Object> map) {
        BufferedReader bfr;
        String result = "";
        GetWeatherDataDTO gwdto;
        
        String apiKey = "320165d843c1f515ebec63f4e051df40";
        String str = "http://api.openweathermap.org/data/2.5/forecast?";
        double lat = 0.0;
        double lon = 0.0;

        lat = DataConverter.convertDouble(map.get("glat"));
        lon = DataConverter.convertDouble(map.get("glon"));
        
        try {
            
            URL url = new URL(str + "lat=" + lat + "&lon=" + lon + "&appid=" + apiKey + "&units=metric");
            
            bfr = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            
            result = bfr.readLine();
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        Gson gson = new Gson();
        gwdto = gson.fromJson(result, GetWeatherDataDTO.class);
        
        return gwdto;
    }
	
}
