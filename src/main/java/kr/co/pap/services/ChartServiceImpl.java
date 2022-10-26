package kr.co.pap.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.ChartDAO;
import kr.co.pap.adminpage.LoginStatVO;
@Service
public class ChartServiceImpl implements ChartService {

	@Autowired
	private ChartDAO dao;
	@Override
	public int joincnt() throws Exception {
		// TODO Auto-generated method stub
		return dao.joincnt();
	}

	@Override
	public int logincnt(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.logincnt(ui_id);
	}



	@Override
	public int joinstatday(String String) throws Exception {
		// TODO Auto-generated method stub
		return dao.joinstatday(String);
	}

	@Override
	public int loginstatday(String String) throws Exception {
		// TODO Auto-generated method stub
		return dao.loginstatday(String);
	}



	@Override
	public int joinstatmonth(String String) throws Exception {
		// TODO Auto-generated method stub
		return dao.joinstatmonth(String);
	}

	@Override
	public int loginstatmonth(String String) throws Exception {
		// TODO Auto-generated method stub
		return dao.loginstatmonth(String);
	}


	@Override
	public int joinstatyear(String String) throws Exception {
		// TODO Auto-generated method stub
		return dao.joinstatyear(String);
	}

	@Override
	public int loginstatyear(String String) throws Exception {
		// TODO Auto-generated method stub
		return dao.loginstatyear(String);
	}

	@Override
	public LoginStatVO loginduplicate(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.loginduplicate(ui_id);
	}


}
