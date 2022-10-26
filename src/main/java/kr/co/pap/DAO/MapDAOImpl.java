package kr.co.pap.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.co.pap.map.MapCriteria;
import kr.co.pap.map.MapVO;

@Repository
public class MapDAOImpl implements MapDAO {

	// 접근하는 파일 이름
	private static final String namespace = "kr.co.pap.mapMapper";

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MapVO> listmap(MapCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPage", cri);
	}

	@Override
	public int listCount() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".listCount");
	}

	// 병원
	@Override
	public List<MapVO> listhospital() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPageHospital");
	}

	// 카페
	@Override
	public List<MapVO> listcafe() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPageCafe");
	}

	// 마트
	@Override
	public List<MapVO> listmart() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPageMart");

	}

	// 기타
	@Override
	public List<MapVO> listetc() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPageEtc");
	}

	// 식당
	@Override
	public List<MapVO> listrestaurant() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPageRestaurant");
	}

	// 놀이터
	@Override
	public List<MapVO> listplayground() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".listPagePlayground");
	}

	// 추가
	@Override
	public int insertmap(MapVO mapVO) throws Exception {

		return sqlSession.insert(namespace + ".insertmap", mapVO);
	}

	// 삭제
	@Override
	public int deletemap(String pl_name) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace + ".deletemap", pl_name);
	}

	// 수정
	@Override
	public int updatemap(MapVO mapVO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("결과" + mapVO);
		return sqlSession.update(namespace + ".updatemap", mapVO);
	}

	// 디테일
	@Override
	public MapVO detailmap(String pl_name) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".detailmap", pl_name);
	}

	//관련글
	@Override
	public List<MapVO> relatedPost(String pl_name) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".relatedPost",pl_name);
	}

}
