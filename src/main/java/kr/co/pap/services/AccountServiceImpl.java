package kr.co.pap.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.AccountDAO;
import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;

@Service
public class AccountServiceImpl implements AccountService{

	@Autowired
	private AccountDAO dao;
	
	@Override
	public int registerUser(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		if(vo.getUi_birth().isEmpty()) {
			vo.setUi_birth(null);
		}
		
		return dao.registerUser(vo);
	}
	

	@Override
	public LoginVO login(LoginVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.login(vo);
	}
@Override
	public UserVO selecOneUser(String id) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOneUser(id);
	}

	@Override
	public int dueplicate(String id) throws Exception {
		
		return dao.UserIdCount(id);
	}
	@Override
	public int ncdueplicate(String ncName) throws Exception {
		// TODO Auto-generated method stub
		return dao.UserNcCount(ncName);
	}
	@Override
	public String confirmPW(LoginVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.confirmPW(vo);
	}
		
	@Override
	public UserVO selectOne(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOneUser(ui_id);
	}

	@Override
	public int userupdate(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.userupdate(vo);
	}

	@Override
	public int userdel(String ui_id) {
		// TODO Auto-generated method stub
		return dao.userdel(ui_id);
	}


	@Override
	public LoginVO kakaocheck(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.kakaocheck(ui_id);
	}


	@Override
	public int kakaoregister(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.registerUser(vo);
	}

    @Override
    public int countEmail(String email) throws Exception {
        
        return dao.countEmail(email);
    }


}
