package kr.co.pap.chat;


public class ChatVO {
	private int ch_num;
	private String ch_fromid;
	private String ch_toid;
	private String ch_content;
	private String ch_sendtime;
	private int ch_sellidx;
	private int ch_status;
	public int getCh_num() {
		return ch_num;
	}
	public void setCh_num(int ch_num) {
		this.ch_num = ch_num;
	}
	public String getCh_fromid() {
		return ch_fromid;
	}
	public void setCh_fromid(String ch_fromid) {
		this.ch_fromid = ch_fromid;
	}
	public String getCh_toid() {
		return ch_toid;
	}
	public void setCh_toid(String ch_toid) {
		this.ch_toid = ch_toid;
	}
	public String getCh_content() {
		return ch_content;
	}
	public void setCh_content(String ch_content) {
		this.ch_content = ch_content;
	}
	public String getCh_sendtime() {
		return ch_sendtime;
	}
	public void setCh_sendtime(String ch_sendtime) {
		this.ch_sendtime = ch_sendtime;
	}
	public int getCh_sellidx() {
		return ch_sellidx;
	}
	public void setCh_sellidx(int ch_sellidx) {
		this.ch_sellidx = ch_sellidx;
	}
	public int getCh_status() {
		return ch_status;
	}
	public void setCh_status(int ch_status) {
		this.ch_status = ch_status;
	}
	@Override
	public String toString() {
		String message = "[" + ch_sendtime + "] " + ch_fromid + " : " + ch_content ;
		return message;
	}
	
	
}
