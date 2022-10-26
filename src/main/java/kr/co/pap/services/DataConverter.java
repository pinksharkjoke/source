package kr.co.pap.services;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DataConverter {
	
	public static String convertString(Object obj) {
		return String.valueOf(obj);
	}
	
	public static Integer convertInt(Object obj) {
		return Integer.valueOf(convertString(obj));
	}
	
	public static Double convertDouble(Object obj) {
		return Double.valueOf(convertString(obj));
	}
	
	public static String convertDate(String time) {
		
		String datetime = "";
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date;
		try {
			date = formatter.parse(time);
			
			Calendar cal = Calendar.getInstance();
			
			cal.setTime(date);
			
			cal.add(Calendar.HOUR, 9);
			
			datetime = formatter.format(cal.getTime());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return datetime;
	}
}
