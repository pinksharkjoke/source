package kr.co.pap.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.EventDAO;
import kr.co.pap.adminpage.EventVO;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	private EventDAO dao;
	
	@Override
	public List<EventVO> list() throws Exception {
		// TODO Auto-generated method stub
		return dao.list();
	}

	@Override
	public EventVO detail(int ev_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.detail(ev_id);
	}

	@Override
	public int update(EventVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.update(vo);
	}

	@Override
	public int delete(int ev_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.delete(ev_id);
	}

	@Override
	public int insert(EventVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.insert(vo);
	}

	@Override
	public List<EventVO> list2() throws Exception {
		// TODO Auto-generated method stub
		return dao.list2();
	}

}
