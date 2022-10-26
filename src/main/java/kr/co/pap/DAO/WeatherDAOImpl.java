package kr.co.pap.DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WeatherDAOImpl implements WeatherDAO{

	private final static String NAMESPACE = "kr.co.pap.weatherMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int countGeo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".countGeo", map);
	}

	@Override
	public int regitGeo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".regitGeo", map);
	}

	@Override
	public List<Map<String, Object>> selectAllLoc() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectAllLoc");
	}
	
	@Override
	public Map<String, Object> selectOneLoc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectOneLoc", map);
	}

}
