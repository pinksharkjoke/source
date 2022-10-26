package kr.co.pap.adminpage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.board.ReplyVO;

@Repository
public class UserboardManageDAOImpl implements UserboardManageDAO{
	
	
	@Autowired
	private SqlSession sqlsession;
	
	private final static String namespace = "kr.co.pap.userboardmanageMapper";
	
	
	@Override
	public List<BoardVO> boardlist(ReportCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".list",cri);
	}

	@Override
	public List<ReplyVO> replylist() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".replylist");
	}

	@Override
	public int boarddelete(int bo_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace + ".reportboarddelete", bo_num);
	}

	@Override
	public int replydelete(int co_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace+".reportreplydelete", co_num);
	}

	@Override
	public int boardback(int bo_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace +".reportboardback", bo_num);
	}

	@Override
	public int replyback(int co_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace+".reportreplyback",co_num);
	}

	@Override
	public int userban(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace+".userban",vo);
	}

	@Override
	public int writeban(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace+".writeban",vo);
	}

	@Override
	public int banclear(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace+".banclear", ui_id);
	}

	@Override
	public int usergrade(String grade,String ui_id) throws Exception {
		if(grade.equals("매니저")) {
			return sqlsession.update(namespace+".usergrademanager",ui_id);
		}else if(grade.equals("전문가")){
			return sqlsession.update(namespace+".usergradeexpert", ui_id);
		}else if(grade.equals("평회원")){
			return sqlsession.update(namespace+".usergradenormal", ui_id);
		}
		return 0;
	}

	@Override
	public int reportcnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace+".reportcnt");
	}
	@Override
	public int reportreplycnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace+".reportreplycnt");
	}

	@Override
	public int gradeupcnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace+".gradeupcnt");
	}

	@Override
	public List<BoardVO> gradeuplist() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace+".gradeuplist");
	}

}
