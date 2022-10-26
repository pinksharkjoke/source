package kr.co.pap.adminpage;

import java.util.List;


import kr.co.pap.account.UserVO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.board.ReplyVO;

public interface UserboardManageDAO {
	public List<BoardVO> boardlist(ReportCriteria cri) throws Exception;
	public List<ReplyVO> replylist() throws Exception;
	public int reportcnt() throws Exception;
	public int reportreplycnt() throws Exception;
	public int boarddelete(int bo_num) throws Exception;
	public int replydelete(int co_num) throws Exception;
	public int boardback(int bo_num) throws Exception;
	public int replyback(int co_num) throws Exception;
	public int userban(UserVO vo)throws Exception;
	public int writeban(UserVO vo)throws Exception;
	public int banclear(String ui_id)throws Exception;
	public int usergrade(String grade,String ui_id)throws Exception;
	public int gradeupcnt()throws Exception;
	public List<BoardVO> gradeuplist() throws Exception;
}
