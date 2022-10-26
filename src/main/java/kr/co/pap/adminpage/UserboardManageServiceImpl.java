package kr.co.pap.adminpage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.board.ReplyVO;

@Service
public class UserboardManageServiceImpl implements UserboardManageService{

	@Autowired
	private UserboardManageDAO dao;
	
	@Override
	public List<BoardVO> boardlist(ReportCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.boardlist(cri);
	}

	@Override
	public List<ReplyVO> replylist() throws Exception {
		// TODO Auto-generated method stub
		return dao.replylist();
	}

	@Override
	public int boarddelete(int bo_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.boarddelete(bo_num);
	}

	@Override
	public int replydelete(int co_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.replydelete(co_num);
	}

	@Override
	public int boardback(int bo_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.boardback(bo_num);
	}

	@Override
	public int replyback(int co_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.replyback(co_num);
	}

	@Override
	public int userban(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.userban(vo);
	}

	@Override
	public int writeban(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.writeban(vo);
	}

	@Override
	public int banclear(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.banclear(ui_id);
	}

	@Override
	public int usergrade(String grade, String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.usergrade(grade, ui_id);
	}

	@Override
	public int reportcnt() throws Exception {
		// TODO Auto-generated method stub
		return dao.reportcnt();
	}

	@Override
	public int reportreplycnt() throws Exception {
		// TODO Auto-generated method stub
		return dao.reportreplycnt();
	}

	@Override
	public int gradeupcnt() throws Exception {
		// TODO Auto-generated method stub
		return dao.gradeupcnt();
	}

	@Override
	public List<BoardVO> gradeuplist() throws Exception {
		// TODO Auto-generated method stub
		return dao.gradeuplist();
	}

}