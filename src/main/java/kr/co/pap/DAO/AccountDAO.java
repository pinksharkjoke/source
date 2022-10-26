package kr.co.pap.DAO;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;

public interface AccountDAO {

	public int registerUser(UserVO vo)throws Exception;
	public LoginVO login(LoginVO vo) throws Exception;
	public UserVO selectOneUser(String id)throws Exception;
	public int UserIdCount(String id)throws Exception;
	public int UserNcCount(String ncName)throws Exception;
	public String confirmPW(LoginVO vo) throws Exception;
	public int userupdate(UserVO vo)throws Exception;
	public int userdel(String ui_id);
	public LoginVO kakaocheck(String ui_id) throws Exception;
	public int countEmail(String email) throws Exception;
}
