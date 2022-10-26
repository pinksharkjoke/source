package kr.co.pap.services;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import kr.co.pap.DAO.WeatherDAO;
import kr.co.pap.weather.CityDTO;
import kr.co.pap.weather.City_name;
import kr.co.pap.weather.GetData;
import kr.co.pap.weather.GetWeatherDataDTO;
import kr.co.pap.weather.WeatherDTO;
import kr.co.pap.weather.WeatherDateDevideProc;
import kr.co.pap.weather.WeatherOpenApi;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WeatherServiceImpl implements WeatherService{
	
	@Autowired
	private WeatherDAO dao;

	@Override
	public JSONArray weatherDataProc(City_name cn) {
		WeatherOpenApi woa = new WeatherOpenApi();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("glat", cn.getLat());
		map.put("glon", cn.getLon());
		GetWeatherDataDTO gwdto = woa.ForecastopenApi(map);
		
		ArrayList<WeatherDTO> list = (ArrayList<WeatherDTO>)gwdto.getList();
		String name = cn.getPaldo()+ " " + cn.getSi() + " " + cn.getDong();
		
		JSONObject json = allLocDataProc(list, name);
		JSONArray jar = new JSONArray();
		
		jar.add(json);
		
		return jar;
	}

	@Override
	public int countGeo(GetData gd) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("glat", gd.getWeatherData().getCity().getCoord().getLat());
		map.put("glon", gd.getWeatherData().getCity().getCoord().getLon());
		map.put("gname", gd.getCn().getSi());
		map.put("gpaldo", gd.getCn().getPaldo());
		
		int r = dao.countGeo(map);
		
		if(r == 1) {
			return 0;
		}else if(r < 1){
			int re = dao.regitGeo(map);
			return 1;
		}else {
			System.out.println("count ����");
			return -1;
		}
		
	}

	@Override
	public JSONArray weatherAllLoc() {
		JSONArray jarr = new JSONArray();
		Map<String, Object> data = new HashMap<String, Object>();
		ArrayList<WeatherDTO> wlist = new ArrayList<WeatherDTO>();
		ArrayList<String> name = new ArrayList<String>();
		Gson gson = new Gson();

		// get all korea important city lat, lon list
		List<Map<String, Object>> list = dao.selectAllLoc();
		int num = 0;
		WeatherOpenApi woa = new WeatherOpenApi();
		for (Map<String, Object> map : list) {
			System.out.println(map);
			GetWeatherDataDTO gwdto = woa.ForecastopenApi(map);
			name.add(num, DataConverter.convertString(map.get("gname")));
			wlist = (ArrayList<WeatherDTO>)gwdto.getList();
			data = allLocDataProc(wlist, name.get(num));
//			Map<String, ArrayList<GoViewWeatherData>> gvmap = allLocdateDevide(gvlist);
//			if(num == 0) {
//				weatherMap.put("today", gvmap.get("today"));
//				weatherMap.put("tomorrow", gvmap.get("tomorrow"));
//				weatherMap.put("third", gvmap.get("third"));
//				weatherMap.put("forth", gvmap.get("forth"));
//				weatherMap.put("fivth", gvmap.get("fivth"));
//			}else {
//				weatherMap.get("today").addAll(weatherMap.get("today").size()-1, gvmap.get("today"));
//				weatherMap.get("tomorrow").addAll(weatherMap.get("tomorrow").size()-1, gvmap.get("tomorrow"));
//				weatherMap.get("third").addAll(weatherMap.get("third").size()-1, gvmap.get("third"));
//				weatherMap.get("forth").addAll(weatherMap.get("forth").size()-1, gvmap.get("forth"));
//  			weatherMap.get("fivth").addAll(weatherMap.get("fivth").size()-1, gvmap.get("fivth"));
//			}
			num++;
			jarr.add(data);
		}
		
		return jarr;
	}

	@Override
	public JSONObject allLocDataProc(ArrayList<WeatherDTO> wlist, String name) {
		
        int num = 0;
        Map<String, Object> map = new HashMap<String, Object>();
        ArrayList<JSONObject> weather = new ArrayList<JSONObject>();
     
        
        String day = "";
        String date = "";
        double tempmin = 100;
        double tempmax = 0;
        int[][] weatherstate = new int[5][8];
        double[][] weatherair = new double[5][8];
        double[][] weatherspeed = new double[5][8];
        double[][] weatherdeg = new double[5][8];
        double[][] weatherpop = new double[5][8];
        double[][] weatherfeellike = new double[5][8];
        double[][] weatherhumidity = new double[5][8];
        
		String time = DataConverter.convertDate(wlist.get(0).getDt_txt());
		
		for (int i = 0; i < wlist.size(); i++) {
		    String time1 = DataConverter.convertDate(wlist.get(i).getDt_txt());
		    
		    if(!(time1.substring(0, 10)).equals(time.substring(0, 10))) {
		    	JSONObject weatherData = new JSONObject();
		    	JSONObject state = new JSONObject();
		        JSONObject air = new JSONObject();
		        JSONObject windspeed = new JSONObject();
		        JSONObject winddirection = new JSONObject();
		        JSONObject pop = new JSONObject();
		        JSONObject feellike = new JSONObject();
		        JSONObject humidity = new JSONObject();
		        state.put("display", weatherstate[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        state.put("hourly", Arrays.toString(weatherstate[WeatherDateDevideProc.dayVerify(time1)-1]));
		        air.put("display", weatherair[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        air.put("hourly", Arrays.toString(weatherair[WeatherDateDevideProc.dayVerify(time1)-1]));
		        windspeed.put("display", weatherspeed[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        windspeed.put("hourly", Arrays.toString(weatherspeed[WeatherDateDevideProc.dayVerify(time1)-1]));
		        winddirection.put("display", weatherdeg[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        winddirection.put("hourly", Arrays.toString(weatherdeg[WeatherDateDevideProc.dayVerify(time1)-1]));
		        pop.put("display", weatherpop[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        pop.put("hourly", Arrays.toString(weatherpop[WeatherDateDevideProc.dayVerify(time1)-1]));
		        feellike.put("display", weatherfeellike[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        feellike.put("hourly", Arrays.toString(weatherfeellike[WeatherDateDevideProc.dayVerify(time1)-1]));
		        humidity.put("display", weatherhumidity[WeatherDateDevideProc.dayVerify(time1)-1][0]);
		        humidity.put("hourly", Arrays.toString(weatherhumidity[WeatherDateDevideProc.dayVerify(time1)-1]));
		        
		        weatherData.put("state", state);
		        weatherData.put("day", day);
		        weatherData.put("date", date);
		        weatherData.put("tempmin", tempmin);
		        weatherData.put("tempmax", tempmax);
		        weatherData.put("air", air);
		        weatherData.put("windspeed", windspeed);
		        weatherData.put("winddirection", winddirection);
		        weatherData.put("pop", pop);
		        weatherData.put("feellike", feellike);
		        weatherData.put("humidity", humidity);
		        
		        weather.add(weatherData);
		        System.out.println(weather);
		        time = time1;
		        
		        num = 0;
		        
		    }
		    
		    System.out.println(weather);
		    
		    
		    if(WeatherDateDevideProc.dayVerify(time1) == 0) {// today
		    	
		        day = "today";
		        date = DataConverter.convertDate(wlist.get(i).getDt_txt()).substring(0, 10);
		        String pod = DataConverter.convertString(wlist.get(i).getSys().get("pod"));
		        String main = DataConverter.convertString(wlist.get(i).getWeather().get(0).getMain());
		        String des = DataConverter.convertString(wlist.get(i).getWeather().get(0).getDescription());
		        if(tempmin > DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min())) {
		            tempmin = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min());
		        }
		        if(tempmax < DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max())) {
		            tempmax = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max());
		        }
		        
		        if(time1.substring(11, 19).equals("00:00:00")) {
		            weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
		            weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
		            num++;
		        }else if(time1.substring(11, 19).equals("03:00:00")) {
		            if(num == 0) {
                        num = 1;
                        weatherstate[WeatherDateDevideProc.dayVerify(time1)][0] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][0] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][0] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][0] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][0] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][0] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][0] = 0;
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                    num++;
		        }else if(time1.substring(11, 19).equals("06:00:00")) {
		            if(num == 0) {
                        num = 2;
                        for(int j = 0; j < 2; j++) {
                            weatherstate[WeatherDateDevideProc.dayVerify(time1)][j] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                        }
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                    num++;
                }else if(time1.substring(11, 19).equals("09:00:00")) {
                    if(num == 0) {
                        num = 3;
                        for(int j = 0; j < 3; j++) {
                            weatherstate[WeatherDateDevideProc.dayVerify(time1)][j] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                        }
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                    num++;
                }else if(time1.substring(11, 19).equals("12:00:00")) {
                    if(num == 0) {
                        num = 4;
                        for(int j = 0; j < 4; j++) {
                            weatherstate[WeatherDateDevideProc.dayVerify(time1)][j] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                        }
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                    num++;
                }else if(time1.substring(11, 19).equals("15:00:00")) {
                    if(num == 0) {
                        num = 5;
                        for(int j = 0; j < 5; j++) {
                            weatherstate[WeatherDateDevideProc.dayVerify(time1)][j] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                        }
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                    num++;
                }else if(time1.substring(11, 19).equals("18:00:00")) {
                    if(num == 0) {
                        num = 6;
                        for(int j = 0; j < 6; j++) {
                            weatherstate[WeatherDateDevideProc.dayVerify(time1)][j] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                        }
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                    num++;
                }else if(time1.substring(11, 19).equals("21:00:00")) {
                    if(num == 0) {
                        num = 7;
                        for(int j = 0; j < 7; j++) {
                            weatherstate[WeatherDateDevideProc.dayVerify(time1)][j] = 1;
                            weatherair[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherspeed[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherdeg[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherpop[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                            weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][j] = 0;
                        }
                    }
                    weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                    weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                    weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                    weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                    weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                    weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                    weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                }
		        
		    }else if(WeatherDateDevideProc.dayVerify(time1) == 1) { // tomorrow
		        day = "tomorrow";
		        date = DataConverter.convertDate(wlist.get(i).getDt_txt()).substring(0, 10);
		        String pod = DataConverter.convertString(wlist.get(i).getSys().get("pod"));
                String main = DataConverter.convertString(wlist.get(i).getWeather().get(0).getMain());
                String des = DataConverter.convertString(wlist.get(i).getWeather().get(0).getDescription());
                if(tempmin > DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min())) {
                    tempmin = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min());
                }
                if(tempmax < DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max())) {
                    tempmax = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max());
                }
                weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                num++;

		    }else if(WeatherDateDevideProc.dayVerify(time1) == 2) { // 2day after
		        day = "2day after";
		        date = DataConverter.convertDate(wlist.get(i).getDt_txt()).substring(0, 10);
		        String pod = DataConverter.convertString(wlist.get(i).getSys().get("pod"));
                String main = DataConverter.convertString(wlist.get(i).getWeather().get(0).getMain());
                String des = DataConverter.convertString(wlist.get(i).getWeather().get(0).getDescription());
                if(tempmin > DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min())) {
                    tempmin = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min());
                }
                if(tempmax < DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max())) {
                    tempmax = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max());
                }
                weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                num++;
                
		    }else if(WeatherDateDevideProc.dayVerify(time1) == 3) { // 3day after
		        day = "3day after";
		        date = DataConverter.convertDate(wlist.get(i).getDt_txt()).substring(0, 10);
		        String pod = DataConverter.convertString(wlist.get(i).getSys().get("pod"));
                String main = DataConverter.convertString(wlist.get(i).getWeather().get(0).getMain());
                String des = DataConverter.convertString(wlist.get(i).getWeather().get(0).getDescription());
                if(tempmin > DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min())) {
                    tempmin = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min());
                }
                if(tempmax < DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max())) {
                    tempmax = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max());
                }
                weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                System.out.println("3day"+wlist.get(i).getMain().getTemp());
                weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                num++;
                
		    }else if(WeatherDateDevideProc.dayVerify(time1) == 4) { // 4day after
		        day = "4day after";
		        date = DataConverter.convertDate(wlist.get(i).getDt_txt()).substring(0, 10);
		        String pod = DataConverter.convertString(wlist.get(i).getSys().get("pod"));
                String main = DataConverter.convertString(wlist.get(i).getWeather().get(0).getMain());
                String des = DataConverter.convertString(wlist.get(i).getWeather().get(0).getDescription());
                if(tempmin > DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min())) {
                    tempmin = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_min());
                }
                if(tempmax < DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max())) {
                    tempmax = DataConverter.convertDouble(wlist.get(i).getMain().getTemp_max());
                }
                weatherstate[WeatherDateDevideProc.dayVerify(time1)][num] = insertState(pod, main, des);
                System.out.println("4day"+wlist.get(i).getMain().getTemp());
                weatherair[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getTemp());
                weatherspeed[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getSpeed());
                weatherdeg[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getWind().getDeg());
                weatherpop[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getPop());
                weatherfeellike[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getFeels_like());
                weatherhumidity[WeatherDateDevideProc.dayVerify(time1)][num] = DataConverter.convertDouble(wlist.get(i).getMain().getHumidity());
                num++;
                
		    }
		    
		} // end of for
		System.out.println(weather.toString());
		map.put("name", name);
        map.put("weather", weather);
        System.out.println(map);
		JSONObject json = new JSONObject(map);
        
        
		return json;
	}
	
    @Override
    public int insertState(String pod, String main, String description) {
        int state = 0;
        
        if(pod.equals("n")) { // night
            if(main.equals("Clouds")) {
                if(!description.equals("overcast clouds")) {
                    state = 7; // partlyClouds Night
                }else {
                    state = 3; // clouds
                }
            }else if(main.equals("Clear") || main.equals("Dirzzle")){
                state = 6;
            }else if(main.equals("Thunderstorm")) {
                state = 5;
            }else if(main.equals("Rain")) {
                state = 8;
            }else if(main.equals("Snow")) {
                state = 9;
            }else {
                state = 10; // mist
            }
        }else if(pod.equals("d")) {// day
            if(main.equals("Clouds")) {
                if(!description.equals("overcast clouds")) {
                    state = 2; // partlyClouds
                }else {
                    state = 3; // clouds
                }
            }else if(main.equals("Clear") || main.equals("Dirzzle")) {
                state = 1;
            }else if(main.equals("Thunderstorm")) {
                state = 5;
            }else if(main.equals("Rain")) {
                state = 4;
            }else if(main.equals("Snow")) {
                state = 11;
            }else {
                state = 10; // mist
            }
        }
        
        return state;
    }

	
	

}
