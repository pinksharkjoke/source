package kr.co.pap.DAO;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;

@Repository
public class AccountDAOImpl implements AccountDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private final static String namespace = "kr.co.pap.accountMapper";
	
	@Override
	public int registerUser(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + ".registerUser", vo);
	}

	@Override
	public LoginVO login(LoginVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".login", vo);
	}
	@Override
	public UserVO selectOneUser(String Id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".selectOneUser", Id);
	}

	@Override
	public int UserIdCount(String id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".UserIdCount", id);
	}
	@Override
	public int UserNcCount(String ncName) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".UserNcCount", ncName);
	}
	@Override
	public String confirmPW(LoginVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".confirmPW", vo);
	}

	@Override
	public int userupdate(UserVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".userupdate", vo);
	}

	@Override
	public int userdel(String ui_id) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".userdel", ui_id);
	}

	@Override
	public LoginVO kakaocheck(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".kakaocheck", ui_id);
	}

    @Override
    public int countEmail(String email) throws Exception {
        
        return sqlSession.selectOne(namespace + ".emailCount", email);
    }


}
