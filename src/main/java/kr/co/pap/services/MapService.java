package kr.co.pap.services;

import java.util.List;

import kr.co.pap.map.MapCriteria;
import kr.co.pap.map.MapVO;

public interface MapService {

	// 지도 리스트
	public List<MapVO> listmap(MapCriteria cri) throws Exception;
	//총 갯수
	public int listCount()throws Exception;
	
	// 병원 리스트
	public List<MapVO> listhospital() throws Exception;

	// 카페 리스트
	public List<MapVO> listcafe() throws Exception;
	

	// 식당  리스트
	public List<MapVO> listrestaurant() throws Exception;

	// 놀이터 리스트
	public List<MapVO> listplayground() throws Exception;

	
	// 마트 리스트
	public List<MapVO> listmart() throws Exception;


	// 기타 리스트
	public List<MapVO> listetc() throws Exception;
	

	// 삭제 
	public int deletemap(String pl_name) throws Exception;

	// 수정 
	public int updatemap(MapVO mapVO) throws Exception;
	
	// 디테일
	public  MapVO detailmap(String pl_name) throws Exception;
	
	// 지도 추가
	public int insertmap(MapVO mapVO) throws Exception;
	//관련글 보기
		public List<MapVO> relatedPost(String pl_name) throws Exception;
	
}
