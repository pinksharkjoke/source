package kr.co.pap.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.adminpage.BannerDTO;



@Repository
public class BannerDAOImpl implements BannerDAO{
	@Autowired
	private SqlSession sqlSession;
	
	private static final String nameSpace="kr.co.pap.bannerMapper";

	@Override
	public List<BannerDTO> list(){
		// TODO Auto-generated method stub
		return sqlSession.selectList(nameSpace+".list");
	}

	@Override
	public BannerDTO SelBanner(int bn_num){
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace + ".SelBanner", bn_num);
	}

	@Override
	public int insertBanner(BannerDTO bannerDTO){
		// TODO Auto-generated method stub
		return sqlSession.insert(nameSpace+".insertBanner",bannerDTO);
	}

	@Override
	public int updateBanner(BannerDTO bannerDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update(nameSpace+".updateBanner", bannerDTO);
	}

	@Override
	public int deleteBanner(int bn_num) {
		// TODO Auto-generated method stub
		return sqlSession.delete(nameSpace+".deleteBanner", bn_num);
	}

	@Override
	public int reorderbanner(BannerDTO bannerDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update(nameSpace + ".reorderbanner", bannerDTO);
	}

	@Override
	public BannerDTO recentbanner() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace+".selectrecent");
	} 
}
