package kr.co.pap.DAO;

import java.util.List;

import kr.co.pap.adminpage.BannerDTO;

public interface BannerDAO {
	
	public List<BannerDTO> list();
	
	public BannerDTO SelBanner(int BN_num);
	
	public int insertBanner(BannerDTO bannerDTO);
	
	public int updateBanner(BannerDTO bannerDTO);
	
	public int deleteBanner(int BN_num);
	
	public int reorderbanner(BannerDTO bannerDTO);
	
	public BannerDTO recentbanner();
	//����÷�� 
	//public  String selBannerFile()
}
