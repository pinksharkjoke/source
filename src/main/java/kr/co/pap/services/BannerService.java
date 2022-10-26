package kr.co.pap.services;

import java.util.List;

import kr.co.pap.adminpage.BannerDTO;

public interface BannerService {
	public List<BannerDTO> list();
	
	public BannerDTO SelBanner(int BN_num);
	
	public int insertBanner(BannerDTO bannerDTO);
	
	public int updateBanner(BannerDTO bannerDTO);
	
	public int deleteBanner(int BN_num);

	public int reorderbanner(BannerDTO bannerDTO);
	
	public BannerDTO recentbanner();
}
