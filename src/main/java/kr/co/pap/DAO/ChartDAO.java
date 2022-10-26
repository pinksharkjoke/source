package kr.co.pap.DAO;

import kr.co.pap.adminpage.LoginStatVO;

public interface ChartDAO {

	public int joincnt()throws Exception;
	public int logincnt(String ui_id)throws Exception;
	public int joinstatday(String String)throws Exception;
	public int loginstatday(String String)throws Exception;
	public int joinstatmonth(String String)throws Exception;
	public int loginstatmonth(String String)throws Exception;
	public int joinstatyear(String String)throws Exception;
	public int loginstatyear(String String)throws Exception;
	public LoginStatVO loginduplicate(String ui_id)throws Exception; 
}
