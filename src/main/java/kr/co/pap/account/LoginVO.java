package kr.co.pap.account;

import lombok.Data;

@Data
public class LoginVO {

	private String ui_id;
	private String ui_pw;
	private String ui_ncname;
	private int ui_prohibit;//제재상태 1이면 로그인정지,2면글쓰기정지
	private String ui_stprohibit;//제재시작일
	private String ui_enprohibit;//제재종료일
	private String ui_grade;
}
