package kr.co.pap.weather;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WeatherDateDevideProc {
	
	public static int dayVerify(String day) {
	    
	    Calendar cal = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        
        try {
            Date date1 = formatter.parse(formatter.format(date).substring(0, 10));
            Date comDate = formatter.parse(day.substring(0, 10));
            cal.setTime(date1);
            cal2.setTime(comDate);
            
            long disCountDaysec = ((cal2.getTimeInMillis() - cal.getTimeInMillis()) / 1000);
            long disCountDay = disCountDaysec / (24*60*60);
            System.out.println(disCountDay);
            if(disCountDay >= 0) {
                return (int)disCountDay;
            }else {
                System.out.println("날짜 변환 오류~");
                return 0;
            }
        }catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
	    
	}

}
