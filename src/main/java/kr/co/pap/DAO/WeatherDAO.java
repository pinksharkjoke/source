package kr.co.pap.DAO;

import java.util.List;
import java.util.Map;

public interface WeatherDAO {

	public int countGeo(Map<String, Object> map);
	public int regitGeo(Map<String, Object> map);
	public List<Map<String, Object>> selectAllLoc();
	public Map<String, Object> selectOneLoc(Map<String, Object> map);
}
