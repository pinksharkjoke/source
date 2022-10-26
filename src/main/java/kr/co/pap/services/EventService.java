package kr.co.pap.services;

import java.util.List;

import kr.co.pap.adminpage.EventVO;

public interface EventService {
	public List<EventVO> list() throws Exception;
	public EventVO detail(int ev_id) throws Exception;
	public int update(EventVO vo) throws Exception;
	public int delete(int ev_id) throws Exception;
	public int insert(EventVO vo) throws Exception;
	public List<EventVO> list2() throws Exception;
}
