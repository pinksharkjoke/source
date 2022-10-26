package kr.co.pap.board;

import lombok.Data;

@Data
public class ReplyVO {

	private int co_num;
	private String co_content;
	private String co_date;
	private int co_status;
	private int co_heart;
	private String co_modifydate;
	private String ui_id;
	private int bo_num;
}