package kr.co.pap.account;

import lombok.Data;

@Data
public class UserVO {
	
	private String ui_id;
	private String ui_pw;
	private String ui_name;
	private String ui_ncName;
	private String ui_email;
	private String ui_phonenum;
	private String ui_loc;
	private String ui_birth;
	private int ui_prohibit;
	private String ui_stprohibit;
	private String ui_enprohibit;
	private String ui_img;
	private String ui_grade;
	private String ui_registerdate;
	private String ui_lastlogin;
	private String ui_lastlogout;
	private int ui_status;
	private int ui_registertype;
	
	
}
