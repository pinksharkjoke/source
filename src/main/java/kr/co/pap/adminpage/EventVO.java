package kr.co.pap.adminpage;

import lombok.Data;

@Data
public class EventVO {
	private int ev_id; 
	private String ev_startdate;//행사시작일
	private String ev_enddate;//행사종료일
	private String ev_pic;//행사관련 사진
	private String ev_url;//행사링크
	private String ev_loc;//행사위치,지역?
	private String ev_name;//행사이름
}
