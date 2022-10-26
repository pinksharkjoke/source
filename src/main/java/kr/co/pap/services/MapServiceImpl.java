package kr.co.pap.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.MapDAO;
import kr.co.pap.map.MapCriteria;
import kr.co.pap.map.MapVO;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private MapDAO dao;

	@Override
	public List<MapVO> listmap(MapCriteria cri) throws Exception {
		// 지도 리스트

		return dao.listmap(cri);
	}

	@Override
	public int listCount() throws Exception {
		// TODO Auto-generated method stub
		return dao.listCount();
	}
	
	@Override
	public int insertmap(MapVO mapVO) throws Exception {
		// 지도 추가
		return dao.insertmap(mapVO);
	}
	//병원
	@Override
	public List<MapVO> listhospital() throws Exception {
		// TODO Auto-generated method stub
		return dao.listhospital();
	}
	
	
	
	//카페
	@Override
	public List<MapVO> listcafe() throws Exception {
		// TODO Auto-generated method stub
		return dao.listcafe();
	}


	//마트
	@Override
	public List<MapVO> listmart() throws Exception {
		// TODO Auto-generated method stub
		return dao.listmart();
	}


	//기타
	@Override
	public List<MapVO> listetc() throws Exception {
		// TODO Auto-generated method stub
		return dao.listetc();
	}


	//식당
	@Override
	public List<MapVO> listrestaurant() throws Exception {
		// TODO Auto-generated method stub
		return dao.listrestaurant();
	}


	//놀이터
	@Override
	public List<MapVO> listplayground() throws Exception {
		// TODO Auto-generated method stub
		return dao.listplayground();
	}


	
	
	
	
	

	@Override
	public int deletemap(String pl_name) throws Exception {
		//삭제
		return dao.deletemap(pl_name);
	}

	@Override
	public int updatemap(MapVO mapVO) throws Exception {
		// 수정
		return dao.updatemap(mapVO);
	}

	@Override
	public MapVO detailmap(String pl_name) throws Exception {
		// 디테일
		return dao.detailmap(pl_name);
	}

	
	@Override
	public List<MapVO> relatedPost(String pl_name) throws Exception {
		// 관련글
		return dao.relatedPost(pl_name);
	}

	

	


}
