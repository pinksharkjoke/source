package kr.co.pap.board;

import lombok.Data;

@Data
public class BoardVO {

	private int bo_num;
	private String bo_title;
	private String bo_content;
	private String bo_DATE;
	private String bo_photo;
	private String bo_name;
	private int bo_heart;
	private String bo_modifydate;
	private int bo_views;
	private int bo_status;
	private String ui_id;
	private int ca_num;
	private String bo_pstatus;
	private int bo_notice;
	private String pl_name;
	private double pl_lat;
	private double pl_lon;
}

//BO_DATE date 
//BO_photo varchar(40) 
//BO_name varchar(10) 
//BO_heart int 
//BO_modifydate datetime 
//BO_views int 
//BO_status int 
//UI_id varchar(15) 
//CA_num int