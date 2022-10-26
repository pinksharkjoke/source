package kr.co.pap.chat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateNow {
	public static String getDateNowFull() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
		LocalDateTime now = LocalDateTime.now();
		
		return dtf.format(now);
	}
}
