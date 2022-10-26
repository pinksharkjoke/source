package kr.co.pap.personal;

import lombok.Data;

@Data
public class CalVO {

	private String ui_id;
	private int cd_id;
	private String cd_title; 
	private String cd_start; 
	private String cd_end;
	private boolean cd_allday;
}