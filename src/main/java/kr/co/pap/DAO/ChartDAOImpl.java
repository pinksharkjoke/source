package kr.co.pap.DAO;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.adminpage.LoginStatVO;


@Repository
public class ChartDAOImpl implements ChartDAO {

	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "kr.co.pap.chartMapper";
	
	@Override
	public int joincnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".joincnt");
	}

	@Override
	public int logincnt(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".logincnt",ui_id);
	}


	@Override
	public int joinstatday(String String) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".joinstatday",String);
	}

	@Override
	public int loginstatday(String String) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".loginstatday",String);
	}

	
	@Override
	public int joinstatmonth(String String) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".joinstatmonth",String);
	}

	@Override
	public int loginstatmonth(String String) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".loginstatmonth",String);
	}


	@Override
	public int joinstatyear(String String) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".joinstatyear",String);
	}

	@Override
	public int loginstatyear(String String) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".loginstatyear",String);
	}

	@Override
	public LoginStatVO loginduplicate(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".loginduplicate", ui_id);
	}

}
