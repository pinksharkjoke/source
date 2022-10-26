package kr.co.pap.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.adminpage.EventVO;

@Repository
public class EventDAOImpl implements EventDAO {

	@Autowired
	private SqlSession sqlsession;
	
	private final static String namespace = "kr.co.pap.eventMapper";
	
	@Override
	public List<EventVO> list() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".list");
	}

	@Override
	public EventVO detail(int ev_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".detail", ev_id);
	}

	@Override
	public int update(EventVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace + ".update", vo);
	}

	@Override
	public int delete(int ev_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.delete(namespace + ".delete", ev_id);
	}

	@Override
	public int insert(EventVO vo) throws Exception {
		// TODO Auto-generated method stu
		return sqlsession.insert(namespace+".insert",vo);
	}

	@Override
	public List<EventVO> list2() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace +".list2");
	}

	
	
}
