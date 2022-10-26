package kr.co.pap.adminpage;

import lombok.Data;

@Data
public class BannerDTO {
	private int bn_num;
	private String bn_name;
	private String bn_url;
	private int bn_order;
	private String bn_img;
}
