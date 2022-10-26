package kr.co.pap.services;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.BannerDAO;
import kr.co.pap.adminpage.BannerDTO;

@Service
public class BannerServiceImpl implements BannerService {
	@Autowired
	private BannerDAO bannerDAO;

	@Override
	public List<BannerDTO> list() {
		// TODO Auto-generated method stub
		return bannerDAO.list();
	}

	@Override
	public BannerDTO SelBanner(int bn_num) {
		// TODO Auto-generated method stub
		return bannerDAO.SelBanner(bn_num);
	}

	@Override
	public int insertBanner(BannerDTO bannerDTO) {
		// TODO Auto-generated method stub
		return bannerDAO.insertBanner(bannerDTO);
	}

	@Override
	public int updateBanner(BannerDTO bannerDTO) {
		// TODO Auto-generated method stub
		return bannerDAO.updateBanner(bannerDTO);
	}

	@Override
	public int deleteBanner(int bn_num) {
		// TODO Auto-generated method stub
		return bannerDAO.deleteBanner(bn_num);
	}

	@Override
	public int reorderbanner(BannerDTO bannerDTO) {
		// TODO Auto-generated method stub
		return bannerDAO.reorderbanner(bannerDTO);
	}

	@Override
	public BannerDTO recentbanner() {
		// TODO Auto-generated method stub
		return bannerDAO.recentbanner();
	}
	
}
