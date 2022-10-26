package kr.co.pap.services;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;

public interface AccountService {
	
	public int registerUser(UserVO vo) throws Exception;
	public LoginVO login(LoginVO vo) throws Exception;
	public UserVO selecOneUser(String id) throws Exception;
	public int dueplicate(String id)throws Exception;
	public int ncdueplicate(String ncName)throws Exception;
	public String confirmPW(LoginVO vo) throws Exception;
	public UserVO selectOne(String ui_id) throws Exception;
	public int userupdate(UserVO vo) throws Exception;
	public int userdel(String ui_id);

	public LoginVO kakaocheck(String ui_id) throws Exception;
	public int kakaoregister(UserVO vo) throws Exception;

	public int countEmail(String email) throws Exception;

}
